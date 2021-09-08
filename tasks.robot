*** Settings ***
Documentation    Complete orders
Library          Collections
Library          MyLibrary
Library          RPA.Browser.Selenium
Library          RPA.HTTP
Library          MyLibrary
Library          RPA.Excel.Files

*** Keywords ***
Open browse and download
    Open Available Browser    https://developer.automationanywhere.com/challenges/automationanywherelabs-supplychainmanagement.html
    Wait Until Page Contains Element    id:onetrust-policy-text
    Click Button    id:onetrust-accept-btn-handler
    
    #Download    https://s3-us-west-2.amazonaws.com/aai-devportal-media/wp-content/uploads/2021/07/09220646/StateAssignments.xlsx
    #...    overwrite=True
    
    Execute Javascript    window.open()
    Switch Window    locator=NEW
    Go To    https://developer.automationanywhere.com/challenges/AutomationAnywhereLabs-POTrackingLogin.html

    Input Text    id:inputEmail    admin@procurementanywhere.com
    Input Password    id:inputPassword    paypacksh!p
    Click Button    //button[@type='button']
    Wait Until Page Contains Element    id:dtBasicExample
    Select From List By Value    dtBasicExample_length    100
    Switch Window    locator=MAIN
    
*** Keywords ***
Fill in the blank for 7 people
    Open Workbook    ${CURDIR}${/}StateAssignments.xlsx
   
    FOR    ${i}    IN RANGE    1    8    1
        ${PO}=    Get PO number    ${i}
        Fill in the blank for person    ${PO}    ${i}   
    END
    Close Workbook
    Click Button    id:submitbutton
*** Keywords ***
Fill in the blank for person
    [Arguments]    ${PO}    ${i}
    Switch Window    locator=NEW

    Input Text    //input[@type='search']    ${PO}
    ${state}=    Get Table Cell    id:dtBasicExample    2    5
    ${shipdate}=    Get Table Cell    id:dtBasicExample    2    7
    ${ordertotal}=    Get Table Cell    id:dtBasicExample    2    8

    Switch Window    locator=MAIN

    Input Text    id:shipDate${i}    ${shipdate}

    ${ordertotal2}=    Cut String    ${ordertotal}
    Input Text    id:orderTotal${i}    ${ordertotal2}

    FOR    ${n}    IN RANGE    2    53    1
        ${stateexcel}=    Get Cell Value    ${n}    A
        IF    ${stateexcel} == ${state}
            Get agent    ${n}    ${i}
            
        END       
    END      
        
    
*** Keywords ***
Get agent
    [Arguments]    ${n}    ${i}    
    ${agent}=    Get Cell Value    ${n}    B
    Select From List By Value    id:agent${i}    ${agent}   
    



*** Keywords ***

Get PO number
    [Arguments]    ${i}
    ${PO}=    Get Element Attribute    id:PONumber${i}    value
    [Return]    ${PO}


*** Keywords ***
Get data

*** Tasks ***
Word need to do
    Open browse and download
    Fill in the blank for 7 people



    



