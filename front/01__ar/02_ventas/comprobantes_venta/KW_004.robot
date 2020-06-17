*** Settings ***
Documentation       Nueva venta
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../funciones_generales/common.robot
Resource            ../../../index.robot
Resource            ../../../01__ar/index_ar.robot
Resource            ../../../login/login.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot

*** Keywords ***
Mas Opciones 1
    [Arguments]     ${moneda}   ${cotizacion}
    click       xpath=//input[@value='Más Opciones']
    click       xpath=//div[@id='masOpcionesWrapper']/div[11]/div/div[2]/div/input
    wait until keyword succeeds     20x      1s       clear element text  xpath=//div[@id='masOpcionesWrapper']/div[11]/div/div[2]/div/input
    click       xpath=//div[@id='masOpcionesWrapper']/div[11]/div/div[2]/div/input
    type        xpath=//div[@id='masOpcionesWrapper']/div[11]/div/div[2]/div/input      ${moneda}
    click       xpath=//td/div/table/tbody/tr/td
    click       css=div[name="wdg_Cotizacion"] > input[type="textbox"]
    type        css=div[name="wdg_Cotizacion"] > input[type="textbox"]                  ${cotizacion}
    sendKeys    css=div[name="wdg_Cotizacion"] > input[type="textbox"]      TAB

Login
    [Documentation]         Ingresar al sistema con credenciales validas
    [Tags]      login
    Elegir Pais                         ${pais}
    index_ar.Loguearse Ar
    login.Completar Formulario de Login
    vision_general.Validar Ingreso Al Sitio

Factura A Al Contado En Dolares
    Go To                                 https://xubiotesting2.ddns.net/NXV/vision-general
    sleep   2s
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente         Responsable Inscripto   default     Factura     Contado
    Mas Opciones 1                          Dólares     65.40

Agregar Productos
    sleep   2s
    comprobantes_venta.Agregar Item RI    1   Carpeta         1       2500        0
    comprobantes_venta.Agregar Item RI    2   Alquiler        1       16500       10
    comprobantes_venta.Agregar Item RI    3   Cinta Papel     2.5     500         0
    comprobantes_venta.Agregar Item RI    4   Goma de borrar  4       120         0
    comprobantes_venta.Agregar Item RI    5   Carátulas       7       25          0
    comprobantes_venta.Agregar Item RI    6   Carátulas       2       -25         0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_7']/div/div

Grilla Percepcion/Impuestos
    sleep  2s
    click    xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion      1   Ingresos Brutos Buenos Aires (Percepción)   250
    comprobantes_venta.Agregar Percepcion      2   IVA                                         130
    comprobantes_venta.Agregar Percepcion      3   Impuestos Internos                          360
    comprobantes_venta.Agregar Percepcion      4   Categoría OTRO                              125.50
    click    xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_5']/div/div

Instrumentos de Cobro
    sleep   2s
    comprobantes_venta.Agregar Instrumento De Cobro     1   Caja    Caja en USD     Dólares   65.40   3891.13
    comprobantes_venta.Agregar Instrumento De Cobro     2   Banco   Banco Galicia cuenta USD   Dólares   65.40   20000
    click    xpath=//td[@id='TransaccionTesoreriaIngresoItems_internal_delete_column_3']/div/div

Guardar Factura
    comprobantes_venta.Guardar

Validaciones
    assertText    xpath=//th[8]/div[2]          Importe
    assertText    xpath=//th[9]/div[2]          IVA
    assertText    xpath=//th[10]/div[2]         Total
    assertText    xpath=//td[@id='TransaccionCVItems_Importe_1']/div            2,500.00
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_1']/div    675.00
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteTotal_1']/div       3,175.00
    assertText    xpath=//td[@id='TransaccionCVItems_Importe_2']/div            14,850.00
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_2']/div    3,118.50
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteTotal_2']/div       17,968.50
    assertText    xpath=//td[@id='TransaccionCVItems_Importe_3']/div            1,250.00
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_3']/div    0.00
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteTotal_3']/div       1,250.00
    assertText    xpath=//td[@id='TransaccionCVItems_Importe_4']/div            480.00
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_4']/div    24.00
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteTotal_4']/div       504.00
    assertText    xpath=//td[@id='TransaccionCVItems_Importe_5']/div            175.00
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_5']/div    4.38
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteTotal_5']/div       179.38
    assertText    xpath=//td[@id='TransaccionCVItems_Importe_6']/div            -50.00
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_6']/div    -1.25
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteTotal_6']/div       -51.25

    comprobantes_venta.Letra Numero Comprobante       A
    comprobantes_venta.Total Bruto                    19205.0000
    comprobantes_venta.Total Impuestos                4686.1300
    comprobantes_venta.Total                          23891.1300
    comprobantes_venta.Total Cobranza                 1562479.9020

    click       xpath=//input[@value='Más Opciones']
    Page Should Contain Element     xpath=//div[@name="wdg_MonedaID"]//input[@value="Dólares"]
    Page Should Contain Element     xpath=//div[@name="wdg_Cotizacion"]//input[@value="65.400000"]

    vision_general.Ir a Inicio
