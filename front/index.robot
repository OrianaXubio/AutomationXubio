*** Keywords ***
Elegir Pais
    [Arguments]                         ${pais}
    Click Element                       xpath=//p[text()= '${pais}']
    Location Should Be                  ${URL}