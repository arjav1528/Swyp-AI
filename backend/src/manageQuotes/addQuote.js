

const addQuote = async (req,res) => {
    const userID = req.userID;
    const quote = req.body.quote;
    const user = await User.findById(userID);
    if(!user){
        return res.status(404).json(new APIError(404, null, "User not found"));
    }
    if(!quote){
        return res.status(400).json(new APIError(400, null, "Quote is required"));
    }

    

}