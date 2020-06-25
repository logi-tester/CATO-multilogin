*** Settings ***
Test Teardown     Close Browser
Library           SeleniumLibrary
Library           ExcelLibrary

*** Variables ***
${Names}          ${EMPTY}
${Num}            ${EMPTY}
${Excel_File_Path}    H:\\Logi\\Robot_Pro\\LibraryDemo\\
${SheetName}      Sheet1
${NewSheetName}    NewSheet

*** Test Cases ***
Multiple login
    Open Browser    http://webtest.xerago.com/cvm/    chrome
    Set Selenium Implicit Wait    30s
    Maximize Browser Window
    Open Excel Current Directory    testdata.xls
    ${userName}=    Read Cell Data By Coordinates    Sheet1    0    1
    ${userPass}=    Read Cell Data By Coordinates    Sheet1    1    1
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Admin login successfully
    ${userName}=    Read Cell Data By Coordinates    Sheet1    0    2
    ${userPass}=    Read Cell Data By Coordinates    Sheet1    1    2
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Creator login successfully
    ${userName}=    Read Cell Data By Coordinates    Sheet1    0    3
    ${userPass}=    Read Cell Data By Coordinates    Sheet1    1    3
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Marketing module login successfully
    ${userName}=    Read Cell Data By Coordinates    Sheet1    0    4
    ${userPass}=    Read Cell Data By Coordinates    Sheet1    1    4
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Reviewer login successfully

*** Keywords ***
Multilogin_repeated
    Click Button    id=form_login
    Wait Until Element Is Visible    id=loginuser    25s
    Log To Console    Creator login success
    Mouse Over    id=loginuser
    Click Element    xpath=.//ul[@class='dropdown-menu welcome-icon']/li/span
