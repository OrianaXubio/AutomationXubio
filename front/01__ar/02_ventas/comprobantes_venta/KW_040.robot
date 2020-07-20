*** Settings ***
Library             SeleniumLibrary
Library             DateTime
Library             ../../../funciones_generales/funciones.py

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Variables ***
${tipo}             Archivo

*** Keywords ***
Ingresar a Comprobantes de Venta
    [Documentation]                     Ir a Comprobantes de Venta
    log to console                      Ir a Comprobantes de Venta
    comprobantes_venta.Ir a Comprobantes de Venta

Importar Planilla Excel
    [Documentation]                     importa planilla de excel
    log to console                      importa planilla de excel
    comprobantes_venta.Ir A Importar Excel
    ${archivo}=         funciones.ruta archivo         ./archivos_adjuntos/prueba testeo.xls
    Choose File         xpath=//input[@id='fileVerdad_0']         ${archivo}
    sleep   1s
    click               xpath=//div[@id="overDiv"]//a[@id='APLICACIONIMPORTAR_0']
    Wait Until Element Is Visible           xpath=//div[@class='FAFProgressBar']
    Wait Until Element Is Not Visible       xpath=//div[@class='FAFProgressBar']            timeout=50

Validaciones
    log to console                      validaciones
    Wait Until Element Is Visible       xpath=//div[@id='overDiv']
    assertText                          xpath=//div[@id="overDiv"]//table//tr[2]//td[2]     La importación finalizó. Se importaron 32 de 32 registros.
    click                               xpath=//a[@id='btnOK']
    Wait Until Element Is Not Visible   xpath=//div[@id='overDiv']
    comprobantes_venta.Filtrar Fecha    30  12  2020
    comprobantes_venta.Buscador         Importación
    assertText                          xpath=//div[@class='dock']                          32 registros encontrados.
    assertText                          xpath=//span[@class='item first']                   Total Mon. Principal: 585,957.35
    # Eliminar todos los registros filtrados
    Select Checkbox                     xpath=//input[@id='CKBox_first']
    Checkbox Should Be Selected         xpath=//div[contains(@class,'webix_first')]//div[1]//div[1]//input[1]
    comprobantes_venta.Eliminar Seleccion De Comprobantes
    sleep   2s
    Wait Until Element Contains             xpath=//div[@class='dock']                      No se encontraron registros.

TC_040
    [Documentation]                     Importar facturas de venta desde excel
    KW_040.Ingresar a Comprobantes de Venta
    KW_040.Importar Planilla Excel
    KW_040.Validaciones