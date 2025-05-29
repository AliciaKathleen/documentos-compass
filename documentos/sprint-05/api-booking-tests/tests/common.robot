*** Settings ***
Documentation       Configurações e keywords comuns para todos os testes
Library             RequestsLibrary
Library             Collections
Library             String
Library             OperatingSystem

*** Variables ***
${URL_BASE}         https://restful-booker.herokuapp.com
${USUARIO}          admin
${SENHA}            password123

*** Keywords ***
Log Response
    [Documentation]  Loga a resposta completa da API para debug
    [Arguments]     ${response}
    Log    Status Code: ${response.status_code}
    Log    Headers: ${response.headers}
    Log    Body: ${response.text}