*** Settings ***
#Documentation    Suite description
Library  SeleniumLibrary

#*** Test Cases ***


*** Variables ***
${Gender_c_MW}  Couple (man/woman)
${Gender_c_2M}  Couple (2 women)
${Gender_c_2W}  Couple (2 mwn)




*** Keywords ***
Go to home page
    [Arguments]                         ${Site}
    ${Site_Link}=   catenate        SEPARATOR=      https://    ${Site}   .com/?lang=english
    Open Browser                        ${Site_Link}


Login
    [Arguments]                         ${Site}  ${Account}  ${Password}
    ${Site_Link}=   catenate        SEPARATOR=      https://    ${Site}   .com/p/logoff.cgi?
    Open Browser                        ${Site_Link}                                                 chrome
    Wait Until Page Contains Element    xpath://input[@id="handle_input_field"]                      20s
    Input Text                          xpath://input[@id="handle_input_field"]                      ${Account}
    Input Text                          xpath://input[@id="password_input_field"]                    ${Password}
    Click Button                        xpath://button[@id="login_btn"]

Login_cover
    [Arguments]                         ${Account}  ${Password}
    Wait Until Page Contains Element    xpath://input[@id="login_username_input"]                   5s
    Input Text                          xpath://input[@id="login_username_input"]                 ${Account}
    Input Text                          xpath://input[@id="login_password_input"]                 ${Password}
    Click Element                       xpath://input[@id="login_submit"]
    Wait Until Location Is Not          https://adultfriendfinder.com/?lang=english&debug_cookie=fake_ip:65.7.63.115        10s
    # Wait Until Page Contains Element    xpath://div[@class="logo"] 


    # Run Keyword If    ${confirm_TF}    Check confirm handle  ${Account}   ELSE   Confirm again   ${Site_Link}  ${Account}
    #    ${GetAccount}=      Get Text        xpath://span[@style="font-family:verdana"]
    #    Log To Console    ${GetAccount}
    #    ${GetPWSid}=      Get Text        xpath://font/b/a
    #    Log To Console    ${GetPWSid}

Register_Cover
    [Arguments]                         ${Gender}  ${Mail}  ${Account}  ${Password}
    Wait Until Element Is Visible       xpath://select[@id="fldID_REG_sex"]                         10s
    Select From List By Label           xpath://select[@id="fldID_REG_sex"]                         ${Gender}
    Select From List By Value           xpath://select[@id="bday_month"]                            5
    Select From List By Value           xpath://select[@id="bday_day"]                              08
    Select From List By Value           xpath://select[@id="bday_year"]                             1990
    Select From List By Value           xpath://select[@id="fldID_country"]                         United States
    Input Text                          xpath://input[@id="fldID_zip"]                              12155
    Click Element                       xpath://input[@id="fldID_butAction_1"]

    Wait Until Element Is Visible       xpath://input[@id="fldID_email"]                            10s
    Run Keyword If      '${Gender}' == '${Gender_c_MW}' or '${Gender}' == '${Gender_c_2W}' or '${Gender}' == '${Gender_c_2M}'   Select couple
    Input Text                          xpath://input[@id="fldID_email"]                            ${Mail}
    Input Text                          xpath://input[@id="fldID_REG_handle"]                       ${Account}
    Input Text                          xpath://input[@id="fldID_password"]                         ${Password}
    Input Text                          xpath://input[@id="fldID_title"]                            Nothing to say
    Click Element                       xpath://input[@id="fldID_butAction_2"]
    Wait Until Page contains Element    xpath://div[@class="reg_page_title"]                        60s

Register_Loop
    [Arguments]                         ${number}  ${Mail}  ${Account}  ${Password}  ${Admin_Account}  ${Admin_Password}
    Go To              https://adultfriendfinder.com/?lang=english&debug_cookie=fake_ip:65.7.63.115
    : FOR    ${INDEX}    IN RANGE    0    ${number}
    \    ${Account}=  Catenate   SEPARATOR=      ${Handle_Base}     ${INDEX}
    \    Register_Cover     ${Gender}  ${Mail}  ${Account}  ${Password}
    \    Log To Console    ${Account}
    \    Wait Until Page Contains Element       xpath://a[@id="email_resend_button"]                50s
    \    Confirm Admin      ${Admin_Account}  ${Admin_Password}  ${Account}
    \    sleep             5s 
    \    Go To             https://adultfriendfinder.com/?lang=english&debug_cookie=fake_ip:65.7.63.115

Register_5step
    [Arguments]                         ${Site}  ${Mail}  ${Account}  ${Password}
    ${Site_Link}=     catenate      SEPARATOR=    https://secure.  ${Site}  .com/p/register.cgi?pid=ff123
    Open Browser                        ${Site_Link}                                                Chrome

    Wait Until Page Contains Element    xpath://button[@data-form-submit="next"]
    Click Button                        xpath://button[@data-form-submit="next"]
    Select From List By Value           xpath://select[@id="bday_month"]                            5
    Select From List By Value           xpath://select[@id="bday_day"]                              08
    Select From List By Value           xpath://select[@id="bday_year"]                             1990
    Select From List By Value           xpath://select[@name="country"]                             United States
    Input Text                          xpath://input[@name="zip"]                                  12155
    Click Button                        xpath:(//button[@data-form-submit="next"])[2]

    Wait Until Element Is Visible       xpath://input[@name="email"]                                10s
    Input Text                          xpath://input[@name="email"]                                ${Mail}
    Input Text                          xpath://input[@name="REG_handle"]                           ${Account}
    Input Text                          xpath://input[@name="password"][@data-password-meter="true"]  ${Password}
    Click Button                        xpath:(//button[@data-form-submit="next"])[3]

    Wait Until Element Is Visible       xpath:(//button[@data-form-submit="next"])[4]               10s
    Click Button                        xpath:(//button[@data-form-submit="next"])[4]

    Wait Until Element Is Visible       xpath://input[@name="title"]                                10s
    Input Text                          xpath://input[@name="title"]                                Nothing to say
    Click Button                        xpath://button[@type="submit"][@class="btn primary"]
    Sleep                               5s

Click Logo Go Home Page
    ${Home_TF}=  Run Keyword And Return Status    Wait Until Location Contains    https://adultfriendfinder.com/go/page/home_delta.html?    5s
    Pass Execution If   ${Home_TF}   Go home page
    
    ${Order_logo}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://div[@class="logo"]/img     10s
    Run Keyword If      ${Order_logo}   Go Home page from order page
    
    ${other_logo}=  Run Keyword And Return Status    Wait Until Page Contains Element    id:site_logo     10s
    Run Keyword If      ${other_logo}   Go Home page from other page


*** Keywords ***
Select couple
    Select From List By Value           xpath://select[@id="bday_month2"]                            5
    Select From List By Value           xpath://select[@id="bday_day2"]                              08
    Select From List By Value           xpath://select[@id="bday_year2"]                             1990

Go Home page from order page
    Wait Until Page Contains Element    xpath://div[@class="brand ng-star-inserted"]
    Click Element                       xpath://div[@class="brand ng-star-inserted"]
    Click Element                       xpath://div[@class="logo"]/img
    ${Home_Order}=  Run Keyword And Return Status    Wait Until Location Contains    https://adultfriendfinder.com/go/page/home_delta.html?   20s
    Pass Execution If   ${Home_Order}   Go home page

Go Home Page from other page
    Wait Until Page Contains Element    id:site_logo
    Click Element                       id:site_logo
    ${Home_Other}=  Run Keyword And Return Status    Wait Until Location Contains    https://adultfriendfinder.com/go/page/home_delta.html?   20s
    Pass Execution If   ${Home_Other}   Go home page