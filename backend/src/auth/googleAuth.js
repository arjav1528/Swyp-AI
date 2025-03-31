const { OAuth2Client } = require("google-auth-library")
const User = require("../models/usermodel");
const { generateTokens } = require("./LoginUser");
const APIError = require("../apiError");
const APIResponse = require("../apiResponse");
const jwt = require("jsonwebtoken");

const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID)
if(!process.env.GOOGLE_CLIENT_ID){
    console.error("Google Client ID is not defined in environment variables");
}


const googleAuth = async (req,res) => {
    try{
        const idToken = req.body.idToken;
        console.log('idToken:', idToken);
        const decodedToken = jwt.decode(idToken,{complete: true});
        console.log('Decoded Token:', decodedToken);

        if(!idToken){
            return res.status(400).json(new APIError(400, null, "Token is required"))
        }

        const ticket = await client.verifyIdToken({
            idToken,
            audience: process.env.GOOGLE_CLIENT_ID,
        })

        if(!ticket){
            return res.status(401).json(new APIError(401, null, "Invalid token"))
        }
        
        const payload = ticket.getPayload()
        const username = payload.name.toLowerCase().replace(/\s/g, "")+payload.sub
        const googleId = payload.sub
        

        const user = await User.findOne({googleId : googleId})
        if(!user){
            const newUser = await new User({
                username,
                googleId
            }).save()
            if(!newUser){
                return res.status(500).json(new APIError(500, null, "Error creating user"))
            }

            const refreshToken = await generateTokens(newUser._id)
            user.refreshToken = refreshToken
            user.save()

            return res
            .json(new APIResponse(200, {
                user: newUser,
                },
                "User created successfully"))
                .status(200);
        }else{
            const refreshToken = await generateTokens(user._id)
            return res
            .json(new APIResponse(200, {
                user : user,
            },'User logged in successfully'))
            .status(200);
        }
    }catch(error){
        console.error('Error logging in with google:', error)
        return res.status(500).json(new APIError(500, null, "Error logging in with google"))
    }

}

module.exports = googleAuth;


