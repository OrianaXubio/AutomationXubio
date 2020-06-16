*** Settings ***
Documentation       Comprobantes de ventas
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../funciones_generales/common.robot
Resource            ../../../index.robot
Resource            ../../../01__ar/index_ar.robot
Resource            ../../../login/login.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot

Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Variables ***
${URL}              https://xubiotesting2.ddns.net/
${email}            xubiotesting1@gmail.com        # melina@xubio.com
${password}         xubiotest2020               # 1161667410
${pais}             Argentina

*** Test Cases ***
Login
    [Documentation]         Ingresar al sistema con credenciales validas
    [Tags]      login
    Elegir Pais                         ${pais}
    index_ar.Loguearse Ar
    login.Completar Formulario de Login
    vision_general.Validar Ingreso Al Sitio

Filtros en Comprobante de Ventas
    [Documentation]         Se prueban todos los filtros en comprobante de ventas
    click    link=Ventas
    click    link=Comprobantes de Venta
    verifyText    xpath=//div[@id='webreport_container']/div/div/div    Comprobantes de Venta
    click    xpath=//a[@id='FAFWebReportFiltersLink']/div
    wait until keyword succeeds     20x      1s       clear element text        name=day
    type    name=day    01
    wait until keyword succeeds     20x      1s       clear element text        name=month
    type    name=month    05
    wait until keyword succeeds     20x      1s       clear element text        name=year
    type    name=year    2019
    wait until keyword succeeds     20x      1s       clear element text        xpath=(//input[@name='day'])[2]
    sleep   3s
    input text    xpath=(//input[@name='day'])[2]    31
   # wait until keyword succeeds     20x      1s       clear element text        xpath=(//input[@name='month'])[2]
    input text    xpath=(//input[@name='month'])[2]    12
   # wait until keyword succeeds     20x      1s       clear element text        xpath=(//input[@name='year'])[2]
    input text    xpath=(//input[@name='year'])[2]    2019
    click    link=Aceptar
    sleep   3s
    assertText    xpath=//div[@id='webreport_container']/div/div[2]/div/div/div/div/div[2]          01-05-2019
    assertText    xpath=//div[@id='webreport_container']/div/div[2]/div/div/div/div[2]/div[2]       31-12-2019
    assertText    xpath=//div[@id='webreport_container']/div/div[5]/div/div[3]/div          1000 registros encontrados.
    click    xpath=//a[@id='FAFWebReportFiltersLink']/div
    click    xpath=//input[@value='0']
    click    link=Aceptar
    sleep   3s
    assertText    xpath=//div[@id='webreport_container']/div/div[2]/div/div/div/div[3]/div      Pendientes de Cobro
    assertText    xpath=//div[@id='webreport_container']/div/div[5]/div/div[3]/div              1000 registros encontrados.
    click    xpath=//a[@id='FAFWebReportFiltersLink']/div
    click    xpath=//input[@value='0']
    click    xpath=(//input[@value='0'])[4]
    click    link=Aceptar
    sleep   3s
    assertText    xpath=//div[@id='webreport_container']/div/div[5]/div/div[3]/div              2732 registros encontrados.
    click    xpath=//a[@id='FAFWebReportFiltersLink']/div
    click    xpath=(//input[@value='0'])[4]
    click    xpath=(//input[@value='0'])[2]
    click    link=Aceptar
    sleep   3s
    assertText    xpath=//div[@id='webreport_container']/div/div[5]/div/div[3]/div              1000 registros encontrados.
    click    xpath=//a[@id='FAFWebReportFiltersLink']/div
    # click    xpath=(//input[@value='0'])[2]
    click    xpath=//div[@id='cmwebreport']/div/div/div/div/div/div/div[11]/div[2]/div/div/a/span
    click    xpath=//td/div/table/tbody/tr[4]/td
    click    link=Aceptar
    assertText    xpath=//div[@id='webreport_container']/div/div[5]/div/div[3]/div              No se encontraron registros.