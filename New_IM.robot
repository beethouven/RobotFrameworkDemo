*** Settings ***
Documentation    Suite description
Library          SeleniumLibrary



*** Variables ***

*** Keywords ***

    


Open IM and Get Window's Handle
    Wait Until Page Contains Element    xpath://a[@class="nav-webcam-wrap nav-start-messenger"]
    Mouse Over                          xpath://a[@class="nav-webcam-wrap nav-start-messenger"]
    sleep                               1s
    Click Element                       xpath://a[@class="nav-webcam-wrap nav-start-messenger"]
    Wait Until Keyword Succeeds   30s   5s    Switch to New window
    ${Sender_IM}=                 Get Window Handles
    [return]        ${Sender_IM[-1]}

Go Search
    [Arguments]                         ${Account}
    Wait Until Page Contains Element     xpath://input[@id="search-members-handle"]         10s
    Wait Until Element Is Enabled        xpath://input[@id="search-members-handle"]         10s
    Input Text                        xpath://input[@id="search-members-handle"]            ${Account}
    Wait Until Page Contains Element    xpath://button[@class="chat-button mat-button mat-button-base"]            20s
    Click Element                       xpath://button[@class="chat-button mat-button mat-button-base"]

Go Friend
    [Arguments]                         ${Account}
    Wait Until Page Contains Element     xpath://a[@id="friendsNavTab"]          10s
    Mouse Over                           xpath://a[@id="friendsNavTab"]
    sleep                               2s
    Click Element                       xpath://a[@id="friendsNavTab"]
    ${Account_String}=   Evaluate    '"${Account}"'
    Wait Until Page Contains Element    xpath://span[@class="handle"][text()=${Account_String}]
    Mouse Over                          xpath://span[@class="handle"][text()=${Account_String}]/../..
    sleep                               2s
    Click Element                       xpath://span[@class="handle"][text()=${Account_String}]/../..

Send IM
    # Wait Until Page Contains Element    xpath://div[@class="input-row"]                                     5s
    # Click Element                       xpath://div[@class="input-row"]
    Wait Until Page Contains Element    xpath://textarea              10s
    # Wait Until Page Contains Element    xpath://textarea[@class="text-input ng-pristine ng-valid ng-touched"]              20s
    sleep                               3s
    Input Text                          xpath://textarea              Hi This is from IM
    Click Element                       xpath://span[@class="aff-icon-airplane"]

Send Tip
    Wait Until Page Contains Element    xpath://span[@class="aff-icon-points"]                      10s
    sleep                               1s
    Click Element                       xpath://span[@class="aff-icon-points"] 
    Wait Until Page Contains Element    xpath://div[@class="tip-option pointer ng-star-inserted"][1]                     10s
    Click Element                       xpath://div[@class="tip-option pointer ng-star-inserted"][1]
    sleep                               1s
    Wait Until Page Contains Element    xpath://span[@class="aff-icon-airplane"]                     10s
    sleep                               1s
    Click Element                       xpath://span[@class="aff-icon-airplane"]

Quickbuy from Tip
    Wait Until Page Contains Element    xpath://span[@class="aff-icon-points"]                      10s
    sleep                               1s
    Click Element                       xpath://span[@class="aff-icon-points"] 
    Wait Until Page Contains Element    xpath://div[@class="buy-more-points pointer"]                      10s
    sleep                               1s
    Click Element                       xpath://div[@class="buy-more-points pointer"]
    Wait Until Page Contains Element    xpath://iframe[@class="ng-star-inserted"]           10s
    Select Frame                        xpath://iframe[@class="ng-star-inserted"]
    Wait Until Page Contains Element    xpath://div[@class="btnbar overlaybtn"]/button[@class="submitbtn mat-raised-button"]                      10s
    sleep                               1s
    Click Element                       xpath://div[@class="btnbar overlaybtn"]/button[@class="submitbtn mat-raised-button"]
    Wait Until Page Contains Element    xpath://button[@id="saved-submit"]                      10s
    sleep                               1s
    Click Element                       xpath://button[@id="saved-submit"]

Send Gift
    Wait Until Page Contains Element    xpath://span[@class="aff-icon-gift"]                      10s
    sleep                               1s
    Click Element                       xpath://span[@class="aff-icon-gift"]
    Wait Until Page Contains Element    xpath://div[@class="virtual-gift-option ng-star-inserted"][10]                     10s
    sleep                               1s
    Click Element                       xpath://div[@class="virtual-gift-option ng-star-inserted"][10]
    sleep                               1s
    Wait Until Page Contains Element    xpath://button[@class="confirm-btn mat-button mat-button-base"]                     10s
    sleep                               1s
    Click Element                       xpath://button[@class="confirm-btn mat-button mat-button-base"]
    Wait Until Page Contains Element    xpath://span[@class="aff-icon-airplane"]                     10s
    sleep                               1s
    Click Element                       xpath://span[@class="aff-icon-airplane"]

Quickbuy from Gift
    Wait Until Page Contains Element    xpath://span[@class="aff-icon-gift"]                      10s
    sleep                               1s
    Click Element                       xpath://span[@class="aff-icon-gift"]
    Wait Until Page Contains Element    xpath://span[@class="upsell pointer"]                      10s
    Click Element                       xpath://span[@class="upsell pointer"]
    Wait Until Page Contains Element    xpath://iframe[@class="ng-star-inserted"]           10s
    Select Frame                        xpath://iframe[@class="ng-star-inserted"]
    Wait Until Page Contains Element    xpath://div[@class="btnbar overlaybtn"]/button[@class="submitbtn mat-raised-button"]                      10s
    sleep                               1s
    Click Element                       xpath://div[@class="btnbar overlaybtn"]/button[@class="submitbtn mat-raised-button"]
    Wait Until Page Contains Element    xpath://button[@id="saved-submit"]                      10s
    sleep                               1s
    Click Element                       xpath://button[@id="saved-submit"]


 
*** Keywords ***
Switch to New window
    Switch window   NEW

