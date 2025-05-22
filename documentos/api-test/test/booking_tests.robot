*** Settings ***
Resource    ../resources/common.robot
Resource    ../resources/booking_resources.robot

*** Variables ***
&{BOOKING_DATA}    firstname=Alice    lastname=Silva    totalprice=200
...                depositpaid=true    bookingdates=${None}    additionalneeds=Breakfast
&{DATES}           checkin=2024-01-01    checkout=2024-01-05

*** Test Cases ***
Criar Reserva Válida
    ${booking_data}=    Copy Dictionary    ${BOOKING_DATA}
    Set To Dictionary    ${booking_data}    bookingdates    ${DATES}
    ${response}=    Criar Reserva    ${booking_data}
    Status Should Be    200    ${response}
    Should Contain    ${response.json()}    bookingid