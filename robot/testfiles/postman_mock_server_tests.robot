*** Settings ***
Test Setup                Set Log Level    TRACE
Documentation  API Testing in Robot Framework
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections
Resource    ../helpers/generic.robot

*** Variables ***
${postman_base_url}     https://api.postman.com/workspaces
${get_mock_server}    https://1f039692-0e8c-437d-a03f-fea5c10f39e9.mock.pstmn.io/complexjson
${api_key_postman}    
${user_creation_url}    https://1f039692-0e8c-437d-a03f-fea5c10f39e9.mock.pstmn.io/mock/post

*** Test Cases ***
BearerAuth
    ${headers}      Create Dictionary       x-api-key=${api_key_postman}       Content-type=application/json
    #Create Session    mysession    ${postman_base_url}
    ${resp}=     Get  ${postman_base_url}     headers=${headers}
    ${resp_body}    Set Variable    ${resp.json()}
    Log     ${resp_body}
    ${workspaces}     Set Variable    ${resp_body['workspaces'][0]['id']}
    Log    ${workspaces}
    Log     ${resp_body['workspaces'][1]['id']}
    Log     ${resp_body['workspaces'][1]['name']}

mock example 1
    [tags]  simple_two
    ${headers}      Create Dictionary             Content-type=application/json    headerName=value2    x-mock-match-request-headers=headerName
    #Create Session    mysession    ${get_mock_server}    headers=${headers}
    ${resp}=     GET        ${get_mock_server}/two         headers=${headers}  
    ${resp_body}    Set Variable    ${resp.json()}
    Log    " "
    Log    ${resp_body['data']}
    Log    ${resp_body['messages']}
    Log    ${resp_body['success']}

mock example 1 more nested
    [tags]  simple_two
    ${headers}      Create Dictionary             Content-type=application/json    headerName=value2    x-mock-match-request-headers=headerName
    ${resp}=     GET        ${get_mock_server}/two         headers=${headers}  
    ${resp_body}    Set Variable    ${resp.json()}
    log    " "
    log    ${resp_body['data']}
    FOR      ${item}   IN    @{resp_body['data']}
        log    ${item['mainId']}
        log    ${item['firstName']}
        log    ${item['lastName']}
        log    'next item'
    END
    log    ${resp_body['messages']}
    log    ${resp_body['success']}
mock example 1 nested nested
    [tags]  simple_two
    ${headers}      Create Dictionary            Content-type=application/json    headerName=value2    x-mock-match-request-headers=headerName
    ${resp}=     GET        ${get_mock_server}/two         headers=${headers}  
    ${resp_body}    Set Variable    ${resp.json()}
    log    " "
    FOR      ${item}   IN    @{resp_body['data']}
        log    ${item['mainId']}
        log    ${item['firstName']}
        log    ${item['lastName']}
        FOR      ${item_nested}   IN    @{item['categories']}
            log    ${item_nested['categoryID']}
            log    ${item_nested['categoryName']}

        END
        log    'next item'
    END
    log    ${resp_body['messages']}
    log    ${resp_body['success']}

mock example 1 get from dictionary
    [tags]  simple_two
    ${headers}      Create Dictionary              Content-type=application/json    headerName=value2    x-mock-match-request-headers=headerName
    ${resp}=     GET        ${get_mock_server}/two         headers=${headers}  
    ${resp_body}    Set Variable    ${resp.json()}
    log    ${resp_body}
    log    ${resp_body['data']}
    ${content_type_header}    Get From Dictionary    ${resp.headers}    Content-Type
    Should Be Equal    ${content_type_header}    application/json; charset=utf-8
    log    ${content_type_header}

mock example 1 convert to string
    [tags]  simple_two
    ${headers}      Create Dictionary             Content-type=application/json    headerName=value2    x-mock-match-request-headers=headerName
    ${resp}=     GET        ${get_mock_server}/two         headers=${headers}  
    ${resp_body}    Set Variable    ${resp.json()}
    log    ${resp_body}
    log    ${resp_body}
    ${content_type_header}    Get From Dictionary    ${resp.headers}    Content-Type
    Should Be Equal    ${content_type_header}    application/json; charset=utf-8
    log    ${content_type_header}



