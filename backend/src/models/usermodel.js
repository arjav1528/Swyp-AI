//create a usermodel.js file in the models folder and add the following code to it:


const mongoose = require('mongoose');
const { Schema } = mongoose;
const mongooseAggregatePaginate = require('mongoose-aggregate-paginate-v2');

const userSchema = new Schema({
    
    username : {
        type: String,
        required: true,
        unique: true,
        trim: true,
        minlength: 2,
        maxlength: 50
    }, 
    email: {
        type: String,
        required: true,
        trim: true,
        lowercase: true
    },
    password: {
        type: String,
        required: true,
        trim: true,
        minlength: 6,
        maxlength: 1024
    },
    profilePircture: {
        type: String,
        default: null
    },
    savedQuotes : {
        type: Array,
        default: [],
    },
    refreshToken: {
        type: String,
        default: null
    },

    
});

userSchema.plugin(mongooseAggregatePaginate);

module.exports = mongoose.model('User', userSchema);