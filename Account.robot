*** Settings ***
Library  SeleniumLibrary



*** Variables ***


*** Keywords ***
Go Account Page
    Wait Until Page Contains Element    xpath://div[@class="nav-handle dropdown-btn"]       15s
    Mouse Over                          xpath://div[@class="nav-handle dropdown-btn"]
    sleep                               2s
    Wait Until Page Contains Element    xpath://ul[@class="dropdown subnav-flyout"]/li[4]       10s
    Click Element                       xpath://ul[@class="dropdown subnav-flyout"]/li[4]

Change Mail
    [Arguments]                         ${Mail_Changed}  ${Password}
    Wait Until Page Contains Element    xpath:(//div[@class="section short-account-links"])[3]/ul/li[1]/a     10s
    Mouse Over                          xpath:(//div[@class="section short-account-links"])[3]/ul/li[1]/a
    sleep                               2s
    Click Element                       xpath:(//div[@class="section short-account-links"])[3]/ul/li[1]/a
    Wait Until Page Contains Element    xpath://input[@name="email"]                                        10s
    Input Text                          xpath://input[@name="email"]                        ${Mail_Changed}
    Input Text                          xpath://input[@name="password"]                     ${Password}
    Click Element                       xpath://input[@name="update"]
    Wait Until Page Contains Element    xpath://div[@class="center fwb fs14px pb10"]                    10s

Change Password
    [Arguments]                         ${Password}  ${Password_Changed}
    Wait Until Page Contains Element    xpath:(//div[@class="section short-account-links"])[3]/ul/li[3]/a     10s
    Mouse Over                          xpath:(//div[@class="section short-account-links"])[3]/ul/li[3]/a
    sleep                               2s
    Click Element                       xpath:(//div[@class="section short-account-links"])[3]/ul/li[3]/a
    Wait Until Page Contains Element    xpath://input[@name="origpassword"]                                        10s
    Input Text                          xpath://input[@name="origpassword"]                        ${Password}
    Input Text                          xpath://input[@name="password"]                     ${Password_Changed}
    Input Text                          xpath://input[@name="confirm_password"]                     ${Password_Changed}
    Click Element                       xpath://button[@type="submit"][@class="btn default"]
    Wait Until Page Contains Element    xpath://div[@class="center fwb fs14px pb10"]                    10s


Delete Account
    [Arguments]                         ${Password}
    Wait Until Page Contains Element    xpath:(//div[@class="section short-account-links"])[3]/ul/li[6]/a     10s
    Mouse Over                          xpath:(//div[@class="section short-account-links"])[3]/ul/li[6]/a
    sleep                               2s
    Click Element                       xpath:(//div[@class="section short-account-links"])[3]/ul/li[6]/a
    Wait Until Page Contains Element    xpath://div[@class="UpSellContainer"]/a                             5s
    Click Element                       xpath://div[@class="UpSellContainer"]/a
    Wait Until Page Contains Element    xpath://div[@id="passwordNeeded"][@style="display: block; padding-left: 10px; margin-bottom: 20px;"]    10s
    sleep                               2s
    Input Text                          xpath://input[@name="password"]                          ${Password}
    Click Element                       xpath://input[@type="submit"][@value="Submit"]
    Wait Until Page Contains Element    xpath://div[@id="survey"]                                   30s