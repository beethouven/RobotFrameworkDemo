*** Settings ***
#Documentation    Suite description
Library  SeleniumLibrary

#*** Test Cases ***


*** Variables ***


*** Keywords ***
Add Friend from Profile Page
    Wait Until Page Contains Element    xpath://div[@class="btn_text_wrapper invite_btn"]/i[@class="sprite-add-friend"]
    Click Element                       xpath://div[@class="btn_text_wrapper invite_btn"]/i[@class="sprite-add-friend"]
    sleep                               3s
    Switch window       locator=NEW
    Wait Until Page Contains Element    xpath://input[@type="submit"]               10s
    Click Element                       xpath://input[@type="submit"]
    Wait Until Page Contains Element    xpath://input[@type="button"][@value="Done"]
    Click Element                       xpath://input[@type="button"][@value="Done"]
    Switch window       locator=MAIN

Add Hotlist
    Wait Until Page Contains Element    xpath://div[@data-events="ProfileTopInfo.hotlist_state:set_state"]/div[@class="active"]                                    10s
    Click Element                       xpath://div[@data-events="ProfileTopInfo.hotlist_state:set_state"]/div[@class="active"]
    
#     # close popup

    Wait Until Element Is Enabled       xpath://div[@data-lightbox="top_fans_popup"]/div[@class="modal"]/span[@class="lightbox-close"]
    Click Element                       xpath://div[@data-lightbox="top_fans_popup"]/div[@class="modal"]/span[@class="lightbox-close"]
    
    # Bid point
    # Wait Until Element Is Visible       xpath://form[@id="bid_form"]/input[@name="bid_pts"]                                    10s
    # Input Text                          xpath://form[@id="bid_form"]/input[@name="bid_pts"]                  1
    # Click Element                       xpath://form[@id="bid_form"]/input[@type="submit"]
    # Wait Until Element Is Visible       xpath://div[@data-lightbox="top_fans_popup_congratulations"]/div[@class="modal"]/span[@class="lightbox-close"]
    # Click Element                       xpath://div[@data-lightbox="top_fans_popup_congratulations"]/div[@class="modal"]/span[@class="lightbox-close"]
    
Send Flirt from Profile Page
    Wait Until Page Contains Element    xpath://div[@data-events="ProfileTopInfo.flirt_state:set_state"]/div[@class="active"]                                    10s
    Click Element                       xpath://div[@data-events="ProfileTopInfo.flirt_state:set_state"]/div[@class="active"]

Tip from Profile Page
    Wait Until Page Contains Element    xpath://div[@data-state="can_friend"]/a[@data-click="showTipPopup"]
    Click Element                       xpath://div[@data-state="can_friend"]/a[@data-click="showTipPopup"]
    Wait Until Element Is Visible       xpath://span[@data-name="TipBtn"]                                       5s
    Mouse Over                          xpath://span[@data-name="TipBtn"]
    Click Element                       xpath://span[@data-name="TipBtn"]

Send Message from Profile               
    Wait Until Page Contains Element    xpath://textarea[@class="message mini-textarea"]           5s 
    Input Text                          xpath://textarea[@class="message mini-textarea"]           hi, First
    Click Element                       xpath://div[@data-name="SendMessageBtn"]

Send Gift from Profile Page
    Wait Until Page Contains Element    xpath://textarea[@class="message mini-textarea"]           10s 
    Click Element                       xpath://span[@id="mc_msg_box_icon-vgift"]
    Wait Until Page Contains Element    xpath://div[@data-name="SubmitGiftsBtn"]
    # Execute Javascript                  $('.virtual_gift_popup').css('display','block')
    Wait Until Element Is visible       xpath:(//div[@class="gift_selector_list scrollable"]/li)[10]
    Click Element                       xpath:(//div[@class="gift_selector_list scrollable"]/li)[10]
    Click Element                       xpath://div[@data-name="SubmitGiftsBtn"]
    Wait Until Page Contains Element    xpath://div[@data-name="SendMessageBtn"]
    Input Text                          xpath://textarea[@class="message mini-textarea"]           hi,Gift
    Click Element                       xpath://div[@data-name="SendMessageBtn"]

