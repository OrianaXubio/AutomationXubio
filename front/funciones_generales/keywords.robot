
*** Keywords ***
open
    [Arguments]    ${element}
    wait until keyword succeeds     10x      1s       Go To          ${element}

click
    [Arguments]    ${element}
    wait until page contains element       ${element}
    wait until keyword succeeds     10x      1s       Click Element  ${element}

sendKeys
    [Arguments]    ${element}    ${value}
    wait until keyword succeeds     10x      1s       Press Keys     ${element}    ${value}

type
    [Arguments]    ${element}    ${value}
    wait until keyword succeeds     10x      1s       Press Keys     ${element}    DELETE
    wait until keyword succeeds     10x      1s       Press Keys     ${element}    ${value}

clickAndWait
    [Arguments]    ${element}
    wait until keyword succeeds     10x      1s       Click Element  ${element}

submit
    [Arguments]    ${element}
    wait until keyword succeeds     10x      1s       Submit Form    ${element}

selectAndWait
    [Arguments]                 ${element}  ${value}
    wait until keyword succeeds     10x      1s       Select From List By Label   ${element}  ${value}

select
    [Arguments]                 ${element}  ${value}
    wait until keyword succeeds     10x      1s       Select From List By Label   ${element}  ${value}

verifyValue
    [Arguments]                  ${element}  ${value}
    wait until keyword succeeds     10x      1s       Element Should Contain       ${element}  ${value}

verifyText
    [Arguments]                  ${element}  ${value}
    wait until keyword succeeds     10x      1s       Page Should Contain          ${value}

verifyElementPresent
    [Arguments]                  ${element}
    wait until page contains element    ${element}
    wait until keyword succeeds     10x      1s       Page Should Contain Element  ${element}

verifyVisible
    [Arguments]                  ${element}
    wait until keyword succeeds     10x      1s       Page Should Contain Element  ${element}

verifyTitle
    [Arguments]                  ${title}
    wait until keyword succeeds     10x      1s       Title Should Be              ${title}

verifyTable
    [Arguments]                  ${element}  ${value}
    wait until keyword succeeds     10x      1s       Element Should Contain       ${element}  ${value}

assertConfirmation
    [Arguments]                  ${value}
    wait until keyword succeeds     10x      1s       Alert Should Be Present      ${value}

assertText
    [Arguments]                  ${element}  ${value}
    Wait Until Element Contains       ${element}  ${value}

assertValue
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

assertElementPresent
    [Arguments]                  ${element}
    wait until keyword succeeds     10x      1s       Page Should Contain Element  ${element}

assertVisible
    [Arguments]                  ${element}
    wait until keyword succeeds     10x      1s       Page Should Contain Element  ${element}

assertTitle
    [Arguments]                  ${title}
    wait until keyword succeeds     10x      1s       Title Should Be              ${title}

assertTable
    [Arguments]                  ${element}  ${value}
    wait until keyword succeeds     10x      1s       Element Should Contain       ${element}  ${value}

waitForText
    [Arguments]                  ${element}  ${value}
    wait until page contains element    ${element}
    Wait Until Element Contains       ${element}  ${value}

waitForValue
    [Arguments]                  ${element}  ${value}
    Wait Until Element Contains       ${element}  ${value}

waitForElementPresent
    [Arguments]                  ${element}
    Wait Until Page Contains Element  ${element}

waitForVisible
    [Arguments]                  ${element}
    Wait Until Page Contains Element  ${element}

waitForTitle
    [Arguments]                  ${title}
    Title Should Be              ${title}

waitForTable
    [Arguments]                  ${element}  ${value}
    wait until keyword succeeds     10x      1s       Table Should Contain       ${element}  ${value}

doubleClick
    [Arguments]           ${element}
    wait until keyword succeeds     10x      1s       Double Click Element  ${element}

doubleClickAndWait
    [Arguments]           ${element}
    wait until keyword succeeds     10x      1s       Double Click Element  ${element}
    sleep  2s

goBack
    wait until keyword succeeds     10x      1s       Go Back

goBackAndWait
    wait until keyword succeeds     10x      1s       Go Back

runScript
    [Arguments]         ${code}
    Execute Javascript  ${code}

runScriptAndWait
    [Arguments]         ${code}
    Execute Javascript  ${code}

setSpeed
    [Arguments]           ${value}
    Set Selenium Timeout  ${value}

setSpeedAndWait
    [Arguments]           ${value}
    Set Selenium Timeout  ${value}

verifyAlert
    [Arguments]              ${value}
    wait until keyword succeeds     10x      1s       Alert Should Be Present  ${value}

selectWindow
    [Arguments]         ${element}
    wait until keyword succeeds     10x      1s       Switch Window       ${element}

waitForTextPresent
    [Arguments]                     ${element}  ${value}
    Wait Until Page Contains        ${value}

storeText
    [Arguments]         ${element}  ${valor}
    ${texto}=           Get Text            ${element}
    [Return]            ${texto}
