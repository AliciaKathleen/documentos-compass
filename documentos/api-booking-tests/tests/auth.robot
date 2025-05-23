*** Settings ***
Recurso             common.robot

*** Palavras-Chave ***
Criar Sessão
    Criar Sessão    booker    ${URL_BASE}

Gerar Token
    ${cabecalhos}=  Criar Dicionário    Content-Type=application/json
    ${corpo}=       Criar Dicionário    
    ...             username=${USUARIO}    
    ...             password=${SENHA}
    
    ${resposta}=    POST Na Sessão    booker    /auth    
    ...             json=${corpo}    
    ...             headers=${cabecalhos}    
    ...             expected_status=200
    
    ${token}=       Obter Do Dicionário    ${resposta.json()}    token
    [Retorno]       ${token}