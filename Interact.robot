*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary

Resource         Register_Login.robot
Resource         Order.robot
Resource         Admin.robot

*** Variables ***
${Handle1}                          bt191122ga
${Password1}                        bt191122

${Handle2}                          bt10M13D1253
${Password2}                        00000






*** Test Cases ***
Login Sender 
    Open Browser                       https://adultfriendfinder.com?lang=english&debug_cookie=no_admin:1          Chrome     alias=Sender
    Login_cover                         ${Handle1}  ${Password1}


Go Profile
    Wait Until Page Contains Element    xpath://a[@data-ga-event="Search:Navbar"]                           10s
    Mouse Over                          xpath://a[@data-ga-event="Search:Navbar"]                           
    sleep                               1s
    Input Text                          xpath://input[@name="handlesearch"]                ${Handle2}
    Click Element                       xpath://button[@data-ga-event="Username search:Navbar"]

# Add Friend from Profile Page
#     Wait Until Page Contains Element    xpath://div[@class="btn_text_wrapper invite_btn"]/i[@class="sprite-add-friend"]
#     Click Element                       xpath://div[@class="btn_text_wrapper invite_btn"]/i[@class="sprite-add-friend"]
#     sleep                               3s
#     Switch window       locator=NEW
#     Wait Until Page Contains Element    xpath://input[@type="submit"]
#     Click Element                       xpath://input[@type="submit"]
#     Switch window       locator=MAIN

# Add Hotlist
#     Wait Until Page Contains Element    xpath://div[@data-events="ProfileTopInfo.hotlist_state:set_state"]/div[@class="active"]                                    10s
#     Click Element                       xpath://div[@data-events="ProfileTopInfo.hotlist_state:set_state"]/div[@class="active"]
    
    # close popup
    # Wait Until Page Contains Element    xpath://div[@data-lightbox="top_fans_popup"]/div[@class="modal"]/span[@class="lightbox-close"]
    # Click Element                       xpath://div[@data-lightbox="top_fans_popup"]/div[@class="modal"]/span[@class="lightbox-close"]
    
    # Bid point
    # Wait Until Element Is Visible       xpath://form[@id="bid_form"]/input[@name="bid_pts"]                                    10s
    # Input Text                          xpath://form[@id="bid_form"]/input[@name="bid_pts"]                  1
    # Click Element                       xpath://form[@id="bid_form"]/input[@type="submit"]
    # Wait Until Element Is Visible       xpath://div[@data-lightbox="top_fans_popup_congratulations"]/div[@class="modal"]/span[@class="lightbox-close"]
    # Click Element                       xpath://div[@data-lightbox="top_fans_popup_congratulations"]/div[@class="modal"]/span[@class="lightbox-close"]
    
# Send Flirt from Profile Page
#     Wait Until Page Contains Element    xpath://div[@data-events="ProfileTopInfo.flirt_state:set_state"]/div[@class="active"]                                    10s
#     Click Element                       xpath://div[@data-events="ProfileTopInfo.flirt_state:set_state"]/div[@class="active"]

# Tip from Profile Page
#     Wait Until Page Contains Element    xpath://div[@data-state="can_friend"]/a[@data-click="showTipPopup"]
#     Click Element                       xpath://div[@data-state="can_friend"]/a[@data-click="showTipPopup"]
#     Wait Until Element Is Visible       xpath://span[@data-name="TipBtn"]                                       5s
#     Mouse Over                          xpath://span[@data-name="TipBtn"]
#     Click Element                       xpath://span[@data-name="TipBtn"]

# Send Message from Profile               
#     Wait Until Page Contains Element    xpath://textarea[@class="message mini-textarea"]           5s 
#     Input Text                          xpath://textarea[@class="message mini-textarea"]           hi, ${Handle2} this is ${Handle1} First
#     Click Element                       xpath://div[@data-name="SendMessageBtn"]

Send Gift from Profile Page
    Wait Until Page Contains Element    xpath://textarea[@class="message mini-textarea"]           10s 
    Click Element                       xpath://span[@id="mc_msg_box_icon-vgift"]
    Wait Until Page Contains Element    xpath://div[@data-name="SubmitGiftsBtn"]
    # Execute Javascript                  $('.virtual_gift_popup').css('display','block')
    Wait Until Element Is visible       xpath:(//div[@class="gift_selector_list scrollable"]/li)[2]
    Click Element                       xpath:(//div[@class="gift_selector_list scrollable"]/li)[2]
    Click Element                       xpath://div[@data-name="SubmitGiftsBtn"]
    Wait Until Page Contains Element    xpath://div[@data-name="SendMessageBtn"]
    Input Text                          xpath://textarea[@class="message mini-textarea"]           hi, ${Handle2} gift is ${Handle1} First
    Click Element                       xpath://div[@data-name="SendMessageBtn"]

    
# Send Mail
#     Wait Until Page Contains Element    xpath://a[@data-ga-event="Message Center:Navbar"]                           10s
#     Click Element                       xpath://a[@data-ga-event="Message Center:Navbar"]                           
#     Wait Until Page Contains Element    id:mc-fn_new_message                                                      20s
#     Click Element                       id:mc-fn_new_message
#     Input Text                          id:lbnm-to                            ${Handle2}
#     Input Text                          id:chat_textarea                      hi, ${Handle2} this is ${Handle1} First
#     Wait Until Element Is Visible       xpath://div[@class='right']                                                        10s
#     Mouse Over                       xpath://div[@class='right']
#     sleep                               5s
#     Click Element                       xpath://div[@class='right']
#     Wait Until Element Does Not Contain  xpath://div[@class='right']                           15s




# Go AFF And Login
#     Open Browser                        https://adultfriendfinder.com?lang=english&debug_cookie=no_admin:1          FireFox   alias=Recevier
#     Wait Until Page Contains Element    id:login_username_input
#     Input Text                          id:login_username_input               ${Handle2}
#     Input Text                          id:login_password_input               ${Password2}
#     sleep                               1s
#     Click Button                        id:login_submit
#     sleep                               1s

# Get Mail and Reply
    # Wait Until Page Contains Element    xpath://a[@data-ga-event="Message Center:Navbar"]               10s
    # Click Element                       xpath://a[@data-ga-event="Message Center:Navbar"]
    # Wait Until Page Contains Element    xpath://div[@id="message_center_side"]/div[1]                                                      20s
    # sleep                               5s
    # ${Handle_String1}=   Evaluate    '"${Handle1}"'
    # Click Element                       xpath://span[text()=${Handle_String1}]
    # Wait Until Page Contains Element    id:chat_textarea                                                  20s
    # # Click Element                       id:chat_textarea
    # Input Text                          id:chat_textarea              hi, ${Handle1} this is ${Handle2} reply Second
    # sleep                               2s
    # Click Element                       id:mc-msg_box_send 
    
# Change to Sender's Window
    # Switch Browser         Sender
    # sleep                               5s
    # # Go To                   https://yahoo.com
    # # sleep                       20s    
    # Click Element                       xpath://a[@data-ga-event="Message Center:Navbar"]
    # Wait Until Page Contains Element    xpath://div[@id="message_center_side"]/div[1]                                                      20s
    # sleep                               5s
    # ${Handle_String2}=   Evaluate    '"${Handle2}"'
    # Click Element                       xpath://span[text()=${Handle_String2}]
    # Wait Until Page Contains Element    id:chat_textarea
    # Input Text                          id:chat_textarea              hi, ${Handle2} this is ${Handle1} reply Third
    # sleep                               2s
    # Click Element                       id:mc-msg_box_send




# Take a screenshot
#     capture page screenshot               C:\\Users\\tchang.tw\\Desktop\\robot\\Top_Fans\\Test_Screen\\123\\test.png



*** Keywords ***
