*** Settings ***
Resource    ../../resources/config.robot
Resource    ../../resources/cart.robot

*** Test Cases ***
Concluir Compra com Carrinho Válido
    [Documentation]    Testa o fluxo de checkout
    Criar Sessão API    ${BASE_URL}
    ${token}    Obter Token de Login    user@example.com    Senha@123
    ${cart_id}    Criar Carrinho    ${token}
    Adicionar Item ao Carrinho    ${token}    ${cart_id}    product_123    2
    ${response}    Concluir Compra    ${token}    ${cart_id}
    Status da Resposta Deve Ser    200    ${response}