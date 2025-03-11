const APIError = require("../apiError");
const APIResponse = require("../apiResponse");
const { generateAccessAndRefreshTokens } = require("../auth/LoginUser");
const User = require("../models/usermodel");
const jwt = require('jsonwebtoken');


const addQuote = async (req,res) => {
    const refreshToken = req.body.refreshToken;
    const quote = req.body.quote;
    if(!refreshToken){
        return res.status(400).json(new APIError(400, null, "Refresh token is required"));
    }
    if(!quote){
        return res.status(400).json(new APIError(400, null, "Quote is required"));
    }
    let decoded;
    try {
        decoded = jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET);
    } catch (error) {
        if(error.name === 'TokenExpiredError'){
            return res.status(401).json(new APIError(401, null, "Refresh token expired. Please logout and login again"));
        }
        return res.status(401).json(new APIError(401, null, "Invalid refresh token"));
    }
    const user = await User.findById(decoded._id);
    if(!user){
        return res.status(404).json(new APIError(404, null, "User not found"));
    }
    if(user.refreshToken !== refreshToken){
        return res.status(401).json(new APIError(401, null, "Invalid refresh token"));
    }
    user.savedQuotes.push(quote);
    await user.save().catch((error) => {
        return res.status(500).json(new APIError(500, null, "Error adding quote"));
    });
    return res.status(200).json(new APIResponse(200, user, "Quote added successfully"));

    



}

module.exports = addQuote;