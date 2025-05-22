*** Settings ***
Library    RequestsLibrary
Variables  variables.robot

*** Keywords ***
Create Token
    Create Session    restful    ${BASE_URL}
    ${payload}=    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${response}=   Post Request    restful    /auth    json=${payload}
    ${token}=      Set Variable    ${response.json()['token']}
    Set Suite Variable    ${TOKEN}    ${token}
