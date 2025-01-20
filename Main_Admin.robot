*** Settings ***
Documentation    Suite description
Library          SeleniumLibrary
Library          DateTime


Resource         Register_Login.robot
Resource         Admin.robot
Resource         Account.robot
# Resource         Profile.robot
# Resource         New_IM.robot




*** Variables ***

${Mail}                 tchang.tw@ffn.com
${Mail_Changed}         AutoCheck@ffn.com
${Account}              bt11M17D1730
${Password}             00000
${Password_Changed}     11111
${Gender}               Woman
${Admin_Account}        tchang.tw
${Admin_Password}       sj03sj03$
${CC_number}            92401234567890805
${check_item}           xpath://tr[@id="order_1"]/td[1]/span[@class="origin"]
${Folder_base}          C:\\Users\\tchang.tw\\Desktop\\robot\\Report_by_date\\
${PWSID}                475525567_67841
${Item}                 HISTORY
# ${value}


*** Test Cases ***
Open Browser
    Open Browser                            https://adultfriendfinder.com/?lang=english     Chrome

Login from cover                     
    Go To                           https://adultfriendfinder.com/?lang=english&debug_cookie=fake_ip:65.7.63.115
    Login_cover                     ${Account}  ${Password}

Go home page
    Click Logo Go Home Page

Go Account Page Case
    Go Account Page

Change Mail Case
    Change Mail     ${Mail_Changed}   ${Password}

Go Account Page Again
    Go Account Page

Go Change Password Case
    Change Password   ${Password}   ${Password_Changed}

Go Account Page Again Again
    Go Account Page

Delete Account Case
    Delete Account      ${Password_Changed}

Go Admin
    Go admin by account             ${Admin_Account}  ${Admin_Password}  ${Account}

Check Mail
    ${Mail}=    Get Mail From Admin
    Log To Console      The Mail is ${Mail}

Check Deactive
    ${PWSID}=   Get PWSID From Admin
    Deact from Admin               ${Admin_Account}  ${Admin_Password}  ${PWSID}  ${Account}




# *** Keywords ***

