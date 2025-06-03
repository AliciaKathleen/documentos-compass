*** Settings ***
Resource    ../../resources/config.robot
Resource    ../../resources/auth.robot

*** Test Cases ***
Token Expirado Deve Retornar 401
    [Documentation]    Testa acesso com token expirado
    Criar Sessão API    ${BASE_URL}
    ${response}    Fazer Login Com Token Expirado    expired_token
    Status da Resposta Deve Ser    401    ${response}