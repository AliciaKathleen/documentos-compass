*** Settings ***  
Resource    ../../resources/config.robot  
Resource    ../../resources/products.robot  

*** Test Cases ***  
Tentar Listar Produtos Sem Autenticação  
    [Documentation]    Deve retornar 401 ao acessar endpoint protegido sem token  
    Criar Sessão API    ${BASE_URL}  
    ${response}    Listar Produtos Sem Token  
    Status da Resposta Deve Ser    401    ${response}  