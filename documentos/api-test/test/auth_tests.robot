*** Settings ***
Resource    ../resources/common.robot
Resource    ../resources/booking_resources.robot

*** Test Cases ***
Obter Token com Credenciais Válidas
    ${token}=    Obter Token de Autenticação
    Should Not Be Empty    ${token}