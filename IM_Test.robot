*** Settings ***
Documentation    Suite description
Library          SeleniumLibrary

Resource         Register_Login.robot
Resource         New_IM.robot
# Resource         Order.robot
# Resource         Admin.robot
# Resource         Profile.robot



*** Variables ***

${Mail}                 tchang.tw@ffn.com
${Password}             00000
${Gender}               Woman
${Admin_Account}        tchang.tw
${Admin_Password}       sj03sj03$
${CC_number}            92401234567890805
${check_item}           xpath://tr[@id="order_1"]/td[1]/span[@class="origin"]
${Folder_base}          C:\\Users\\tchang.tw\\Desktop\\robot\\Report_by_date\\
${Account}              bt11M09D1936
${Handle2}              bt191122ga
${Password2}            bt191122



*** Test Cases ***

Go AFF
    Open Browser                    https://adultfriendfinder.com/?lang=english&debug_cookie=fake_ip:65.7.63.115        Chrome       alias=Sender
    ${Sender_Home}=                 Get Window Handles
    Set Global Variable     ${Sender_Home_G}   ${Sender_Home[-1]}   
    Log To Console   ${Sender_Home_G}
    
 

Login from cover                     
    Go To                           https://adultfriendfinder.com/?lang=english&debug_cookie=fake_ip:65.7.63.115
    Login_cover                     ${Account}  ${Password}
    Click Logo Go Home Page

Open IM and Wait
    ${Sender_IM}=     Open IM and Get Window's Handle
    Set Global Variable     ${Sender_IM_G}   ${Sender_IM}
    Log To Console   ${Sender_IM_G}

# Another Browser for Recevier

Go AFF And Login
    Open Browser                        https://adultfriendfinder.com?lang=english&debug_cookie=no_admin:1          Chrome   alias=Recevier
    ${Reciever_Home}=                   Get Window Handles
    Set Global Variable     ${Reciever_Home_G}   ${Reciever_Home[-1]}    
    Log To Console   ${Reciever_Home_G}
    Login_cover                         ${Handle2}  ${Password2}

Go Home Page
    Click Logo Go Home Page
    

Open IM
    ${Recevier_IM}=     Open IM and Get Window's Handle
    Set Global Variable     ${Recevier_IM_G}   ${Recevier_IM}
    Log To Console   ${Recevier_IM_G}
    

Send IM
    Go Search                          ${Account}
    sleep                               3s
    Go Friend                          ${Account}
    sleep                               3s
    # Wait Until Page Contains Element    xpath://div[@class="input-row"]     3s
    # Click Element                       xpath://div[@class="input-row"]
    Send IM



Switch and Reply
    Log To Console   ${Recevier_IM_G} ${Reciever_Home_G} ${Sender_IM_G}  ${Sender_Home_G}
    
    Switch Browser      Sender
    Switch Window       ${Sender_IM_G}

    Go Friend           ${Handle2}
    # Wait Until Page Contains Element    xpath://div[@class="input-row"]     3s
    # Click Element                       xpath://div[@class="input-row"]
    Send IM
    Send Tip
    Send Gift
    Quickbuy from Tip
    sleep                       3s
    Switch Browser      Recevier
    Switch Window       ${Recevier_IM_G}
    sleep                       3s
    Switch Browser      Sender
    Switch Window       ${Sender_IM_G}
    
    sleep               3s
    Quickbuy from Gift



# Send Tip

# Quickbuy from Gift

# Send Gift
    
# Finish test close browser
#     Close All Browsers

 
*** Keywords ***
