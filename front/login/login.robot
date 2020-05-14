*** Keywords ***
Login Usuario
    [Arguments]                         ${email}
    Page Should Contain Element         id=userName
    Input Text                          id=userName             ${email}
Login Password
    [Arguments]                         ${password}
    Page Should Contain Element         id=password
    Input Text                          id=password             ${password}
Login Boton
    Page Should Contain Element         id=loginbuton
    Click Element                       id=loginbuton
# ==================================================================
Completar Formulario de Login
    Wait Until Page Contains Element     xpath=//h1[contains(text(),'Ingresar')]
    Login Usuario                       ${email}
    Login Password                      ${password}
    Login Boton
