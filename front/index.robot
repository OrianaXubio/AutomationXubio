*** Keywords ***
Elegir Pais
    [Documentation]                     Elijir el pais en el index
    [Arguments]                         ${pais}
    Location Should Be                  ${URL}
    Click Element                       xpath=//p[text()= '${pais}']