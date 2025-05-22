*** Settings ***
Resource    common.robot
Resource    ../variables/api_variables.robot

*** Keywords ***
    ${auth_data}=    Create Dictionary    username=admin    password=password123
    ${response}=    POST On Session    booking    /auth    json=${auth_data}
    [Return]    ${response.json()}[token]

 [Arguments]    ${data}
    ${headers}=    Create Dictionary    Content-Type=${CONTENT_TYPE}
    ${response}=    POST On Session    booking    /booking    json=${data}    headers=${headers}
    [Return]    ${response}

 [Arguments]    ${booking_id}
    ${response}=    GET On Session    booking    /booking/${booking_id}
    [Return]    ${response}

 [Arguments]    ${booking_id}    ${token}    ${new_data}
    ${headers}=    Create Dictionary    Cookie=token=${token}    Content-Type=${CONTENT_TYPE}
    ${response}=    PUT On Session    booking    /booking/${booking_id}    headers=${headers}    json=${new_data}
    [Return]    ${response}

[Arguments]    ${booking_id}    ${token}
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${response}=    DELETE On Session    booking    /booking/${booking_id}    headers=${headers}
    [Return]    ${response}