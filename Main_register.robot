*** Settings ***
Documentation    Suite description
Library          SeleniumLibrary
Library          DateTime

Resource         Register_Login.robot
Resource         Order.robot
Resource         Admin.robot
# Resource         Profile.robot



*** Variables ***

${Mail}                 tchang.tw@ffn.com
${Password}             00000
${Gender}               Man
${Admin_Account}        tchang.tw
${Admin_Password}       sj03sj03$
${CC_number}            92401234567890805
${check_item}           xpath://tr[@id="order_1"]/td[1]/span[@class="origin"]
${Folder_base}          C:\\Users\\tchang.tw\\Desktop\\robot\\Report_by_date\\
# ${Handle2}              bt191122ga
# ${Password2}            bt191122
${Handle2}              bt191122ga
${Password2}            bt191122



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

Register at cover
    Register_Cover                    ${Gender}  ${Mail}  ${Account}  ${Password}
    # capture page screenshot           ${Folder}Register.jpg

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

Go home page
    Click Logo Go Home Page

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




    

# Trigger Order Point Overlay
#     Wait Until Page Contains Element      xpath://li[@class="nav-points"]                   5s
#     Click Element                         xpath://li[@class="nav-points"]/div/span/a
#     Wait Until Page Contains Element      xpath://span[@class="cta_pts_group"]/a[@class="btn btn-blue"]              5s
#     Click Element                         xpath://span[@class="cta_pts_group"]/a[@class="btn btn-blue"]
    



# Go Order Point Overlay
#     Buy Point with CC



# Trigger Order Point Page
#     Wait Until Page Contains Element      xpath://li[@class="nav-points"]                   5s
#     Click Element                         xpath://li[@class="nav-points"]/div/span/a
#     Wait Until Page Contains Element      xpath://span[@class="cta_pts_group"]/span/a[@class="point_number"]    5s        5s
#     Click Element                         xpath://span[@class="cta_pts_group"]/span/a[@class="point_number"]  
#     Wait Until Page Contains Element      xpath://div[@class="grey_block"]/a[@class="btn btn-blue"]             5s
#     Click Element                         xpath://div[@class="grey_block"]/a[@class="btn btn-blue"]


# Quickbuy
#     Wait Until Page Contains Element      xpath://div[@class="action-btn"]/span
#     Click Element                         xpath://div[@class="custom-dropdown"][@data-name="PointsSelector"]
#     sleep                                 1s
#     Click Element                         xpath://div[@class="custom-options"]/div[@data-value="50.0"]
#     sleep                                 1s
#     Click Element                         xpath://div[@class="action-btn"]/span
#     sleep                                  3s

# Go Order Point Page
#     Wait Until Page Contains Element    xpath:(//div[@class="checkborder"])[1]                                  5s
#     Click Element                       xpath:(//div[@class="checkborder"])[1]
#     Click Element                       xpath://button[@id="saved-submit"]
#     Wait Until Page Contains Element    xpath://div[@class="continue"]               20s
#     Click Element                       xpath://div[@class="continue"]



# Go upgrade page
#     # Trigger upgrade from handle
#     Wait Until Page Contains Element    (//a[@class="handle_container"])[5]
#     Click Element                       (//a[@class="handle_container"])[5]
    
    # Trigger upgrade from left side
    # Wait Until Page Contains Element    //a[@class="btn btn-red"][@data-ga-event="Left ad:Text"]
    # Click Element                       //a[@class="btn btn-red"][@data-ga-event="Left ad:Text"]

    # Trigger upgrade from right-top
    # Wait Until Page Contains Element    xpath://a[@class="profile-link"]
    # Mouse Over                          xpath://a[@class="profile-link"]
    # Wait Until Page Contains Element    //ul[@class="dropdown subnav-flyout"]/li[5]/a[@class="btn btn-red"]
    # Click Element                       //ul[@class="dropdown subnav-flyout"]/li[5]/a[@class="btn btn-red"]

# Upgrading
#     ${Order_page}=  Run Keyword And Return Status   Wait Until Location Contains   adultfriendfinder.com/p/order.cgi    10s
#     Run Keyword If     ${Order_page}   Upgrade from page no cc     ${CC_number}

#     ${Order_overlay}=   Run Keyword And Return Status    Wait Until Page Contains Element    xpath://iframe[@class="ffn_overlay_frame"]     10s
#     Run Keyword If     ${Order_overlay}   Upgrade from overlay no cc     ${CC_number}




# Check history
#     Check on order history             ${Admin_Account}  ${Admin_Password}  ${Account}  ${check_item}
#     sleep                           60s





*** Keywords ***
