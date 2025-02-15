

const APIError = require('../apiError');
const APIResponse = require('../apiResponse');
const User = require('../models/usermodel');





const registerUser = async (username,password) => {

    if(!username || !password){
        throw new APIError(400, "Username and password are required");
    }

    if(username.length < 2){
        throw new APIError(400, "Username must be at least 2 characters long");
    }

    if(password.length < 6){
        throw new APIError(400, "Password must be at least 6 characters long");
    }

    const existedUser = await User.findOne({
        username
    });

    if(existedUser){
        throw new APIError(400, "Username already exists");
    }

    const registeredUser = await new User({
        username,
        password
    }).save().catch((error) => {
        throw new APIError(500, "Error creating user",
        error);
    });

    try {
        const createdUser = await User.findById(registeredUser._id).select("-password -refreshToken");
        if(!createdUser){
            throw new APIError(500, "Error creating user");
        }
        return createdUser;
    } catch (error) {
        // console.error('Error creating user:', error);
        console.log('Error creating user:');
        throw new APIError(500, 'Error creating user', error);
        
    }

    return createdUser;

    

    
}


module.exports = registerUser;