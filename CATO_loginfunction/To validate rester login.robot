*** Settings ***
Test Teardown     Close Browser
Library           SeleniumLibrary
Library           ExcelLibrary

*** Variables ***
${excel_file_name}    credential_details.xls
${SheetName}      Sheet1
${baseurl}        http://webtest.xerago.com/cvm/

*** Test Cases ***
To enter valid username & valid password
    Jenkins browser launch
    Open Excel    ${CURDIR}\\${excel_file_name}
    ${userName}=    Read Cell Data By Coordinates    Sheet1    0    4
    ${userPass}=    Read Cell Data By Coordinates    Sheet1    1    4
    Input Text    id=form_username    ${userName}
    Input Text    id=form_password    ${userPass}
    Multilogin_repeated
    Log To Console    Marketing module login successfully

To Enter valid username & Invalid password
    Jenkins browser launch
    Input Text    xpath=(.//*[@type='text'])[1]    CreatorAdmincreator
    Input Text    xpath=(.//*[@type='text'])[2]
    Click Element    xpath=(.//*[@type='submit'])[1]
    Page Should Contain    Please enter your password

To Enter Invalid username & valid password
    Jenkins browser launch
    Input Text    xpath=(.//*[@type='text'])[1]
    Input Text    xpath=(.//*[@type='text'])[2]    CreatorAdmin123
    Click Element    xpath=(.//*[@type='submit'])[1]
    Page Should Contain    Please enter your username

To Enter Invalid username & Invalid password
    Jenkins browser launch
    Input Text    xpath=(.//*[@type='text'])[1]
    Input Text    xpath=(.//*[@type='text'])[2]
    Click Element    xpath=(.//*[@type='submit'])[1]
    Page Should Contain    Please enter your username and password to login

*** Keywords ***
Jenkins browser launch
    Set Selenium Speed    1s
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-gpu
    Call Method    ${chrome_options}    add_argument    no-sandbox
    Create WebDriver    Chrome    chrome_options=${chrome_options}
    Go To    ${baseurl}
    Maximize Browser Window
    Set Browser Implicit Wait    15s

Multilogin_repeated
    Click Button    id=form_login
    Wait Until Element Is Visible    id=loginuser    25s
    Mouse Over    id=loginuser
    Click Element    xpath=.//ul[@class='dropdown-menu welcome-icon']/li/span
