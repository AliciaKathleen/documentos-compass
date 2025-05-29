*** Settings ***
Documentation       Testes CRUD para o sistema de reservas Booker
Resource            common.robot
Resource            auth.robot
Suite Setup         Criar Sessão
Test Teardown       Run Keyword If Test Failed    Log    Test failed - check logs for details

*** Variables ***
${DEFAULT_FIRSTNAME}    Maria
${DEFAULT_LASTNAME}     Silva

*** Test Cases ***
Cenario 01: Obter IDs de todas as reservas
    [Documentation]  Verifica se a API retorna uma lista de IDs de reservas
    [Tags]          GET    SMOKE
    ${response}=    GET On Session    booker    /booking
    ...             expected_status=200
    Should Be Equal As Numbers    ${response.status_code}    200
    List Should Not Contain Value    ${response.json()}    ${None}
    ${count}=       Get Length    ${response.json()}
    Log    Total de reservas encontradas: ${count}

Cenario 02: Criar nova reserva
    [Documentation]  Testa a criação de uma nova reserva
    [Tags]          POST    CRITICAL
    ${headers}=     Create Dictionary    Content-Type=application/json
    ${booking_dates}=    Create Dictionary    
    ...             checkin=2024-07-01    
    ...             checkout=2024-07-05
    
    ${booking_data}=    Create Dictionary    
    ...             firstname=${DEFAULT_FIRSTNAME}    
    ...             lastname=${DEFAULT_LASTNAME}    
    ...             totalprice=200    
    ...             depositpaid=${true}    
    ...             bookingdates=${booking_dates}    
    ...             additionalneeds=Breakfast
    
    ${response}=    POST On Session    booker    /booking    
    ...             json=${booking_data}    
    ...             headers=${headers}    
    ...             expected_status=200
    
    ${booking_id}=    Set Suite Variable    ${BOOKING_ID}    ${response.json()}[bookingid]
    Dictionary Should Contain Key    ${response.json()}    bookingid
    Should Be True    ${booking_id} > 0
    
Cenario 03: Consultar reserva específica
    [Documentation]  Testa a consulta de uma reserva específica
    [Tags]          GET    FUNCTIONAL
    [Setup]         Run Keyword If    "${BOOKING_ID}" == "${None}"    Criar Reserva Temporaria
    ${response}=    GET On Session    booker    /booking/${BOOKING_ID}
    ...             expected_status=200
    Validate Booking Data    ${response.json()}
    
Cenario 04: Atualizar reserva
    [Documentation]  Testa a atualização de uma reserva existente
    [Tags]          PUT    CRITICAL
    [Setup]         Run Keyword If    "${BOOKING_ID}" == "${None}"    Criar Reserva Temporaria
    ${token}=       Gerar Token
    ${headers}=     Create Dictionary    
    ...             Content-Type=application/json    
    ...             Cookie=token=${token}    
    ...             Accept=application/json
    
    ${new_data}=    Create Dictionary    
    ...             firstname=${DEFAULT_FIRSTNAME}    
    ...             lastname=Santos  # Sobrenome atualizado
    
    ${response}=    PUT On Session    booker    /booking/${BOOKING_ID}    
    ...             json=${new_data}    
    ...             headers=${headers}    
    ...             expected_status=200
    
    Should Be Equal    ${response.json()}[lastname]    Santos
    Should Be Equal    ${response.json()}[firstname]    ${DEFAULT_FIRSTNAME}
    
Cenario 05: Deletar reserva
    [Documentation]  Testa a exclusão de uma reserva
    [Tags]          DELETE    CRITICAL
    [Setup]         Run Keyword If    "${BOOKING_ID}" == "${None}"    Criar Reserva Temporaria
    ${token}=       Gerar Token
    ${headers}=     Create Dictionary    
    ...             Content-Type=application/json    
    ...             Cookie=token=${token}
    
    ${response}=    DELETE On Session    booker    /booking/${BOOKING_ID}    
    ...             headers=${headers}    
    ...             expected_status=201
    
    # Verificar que a reserva foi realmente excluída
    ${get_response}=    Run Keyword And Expect Error    *    
    ...             GET On Session    booker    /booking/${BOOKING_ID}    
    ...             expected_status=404
    Should Contain    ${get_response}    404
    Should Contain    ${get_response}    Not Found

*** Keywords ***
Criar Reserva Temporaria
    [Documentation]  Cria uma reserva temporária para testes que necessitam de um ID existente
    ${headers}=     Create Dictionary    Content-Type=application/json
    ${booking_dates}=    Create Dictionary    
    ...             checkin=2024-01-01    
    ...             checkout=2024-01-05
    
    ${booking_data}=    Create Dictionary    
    ...             firstname=Temporario    
    ...             lastname=Reserva    
    ...             totalprice=100    
    ...             depositpaid=${true}    
    ...             bookingdates=${booking_dates}
    
    ${response}=    POST On Session    booker    /booking    
    ...             json=${booking_data}    
    ...             headers=${headers}
    ${booking_id}=    Set Suite Variable    ${BOOKING_ID}    ${response.json()}[bookingid]
    [Return]    ${booking_id}

Validate Booking Data
    [Documentation]  Valida os dados básicos de uma reserva
    [Arguments]     ${booking_data}
    Dictionary Should Contain Key    ${booking_data}    firstname
    Dictionary Should Contain Key    ${booking_data}    lastname
    Dictionary Should Contain Key    ${booking_data}    totalprice
    Dictionary Should Contain Key    ${booking_data}    depositpaid
    Dictionary Should Contain Key    ${booking_data}    bookingdates
    Dictionary Should Contain Key    ${booking_data["bookingdates"]}    checkin
    Dictionary Should Contain Key    ${booking_data["bookingdates"]}    checkout