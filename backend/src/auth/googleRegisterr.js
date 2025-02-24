
const APIError = require("../apiError");
const APIResponse = require("../apiResponse");
const User = require("../models/usermodel");
const { generateAccessAndRefreshTokens } = require("./LoginUser");

const googleRegister = async (req, res) => {
    const googleId = req.body.googleId;
    const username = req.body.username;
    const password = req.body.password;
    if (!googleId || !username) {
        return res.status(400).json(new APIError(400, null, "Google ID and email are required"));
    }

    const existedUser = await User.findOne({ username });
    // If the user already exists, just generate tokens and respond
    if (existedUser) {
        return 
    }

    const registeredUser = await new User({
        username : username,
        password : password,
        gender : "Other",
        age : 0,
        googleId : googleId

    }).save().catch((error) => {
        return res.status(500).json(new APIError(500, null, "Error creating user"));
    });

    try {
        const createdUser = await User.findOne({ googleId });
        if (!createdUser) {
            return res.status(500).json(new APIError(500, null, "Error finding created user"));
        }

        // Generate and respond (instead of calling loginUser)
        const { accessToken, refreshToken } = await generateAccessAndRefreshTokens(createdUser._id);
        return res
            .status(200)
            .json(new APIResponse(200, {
                user: createdUser,
                accessToken,
                refreshToken
            }, "User created and logged in successfully"));

    } catch (error) {
        return res.status(500).json(new APIError(500, null, "Error: " + error.message));
    }
};

module.exports = googleLogin;