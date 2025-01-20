*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Library     DateTime


*** Variables ***
${Folder_base}     C:\\Users\\tchang.tw\\Desktop\\robot\\Report_by_date\\


*** Test Cases ***

Set Log and folder
    ${Time}=   Get Current Date    result_format=datetime    
    ${Month}=   Convert To Integer     ${Time.month}
    ${Month}    Execute Javascript      return ${Month}/10+''+${Month}%10
    ${Day}=   Convert To Integer     ${Time.day}
    ${Day}    Execute Javascript      return ${Day}/10+''+${Day}%10
    Log To Console      ${Month}
    
    Set Global Variable     ${Account}  bt${Time.month}M${Time.day}D${Time.hour}${Time.minute}
    Set Global Variable     ${Folder}     ${Folder_base}${Time.month}M${Time.day}D\\${Account}
    # capture page screenshot               ${Folder}\\test.png

Test Global Variables
    Log To Console       ${Account}
    Log To Console       ${Folder}
    


Go AFF And Login
    Open Browser                        https://adultfriendfinder.com?lang=english&debug_cookie=no_admin:1          Chrome
    # Go To     https://adultfriendfinder.com?lang=english&debug_cookie=no_admin:1
    Wait Until Page Contains Element    id:login_username_input
    # Input Text                          id:login_username_input               ${Handle}
    # Input Text                          id:login_password_input               ${Password}
    # sleep                               1s
    # Click Button                        id:login_submit
    # sleep                               1s

Take a screenshot
    # Set Screenshot Directory            C:\Users\tchang.tw\Desktop\robot\Top_Fans\Test_Screen
    # Take Screenshot                     test.jpg
    capture page screenshot               ${Folder}\\test.png






*** Keywords ***
