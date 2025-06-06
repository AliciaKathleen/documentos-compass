*** Keywords ***
Criar Sessão API
    [Arguments]    ${url}
    Create Session    api_session    ${url}

Fazer Login
    [Arguments]    ${email}    ${password}
    ${headers}=    Create Dictionary    Content-Type=${CONTENT_TYPE}
    ${body}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    api_session    /auth/login    json=${body}    headers=${headers}
    [Return]    ${response}

Status da Resposta Deve Ser
    [Arguments]    ${expected_status}    ${response}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}

Verificar Token na Resposta
    [Arguments]    ${response}
    Dictionary Should Contain Key    ${response.json()}    token

Cadastrar Usuário
    [Arguments]    ${email}    ${password}
    ${headers}=    Create Dictionary    Content-Type=${CONTENT_TYPE}
    ${body}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    api_session    /users    json=${body}    headers=${headers}
    [Return]    ${response}

Fazer Login Com Token Expirado
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${response}=    GET On Session    api_session    /auth/validate    headers=${headers}
    [Return]    ${response}