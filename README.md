# api-skills-2023

## Description
This GitHub repository contains a PHP script for handling requests to a RESTful API. The script is designed to handle various CRUD (Create, Read, Update, Delete) operations on different database tables based on the provided route parameter. It follows a RESTful architecture and returns responses in JSON format.

## Features
- Flexible routing: The script accepts different routes in the URL query string to determine the target table for performing database operations.
- Secure token handling: The included "token.php" file likely implements token-based authentication or authorization to ensure secure access to the API.
- GET request support: Retrieves data from the specified table and returns it in the response, along with relevant metadata.
- POST request support: Inserts new data into the specified table based on the JSON data provided in the request body.
- DELETE request support: Deletes a row from the specified table based on the provided ID in the URL query string.
- PATCH request support: Updates a row in the specified table based on the provided ID and JSON data in the request body.
- Error handling: Sets appropriate error messages and codes in case of invalid routes or failed database operations.
- JSON response: Returns all responses in JSON format for easy consumption by clients.
