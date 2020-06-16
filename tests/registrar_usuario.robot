*** Settings ***
Documentation       Registracion y login
Library             SeleniumLibrary
Library             RequestsLibrary
Resource            ../front/funciones_generales/setup.robot
Resource            ../front/funciones_generales/common.robot
Resource            ../front/index.robot
Resource            ../front/01__ar/index_ar.robot
Resource            ../front/login/login.robot
Resource            ../front/registro/registro.robot
Resource            ../front/01__ar/vision_general.robot
Resource            ../front/registro/bienvenida.robot
Resource            ../front/desloguear/desloguear.robot
Resource            ../front/funciones_generales/keywords.robot


Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Variables ***
${URL}              https://xubiotesting2.ddns.net/
${email}            melina@xubio.com
${password}         1161667410
${nombre}           Juan Perez
${telefono}         110000000
${pais}             Argentina
${tipo}             soyContador

*** Test Cases ***
Registro de Usuario
    [Documentation]         Registrar, dar de alta un usuario
    [Tags]      smoke
    Elegir Pais                         ${pais}
    index_ar.Registrarme Ar
    registro.Completar Formulario de Registro
    bienvenida.Validar Alta Usuario
Salir del Sistema
    [Documentation]         Desloguearse, salir del sistema
    [Tags]      smoke
    desloguear.Desloguearse
Login
    [Documentation]         Ingresar al sistema con credenciales validas
    [Tags]      login
    Create Session    xubio             ${URL}
    Elegir Pais                         ${pais}
    index_ar.Loguearse Ar
    login.Completar Formulario de Login
    vision_general.Validar Ingreso Al Sitio
    #Create Session    xubio         https://xubiotesting2.ddns.net/NXV/vision-general
    ${resp}=          Get Request   xubio               /
    Status Should Be  200           ${resp}
    log               ${resp.status_code}
    log               ${resp.ok}
    log               ${resp.headers}
    log               ${resp.headers['Content-Type']}
    log               ${resp.headers['Date']}

Prueba
    [Tags]  login
    mouse over      //a[contains(text(),'Finanzas')]
    click    link=Fondos
    selectFrame    //iframe[@id='content']
    Wait Until Element Is Visible   xpath=(//a[contains(text(),'Acciones')])[2]
    click    xpath=(//a[contains(text(),'Acciones')])[2]
    click    xpath=(//a[contains(text(),'Exportar')])[2]
    click    xpath=//li[contains(text(),'Exportar a TXT...')]
