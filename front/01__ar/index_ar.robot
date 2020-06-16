*** Keywords ***
Boton Ingresar
    Page Should Contain Element         xpath=(//a[text() = "Ingresar"])[1]
    Click Element                       xpath=(//a[text() = "Ingresar"])[1]
Boton Registrarme
    Page Should Contain Element         xpath=//a[text() = "Registrarme gratis"]
    Click Link                          Registrarme gratis

#=============================================================================
Loguearse Ar
    [Documentation]                     Ingresar al formulario de login
    Boton Ingresar
Registrarme Ar
    [Documentation]                     Ingresar al formulario de registracion
    Boton Registrarme