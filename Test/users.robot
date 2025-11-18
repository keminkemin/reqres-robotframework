*** Settings ***
Resource    ../Resource/users.resource

*** Test Cases ***
Verify user able to get users list from page 1 and page 2
    user hit users list in page    1
    status code should be    200
    user data not empty
    user hit users list in page    2
    status code should be    200
    user data not empty

Verify user not able to get user list from page 3 and more
    user hit users list in page    3
    status code should be    200
    user data empty

Verify user can create new user
    user create new user
    status code should be    201

Verify user can update existing user
    user update existing user
    status code should be    200

Verify user can delete existing user
    user delete existing user
    status code should be    204