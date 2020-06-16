*** Settings ***
Documentation       Nueva venta
Library             SeleniumLibrary

Resource            ../../../front/funciones_generales/setup.robot
Resource            ../../../front/funciones_generales/common.robot
Resource            ../../../front/index.robot
Resource            ../../../front/01__ar/index_ar.robot
Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/vision_general.robot
Resource            ../../../front/funciones_generales/keywords.robot

Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Variables ***
${URL}              https://xubiotesting2.ddns.net/
${email}            melina@xubio.com
${password}         1161667410
${pais}             Argentina

*** Test Cases ***
Login
    [Documentation]         Ingresar al sistema con credenciales validas
    [Tags]      login
    Elegir Pais                         ${pais}
    index_ar.Loguearse Ar
    login.Completar Formulario de Login
    vision_general.Validar Ingreso Al Sitio

Editar Cliente
    click    link=Ventas
    click    link=Clientes
    click    xpath=(//input[@type='text'])[2]
    type    xpath=(//input[@type='text'])[2]    Juan Perez
    click    link=Juan Perez
    click    xpath=//input[@value='Juan Perez']
    type    xpath=//input[@value='Juan Perez']    Juan Peres
    click    xpath=(//input[@value=''])[3]
    type    xpath=(//input[@value=''])[3]    1165123456
    click    id=_onSave
    click    xpath=(//input[@type='text'])[2]
    type    xpath=(//input[@type='text'])[2]    Juan Peres
    click    xpath=//div[@id='webreport_container']/div/div[4]/div/div/div/div/a/span
    assertText    link=Juan Peres    Juan Peres