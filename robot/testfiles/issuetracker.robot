*** Variables ***

${headers}    

** Settings ***
Test Setup                Set Log Level    TRACE
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections
Library     FakerLibrary
Resource    ../helpers/issuetracker_generic.robot
Documentation  API Testing in Robot Framework




*** Variables ***
${get_mock_server}    https://1f039692-0e8c-437d-a03f-fea5c10f39e9.mock.pstmn.io/complexjson
${user_creation_url}    https://1f039692-0e8c-437d-a03f-fea5c10f39e9.mock.pstmn.io/mock/post
${spring_boot_issue_tracker}    https://spring-boot-issue-tracker.herokuapp.com
${id_to_be_deleted}

*** Test Cases ***
# Get all issues
#     Create Session    session    https://spring-boot-issue-tracker.herokuapp.com/api/issues
#     ${resp_issues}=   GET On Session      session      /      expected_status=200
#     ${resp_issues}    Set Variable    ${resp_issues.json()}
#     Log To Console    printing different values from response
#     Log To Console    ${resp_issues[0]['title']}
#     FOR      ${item}   IN    @{resp_issues}
#         Log To Console    ${item['id']}
#         Log To Console    ${item['description']}
#         Log To Console    ${item['assigneeName']}
#         Log To Console    ${item['status']}
#         Log To Console    'next item'
#     END

# Create issue by modifying json from file and then post
#     [tags]  create_issue
#     ${headers}      Create Dictionary             Content-Type=application/json    Accept=*/*    Accept-Encoding=gzip, deflate, br    Connection=keep-alive    
#     ${body}    Load JSON From File    issuetracker.json
#     ${dictionary}    Convert To Dictionary    ${body}
#     ${created_number}    Set Variable    
#     set to dictionary    ${dictionary}    assigneeName=the new value
#     Log To Console    ${body}
#     ${resp}=     POST     ${spring_boot_issue_tracker}/api/issues    json=${dictionary}    headers=${headers}
#     ${resp_body}    Set Variable    ${resp.json()}
#     Log To Console    ${resp_body}
    
# POST issue by using faker
#     [tags]  create_issue
#     ${headers}    Create Dictionary    Content-Type=application/json    Accept=*/*    Accept-Encoding=gzip, deflate, br    Connection=keep-alive    
#     ${dictionary}    Create Dictionary
#     ${dictionary}    issuetracker_generic.Generate faker data for issuetracker
#     ${write_out_file_name}    Set Variable    ${TEST NAME}.json
#     Dump JSON To File    ..\\results\\${write_out_file_name}    ${dictionary}
#     Log To Console    ${dictionary}
#     ${resp}=     POST     ${spring_boot_issue_tracker}/api/issues    json=${dictionary}    headers=${headers}
#     ${resp_body}    Set Variable    ${resp.json()}
#     issuetracker_generic.Response should contain the values    ${resp_body}    ${dictionary}



# Get issues returned
#     ${all_issues}    issuetracker_generic.Get all issues returned in dictionary
#     FOR      ${item}   IN    @{all_issues}
#         Log To Console    ${item['id']}
#         Log To Console    ${item['description']}
#         Log To Console    ${item['assigneeName']}
#         Log To Console    ${item['status']}
#         Log To Console    'next item'
#     END

 Delete by id
    [Tags]  delete_by_id
    issuetracker_generic.Delete issue    ${id_to_be_deleted}


Create issue with fake data
    [Tags]    create_issue  issuetracker
    issuetracker_generic.Post issue


Delete the last entry in the db
    [Tags]    delete_last_entry
    issuetracker_generic.Delete last entry in db

Get all issues
    [Tags]    print_all_issues  issuetracker
    ${dict}    issuetracker_generic.Get all issues returned in dictionary
    Log To Console    ${dict}



