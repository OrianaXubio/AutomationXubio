*** Settings ***
Resource            ../01__ar/index_ar.robot
Resource            ../01__ar/vision_general.robot
Resource            ../index.robot
Resource            ../funciones_generales/recursos.robot

*** Variables ***
${email}            xubiotesting1@gmail.com        # melina@xubio.com
${password}         xubiotest2020               # 1161667410
${pais}             Argentina

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
    [Documentation]                     Completar el formulario con credenciales validas
    Wait Until Page Contains Element     xpath=//h1[contains(text(),'Ingresar')]
    Login Usuario                       ${email}
    Login Password                      ${password}
    Login Boton

Login
    [Documentation]         Ingresar al sistema con credenciales validas
    [Tags]      login
    log to console          ingresando al sistema
    index.Elegir Pais                         ${pais}
    index_ar.Loguearse Ar
    Completar Formulario de Login
    log to console          login
    vision_general.Validar Ingreso Al Sitio
    recursos.Verificar Tipo De Empresa      Responsable Inscripto