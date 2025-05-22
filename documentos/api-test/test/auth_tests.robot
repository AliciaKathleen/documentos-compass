*** Settings ***
Resource    ../resources/common.robot
Resource    ../resources/booking_resources.robot

*** Test Cases ***
    ${token}=    Obter Token de Autenticação
    Should Not Be Empty    ${token}
    Log    Token obtido: ${token}