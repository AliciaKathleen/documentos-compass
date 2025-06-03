*** Settings ***  
Resource    ../../resources/config.robot  
Resource    ../../resources/products.robot  

*** Test Cases ***  
Listar Produtos com Autenticação Válida  
    [Documentation]    Deve retornar lista de produtos com status 200  
    Criar Sessão API    ${BASE_URL}  
    ${token}    Obter Token de Login    user@example.com    Senha@123  
    ${response}    Listar Produtos Com Token    ${token}  
    Status da Resposta Deve Ser    200    ${response}  
    Verificar Se Lista de Produtos Não Está Vazia    ${response}  