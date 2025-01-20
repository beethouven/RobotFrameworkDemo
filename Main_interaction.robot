*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary

Resource         Register_Login.robot
Resource         Order.robot
Resource         Admin.robot

*** Variables ***
${Handle1}                          bt10M13D1253
${Password1}                        00000

${Handle2}                          bt191122ga
${Password2}                        bt191122






*** Test Cases ***
Login Sender 
    Open Browser                       https://adultfriendfinder.com?lang=english&debug_cookie=no_admin:1          Chrome     alias=Sender
    Login_cover                         ${Handle1}  ${Password1}
    
Send Mail
    Wait Until Page Contains Element    xpath://a[@data-ga-event="Message Center:Navbar"]                           10s
    Click Element                       xpath://a[@data-ga-event="Message Center:Navbar"]                           
    Wait Until Page Contains Element    id:mc-fn_new_message                                                      20s
    Click Element                       id:mc-fn_new_message
    Input Text                          id:lbnm-to                            ${Handle2}
    Input Text                          id:chat_textarea                      hi, ${Handle2} this is ${Handle1} First
    Wait Until Element Is Visible       xpath://div[@class='right']                                                        10s
    Mouse Over                       xpath://div[@class='right']
    sleep                               5s
    Click Element                       xpath://div[@class='right']
    Wait Until Element Does Not Contain  xpath://div[@class='right']                           15s




Go AFF And Login
    Open Browser                        https://adultfriendfinder.com?lang=english&debug_cookie=no_admin:1          Chrome   alias=Recevier
    Wait Until Page Contains Element    id:login_username_input
    Input Text                          id:login_username_input               ${Handle2}
    Input Text                          id:login_password_input               ${Password2}
    sleep                               1s
    Click Button                        id:login_submit
    sleep                               1s

Get Mail and Reply
    Wait Until Page Contains Element    xpath://a[@data-ga-event="Message Center:Navbar"]               10s
    Click Element                       xpath://a[@data-ga-event="Message Center:Navbar"]
    Wait Until Page Contains Element    xpath://div[@id="message_center_side"]/div[1]                                                      20s
    sleep                               5s
    ${Handle_String1}=   Evaluate    '"${Handle1}"'
    Click Element                       xpath://span[text()=${Handle_String1}]
    Wait Until Page Contains Element    id:chat_textarea                                                  20s
    # Click Element                       id:chat_textarea
    Input Text                          id:chat_textarea              hi, ${Handle1} this is ${Handle2} reply Second
    sleep                               2s
    Click Element                       id:mc-msg_box_send 
    
Change to Sender's Window
    Switch Browser         Sender
    sleep                               5s
    # Go To                   https://yahoo.com
    # sleep                       20s    
    Click Element                       xpath://a[@data-ga-event="Message Center:Navbar"]
    Wait Until Page Contains Element    xpath://div[@id="message_center_side"]/div[1]                                                      20s
    sleep                               5s
    ${Handle_String2}=   Evaluate    '"${Handle2}"'
    Click Element                       xpath://span[text()=${Handle_String2}]
    Wait Until Page Contains Element    id:chat_textarea
    Input Text                          id:chat_textarea              hi, ${Handle2} this is ${Handle1} reply Third
    sleep                               2s
    Click Element                       id:mc-msg_box_send




# Take a screenshot
#     capture page screenshot               C:\\Users\\tchang.tw\\Desktop\\robot\\Top_Fans\\Test_Screen\\123\\test.png



*** Keywords ***
