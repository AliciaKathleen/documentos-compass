*** Settings ***
Resource    common.robot
Resource    ../variables/api_variables.robot

*** Keywords ***
    ${auth_data}=    Create Dictionary    username=admin    password=password123
    ${response}=    POST On Session    booking    /auth    json=${auth_data}
    [Return]    ${response.json()}[token]