const app = require('./app');
const connectDB = require('./db');
const cors = require('cors');
const express = require('express');
require('dotenv').config();


app.use(cors());
app.use(express.json());



const PORT = process.env.PORT || 3001;


connectDB().then(() => {
    app.listen(PORT, () => {
        console.log(`Server running on port ${PORT}`);
    });
}).catch((error) => {
    console.error('Error connecting to MongoDB:', error.message);
});