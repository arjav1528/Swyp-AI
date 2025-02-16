
const app = require('./app');
const connectDB = require('./db');
const cors = require('cors');
const express = require('express');
const cookieParser = require('cookie-parser');
require('dotenv').config();
const registerUser = require('./auth/RegisterUser');
const APIResponse = require('./apiResponse');
const APIError = require('./apiError');
const loginUser = require('./auth/LoginUser');



app.use(cors());
app.use(express.json({limit: '16kb'}));
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());



const PORT = process.env.PORT || 3001;

//Routes

app.get('/', (req, res) => {
    return res.json(new APIResponse(200, null, 'Welcome to the API')).status(200);
});

app.post('/register',registerUser);
app.post('/login', loginUser);




//DB connection

connectDB().then(() => {
    app.listen(PORT, () => {
        console.log(`Server running on port ${PORT}`);
        console.log(`Server runnin on url: http://localhost:${PORT}`);
    });
}).catch((error) => {
    console.error('Error connecting to MongoDB:', error.message);
});