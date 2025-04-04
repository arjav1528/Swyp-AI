const APIError = require("../apiError");
const APIResponse = require("../apiResponse");
const User = require("../models/usermodel");
const jwt = require('jsonwebtoken');

/**
 * Deletes a quote from the user's saved quotes
 * @param {Object} req - Express request object
 * @param {Object} res - Express response object
 */
const deleteQuotes = async (req, res) => {
    try {
        // Extract and validate required fields
        const { refreshToken, quote } = req.body;
        
        if (!refreshToken) {
            return res.status(400).json(
                new APIError(400, null, "Refresh token is required")
            );
        }
        
        if (!quote) {
            return res.status(400).json(
                new APIError(400, null, "Quote is required")
            );
        }

        // Verify refresh token
        const decoded = jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET);
        if(!decoded) {
            return res.status(401).json(
                new APIError(401, null, "Invalid refresh token")
            );
        }
        
        // Find user by ID
        const user = await User.findById(decoded._id);
        if (!user) {
            return res.status(404).json(
                new APIError(404, null, "User not found")
            );
        }

        // Check if user has the quote
        const index = user.savedQuotes.indexOf(quote);
        if (index === -1) {
            return res.status(404).json(
                new APIError(404, null, "Quote not found")
            );
        }

        // Remove quote and save user
        user.savedQuotes.splice(index, 1);
        await user.save();
        
        return res.status(200).json(
            new APIResponse(200, user, "Quote deleted successfully")
        );
    } catch (error) {
        console.error('Error deleting quote:', error);
        
        if (error.name === 'TokenExpiredError') {
            return res.status(401).json(
                new APIError(401, null, "Refresh token expired. Please logout and login again")
            );
        }
        
        return res.status(500).json(
            new APIError(500, null, "Error deleting quote")
        );
    }
};

module.exports = deleteQuotes;