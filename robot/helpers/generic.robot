*** Settings ***
Documentation       Common keywords

Library             FakerLibrary
Library    JSONLibrary
Library    Collections
Library    RequestsLibrary
Library      OperatingSystem
*** Variables ***
${spring_boot_issue_tracker}    https://spring-boot-issue-tracker.herokuapp.com
${headers_for_postman_mock}



*** Keywords ***
get all entries
    [Arguments]    ${base_uri}    ${path}    ${headers}
    Create Session    session    ${base_uri}    ${headers}
    ${resp_issues}=   GET On Session      session      ${path}      expected_status=200
    ${resp_issues}    Set Variable    ${resp_issues.json()}
    RETURN From Keyword    ${resp_issues}

creating header for mock server
    

return header for mock
    [Arguments]    ${match-request-header}    ${headerName}    
    ${headers_for_postman_mock}    Create Dictionary    Content-Type=application/json    Accept=*/*    Accept-Encoding=gzip, deflate, br
...    Connection=keep-alive    x-mock-match-request-headers=${match-request-header}    headerName=${headerName}
    Return From Keyword    ${headers_for_postman_mock}
    
    
