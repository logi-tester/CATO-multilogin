*** Settings ***
Test Teardown     Close Browser
Library           SeleniumLibrary
Library           ExcelLibrary

*** Variables ***    
${Excel_file_name}    credential_details.xls
${SheetName}      Sheet1

*** Test Cases ***
Multiple login
    Jenkins browser launch
    Open Excel    ${CURDIR}/${Excel_file_name}
    ${userName}=    Read Cell Data By Coordinates    ${SheetName}    0    1
    ${userPass}=    Read Cell Data By Coordinates    ${SheetName}    1    1
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Admin login successfully
    ${userName}=    Read Cell Data By Coordinates    ${SheetName}    0    2
    ${userPass}=    Read Cell Data By Coordinates    ${SheetName}    1    2
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Creator login successfully
    ${userName}=    Read Cell Data By Coordinates    ${SheetName}    0    3
    ${userPass}=    Read Cell Data By Coordinates    ${SheetName}    1    3
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Marketing module login successfully
    ${userName}=    Read Cell Data By Coordinates    ${SheetName}    0    4
    ${userPass}=    Read Cell Data By Coordinates    ${SheetName}    1    4
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Reviewer login successfully

*** Keywords ***
Multilogin_repeated
    Click Button    id=form_login
    Wait Until Element Is Visible    id=loginuser    25s
    Mouse Over    id=loginuser
    Click Element    xpath=.//ul[@class='dropdown-menu welcome-icon']/li/span

Jenkins browser launch
    Set Selenium Speed    1s
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-gpu
    Call Method    ${chrome_options}    add_argument    no-sandbox
    Create WebDriver    Chrome    chrome_options=${chrome_options}
    Go To    http://webtest.xerago.com/cvm/
    Maximize Browser Window
    Set Browser Implicit Wait    15s
