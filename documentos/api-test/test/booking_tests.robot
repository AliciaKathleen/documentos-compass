*** Settings ***
Resource    ../resources/common.robot
Resource    ../resources/booking_resources.robot

*** Variables ***
&{BOOKING_DATA}    firstname=Alice    lastname=Silva    totalprice=200
...                depositpaid=true    bookingdates=${None}    additionalneeds=Breakfast
&{BOOKING_DATES}   checkin=2024-01-01    checkout=2024-01-05
&{UPDATE_DATA}     firstname=Alice    lastname=Souza    totalprice=250

*** Test Cases ***

    ${booking_data}=    Copy Dictionary    ${BOOKING_DATA}
    Set To Dictionary    ${booking_data}    bookingdates    ${BOOKING_DATES}
    ${response}=    Criar Reserva    ${booking_data}
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    bookingid

 ${response}=    Criar Reserva    ${booking_data}
    ${booking_id}=    Set Variable    ${response.json()}[bookingid]
    ${get_response}=    Consultar Reserva Por ID    ${booking_id}
    Status Should Be    200    ${get_response}