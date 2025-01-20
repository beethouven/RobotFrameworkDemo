*** Settings ***
Library  SeleniumLibrary

*** Variables ***




*** Test Cases ***

Chrome Headless
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-gpu
    ${options}=     Call Method     ${chrome_options}    to_capabilities
    Create Webdriver    Chrome    desired_capabilities=${options}
    Set Window Size    1920    1080
    Maximize Browser Window

Mobile Emulator
    # Device name can be Nexus 4,5,6 Nokia N9, iPad Mini, iPhone 4,5,6,7,8,9,X, Galaxy S5 S6
    ${devname}    Create Dictionary    deviceName=iPhone X
    ${mobile_emulation}    Create Dictionary     mobileEmulation=${devname}
    ${chromeoptions}    Evaluate    sys.modules['selenium.webdriver.chrome.options'].Options()     sys, selenium.webdriver.chrome.options
    ${chromeoptions._experimental_options}    Set Variable     ${mobile_emulation}
    Call Method    ${chromeoptions}    add_experimental_option    mobileEmulation     ${devname}
     Create Webdriver     Chrome    chrome_options=${chromeoptions}

Healess Mobile
    sleep           10s



*** Keywords ***
