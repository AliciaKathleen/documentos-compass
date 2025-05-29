*** Settings ***
Documentation       Keywords relacionadas à autenticação
Resource            common.robot

*** Keywords ***
Criar Sessão
    [Documentation]  Cria uma sessão HTTP para a API Booker
    Create Session    booker    ${URL_BASE}    verify=true
    Set Suite Variable    ${SESSION}    booker

Gerar Token
    [Documentation]  Gera token de autenticação para a API
    [Arguments]      ${username}=${USUARIO}    ${password}=${SENHA}
    
    ${headers}=      Create Dictionary    Content-Type=application/json
    ${body}=        Create Dictionary    
    ...             username=${username}    
    ...             password=${password}
    
    ${response}=    POST On Session    booker    /auth    
    ...             json=${body}    
    ...             headers=${headers}    
    ...             expected_status=200
    
    ${token}=       Get From Dictionary    ${response.json()}    token
    [Return]        ${token}