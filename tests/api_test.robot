*** Settings ***
Resource    ../resources/common_api.resource
Suite Setup    Setup API Session

*** Test Cases ***
TC01 - ทดสอบดึงข้อมูลผู้ใช้งาน
    ${response}=    GET On Session    alias=my_api    url=/users/2    expected_status=200
    Should Be Equal As Strings    ${response.json()['firstName']}    Michael
    Should Be Equal As Strings    ${response.json()['lastName']}    Williams
    Should Be Equal As Strings    ${response.json()['email']}    michael.williams@x.dummyjson.com

TC02 - ทดสอบสร้างผู้ใช้งานใหม่
    &{body}=    Create Dictionary    firstName=Natchanon     lastName=Tienthong  
    ${response}=    POST On Session    alias=my_api    url=/users/add   json=${body}    expected_status=201
    Should Be Equal As Strings    ${response.json()['firstName']}    Natchanon
    Should Be Equal As Strings    ${response.json()['lastName']}    Tienthong

TC03 - ทดสอบค้นหาผู้ใช้งานที่ไม่มีในระบบ
    ${response}=    GET On Session    alias=my_api    url=/users/9999   expected_status=404

TC04 - ทดสอบ Login ไม่สำเร็จกรณีไม่ส่งรหัสผ่าน
    &{body}=    Create Dictionary    username=emilys
    ${response}=    POST On Session    alias=my_api    url=/auth/login   json=${body}    expected_status=400
    Should Be Equal As Strings    ${response.json()['message']}    Username and password required

TC05 - ทดสอบแก้ไขข้อมูลผู้ใช้งาน
    &{body}=    Create Dictionary    lastName=Updated
    ${response}=    PUT On Session    alias=my_api    url=/users/2   json=${body}    expected_status=200
    Should Be Equal As Strings    ${response.json()['lastName']}    Updated

TC06 - ทดสอบลบผู้ใช้งาน
    ${response}=    DELETE On Session    alias=my_api    url=/users/2   expected_status=200

TC07 - ทดสอบ Login สำเร็จและนำ Token ไปใช้งานต่อ
    ${token}=         Get Auth Token    username=emilys    password=emilyspass
    &{my_headers}=    Create Dictionary    Authorization=Bearer ${token}
    GET On Session    alias=my_api    url=/auth/me    headers=${my_headers}    expected_status=200

