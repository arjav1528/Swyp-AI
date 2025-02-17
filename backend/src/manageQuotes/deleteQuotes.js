const APIError = require("../apiError");
const APIResponse = require("../apiResponse");
const User = require("../models/usermodel");


const deleteQuotes = async (req, res) => {
    const index = req.body.index;
    const userID = req.body.userID;
    const user = await User.findById(userID);
    console.log(user.savedQuotes[index]);

    if(!user){
        return res.status(404).json(new APIError(404, null, "User not found"));
    }
    if(!index){
        return res.status(400).json(new APIError(400, null, "Index is required"));
    }
    if(index < 0 || index >= user.savedQuotes.length){
        return res.status(400).json(new APIError(400, null, "Index is out of bounds"));
    }

    const updatedUser = await User.findByIdAndUpdate(userID, {
        $pull: {
            savedQuotes: user.savedQuotes[index]
        }
    }, {new: true}).select("-password -refreshToken");

    if(!updatedUser){
        return res.status(500).json(new APIError(500, null, "Error deleting quote"));
    }

    return res.status(200).json(new APIResponse(200, updatedUser, "Quote deleted successfully"));


}


module.exports = deleteQuotes;