*** Settings ***
Recurso             common.robot
Recurso             auth.robot
Suite Setup         Criar Sessão

*** Casos de Teste ***
Cenario 01: Obter IDs de todas as reservas
    [Tags]          GET
    ${resposta}=    GET Na Sessão    booker    /booking
    ...             expected_status=200
    Lista Não Deve Ser Vazia    ${resposta.json()}

Cenario 02: Criar nova reserva
    [Tags]          POST
    ${cabecalhos}=  Criar Dicionário    Content-Type=application/json
    ${dados}=       Criar Dicionário
    ...             firstname=Maria
    ...             lastname=Silva
    ...             totalprice=200
    ...             depositpaid=true
    ...             bookingdates=${{"checkin":"2024-07-01","checkout":"2024-07-05"}}
    ...             additionalneeds=Breakfast
    
    ${resposta}=    POST Na Sessão    booker    /booking
    ...             json=${dados}
    ...             headers=${cabecalhos}
    ...             expected_status=200
    
    ${id_reserva}=  Set Suite Variable    ${ID_RESERVA}    ${resposta.json()}[bookingid]
    Dictionary Should Contain Key    ${resposta.json()}    bookingid

Cenario 03: Consultar reserva específica
    [Tags]          GET
    [Setup]         Run Keyword If    not ${ID_RESERVA}    Executar Criar Reserva
    ${resposta}=    GET Na Sessão    booker    /booking/${ID_RESERVA}
    ...             expected_status=200
    Validar Dados da Reserva    ${resposta.json()}

Cenario 04: Atualizar reserva
    [Tags]          PUT
    [Setup]         Run Keyword If    not ${ID_RESERVA}    Executar Criar Reserva
    ${token}=       Gerar Token
    ${headers}=     Criar Dicionário
    ...             Content-Type=application/json
    ...             Cookie=token=${token}
    
    ${novos_dados}= Criar Dicionário
    ...             firstname=Maria
    ...             lastname=Santos  # Sobrenome atualizado
    
    ${resposta}=    PUT Na Sessão    booker    /booking/${ID_RESERVA}
    ...             json=${novos_dados}
    ...             headers=${headers}
    ...             expected_status=200
    
    Should Be Equal    ${resposta.json()}[lastname]    Santos

Cenario 05: Deletar reserva
    [Tags]          DELETE
    [Setup]         Run Keyword If    not ${ID_RESERVA}    Executar Criar Reserva
    ${token}=       Gerar Token
    ${headers}=     Criar Dicionário
    ...             Content-Type=application/json
    ...             Cookie=token=${token}
    
    ${resposta}=    DELETE Na Sessão    booker    /booking/${ID_RESERVA}
    ...             headers=${headers}
    ...             expected_status=201
    
    # Verificar exclusão
    ${consulta}=    Run Keyword And Expect Error    *
    ...             GET Na Sessão    booker    /booking/${ID_RESERVA}
    ...             expected_status=404
    Should Contain    ${consulta}    404

*** Palavras-Chave ***
Executar Criar Reserva
    ${cabecalhos}=  Criar Dicionário    Content-Type=application/json
    ${dados}=       Criar Dicionário
    ...             firstname=Temporario
    ...             lastname=Reserva
    ...             totalprice=100
    ...             depositpaid=true
    ...             bookingdates=${{"checkin":"2024-01-01","checkout":"2024-01-05"}}
    
    ${resposta}=    POST Na Sessão    booker    /booking
    ...             json=${dados}
    ...             headers=${cabecalhos}
    Set Suite Variable    ${ID_RESERVA}    ${resposta.json()}[bookingid]

Validar Dados da Reserva
    [Arguments]     ${dados_reserva}
    Dictionary Should Contain Key    ${dados_reserva}    firstname
    Dictionary Should Contain Key    ${dados_reserva}    lastname
    Dictionary Should Contain Key    ${dados_reserva}    totalprice