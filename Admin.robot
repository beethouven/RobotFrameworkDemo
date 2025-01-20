*** Settings ***
#Documentation    Suite description
Library  SeleniumLibrary
Library  Collections


*** Variables ***

*** Keywords ***

# ---------------------------------Go admin-------------------------------

Go admin by account
    [Arguments]                         ${Admin_Account}  ${Admin_Password}  ${Account}    
    ${Site_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/lookup.cgi?site=ffadult&handle=  ${Account}
    Go To                        ${Site_Link}
    ${confirm_TF}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://span[@style="font-family:verdana"]    10s
    Run Keyword If    ${confirm_TF}    Check confirm handle  ${Account}   ELSE   Confirm for times   ${Site_Link}  ${Account}  3

Go admin by pwsid
    [Arguments]                         ${Admin_Account}  ${Admin_Password}  ${pwsid}    
    ${Site_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/lookup.cgi?site=ffadult&pwsid=  ${pwsid}
    Go To                        ${Site_Link}
    ${confirm_TF}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://span[@style="font-family:verdana"]    10s
    Run Keyword If    ${confirm_TF}    Log To Console   The pwsid is availible   ELSE   Confirm for times no account  ${Site_Link}   3

Go admin by mail
    [Arguments]                         ${Admin_Account}  ${Admin_Password}  ${Mail}    
    ${Site_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/lookup.cgi?site=ffadult&email=  ${Mail}
    Go To                        ${Site_Link}
    ${confirm_TF}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://span[@style="font-family:verdana"]    5s
    Run Keyword If    ${confirm_TF}    Check confirm mail  ${Mail}
    ${DupMail_TF}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://center/table[@bgcolor="#EEF7FF"]    5s
    Run Keyword If    ${DupMail_TF}    Click First mail
    Run Keyword If    ${DupMail_TF}    Check confirm mail  ${Mail}
    ${NoAccount_TF}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://font[@size="4"][@color="red"]/b[contains(text(),"Cannot Find handle from Email")]    5s
    Run Keyword If    ${NoAccount_TF}  Log To Console   There is no account with the mail

# ---------------------------------Go admin-------------------------------

Confirm Admin
    [Arguments]                         ${Admin_Account}  ${Admin_Password}  ${Account}
    ${Site_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/lookup.cgi?site=ffadult&handle=  ${Account}  &remove_need_to_activate_via_email=1
    Go To                        ${Site_Link}
    ${confirm_TF}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://span[@style="font-family:verdana"]    10s
    Run Keyword If    ${confirm_TF}    Check confirm handle  ${Account}   ELSE   Confirm for times   ${Site_Link}  ${Account}  3
    # Run Keyword If    ${confirm_TF}    Check confirm handle  ${Account}   ELSE   Confirm again   ${Site_Link}  ${Account}

Get PWSID From Admin
       ${GetPWSid}=      Get Text        xpath://font/b/a
       [return]          ${GetPWSid}

Get Account From Admin
       ${GetAccount}=      Get Text        xpath://span[@style="font-family:verdana"]
       [return]          ${GetAccount}

Get Mail From Admin
       ${GetMail}=   Get Element Attribute   xpath://input[@name="emailNew"]   value
       [return]          ${GetMail}

# ----------------------------Approve----------------------------

Go Approve Page From Admin
    Click Element       xpath://b[.='Profile Review']

Go Approve Page from Link
    [Arguments]                   ${Admin_Account}  ${Admin_Password}  ${PWSID}
    ${Site_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/create_review_form.cgi?pwsid=  ${PWSID}  &site=ffadult
    Go To                        ${Site_Link}

Approve Account
    Wait Until Page Contains Element     //a[.='Deselect All']          10s
    Click Element       //a[.='Deselect All']
    Click Element       //input[@type='submit']

# ----------------------------Approve----------------------------

# ------------------Set Account External Internal------------------

Set to be External Account from Link
    [Arguments]                   ${Admin_Account}  ${Admin_Password}  ${PWSID}  ${handle}
    ${Site_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/approve_deny.cgi?set_to_external=1&login=yes&site=ffadult&  ${PWSID}  &handle=  ${handle}  &p=admin_lookup_refresh
    Go To                        ${Site_Link}
    Wait Until Page Contains Element        xpath://a[contains(text(),'Internal Account')]
                    
Set to be External Account
    ${External_Link}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://a[contains(text(),'External Account')]    10s
    Run Keyword If    ${External_Link}    Click Element  xpath://a[contains(text(),'External Account')]   ELSE   Log To Console     It's External account already

Set to be Internal Account from Link
    [Arguments]                   ${Admin_Account}  ${Admin_Password}  ${PWSID}  ${handle}
    ${Site_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/approve_deny.cgi?set_to_internal=1&login=yes&site=ffadult&  ${PWSID}  &handle=  ${handle}  &p=admin_lookup_refresh
    Go To                        ${Site_Link}
    Wait Until Page Contains Element        xpath://a[contains(text(),'External Account')]

Set to be Internal Account
    ${Internal_Link}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://a[contains(text(),'Internal Account')]    10s
    Run Keyword If    ${Internal_Link}    Click Element  xpath://a[contains(text(),'Internal Account')]   ELSE   Log To Console     It's Internal account already

# ------------------Set Account External Internal------------------

# ------------------Deact------------------

Check Deactive
    [Arguments]                   ${Admin_Account}  ${Admin_Password}  ${PWSID}  ${handle}
    ${PWSID}=   Get PWSID From Admin
    ${Deactive_Account}=  Run Keyword And Return Status   Wait Until Page Contains Element    xpath://span[@class="acc_deact"]     20s
    Run Keyword If     ${Deactive_Account}   Log To Console   ${Account} already be deactive   ELSE   Deact from Admin    ${Admin_Account}  ${Admin_Password}  ${PWSID}  ${Account}

Deact from Admin
    [Arguments]                   ${Admin_Account}  ${Admin_Password}  ${PWSID}  ${handle}
    ${Site_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/lookup.cgi?site=ffadult&action=delete_member&pwsid=  ${PWSID}  &handle=  ${handle}
    Go To                        ${Site_Link}
    Wait Until Page Contains Element        xpath://span[@class="acc_deact"]            20s

# ------------------Deact------------------


Change Email
    [Arguments]                   ${Mail}
    Input Text       xpath://input[@name="emailNew"]    ${Mail}
    # Should wait API finish
    sleep       30s

Check on order history
    [Arguments]                         ${Admin_Account}  ${Admin_Password}  ${Account}
    ${OrderHistory_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/billing/cc_lookup.cgi?action=search&handle=  ${Account}  &siteid=ffadult&view=full
    Log To Console   ${OrderHistory_Link}
    Go To  ${OrderHistory_Link}
    Wait Until Page Contains Element      xpath://span[@class="origin"]     10s
    ${Order_Count}=     Get Element Count    xpath://span[@class="origin"]
    @{Order_History}=     Create List
    
    : FOR    ${INDEX}    IN RANGE    1    ${Order_Count}+1
    \    ${origin_path}=     catenate      SEPARATOR=    xpath://tr[@id="order_  ${INDEX}  "]/td/span[@class="origin"]
    \    ${price_path}=     catenate      SEPARATOR=    xpath://tr[@id="order_  ${INDEX}  "]/td/b/span[@class="total_charged_price"]    
    \    &{Origin_Price}=   Create Dictionary  Origin='Origin'     Price='Price'
    \    ${Origin_Price.Origin}=         Get Text         ${origin_path}
    \    ${Origin_Price.Price}=          Get Text         ${price_path}
    \   Append To List    ${Order_History}     ${Origin_Price}
    [return]       ${Order_History}

Drop To Standard
    [Arguments]                         ${Admin_Account}  ${Admin_Password}  ${Account}
    ${Drop_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/billing/change_level.cgi?payment=drop&handle=  ${Account}  &siteid=ffadult
    Log To Console   ${Drop_Link}
    Go To  ${Drop_Link}
    Wait Until Page Contains Element      xpath://input[@value="Membership"]    5s
    Click Element                         xpath://input[@value="Membership"]
    Input Text                            xpath://input[@name="reason"]         For Checking
    Click Element                         xpath://input[@value="Drop Membership To Standard"]
    Wait Until Location Is Not            ${Drop_Link}                          20s

Give Point
    [Arguments]                           ${Point}
    Wait Until Page Contains Element      xpath://a[contains(text(),'Give Points')]                             10s
    Click Element                         xpath://a[contains(text(),'Give Points')]
    Wait Until Page Contains Element      xpath://input[@name="points"]             5s
    Input Text                            xpath://input[@name="points"]          ${Point}
    Click Element                         xpath://input[@value="Give Points"]
    Wait Until Location Contains                admin.friendfinderinc.com/cgi-bin/admin/points_admin.cgi      20s

Give Point from Link
    [Arguments]                   ${Admin_Account}  ${Admin_Password}  ${PWSID}  ${Point}
    ${Site_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/points_admin.cgi?site=ffadult&pwsid=  ${PWSID}
    Go To                        ${Site_Link}
    Wait Until Page Contains Element      xpath://input[@name="points"]             5s
    Input Text                            xpath://input[@name="points"]          ${Point}
    Click Element                         xpath://input[@value="Give Points"]
    Wait Until Location Contains          https://admin.friendfinderinc.com/cgi-bin/admin/points_admin.cgi      10s

# --------------------------Pdf Option--------------------------

Get Pdf Information
    [Arguments]                   ${Admin_Account}  ${Admin_Password}  ${PWSID}  ${Item}
    ${Site_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/show_pdf.cgi?id=  ${PWSID}  &site=ffadult
    Go To                        ${Site_Link}
    ${Check_Item}=     catenate      SEPARATOR=    //b[text()='  ${Item}  ']
    Wait Until Page Contains Element        ${Check_Item}
    ${Check_Item_Result}=   catenate      SEPARATOR=  "  ${Check_Item}  /following-sibling::text()  "
    ${Check_Item_Text}=  Execute Javascript    return Array.from(document.querySelectorAll('b')).find(el => el.textContent === '${Item}').nextSibling.wholeText
    Log To Console      ${Check_Item_Text}
    [return]    ${Check_Item_Text}

Add Pdf Information
    [Arguments]                   ${Admin_Account}  ${Admin_Password}  ${PWSID}  ${Item}  ${Value}
    ${Site_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/show_pdf.cgi?id=  ${PWSID}  &no_skip=&edit=1&site=ffadult
    Go To                         ${Site_Link}
    Wait Until Page Contains Element     xpath://input[@name="new_pdf_key"]
    Input Text                 xpath://input[@name="new_pdf_key"]           ${Item}
    Input Text                 xpath://textarea[@name="new_pdf_value"]      ${value}
    Click Element       `      xpath://input[@type="submit"]

Edit Pdf Information
    [Arguments]                   ${Admin_Account}  ${Admin_Password}  ${PWSID}  ${Item}  ${Value}
    ${Site_Link}=     catenate      SEPARATOR=    https://  ${Admin_Account}  :  ${Admin_Password}  @admin.friendfinderinc.com/cgi-bin/admin/show_pdf.cgi?id=  ${PWSID}  &no_skip=&edit=1&site=ffadult
    Go To                         ${Site_Link}
    ${Item_Xpath}=      catenate      SEPARATOR=    //b[text()="  ${Item}  "]
    ${Value_Xpath}=     catenate      SEPARATOR=    //input[@name="pdf_  ${Item}  "]
    ${Item_TF}=  Run Keyword And Return Status    Wait Until Page Contains Element    ${Item_Xpath}    10s
    Run Keyword If    ${Item_TF}    Input Text   ${Value_Xpath}   ${Value}  ELSE   Add Pdf Information   ${Admin_Account}  ${Admin_Password}  ${PWSID}  ${Item}  ${Value}
    Run Keyword If    ${Item_TF}    Click Element       `      xpath://input[@type="submit"]
    
# --------------------------Pdf Option--------------------------

Click First mail
    Click Element                       xpath://center/table[@bgcolor="#EEF7FF"]/tbody/tr[2]/td[7]

Check confirm handle
    [Arguments]                         ${Account}
    Element Text Should Be              xpath://span[@style="font-family:verdana"]                  ${Account}
    Pass Execution    Go admin by account

Check confirm mail
    [Arguments]                         ${Mail}
    ${Admin_Mail}=      Get Element Attribute       xpath://input[@name="emailNew"]      value
    Should Be Equal     ${Mail}     ${Admin_Mail}
    Pass Execution    Go admin by mail


Confirm No Limit
    [Arguments]                        ${Site_Link}    ${Account}
    Go To                        ${Site_Link}
    ${confirm_TF}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://span[@style="font-family:verdana"]    10s
    Run Keyword If    ${confirm_TF}    Check confirm handle  ${Account}     ELSE   Confirm No Limit  ${Site_Link}   ${Account}

Confirm for times no account
    [Arguments]                         ${Site_Link}  ${Times}
    ${Times}=   Convert To Integer     ${Times}
    : FOR    ${INDEX}    IN RANGE    0    ${Times}
    \    Go To                        ${Site_Link}
    \    ${confirm_TF}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://span[@style="font-family:verdana"]    10s
    \    Log To Console     ${INDEX} Times
    \    Exit For Loop IF    ${confirm_TF}
    Run Keyword If    ${confirm_TF}    Log To Console   The pwsid is availible    ELSE   Log To Console   No Account

Confirm for times
    [Arguments]                         ${Site_Link}  ${Account}  ${Times}
    ${Times}=   Convert To Integer     ${Times}
    : FOR    ${INDEX}    IN RANGE    0    ${Times}
    \    Go To                        ${Site_Link}
    \    ${confirm_TF}=  Run Keyword And Return Status    Wait Until Page Contains Element    xpath://span[@style="font-family:verdana"]    10s
    \    Log To Console     ${INDEX} Times
    \    Exit For Loop IF    ${confirm_TF}
    Run Keyword If    ${confirm_TF}    Check confirm handle  ${Account}    ELSE   Log To Console   No Account