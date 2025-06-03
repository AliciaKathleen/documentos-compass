*** Settings ***
Resource    ../../resources/config.robot
Resource    ../../resources/auth.robot

*** Test Cases ***
Login com Credenciais Válidas
    [Documentation]    Testa o login com e-mail e senha válidos
    Criar Sessão API    ${BASE_URL}
    ${response}    Fazer Login    user@example.com    Senha@123
    Status da Resposta Deve Ser    200    ${response}
    Verificar Token na Resposta    ${response}