*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
# Library  Screenshot     C:\\Users\\tchang.tw\\Desktop\\robot\\Top_Fans\\Test_Screen

*** Variables ***
${Account}                          bt0916mobile
${Password}                        00000
${Gender}                           Couple (man/woman)    
${Mail}                             tchang.tw@ffn.com
${Gender_c_MW}  Couple (man/woman)
${Gender_c_2M}  Couple (2 women)
${Gender_c_2W}  Couple (2 mwn)
${CC_number}                        92401234567890805


*** Test Cases ***
# Robot Framework + Chrome Headless
#     ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
#     Call Method    ${chrome_options}    add_argument    headless
#     Call Method    ${chrome_options}    add_argument    disable-gpu
#     ${options}=     Call Method     ${chrome_options}    to_capabilities
#     Create Webdriver    Chrome    desired_capabilities=${options}

Mobile Test
    # Device name can be Nexus 4,5,6 Nokia N9, iPad Mini, iPhone 4,5,6,7,8,9,X, Galaxy S5 S6
    ${devname}    Create Dictionary    deviceName=iPhone X
    ${mobile_emulation}    Create Dictionary     mobileEmulation=${devname}
    ${chromeoptions}    Evaluate    sys.modules['selenium.webdriver.chrome.options'].Options()     sys, selenium.webdriver.chrome.options
    ${chromeoptions._experimental_options}    Set Variable     ${mobile_emulation}
    Call Method    ${chromeoptions}    add_experimental_option    mobileEmulation     ${devname}
    Create Webdriver     Chrome    chrome_options=${chromeoptions}
    
Go AFF
    go to    https://adultfriendfinder.com?lang=english&debug_cookie=fake_ip:65.7.63.115

# Register from mobile
#     Wait Until Page Contains Element    xpath://input[@id="submit-btn"]
#     Click Element                       xpath://input[@id="submit-btn"]
#     Wait Until Page Contains Element    xpath://select[@name="REG_sex"]                         10s
#     Select From List By Label           xpath://select[@name="REG_sex"]                         ${Gender}
#     Select From List By Value           xpath://select[@id="bday_month"]                            5
#     Select From List By Value           xpath://select[@id="bday_day"]                              08
#     Select From List By Value           xpath://select[@id="bday_year"]                             1990
#     # Select From List By Value           xpath://select[@id="fldID_country"]                         United States
#     Input Text                          xpath://input[@name="zip"]                              12155
#     Input Text                          xpath://input[@name="email"]                            ${Mail}
#     Input Text                          xpath://input[@name="REG_handle"]                       ${Account}
#     Input Text                          xpath://input[@name="password"]                         ${Password}
#     Click Element                       xpath://button[@data-form-submit="next"]

#     Wait Until Page Contains Element    xpath://button[@data-form-submit="submit"]                            10s
#     Run Keyword If      '${Gender}' == '${Gender_c_MW}' or '${Gender}' == '${Gender_c_2W}' or '${Gender}' == '${Gender_c_2M}'   Select couple
    
#     Input Text                          xpath://input[@name="title"]                            Nothing to say
#     Click Element                       xpath://button[@data-form-submit="submit"]
#     Wait Until Page Does Not Contain    xpath://button[@data-form-submit="submit"]              30s





Login from mobile
    Wait Until Page Contains Element    xpath://div[@id="cover-hamburger"]                10s
    Wait Until Element Is Enabled       xpath://div[@id="cover-hamburger"]                10s
    Click Element                       xpath://div[@id="cover-hamburger"]
    sleep                               3s
    Wait Until Element Is Enabled       xpath://nav[@id="nav-drawer"]/ul/li[2]/a          10s
    Click Element                       xpath://nav[@id="nav-drawer"]/ul/li[2]/a
    Wait Until Page Contains Element    xpath://input[@name="handle"]                     10s
    Input Text                          xpath://input[@name="handle"]         ${Account}
    Input Text                          xpath://input[@name="password"]       ${Password}
    Click Element                       xpath://input[@type="submit"][@value="Log in"]
    Wait Until Page Does Not Contain    xpath://input[@type="submit"][@value="Log in"]                10s

# Triger order form
#     go to    https://adultfriendfinder.com?lang=english&debug_cookie=fake_ip:65.7.63.115
#     Wait Until Page Contains Element    xpath://div[@class="upgrade-gold"]                      30s
#     Click Element                       xpath://span[@name="iicon"][@class="info-icon white"][1]
#     Wait Until Page Contains Element    xpath://div[@class="data-footer"]
#     Click Element                       xpath://div[@class="data-footer"]
    # Click Element                       xpath://div[@class="data-body"][1]

# Upgrade no cc overlay from mobile
#     Wait Until Page Contains Element    xpath://iframe[@src="/p/order.cgi?do_overlay=1"]
#     Select Frame                        xpath://iframe[@src="/p/order.cgi?do_overlay=1"]

#     Wait Until Page Contains Element    xpath://productbox[@class="ng-star-inserted"][1]/div                10s
#     Click Element                       xpath://productbox[@class="ng-star-inserted"][1]/div 
#     Click Button                        xpath://button[@class="submitbtn mat-raised-button"]
#     sleep                               10s
    # Input Text                          xpath://input[@id="cardNumber"]                 ${CC_number}
    # Input Text                          xpath://input[@id="mat-input-1"]                Foo

Upgrade no cc from mobile
    go to   https://adultfriendfinder.com/p/order.cgi?site=ffadult





Show effet
    sleep       10s

*** Keywords ***
Select couple
    Select From List By Value           xpath://select[@id="bday_month2"]                            5
    Select From List By Value           xpath://select[@id="bday_day2"]                              08
    Select From List By Value           xpath://select[@id="bday_year2"]                             1990



