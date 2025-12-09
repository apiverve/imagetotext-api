/**
 * Basic Example - Image to Text API
 *
 * This example demonstrates how to use the Image to Text API.
 * Make sure to set your API key in the .env file or replace '[YOUR_API_KEY]' below.
 */

require('dotenv').config();
const imagetotextAPI = require('../index.js');

// Initialize the API client
const api = new imagetotextAPI({
    api_key: process.env.API_KEY || '[YOUR_API_KEY]'
});

// Example query
var query = {
  "url": "https://findingtom.com/images/uploads/what-is-medium-com/article-image-15.png"
};

// Make the API request using callback
console.log('Making request to Image to Text API...\n');

api.execute(query, function (error, data) {
    if (error) {
        console.error('Error occurred:');
        if (error.error) {
            console.error('Message:', error.error);
            console.error('Status:', error.status);
        } else {
            console.error(JSON.stringify(error, null, 2));
        }
        return;
    }

    console.log('Response:');
    console.log(JSON.stringify(data, null, 2));
});
