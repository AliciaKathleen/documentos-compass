*** Keywords ***  
Listar Produtos Sem Token  
    ${response}=    GET On Session    api_session    /products  
    [Return]    ${response}  