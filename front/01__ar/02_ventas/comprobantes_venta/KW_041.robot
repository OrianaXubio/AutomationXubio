*** Settings ***
Library             SeleniumLibrary
Library             DateTime

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot


*** Keywords ***
Ir a Comprobantes de Ventas
    [Documentation]                                         Ingresa a la seccion Comprobantes de venta
    log to console                                          Ir a Comprobantes de Ventas
    comprobantes_venta.Ir a Comprobantes de Venta

Acciones-Importar
    [Documentation]                                         Selecciona a Acciones , Importar e Importar desde AFIP
    log to console                                          Ir a comprobantes de Venta
    comprobantes_venta.Boton Acciones
    #Importar
    comprobantes_venta.Importar desde la AFIP

Seleccionar Archivo
    [Documentation]                                         Selecciona varios archivo y lo adjunta del ordenador
    ${archivo}=         funciones.ruta archivo              ./archivos_adjuntos/VENTAS (2) (1).txt
    ${archivo2}=        funciones.ruta archivo              ./archivos_adjuntos/ALICUOTAS (2) (1).txt

    Choose File                                             xpath=//input[@id='fileVerdad_0']            ${archivo}
    Choose File                                             xpath=//input[@id='fileVerdad_1']            ${archivo2}
    #Importa el archivo
    click                                                   xpath=//div[@class='FAFPopup']//a[@id='APLICACIONIMPORTAR_0']
    #Pop-up Detalle del proceso
    #boton aceptar
    Wait Until Page Contains Element                        xpath=//div[@class='FAFPopup']//a[@id='btnOK']
    Wait Until Page Contains Element                        xpath=(//div[@class='FAFPopup']//td[contains(text(),'exitosamente')])[1]
    Wait Until Page Contains Element                        xpath=(//div[@class='FAFPopup']//td[contains(text(),'exitosamente')])[2]
    Wait Until Page Contains Element                        xpath=(//div[@class='FAFPopup']//td[contains(text(),'exitosamente')])[3]
    Wait Until Page Contains Element                        xpath=(//div[@class='FAFPopup']//td[contains(text(),'exitosamente')])[4]
    Wait Until Page Contains Element                        xpath=(//div[@class='FAFPopup']//td[contains(text(),'exitosamente')])[5]
    Wait Until Page Contains Element                        xpath=(//div[@class='FAFPopup']//td[contains(text(),'exitosamente')])[6]
    Wait Until Page Contains Element                        xpath=(//div[@class='FAFPopup']//td[contains(text(),'exitosamente')])[7]
    Wait Until Page Contains Element                        xpath=(//div[@class='FAFPopup']//td[contains(text(),'exitosamente')])[8]
    Wait Until Page Contains Element                        xpath=(//div[@class='FAFPopup']//td[contains(text(),'exitosamente')])[9]
    Wait Until Page Contains Element                        xpath=(//div[@class='FAFPopup']//td[contains(text(),'exitosamente')])[10]
    assertText                                              xpath=//div[@id="overDiv"]//table//tr[11]//td[2]          La importación finalizó. Se importaron 10 de 10 registros.
    click                                                   xpath=//div[@class='FAFPopup']//a[@id='btnOK']
Comprobantes de Ventas
    [Documentation]                                         ingresa a la seccion Comprobantes de venta
    comprobantes_venta.Ir a Comprobantes de Venta

Filtrar Fecha
    [Documentation]                                          Filtra por un rango de fechas y selecciona el circuito contable
    #Campo Fecha Desde
     click           xpath=//div[@class='filter-caption']
     click           xpath=(//input[@name='day'])[1]
     sendKeys        xpath=(//input[@name='day'])[1]           DELETE
     input text      xpath=(//input[@name='day'])[1]           01
     click           xpath=(//input[@name='month'])[1]
     sendKeys        xpath=(//input[@name='month'])[1]         DELETE
     input text      xpath=(//input[@name='month'])[1]         08
     click           xpath=(//input[@name='year'])[1]
     sendKeys        xpath=(//input[@name='year'])[1]          DELETE
     input text      xpath=(//input[@name='year'])[1]          2020

     #Campo Fecha Hasta
     click           xpath=(//input[@name='day'])[2]
     sendKeys        xpath=(//input[@name='day'])[2]           DELETE
     input text      xpath=(//input[@name='day'])[2]           30
     click           xpath=(//input[@name='month'])[2]
     sendKeys        xpath=(//input[@name='month'])[2]         DELETE
     input text      xpath=(//input[@name='month'])[2]         09
     click           xpath=(//input[@name='year'])[2]
     sendKeys        xpath=(//input[@name='year'])[2]          DELETE
     input text      xpath=(//input[@name='year'])[2]          2020

     #Circuito Contable
     click                                                 xpath=//div[@name='wdg_p_circuitoContable']//a[@class='action']
     Select Checkbox                                       xpath=//tr[4]//td[1]//input[@type='checkbox'][1]
     #Selecciona aceptar
     click                                                 xpath=//a[@id='botonNuevo']
     click                                                 link=Aceptar

Selecionar todos
    [Documentation]                                        Selecciona las facturas de la grilla
     Wait Until Element Is Visible                         xpath=//input[@id='CKBox_first']
     sleep         3s
     Select Checkbox                                       xpath=//input[@id='CKBox_first']
     Checkbox Should Be Selected                           xpath=//input[@id='CKBox_first']
     sleep                                                 2s
     assertText                                            xpath=//div[@class='dock']                 10 registros encontrados.
     Page Should Contain Element                           xpath=//span[contains(text(),'Total Mon. Principal: 480,641.15')]


Eliminar las Facturas
    [Documentation]                                       Elimina todas las facturas seleccionadas
     comprobantes_venta.Boton Acciones
     sleep                                                2s
     click                                                Link=Eliminar
     click                                                xpath=//a[@id='showAskPopupYesButton']
     Wait Until Element Is Not Visible                    xpath=//div[@id="overDiv"]
     sleep   2s
     Wait Until Element Contains             xpath=//div[@class='dock']                      No se encontraron registros.


TC_041
    [Documentation]                                      Importar facturas de venta desde .txt de AFIP
    KW_041.Ir a Comprobantes de Ventas
    KW_041.Acciones-Importar
    KW_041.Seleccionar Archivo
    KW_041.Comprobantes de Ventas
    KW_041.Filtrar Fecha
    KW_041.Selecionar todos
    KW_041.Eliminar las Facturas
