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

*** Test Cases ***
Nuevo Cliente
    click    link=Ventas
    click    link=Clientes
    click    id=undefined
    click    xpath=//input[@value='']
    type    xpath=//input[@value='']    Juan Perez
    click    xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div/div/div[7]/div[2]/div/div/a/span
    click    xpath=//tr[32]/td
    click    xpath=(//input[@value=''])[2]
    click    xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div/div/div[11]/div[2]/div/div/a/span
    sleep  1s
    click    css=tr.checked > td    #xpath=//td/div/table/tbody/tr/td
    click    xpath=(//input[@value=''])[3]
    #click    xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div/div/div[11]/div[2]/div/div/a/span
    sendKeys    xpath=//div[@id="webreport_container"]/div/div[5]/div[2]/div/div[2]/div[1]/div[3]/div[1]/div[1]/div[2]/input    juanperez@mail.com
    click    xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div[3]/div/div[7]/div[2]/div/div/a/span
    click    xpath=//td/div/table/tbody/tr[2]/td
    click    xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div[3]/div/div[7]/div[2]/div/div/a/span
    click    xpath=//tr[15]/td
    click    xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div[3]/div/div[9]/div[2]/div/div/a/span
    click    xpath=//tr[5]/td
    click    xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div[3]/div/div[11]/div[2]/div/div/a/span
    click    xpath=//td/div/table/tbody/tr/td
    click    id=_onSave
    sleep   2s
    verifyText    xpath=(//div[@class="pageWidth"])[1]    Clientes
    click    xpath=(//input[@type='text'])[2]
    type    xpath=(//input[@type='text'])[2]    Juan Perez
    click    link=Buscar
    assertText    link=Juan Perez    Juan Perez
    click    xpath=(//input[@type='text'])[2]
    clear element text      xpath=(//input[@type='text'])[2]
    click    xpath=//div[@id='webreport_container']/div/div[4]/div/div/div/div/a/span
