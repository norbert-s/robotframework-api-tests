*** Settings ***
Documentation       Common keywords

Library    FakerLibrary
Library    JSONLibrary
Library    Collections
Library    RequestsLibrary
Library    OperatingSystem

Library    ../../python/helper/CheckingString.py

*** Variables ***
${spring_boot_issue_tracker}    https://spring-boot-issue-tracker.herokuapp.com
${headers}    Create Dictionary    Content-Type=application/json    Accept=*/*    Accept-Encoding=gzip, deflate, br    Connection=keep-alive    
${on_delete_response_issue_tracker}   Deleted issue id - 


*** Keywords ***
#Setup tests for spring boot issuetracker
#    [Arguments]    ${headers}
#    Set Log Level    Trace
#    ${headers}    Create Dictionary    Content-Type=application/json    Accept=*/*    Accept-Encoding=gzip, deflate, br    Connection=keep-alive

Post issue
    [tags]  create_issue
    #${dictionary}    Load JSON From File        ../resource/issuetracker.json
    ${dictionary}    Create Dictionary            title=""    description=""    assigneeName=""    status=""
    ${dictionary}    Generate faker data for issuetracker
    #${write_out_file_name}    Set Variable    ${TEST NAME}.json
    #Dump JSON To File    ..\\results\\${write_out_file_name}    ${dictionary}
    Log To Console    ${dictionary}
    ${resp}=     POST     ${spring_boot_issue_tracker}/api/issues    json=${dictionary}    headers=${headers}
    ${resp_body}    Set Variable    ${resp.json()}
    Response should contain the values    ${resp_body}    ${dictionary}
    
Delete last entry in db
    ${all_issues}    Get all issues returned in dictionary
    ${length}    Get Length     ${all_issues}
    ${length}    Convert To Integer    ${length}
    Log To Console    ${length}
    #Log To Console    ${all_issues[${length-1}]['id']}
    ${id_of_last_element}    Set Variable            ${all_issues[${length-1}]['id']}
    ${resp_body}    Delete issue    ${id_of_last_element}
    #Should Contain    ${resp_body}    ${on_delete_response_issue_tracker} ${id_of_last_element}
                #python function to check the value of string on deletion
    ${result}    Check Response    ${resp_body}    ${on_delete_response_issue_tracker}      ${id_of_last_element}
    Should Be True    ${result}

Delete issue
    [tags]  delete_issue
    [Arguments]    ${id_to_delete}

    ${resp}=     DELETE     ${spring_boot_issue_tracker}/api/issues/${id_to_delete}    headers=${headers}
    ${resp_body}    Set Variable    ${resp.text}
    #${write_out_file_name}    Set Variable    ${TEST NAME}.text
    #Create File    ..\\result\\${write_out_file_name}    ${resp_body}
    Log To Console    ${resp_body}
    #Response should contain the values    ${resp_body}    ${id_to_delete}
    Return From Keyword    ${resp_body}

Get all issues returned in dictionary
    Create Session    session    ${spring_boot_issue_tracker}/api/issues
    ${resp_issues}=   GET On Session      session      /      expected_status=200
    ${resp_issues}    Set Variable    ${resp_issues.json()}
    RETURN From Keyword    ${resp_issues}


# Get all issues printed out
#     FOR      ${item}   IN    @{resp_issues}
#         Log To Console    ${item['id']}
#         Log To Console    ${item['description']}
#         Log To Console    ${item['assigneeName']}
#         Log To Console    ${item['status']}
#         Log To Console    'next item'
#     END

#better from variable file
Generate faker data for issuetracker 
    [Arguments] 
    ${dictionary}    Create Dictionary
    ${name}            FakerLibrary.Name
    ${title}            FakerLibrary.Text    max_nb_chars=35
    ${description}    FakerLibrary.Text    max_nb_chars=60
    ${status}           FakerLibrary.Word
    set to dictionary    ${dictionary}    title=${title}
    set to dictionary    ${dictionary}   assigneeName=${name}
    set to dictionary    ${dictionary}    description=${description}
    set to dictionary    ${dictionary}    status=${status}
    Log To Console    ${dictionary['title']}
    Return From Keyword     ${dictionary}

Response should contain the values
    [Arguments]    ${response_body}    ${dictionary}
    Dictionary Should Contain Value    ${response_body}    ${dictionary['title']}
    Dictionary Should Contain Value    ${response_body}    ${dictionary['assigneeName']}
    Dictionary Should Contain Value    ${response_body}    ${dictionary['description']}
    Dictionary Should Contain Value    ${response_body}    ${dictionary['status']}
