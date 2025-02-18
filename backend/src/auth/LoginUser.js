const APIError = require("../apiError");
const APIResponse = require("../apiResponse");
const User = require("../models/usermodel");
const jwt = require('jsonwebtoken');
require('dotenv').config();




const generateAccessAndRefreshTokens = async (userID) => {
    try {
        const user = await User.findById(userID);
        if(!user){
            throw new APIError(404, null, "User not found");
        }
        const accessToken = user.generateAccessToken();
        const refreshToken = user.generateRefreshToken();
        user.refreshToken = refreshToken;
        user.save();
        return {accessToken, refreshToken};
    } catch (error) {
        console.error('Error generating tokens:', error);
        throw new APIError(500, null, "Error generating tokens");
        
    }
}



const loginUser = async (req,res) => {
    const username = req.body.username;
    const password = req.body.password;

    if(!username || !password){
        return res.status(400).json(new APIError(400, null, "Username and password are required"));
    }

    const user = await User.findOne({
        username
    });

    if(!user){
        return res.status(400).json(new APIError(400, null, "Username not found"));
    }

    const passwordMatch = await user.isPasswordCorrect(password);

    if(!passwordMatch){
        return res.status(400).json(new APIError(400, null, "Password is incorrect"));
    }

    const {accessToken, refreshToken} = await generateAccessAndRefreshTokens(user._id);

    const loggedInUser = await User.findById(user._id).select("-password -refreshToken");

    if(!loggedInUser){
        return res.status(500).json(new APIError(500, null, "Error logging in"));
    }

    const options = {
        httpOnly: true,
        secure: true,
        sameSite: 'none'
    };
    

    return res
        .cookie('refreshToken', refreshToken, options)
        .cookie('accessToken', accessToken, options)
        .json(new APIResponse(200, loggedInUser, "User logged in successfully"))
        .status(200);
}



const refreshAccessToken = async (req,res) => {
    const refreshToken = req.body.refreshToken;

    

    if(!refreshToken){
        return res.status(401).json(new APIError(401, null, "Refresh token is required"));
    }

    let decodedToken;
    try {
        decodedToken = jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET);
    } catch (error) {
        return res.status(401).json(new APIError(401, null, "Unable to decode refresh token"));
    }

    const user = await User.findOne({
        _id: decodedToken._id
    });

    if(!user){
        return res.status(404).json(new APIError(404, null, "User not found"));
    }

    if(user.refreshToken !== refreshToken){
        console.error('Refresh token:', refreshToken);
        console.error('User refresh token:', user.refreshToken);
        return res.status(401).json(new APIError(401, null, "Refresh token is invalid"));
    }

    const {accessToken, refreshToken : newRefreshToken} = await generateAccessAndRefreshTokens(user._id);

    if(!accessToken){
        return res.status(500).json(new APIError(500, null, "Error generating access token"));
    }

    if(!newRefreshToken){
        return res.status(500).json(new APIError(500, null, "Error generating refresh token"));
    }
    const options = {
        httpOnly: true,
        secure: true,
        sameSite: 'none'
    };

    return res
        .cookie('accessToken', accessToken, options)
        .cookie('refreshToken', newRefreshToken, options)
        .json(new APIResponse(200, {accessToken}, "Access token refreshed"))
        .status(200);


}



module.exports = {loginUser, refreshAccessToken};