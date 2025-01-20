*** Settings ***
#Documentation    Suite description
Library  SeleniumLibrary

#*** Test Cases ***


*** Variables ***


*** Keywords ***
Upgrading
    [Arguments]                         ${CC_number}
    ${Order_page}=  Run Keyword And Return Status   Wait Until Location Contains   adultfriendfinder.com/p/order.cgi    10s
    Run Keyword If     ${Order_page}   Upgrade from page no cc     ${CC_number}     ELSE    Upgrade from overlay no cc     ${CC_number}

    # ${Order_overlay}=   Run Keyword And Return Status    WaitUntil Page Contains Element    xpath://iframe[@class="ffn_overlay_frame"]     10s
    # Run Keyword If     ${Order_overlay}   Upgrade from overlay no cc     ${CC_number}

Upgrade from page no cc
    [Arguments]                         ${CC_number}
    Wait Until Page Contains Element    xpath:(//div[@class="checkborder"])[1]
    Click Element                       xpath:(//div[@class="checkborder"])[1]
    Input Text                          xpath://input[@id="cardNumber"]                 ${CC_number}
    Input Text                          xpath://input[@id="mat-input-1"]                Foo
    Click Element                       xpath://mat-select[@id="mat-select-2"]
    sleep                               1s
    Click Element                       xpath://mat-option[@value="05"]
    sleep                               1s
    Click Element                       xpath://mat-select[@id="mat-select-3"]
    sleep                               1s
    Click Element                       xpath://mat-option[@id="mat-option-27"]
    sleep                               1s
    Input Text                          xpath://input[@id="mat-input-2"]                111
    Click Element                       xpath://button[@class="submitbtn mat-raised-button"][@data-paymenttype="creditCard"]
    Input Text                          xpath://input[@id="autocompleteinput"]                Foo
    sleep                               1s
    Click Element                       xpath://button[@class="submitbtn mat-raised-button ng-star-inserted"][@data-paymenttype="savedPayment"]
    ${Other_Menu}=  Run Keyword And Return Status   Wait Until Page Contains Element    xpath://div[@class="btnbar order-nothanks ng-star-inserted"]     10s
    Run Keyword If     ${Other_Menu}    Click Thanks
    Wait Until Page Contains Element    xpath://div[@class="continue"]               20s
    Click Element                       xpath://div[@class="continue"]

Upgrade from overlay no cc
    [Arguments]                         ${CC_number}
    Wait Until Page Contains Element    xpath://iframe[@class="ffn_overlay_frame"]
    Select Frame                        xpath://iframe[@class="ffn_overlay_frame"]
    Wait Until Page Contains Element    xpath:(//div[@class="checkborder"])[2]
    Click Element                       xpath:(//div[@class="checkborder"])[2]
    Input Text                          xpath://input[@id="cardNumber"]                 ${CC_number}
    Input Text                          xpath://input[@id="mat-input-1"]                Foo
    Click Element                       xpath://mat-select[@id="mat-select-1"]
    sleep                               1s
    Click Element                       xpath://mat-option[@id="mat-option-4"]
    Click Element                       xpath://mat-select[@id="mat-select-2"]
    sleep                               1s
    Click Element                       xpath://mat-option[@id="mat-option-17"]
    sleep                               1s
    Input Text                          xpath://input[@id="mat-input-2"]                111
    Click Element                       xpath://button[@class="submitbtn mat-raised-button"][@data-paymenttype="creditCard"]
    Input Text                          xpath://input[@id="autocompleteinput"]                Foo
    sleep                               1s
    Click Element                       xpath://button[@class="submitbtn mat-raised-button ng-star-inserted"][@data-paymenttype="savedPayment"]
    ${Other_Menu}=   Run Keyword And Return Status    Wait Until Page Contains Element    xpath://p[@class="nothanksbtn"]    10s
    Run Keyword If     ${Other_Menu}    Click Thanks
    Wait Until Page Contains Element    xpath://div[@class="continue"]               20s
    Click Element                       xpath://div[@class="continue"]

Buy Point with CC
    ${Order_page}=  Run Keyword And Return Status   Wait Until Page Contains Element      xpath://div[@class="action-btn"]/span
    Run Keyword If     ${Order_page}   Quickbuy   ELSE   Buy Point with CC after Quickbuy

Buy Point with CC after Quickbuy
    ${Order_page}=  Run Keyword And Return Status   Wait Until Page Contains Element    xpath://iframe[@class="ffn_overlay_frame"]
    Run Keyword If     ${Order_page}   Go Order Point Overlay with CC   ELSE   Buy Point with CC after Overlay

Buy Point with CC after Overlay
    ${Order_page}=  Run Keyword And Return Status   Wait Until Location Contains   adultfriendfinder.com/p/order.cgi    10s
    Run Keyword If     ${Order_page}   Go Order Point Page with CC

Quickbuy
    Wait Until Page Contains Element      xpath://div[@class="action-btn"]/span
    Click Element                         xpath://div[@class="custom-dropdown"][@data-name="PointsSelector"]
    sleep                                 1s
    Click Element                         xpath://div[@class="custom-options"]/div[@data-value="50.0"]
    sleep                                 1s
    Click Element                         xpath://div[@class="action-btn"]/span
    sleep                                  3s

Go Order Point Overlay with CC
    Wait Until Page Contains Element    xpath://iframe[@class="ffn_overlay_frame"]          5s
    Select Frame                        xpath://iframe[@class="ffn_overlay_frame"]
    Wait Until Page Contains Element    xpath:(//div[@class="checkborder"])[1]
    Click Element                       xpath:(//div[@class="checkborder"])[1]
    Click Element                       xpath://button[@id="saved-submit"]
    Wait Until Page Contains Element    xpath://div[@class="continue"]               20s
    Click Element                       xpath://div[@class="continue"]

Go Order Point Page with CC
    Wait Until Page Contains Element    xpath:(//div[@class="checkborder"])[1]                                  5s
    Click Element                       xpath:(//div[@class="checkborder"])[1]
    Click Element                       xpath://button[@id="saved-submit"]
    Wait Until Page Contains Element    xpath://div[@class="continue"]               20s
    Click Element                       xpath://div[@class="continue"]


Click Thanks
    Mouse Over                      xpath://div[@class="btnbar order-nothanks ng-star-inserted"]/p[@class="nothanksbtn"]
    sleep                           2s
    Click Element                   xpath://div[@class="btnbar order-nothanks ng-star-inserted"]/p[@class="nothanksbtn"]