*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    String
Library    lib.py

*** Variables ***
${baseUrl}    https://reqres.in/api

*** Keywords ***
status code should be
    [Arguments]    ${expectedStatusCode}
    Status Should Be    ${expectedStatusCode}