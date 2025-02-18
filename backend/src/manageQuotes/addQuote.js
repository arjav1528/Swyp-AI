const APIError = require("../apiError");
const APIResponse = require("../apiResponse");
const User = require("../models/usermodel");


const addQuote = async (req,res) => {
    const userID = req.body.userID;
    const quote = req.body.quote;
    const user = await User.findById(userID);
    console.log(user);
    
    if(!user){
        return res.status(404).json(new APIError(404, null, "User not found"));
    }
    if(!quote){
        return res.status(400).json(new APIError(400, null, "Quote is required"));
    }

    const updatedUser = await User.findByIdAndUpdate(userID, {
        $push: {
            savedQuotes: quote
        }
    }, {new: true}).select("-password -refreshToken");

    if(!updatedUser){
        return res.status(500).json(new APIError(500, null, "Error adding quote"));
    }

    return res.status(200).json(new APIResponse(200, updatedUser, "Quote added successfully"));



}

module.exports = addQuote;