
const app = require('./src/app');
const connectDB = require('./src/db');
const cors = require('cors');
const express = require('express');
const cookieParser = require('cookie-parser');
require('dotenv').config();
const registerUser = require('./src/auth/RegisterUser');
const APIResponse = require('./src/apiResponse');
const APIError = require('./src/apiError');
const loginUser = require('./src/auth/LoginUser');



app.use(cors());
app.use(express.json({limit: '16kb'}));
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());



const PORT = process.env.PORT || 3001;

//Routes

app.get('/', (req, res) => {
    res.send('Hello World');
});
app.get('/test', (req, res) => {
    return res.json(new APIResponse(200, null, 'Test successful'));
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