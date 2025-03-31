const APIError = require("../apiError");
const APIResponse = require("../apiResponse");
const User = require("../models/usermodel");
const jwt = require('jsonwebtoken');
require('dotenv').config();




const generateTokens = async (userID) => {
    try {
        const user = await User.findById(userID);
        if(!user){
            throw new APIError(404, null, "User not found");
        }
        
        const refreshToken = user.generateRefreshToken();
        user.refreshToken = refreshToken;
        user.save();
        return refreshToken;
    } catch (error) {
        console.error('Error generating tokens:', error);
        throw new APIError(500, null, "Error generating tokens");
        return null;
        
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

    const refreshToken = await generateTokens(user._id);


    

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
        .json(new APIResponse(200, {
            user: loggedInUser,
            refreshToken : refreshToken
        }, "User logged in successfully"))
        .status(200);
}



module.exports = {loginUser , generateTokens};