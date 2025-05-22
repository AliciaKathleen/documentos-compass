*** Settings ***
Resource    __init__.robot

*** Keywords ***
Get Auth Token
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${body}=    Create Dictionary    
    ...    username=admin    
    ...    password=password123
    
    ${response}=    POST    ${BASE_URL}/auth    
    ...    json=${body}    
    ...    headers=${headers}    
    ...    expected_status=200
    
    [Return]    ${response.json()}[token]