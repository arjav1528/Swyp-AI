const { status } = require('express/lib/response');
const { APIResonse } = require('./API-Response');
const app = require('./app');
const connectDB = require('./db');
const cors = require('cors');
const express = require('express');
require('dotenv').config();


app.use(cors());
app.use(express.json(
    {
        limit: '16kb'
    }
));
app.use(express.urlencoded(
    {
        extended: true,
        limit: '16kb'

    }
))
app.use(express.static('public'));



const PORT = process.env.PORT || 3001;

//Routes

app.get('/', (req, res) => {
    return res.json(new APIResonse(200, null, 'Welcome to the API')).status(200);
});


connectDB().then(() => {
    app.listen(PORT, () => {
        console.log(`Server running on port ${PORT}`);
        console.log(`Server runnin on url: http://localhost:${PORT}`);
    });
}).catch((error) => {
    console.error('Error connecting to MongoDB:', error.message);
});