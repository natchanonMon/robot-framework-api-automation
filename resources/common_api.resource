*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}    https://dummyjson.com

*** Keywords ***
Setup API Session
    Create Session    alias=my_api    url=${BASE_URL}    verify=${True}

Get Auth Token
    [Arguments]    ${username}    ${password}
    &{login_body}=        Create Dictionary    username=${username}    password=${password}
    ${login_response}=    POST On Session      alias=my_api    url=/auth/login    json=${login_body}    expected_status=200
    ${token}=             Set Variable         ${login_response.json()['accessToken']}
    RETURN                ${token}
