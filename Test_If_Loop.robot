*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Library     DateTime


*** Variables ***
${Folder_base}     C:\\Users\\tchang.tw\\Desktop\\robot\\Report_by_date\\
${Admin_Account}   tchang.tw
${Admin_Password}  sj03sj03!
${Account}         bt191122gga

*** Test Cases ***
Go site and check
    ${Site_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/lookup.cgi?site=ffadult&handle=  ${Account}  &remove_need_to_activate_via_email=1
    Set Global Variable     ${Confirm_Link}   ${Site_Link}    
    Open Browser                    ${Confirm_Link}        Chrome
    ${present}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://span[@style="font-family:verdana"]    10s
    Log To Console    ${present}
    Run Keyword If    ${present}    Show console     ELSE    Show console Not    
    
    # Wait Until Page Contains Element    xpath://span[@style="font-family:verdana"]                  20s
    Element Text Should Be              xpath://span[@style="font-family:verdana"]                  ${Account}            

*** Keywords ***
Show console
    Log To Console   GetYou

Show console Not
    Go To      ${Confirm_Link}
    ${present}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://span[@style="font-family:verdana"]    10s
    Log To Console    ${present}
    Run Keyword If    ${present}    Show console     ELSE    Show console Not 