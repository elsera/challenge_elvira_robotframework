*** Settings ***
Library     SeleniumLibrary
Documentation       Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}      Chrome
${SIGNINBUTTON}     xpath=//button[@type='submit']
${PASSWORDINPUT}        xpath=//*[@id='password']
${LOGININPUT}       xpath=//*[@id='login']
${PAGELOGO}     xpath=//div[3]/div[1]/div/div[2]/h2
${DATA VALIDATION MESSAGE}      xpath=//*[contains(text(),'password invalid')]
${DATA EMPTY MESSAGE}       xpath=//*[contains(text(),'provide your username')]
${REMIND PASSWORD HYPERLINK}        xpath=//child::div/a
${REMIND PASSWORD TITLE}        xpath=//h5
${EMAIL INPUT}     xpath=//input[@name='email']
${SEND BUTTON}      xpath=//button[@type='submit']
${ALERT MESSAGE}       xpath=//*[@role='alert']
${LANGUAGE BUTTON}        xpath=//*[@aria-haspopup='listbox']
${LANGUAGE PL}        xpath=//*[@data-value='pl']
${SIGN OUT BUTTON}      xpath=//ul[2]/div[2]
${ADD PLAYER HYPERLINK}     xpath=(//a[1]/button)[1]
${NAME INPUT}       xpath=//input[@name='name']
${SURNAME INPUT}        xpath=//input[@name='surname']
${PHONE INPUT}      xpath=//input[@name='phone']
${WEIGHT INPUT}     xpath=//input[@name='weight']
${HEGHT INPUT}      xpath=//input[@name='height']
${AGE INPUT}        xpath=//input[@name='age']
${CLUB INPUT}       xpath=//input[@name='club']
${LEVEL INPUT}      xpath=//input[@name='level']
${MAIN POSITION INPUT}      xpath=//input[@name='mainPosition']
${SECOND POSITION INPUT}        xpath=//input[@name='secondPosition']
${DISTRICT BUTTON}      xpath=//*[@id='mui-component-select-district']
${DISTRICT BUTTON_LIST}     xpath=//*[@id='menu-district']//li
${DISTRICT OPOLE}       xpath=//*[@data-value='opolskie']
${SUBMIT BUTTON}        xpath=//button[@type='submit']
${EDIT PLAYER TITLE}        xpath=//*[@class='MuiCardHeader-root']//span
${CLEAR BUTTON}     xpath=//button[contains(@class,'containedSecondary')]

*** Test Cases ***
Login to the system with valid user data
    Open login page
    Type in email
    Type in password
    Click on the Signin Button
    Assert Dashboard
    [Teardown]      Close Browser

Login to the system with invalid user data
    Open login page
    Type in invalid email
    Type in invalid password
    Click on the Signin Button
    Assert validation message
    [Teardown]      Close Browser

Login to the system with empty email and password
    Open login page
    Click on the Signin Button
    Assert empty data message
    [Teardown]      Close Browser

Test remind password on Log in page
    Open login page
    Click on the Remind Password link
    Assert Remind Password page
    [Teardown]      Close Browser

Send email on remind password page
    Open login page
    Click on the Remind Password link
    Type in remember email
    Click on the Send Button
    Assert Successfull message
    [Teardown]      Close Browser

Check change language option on login page
    Open login page
    Click on Language Button
    Choose language from a list
    Assert selected language
    [Teardown]      Close Browser

Log out of the system
    Open login page
    Type in email
    Type in password
    Click on the Signin Button
    Click on the Signout Button
    Assert Login Page
    [Teardown]      Close Browser

Add a new player
    Open login page
    Type in email
    Type in password
    Click on the Signin Button
    Click on Add Player link
    Type in Player Email
    Type in Name
    Type in Surname
    Type in Phone
    Type in Weight
    Type in Height
    Type in Age
    Type in Club
    Type in Level
    Type in Main Position
    Type in Second Position
    Choose District
    Click on Submit Button
    Assert Saved Player Message
    Assert Edit Page
    [Teardown]      Close Browser

Clear add player form
    Open login page
    Type in email
    Type in password
    Click on the Signin Button
    Click on Add Player link
    Type in Name
    Type in Surname
    Type in Age
    Type in Main Position
    Click on Clear Button
    Assert fields are empty
    [Teardown]      Close Browser

*** Keywords ***
Open login page
    Open Browser        ${LOGIN URL}        ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    Input Text      ${LOGININPUT}       user07@getnada.com
Type in password
    Input Text      ${PASSWORDINPUT}        Test-1234
Click on the Signin Button
    Click Element       ${SIGNINBUTTON}
Assert Dashboard
    Wait Until Element Is Visible       ${PAGELOGO}
    Title Should Be     Scouts panel
    Capture Page Screenshot     screenshots/dashboard.png
Type in invalid email
   Input Text      ${LOGININPUT}       abcd@abcd.com
Type in invalid password
    Input Text    ${PASSWORDINPUT}      123456789abcd
Assert validation message
    Wait Until Element Is Visible    ${DATA VALIDATION MESSAGE}
    Element Text Should Be      ${DATA VALIDATION MESSAGE}      Identifier or password invalid.
    Capture Page Screenshot     screenshots/login_page_validation_message.png
Assert empty data message
    Wait Until Element Is Visible    ${DATA EMPTY MESSAGE}
    Element Text Should Be      ${DATA EMPTY MESSAGE}     Please provide your username or your e-mail.
    Capture Page Screenshot     screenshots/login_page_empty_data_message.png
Click on the Remind Password link
    Click Element    ${REMIND PASSWORD HYPERLINK}
Assert Remind Password page
    Wait Until Element Is Visible       ${REMIND PASSWORD TITLE}
    Title Should Be    Remind password
    Capture Page Screenshot     screenshots/remind_password_page.png
Type in remember email
    Input Text      ${EMAIL INPUT}       test@abc.com
Click on the Send Button
    Click Element       ${SEND BUTTON}
Assert Successfull message
    Wait Until Element Is Visible       ${ALERT MESSAGE}
    Element Text Should Be      ${ALERT MESSAGE}   Message sent successfully.
    Capture Page Screenshot     screenshots/remind_password_email_sent.png
Click on Language Button
    Click Element    ${LANGUAGE BUTTON}
Choose language from a list
    Wait Until Page Contains Element       ${LANGUAGE PL}
    Click Element    ${LANGUAGE PL}
Assert Selected Language
    Wait Until Element Is Visible       ${LANGUAGE BUTTON}
    Element Text Should Be    ${LANGUAGE BUTTON}        Polski
    Capture Page Screenshot     screenshots/login_page_language_changed.png
Click on the Signout Button
    Wait Until Element Is Visible       ${SIGN OUT BUTTON}
    Click Element    ${SIGN OUT BUTTON}
Assert Login Page
    Title Should Be     Scouts panel - sign in
    Capture Page Screenshot     screenshots/login_page.png
Click on Add Player link
    Wait Until Element Is Visible    ${ADD PLAYER HYPERLINK}
    Click Element    ${ADD PLAYER HYPERLINK}
Type in Player Email
    Wait Until Element Is Visible    ${EMAIL INPUT}
    Input Text      ${EMAIL INPUT}       ronaldo@gmail.com
Type in Name
    Wait Until Element Is Visible    ${NAME INPUT}
    Input Text      ${NAME INPUT}       Cristiano
Type in Surname
    Input Text      ${SURNAME INPUT}       Ronaldo
Type in Phone
    Input Text      ${PHONE INPUT}       345678912345
Type in Weight
    Input Text      ${WEIGHT INPUT}       85
Type in Height
    Input Text      ${HEGHT INPUT}       185
Type in Age
    Input Text      ${AGE INPUT}  05.02.1985
Type in Club
    Input Text      ${CLUB INPUT}       Real Madrid
Type in Level
    Input Text      ${LEVEL INPUT}       High
Type in Main Position
    Input Text      ${MAIN POSITION INPUT}       Forward
Type in Second Position
    Input Text      ${SECOND POSITION INPUT}       Any
Choose District
    Click Element       ${DISTRICT BUTTON}
    Wait Until Element Is Visible       ${DISTRICT BUTTON_LIST}
    Click Element        ${DISTRICT OPOLE}
Click on Submit Button
    Wait Until Element Is Visible       ${SUBMIT BUTTON}
    Click Element        ${SUBMIT BUTTON}
Assert Saved Player message
    Wait Until Element Is Visible       ${ALERT MESSAGE}
    Element Text Should Be      ${ALERT MESSAGE}        Added player.
    Capture Page Screenshot     screenshots/new_player_added.png
Assert Edit Page
    Element Should Contain      ${EDIT PLAYER TITLE}        Edit player
    Capture Page Screenshot     screenshots/edit_player_form.png
Click on Clear Button
    Wait Until Element Is Visible       ${CLEAR BUTTON}
    Click Element        ${CLEAR BUTTON}
Assert fields are empty
    Element Text Should Be      ${NAME INPUT}       ${EMPTY}
    Element Text Should Be     ${SURNAME INPUT}     ${EMPTY}
    Element Text Should Be     ${AGE INPUT}     ${EMPTY}
    Element Text Should Be     ${MAIN POSITION INPUT}       ${EMPTY}
    Capture Page Screenshot     screenshots/Add_player_form_is_empty.png















