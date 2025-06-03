*** Keywords ***
Obter Token de Login
    [Arguments]    ${email}    ${password}
    ${response}    Fazer Login    ${email}    ${password}
    ${token}    Get From Dictionary    ${response.json()}    token
    [Return]    ${token}

Criar Carrinho
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    POST On Session    api_session    /carts    headers=${headers}
    [Return]    ${response.json()}[id]

Adicionar Item ao Carrinho
    [Arguments]    ${token}    ${cart_id}    ${product_id}    ${quantity}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${body}=    Create Dictionary    productId=${product_id}    quantity=${quantity}
    POST On Session    api_session    /carts/${cart_id}/items    json=${body}    headers=${headers}

Concluir Compra
    [Arguments]    ${token}    ${cart_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    POST On Session    api_session    /carts/${cart_id}/checkout    headers=${headers}
    [Return]    ${response}