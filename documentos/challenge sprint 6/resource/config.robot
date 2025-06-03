*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Library    variables.py

*** Variables ***
${BASE_URL}    https://api.example.com/v1
${CONTENT_TYPE}    application/json