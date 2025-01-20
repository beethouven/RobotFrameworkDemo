*** Settings ***
Documentation    Suite description
Library          SeleniumLibrary
Library          DateTime

Resource         Register_Login.robot
Resource         Order.robot
Resource         Admin.robot
Resource         Profile.robot
Resource         New_IM.robot
Resource         Account.robot




*** Variables ***

${Mail}                 tchang.tw@ffn.com
${Password}             00000
${Gender}               Man
${Admin_Account}        tchang.tw
${Admin_Password}       sj03sj03$
${CC_number}            92401234567890805
${check_item}           xpath://tr[@id="order_1"]/td[1]/span[@class="origin"]
${Folder_base}          C:\\Users\\tchang.tw\\Desktop\\robot\\Report_by_date\\
${Handle2}              bt191122sa
${Password2}            00000
${Mail_Changed}         AutoCheck@ffn.com
${Password_Changed}     11111



*** Test Cases ***

Set Log and folder
    Open Browser                    https://adultfriendfinder.com/                  Chrome
    ${Time}=   Get Current Date    result_format=datetime    
    ${Month}=   Convert To Integer     ${Time.month}
    ${Month}    Execute Javascript    return parseInt(${Month}/10).toString()+${Month}%10
    ${Day}=   Convert To Integer      ${Time.day}
    ${Day}    Execute Javascript      return parseInt(${Day}/10).toString()+${Day}%10
    ${Hour}=   Convert To Integer      ${Time.hour}
    ${Hour}    Execute Javascript      return parseInt(${Hour}/10).toString()+${Hour}%10
    ${Minute}=   Convert To Integer      ${Time.minute}
    ${Minute}    Execute Javascript      return parseInt(${Minute}/10).toString()+${Minute}%10
    

    Set Global Variable     ${Account}  bt${Month}M${Day}D${Hour}${Minute}
    Set Global Variable     ${Folder}     ${Folder_base}${Month}M${Day}D\\${Account}\\
    Log To Console     ${Account}
    Log To Console     ${Folder}
    Close Browser
    
    # capture page screenshot               ${Folder}\\test.png

Go AFF
    Open Browser                    https://adultfriendfinder.com/?lang=english&debug_cookie=fake_ip:65.7.63.115        Chrome       alias=Sender
    ${Send_Home}=                 Get Window Handles
    Set Global Variable     ${Send_Home_G}        ${Send_Home[-1]}
    capture page screenshot               ${Folder}test.jpg

Register at cover
    Register_Cover                    ${Gender}  ${Mail}  ${Account}  ${Password}
    capture page screenshot           ${Folder}Register.jpg

Go Admin Page
    Confirm Admin                     ${Admin_Account}  ${Admin_Password}  ${Account}
    
    
Work on Admin
    ${PWSID}=      Get PWSID From Admin
    Go Approve Page from Link                   ${Admin_Account}  ${Admin_Password}  ${PWSID}
    Approve Account
    # Set to be External Account from Link        ${Admin_Account}  ${Admin_Password}  ${PWSID}  ${Account}
    Set to be External Account
    Give Point                        1000
Login from cover                     
    Go To                           https://adultfriendfinder.com/?lang=english&debug_cookie=fake_ip:65.7.63.115
    Login_cover                     ${Account}  ${Password}
    capture page screenshot               ${Folder}Login.jpg

Go home page
    Click Logo Go Home Page
    capture page screenshot               ${Folder}homepage.jpg

Go upgrade page
    # Trigger upgrade from handle
    # Wait Until Page Contains Element    (//a[@class="handle_container"])[5]
    # Click Element                       (//a[@class="handle_container"])[5]
    
    # Trigger upgrade from left side
    Wait Until Page Contains Element    //a[@class="btn btn-red"][@data-ga-event="Left ad:Text"]
    Click Element                       //a[@class="btn btn-red"][@data-ga-event="Left ad:Text"]

    # Trigger upgrade from right-top
    # Wait Until Page Contains Element    xpath://a[@class="profile-link"]
    # Mouse Over                          xpath://a[@class="profile-link"]
    # Wait Until Page Contains Element    //ul[@class="dropdown subnav-flyout"]/li[5]/a[@class="btn btn-red"]
    # Click Element                       //ul[@class="dropdown subnav-flyout"]/li[5]/a[@class="btn btn-red"]

Upgrading Checking
    Upgrading                           ${CC_number}
    capture page screenshot               ${Folder}upgrade.jpg


# Trigger Order Point Page
#     Wait Until Page Contains Element      xpath://li[@class="nav-points"]                   5s
#     Click Element                         xpath://li[@class="nav-points"]/div/span/a
#     Wait Until Page Contains Element      xpath://span[@class="cta_pts_group"]/span/a[@class="point_number"]    5s        5s
#     Click Element                         xpath://span[@class="cta_pts_group"]/span/a[@class="point_number"]  
#     Wait Until Page Contains Element      xpath://div[@class="grey_block"]/a[@class="btn btn-blue"]             10s
#     Mouse Over                            xpath://div[@class="grey_block"]/a[@class="btn btn-blue"]
#     sleep                                 1s
#     Click Element                         xpath://div[@class="grey_block"]/a[@class="btn btn-blue"]
#     #    xpath://div[@class="grey_block"]/a[@class="btn btn-blue"]

Buy Point from Page
    Go To                               https://secure.adultfriendfinder.com/p/order.cgi?site=ffadult&do_points=1
    Go Order Point Page with CC
    capture page screenshot               ${Folder}BuyPoint.jpg


Trigger Order Point Overlay
    Wait Until Page Contains Element      xpath://li[@class="nav-points"]                   5s
    Click Element                         xpath://li[@class="nav-points"]/div/span/a
    Wait Until Page Contains Element      xpath://span[@class="cta_pts_group"]/a[@class="btn btn-blue"]              5s
    Click Element                         xpath://span[@class="cta_pts_group"]/a[@class="btn btn-blue"]

Buy Point from Quickbuy
    Buy Point with CC
    capture page screenshot               ${Folder}PointQuickBuy.jpg    


Go Profile
    Wait Until Page Contains Element    xpath://a[@data-ga-event="Search:Navbar"]                           10s
    Mouse Over                          xpath://a[@data-ga-event="Search:Navbar"]                           
    sleep                               1s
    Wait Until Element Is Enabled       xpath://input[@name="handlesearch"]
    Input Text                          xpath://input[@name="handlesearch"]                ${Handle2}
    Click Element                       xpath://button[@data-ga-event="Username search:Navbar"]

Interaction from Profile
    sleep                               3s
    Add Hotlist
    Send Flirt from Profile Page
    Tip from Profile Page
    Send Message from Profile               
    sleep                               2s
    Send Gift from Profile Page
    sleep                               1s
    Add Friend from Profile Page    
    capture page screenshot               ${Folder}ProfileInterAction.jpg

Open IM and Wait From Sender
    ${Sender_IM}=     Open IM and Get Window's Handle
    Set Global Variable     ${Sender_IM_G}   ${Sender_IM}
    capture page screenshot               ${Folder}IM.jpg
    

# Another Browser for Recevier

Go AFF And Login
    Open Browser                        https://adultfriendfinder.com?lang=english&debug_cookie=fake_ip:65.7.63.115          Chrome   alias=Recevier
    Login_cover                         ${Handle2}  ${Password2}

Go Home Page from Recevier
    Click Logo Go Home Page

Go Checking Flirt
    Wait Until Page Contains Element    xpath://li[@role="navbar-tab"][@class="mystuff-tab tab column-3"]                           10s
    Mouse Over                          xpath://li[@role="navbar-tab"][@class="mystuff-tab tab column-3"]                           
    sleep                               1s
    Wait Until Page Contains Element    xpath://a[@data-ga-event="Flirted:Navbar"]
    Click Element                       xpath://a[@data-ga-event="Flirted:Navbar"]
    ${Account_String_b}=   Evaluate    '"${Account}"'
    Set Global Variable     ${Account_String}     ${Account_String_b}
    Wait Until Page Contains Element    xpath://strong[text()=${Account_String}]                            10s

Go Checking Hotlist
    Wait Until Page Contains Element    xpath://li[@role="navbar-tab"][@class="mystuff-tab tab column-3"]                           10s
    Mouse Over                          xpath://li[@role="navbar-tab"][@class="mystuff-tab tab column-3"]
    sleep                               1s
    Wait Until Page Contains Element    xpath://a[@data-ga-event="Hotlisted:Navbar"]
    Click Element                       xpath://a[@data-ga-event="Hotlisted:Navbar"]
    Wait Until Page Contains Element    xpath://strong[text()=${Account_String}]                            10s

Go Checking Friend
    Wait Until Page Contains Element    xpath://li[@role="navbar-tab"][@class="mystuff-tab tab column-3"]                           10s
    Mouse Over                          xpath://li[@role="navbar-tab"][@class="mystuff-tab tab column-3"]
    sleep                               1s
    Wait Until Page Contains Element    xpath://a[@data-ga-event="Friend Request:Navbar"]
    Click Element                       xpath://a[@data-ga-event="Friend Request:Navbar"]
    Wait Until Page Contains Element    xpath://strong[text()=${Account_String}]
    Click Element                       xpath://div[@handle=${Account_String}]/div[@class="member_cell_right"]/div/div/button[@class="btn btn-small btn-blue accept"]
    Wait Until Element Is Enabled       xpath://div[@handle=${Account_String}]/div[@class="member_cell_right"]/div/div[@class="accepted request_action_box clearfix"]      10s

Go MC Checking
    Wait Until Page Contains Element    xpath://a[@data-ga-event="Message Center:Navbar"]               10s
    Click Element                       xpath://a[@data-ga-event="Message Center:Navbar"]
    Wait Until Page Contains Element    xpath://div[@id="message_center_side"]/div[1]                                                      20s
    sleep                               5s
    ${Handle_String1}=   Evaluate       '"${Account}"'
    Click Element                       xpath://span[text()=${Handle_String1}]
    Wait Until Page Contains Element    id:chat_textarea                                                  20s
    Input Text                          id:chat_textarea              hi, ${Account} this is ${Handle2} reply Second
    sleep                               2s
    Click Element                       id:mc-msg_box_send 
    sleep                               2s
    capture page screenshot               ${Folder}MC.jpg

# -------------------------IM_Test-------------------------
Open IM and Wait from Recevier
    ${Recevier_IM}=     Open IM and Get Window's Handle
    Set Global Variable     ${Recevier_IM_G}   ${Recevier_IM}
    Log To Console   ${Recevier_IM_G}
    
Send IM
    Go Search                          ${Account}
    sleep                               3s
    Go Friend                          ${Account}
    sleep                               3s
    Send IM
    capture page screenshot               ${Folder}IM_Send.jpg


Switch and Reply
    Log To Console   ${Recevier_IM_G}  ${Sender_IM_G}
    Switch Browser      Sender
    Switch Window       ${Sender_IM_G}
    Go Friend           ${Handle2}
    Send IM
    Send Tip
    Send Gift
    capture page screenshot               ${Folder}IM_Gift.jpg
    Quickbuy from Tip
    sleep                       3s
    Switch Browser      Recevier
    Switch Window       ${Recevier_IM_G}
    sleep                       3s
    Switch Browser      Sender
    Switch Window       ${Sender_IM_G}
    sleep               3s
    Quickbuy from Gift
    capture page screenshot               ${Folder}QuickBuyIM.jpg

# -------------------------IM_Test-------------------------

# ---------------------Delete Account-------------------------
Go Main Page and Delete Account
    Switch Browser      Sender
    Switch Window      ${Send_Home_G}

Go Home Page for Delete
    Click Logo Go Home Page

Go Change Mail
    Go Account Page
    Change Mail     ${Mail_Changed}   ${Password}

Go Change Password
    Go Account Page
    Change Password   ${Password}   ${Password_Changed}

Go Delete Account
    Go Account Page
    Delete Account      ${Password_Changed}

Go Admin
    Go admin by account             ${Admin_Account}  ${Admin_Password}  ${Account}

Check Mail
    ${Mail}=    Get Mail From Admin
    Log To Console      The Mail is ${Mail}

Check Deactive
    ${PWSID}=   Get PWSID From Admin
    Deact from Admin               ${Admin_Account}  ${Admin_Password}  ${PWSID}  ${Account}

# ---------------------Delete Account-------------------------


# ----------------Take Test Data From Admin----------------
Get Order History
    ${Order_History}=        Check on order history           ${Admin_Account}  ${Admin_Password}  ${Account}
    Log To Console      ${Order_History}

# ----------------Take Test Data From Admin----------------





Finish test close browser
    Close All Browsers

 
*** Keywords ***


