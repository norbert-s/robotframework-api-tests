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
    Log To Console    ${workspaces}
    Log To Console    ${resp_body['workspaces'][1]['id']}
    Log To Console    ${resp_body['workspaces'][1]['name']}

mock example 1
    [tags]  simple_two
    ${headers}      Create Dictionary             Content-type=application/json    headerName=value2    x-mock-match-request-headers=headerName
    #Create Session    mysession    ${get_mock_server}    headers=${headers}
    ${resp}=     GET        ${get_mock_server}/two         headers=${headers}  
    ${resp_body}    Set Variable    ${resp.json()}
    Log To Console    " "
    Log To Console    ${resp_body['data']}
    Log To Console    ${resp_body['messages']}
    Log To Console    ${resp_body['success']}

mock example 1 more nested
    [tags]  simple_two
    ${headers}      Create Dictionary             Content-type=application/json    headerName=value2    x-mock-match-request-headers=headerName
    ${resp}=     GET        ${get_mock_server}/two         headers=${headers}  
    ${resp_body}    Set Variable    ${resp.json()}
    Log To Console    " "
    Log To Console    ${resp_body['data']}
    FOR      ${item}   IN    @{resp_body['data']}
        Log To Console    ${item['mainId']}
        Log To Console    ${item['firstName']}
        Log To Console    ${item['lastName']}
        Log To Console    'next item'
    END
    Log To Console    ${resp_body['messages']}
    Log To Console    ${resp_body['success']}
mock example 1 nested nested
    [tags]  simple_two
    ${headers}      Create Dictionary            Content-type=application/json    headerName=value2    x-mock-match-request-headers=headerName
    ${resp}=     GET        ${get_mock_server}/two         headers=${headers}  
    ${resp_body}    Set Variable    ${resp.json()}
    Log To Console    " "
    FOR      ${item}   IN    @{resp_body['data']}
        Log To Console    ${item['mainId']}
        Log To Console    ${item['firstName']}
        Log To Console    ${item['lastName']}
        FOR      ${item_nested}   IN    @{item['categories']}
            Log To Console    ${item_nested['categoryID']}
            Log To Console    ${item_nested['categoryName']}

        END
        Log To Console    'next item'
    END
    Log To Console    ${resp_body['messages']}
    Log To Console    ${resp_body['success']}

mock example 1 get from dictionary
    [tags]  simple_two
    ${headers}      Create Dictionary              Content-type=application/json    headerName=value2    x-mock-match-request-headers=headerName
    ${resp}=     GET        ${get_mock_server}/two         headers=${headers}  
    ${resp_body}    Set Variable    ${resp.json()}
    Log To Console    ${resp_body}
    Log To Console    ${resp_body['data']}
    ${content_type_header}    Get From Dictionary    ${resp.headers}    Content-Type
    Should Be Equal    ${content_type_header}    application/json; charset=utf-8
    Log To Console    ${content_type_header}

mock example 1 convert to string
    [tags]  simple_two
    ${headers}      Create Dictionary             Content-type=application/json    headerName=value2    x-mock-match-request-headers=headerName
    ${resp}=     GET        ${get_mock_server}/two         headers=${headers}  
    ${resp_body}    Set Variable    ${resp.json()}
    Log To Console    ${resp_body}
    Log To Console    ${resp_body}
    ${content_type_header}    Get From Dictionary    ${resp.headers}    Content-Type
    Should Be Equal    ${content_type_header}    application/json; charset=utf-8
    Log To Console    ${content_type_header}



