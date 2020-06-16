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

Eliminar Cliente
    click    link=Ventas
    click    link=Clientes
    click    xpath=(//input[@type='text'])[2]
    type    xpath=(//input[@type='text'])[2]    Juan Peres
    click    link=Juan Peres
    click    id=_onDelete
    click    id=showAskPopupYesButton
    click    xpath=(//input[@type='text'])[2]
    type    xpath=(//input[@type='text'])[2]    juan Peres
    assertText    xpath=//div[@id='webreport_container']/div/div[5]/div/div[3]/div    No se encontraron registros.