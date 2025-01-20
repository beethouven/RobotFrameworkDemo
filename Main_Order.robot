*** Settings ***
Documentation    Suite description
Library          SeleniumLibrary
Library          DateTime

Resource         Register_Login.robot
Resource         Order.robot
Resource         Admin.robot
Resource         Profile.robot
Resource         New_IM.robot



*** Variables ***

${Mail}                 tchang.tw@ffn.com
${Password}             00000
${Gender}               Man
${Admin_Account}        tchang.tw
${Admin_Password}       sj03sj03$
${CC_number}            92401234567890805
${check_item}           xpath://tr[@id="order_1"]/td[1]/span[@class="origin"]
${Folder_base}          C:\\Users\\tchang.tw\\Desktop\\robot\\Report_by_date\\
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
    # capture page screenshot               ${Folder}test.jpg

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
    # Set to be External Account

    # Give Point                        1000

Login from cover                     
    Go To                           https://adultfriendfinder.com/?lang=english&debug_cookie=fake_ip:65.7.63.115
    Login_cover                     ${Account}  ${Password}
    # capture page screenshot               ${Folder}Login.jpg

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

 
*** Keywords ***


