*** Keywords ***  
Listar Produtos Sem Token  
    ${response}=    GET On Session    api_session    /products  
    [Return]    ${response}  

*** Keywords ***  
Listar Produtos Com Token  
    [Arguments]    ${token}  
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}  
    ${response}=    GET On Session    api_session    /products    headers=${headers}  
    [Return]    ${response}  

Verificar Se Lista de Produtos Não Está Vazia  
    [Arguments]    ${response}  
    ${products}=    Get From Dictionary    ${response.json()}    data  
    Should Not Be Empty    ${products}  