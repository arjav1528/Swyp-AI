const APIError = require("../apiError");
const APIResponse = require("../apiResponse");
const User = require("../models/usermodel");
const { generateAccessAndRefreshTokens } = require("./LoginUser");

const googleLogin = async (req, res) => {
    const googleId = req.body.googleId;
    const username = "user" + googleId;
    const password = 'GoogleAuth';
    
    if (!googleId) {
        return res.status(400).json(new APIError(400, null, "Google ID is required"));
    }

    const existedUser = await User.findOne({ googleId : googleId });
    // console.log(existedUser);

    if(!existedUser){
        return res.status(400).json(new APIError(400, null, "User not found"));

    }
    const {accessToken, refreshToken} = await generateAccessAndRefreshTokens(existedUser._id);
    return res.status(200).json(new APIResponse(200, {
        user : existedUser,
        accessToken : accessToken,
        refreshToken : refreshToken
    }, "User logged in successfully"));
}

module.exports = googleLogin;