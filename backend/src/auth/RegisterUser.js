

const APIError = require('../apiError');
const APIResponse = require('../apiResponse');
const User = require('../models/usermodel');





const registerUser = async (req,res) => {
    const username = req.body.username;
    const password = req.body.password;

    if(!username || !password){
        return res.status(400).json(new APIError(400, null, "Username and password are required"));
    }

    if(username.length < 2){
        return res.status(400).json(new APIError(400, null, "Username must be at least 2 characters long"));
    }

    if(password.length < 6){
        return res.status(400).json(new APIError(400, null, "Password must be at least 6 characters long"));
    }

    const existedUser = await User.findOne({
        username
    });

    if(existedUser){
        return res.status(400).json(new APIError(400, null, "Username already exists"));
    }

    const registeredUser = await new User({
        username,
        password
    }).save().catch((error) => {
        return res.status(500).json(new APIError(500, null, "Error creating user"));
    });

    try {
        const createdUser = await User.findById(registeredUser._id).select("-password -refreshToken");
        if(!createdUser){
            return res.status(500).json(new APIError(500, null, "Error creating user"));
        }
        return res.status(201).json(new APIResponse(201, createdUser, "User created successfully"));
    } catch (error) {
        // console.error('Error creating user:', error);
        console.log('Error creating user:');
        res.status(500).json(new APIError(500, null, "Error creating user"));
        
    }


    

    
}


module.exports = registerUser;