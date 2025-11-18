*** Settings ***
Resource    ./init.resource

*** Keywords ***
user hit users list in page
    [Arguments]    ${page}
    ${params}=  Create Dictionary    page=${page}
    ${headers}=  Create Dictionary    x-api-key=reqres-free-v1
    Create Session  users  ${baseUrl}  disable_warnings=1
    ${usersList}=  GET On Session  users  /users  headers=${headers}  params=${params}  expected_status=Anything
    ${usersListJson}=  Set Variable  ${usersList.json()}
    Set Test Variable    ${usersListJson}

user data not empty
    ${data}=    Get Value From Json    ${usersListJson}    $.data
    ${data}=    Set Variable    ${data[0]}
    Length Should Be    ${data}    6

user data empty
    ${data}=    Get Value From Json    ${usersListJson}    $.data
    ${data}=    Set Variable    ${data[0]}
    Length Should Be    ${data}    0

user hit without api key 
    [Arguments]    ${page}
    ${params}=  Create Dictionary    page=${page}
    Create Session  users  ${baseUrl}  disable_warnings=1
    ${usersList}=  GET On Session  users  /users  params=${params}  expected_status=Anything
    ${usersListJson}=  Set Variable  ${usersList.json()}
    Set Test Variable    ${usersListJson}

user create new user
    ${json}=  Create Dictionary  name=morpheus  job=leader
    ${headers}=  Create Dictionary    x-api-key=reqres-free-v1
    Create Session  users  ${baseUrl}  disable_warnings=1
    ${createUser}=  POST On Session  users  /users  headers=${headers}  json=${json}  expected_status=Anything
    ${createUserJson}=  Set Variable  ${createUser.json()}
    Set Test Variable  ${createUserJson}

user update existing user
    ${json}=  Create Dictionary  name=morpheus  job=zion resident
    ${headers}=  Create Dictionary    x-api-key=reqres-free-v1
    Create Session  users  ${baseUrl}  disable_warnings=1
    ${updateUser}=  PUT On Session  users  /users/2  headers=${headers}  json=${json}  expected_status=Anything
    ${updateUserJson}=  Set Variable  ${updateUser.json()}
    Set Test Variable  ${updateUserJson}

user delete existing user
    ${headers}=  Create Dictionary    x-api-key=reqres-free-v1
    Create Session  users  ${baseUrl}  disable_warnings=1
    ${deleteUser}=  DELETE On Session  users  /users/2  headers=${headers}  expected_status=Anything