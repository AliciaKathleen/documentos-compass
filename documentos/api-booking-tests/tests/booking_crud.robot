*** Settings ***
Resource    __init__.robot
Resource    auth.robot

*** Test Cases ***
Get All Bookings
    ${response}=    GET    ${BASE_URL}/booking
    Should Be Equal As Numbers    ${response.status_code}    200

Create Booking
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${booking}=    Create Dictionary
    ...    firstname=Alice
    ...    lastname=Smith
    ...    totalprice=200
    ...    depositpaid=true
    ...    bookingdates=${{"checkin":"2024-01-01","checkout":"2024-01-05"}}
    ...    additionalneeds=Breakfast
    
    ${response}=    POST    ${BASE_URL}/booking
    ...    json=${booking}
    ...    headers=${headers}
    
    Set Suite Variable    ${BOOKING_ID}    ${response.json()}[bookingid]

Update Booking
    [Setup]    Run Keyword If    not ${BOOKING_ID}    Create Booking
    
    ${token}=    Get Auth Token
    ${headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Cookie=token=${token}
    
    ${updated}=    Create Dictionary
    ...    firstname=AliceUpdated
    
    ${response}=    PUT    ${BASE_URL}/booking/${BOOKING_ID}
    ...    json=${updated}
    ...    headers=${headers}

Delete Booking
    [Setup]    Run Keyword If    not ${BOOKING_ID}    Create Booking
    
    ${token}=    Get Auth Token
    ${headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Cookie=token=${token}
    
    ${response}=    DELETE    ${BASE_URL}/booking/${BOOKING_ID}
    ...    headers=${headers}