*** Settings ***
Resource    ../../resources/config.robot
Resource    ../../resources/auth.robot

*** Test Cases ***
Cadastro de Usuário Válido
    [Documentation]    Testa o cadastro com dados válidos
    Criar Sessão API    ${BASE_URL}
    ${response}    Cadastrar Usuário    newuser@example.com    Senha@123
    Status da Resposta Deve Ser    201    ${response}