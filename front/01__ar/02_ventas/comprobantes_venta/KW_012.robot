*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Factura A Al Contado En Dolares
    [Documentation]                     creacion de una nota de credito
    log to console                      Factura A Al Contado En Dolares
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente       Responsable Inscripto   default     Factura     Contado
    comprobantes_venta.Mas Opciones - Moneda                Dólares     65.40

Agregar Productos
    [Documentation]                     se completan los campos de productos
    log to console                      Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item     1   Carpeta         1       2500.00     0
    comprobantes_venta.Agregar Item     2   Alquiler        1       16500       10
    comprobantes_venta.Agregar Item     3   Cinta Papel     2.5     500         0
    comprobantes_venta.Agregar Item     4   Goma de borrar  4       120         0
    comprobantes_venta.Agregar Item     5   Carátulas       7       25          0
    comprobantes_venta.Agregar Item     6   Carátulas       2       -25         0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_7']/div/div

Grilla Percepcion/Impuestos
    [Documentation]                     se completan los campos de percepcion/impuestos
    log to console                      Grilla Percepcion/Impuestos
    sleep  1s
    click    xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion      1   Ingresos Brutos Buenos Aires (Percepción)   250
    comprobantes_venta.Agregar Percepcion      2   IVA                                         130
    comprobantes_venta.Agregar Percepcion      3   Impuestos Internos                          360
    comprobantes_venta.Agregar Percepcion      4   Categoría OTRO                              125.50
    click    xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_5']/div/div

Instrumentos de Cobro
    [Documentation]                     se completan los campos de instrumento de cobro
    log to console                      Instrumentos de Cobro
    sleep   1s
    comprobantes_venta.Agregar Instrumento De Cobro     1   Caja    Caja en USD     Dólares   65.40   3891.13
    comprobantes_venta.Agregar Instrumento De Cobro     2   Banco   Banco Galicia cuenta USD   Dólares   65.40   20000
    click    xpath=//td[@id='TransaccionTesoreriaIngresoItems_internal_delete_column_3']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura
    comprobantes_venta.Guardar

Validaciones
    [Documentation]                     validacion de columnas importe, iva, total, totalizadores
    ...                                 y letra del comprobante
    log to console                      Validaciones
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
    # validacion de moneda y cotizacion
    click       xpath=//input[@value='Más Opciones']
    Page Should Contain Element     xpath=//div[@name="wdg_MonedaID"]//input[@value="Dólares"]
    Page Should Contain Element     xpath=//div[@name="wdg_Cotizacion"]//input[@value="65.400000"]
    # Se guarda el numero de comprobante en una variable
    ${num_comprobante}      Get value           xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                         ${num_comprobante}

Ir a Crear Nota de Credito
    [Documentation]                     se validan los datos en todos los campos
    log to console                      Ir a Crear Nota de Credito
    click                               xpath=//a[@id='generarNotaCredito']
    Page Should Contain Element         xpath=//div[@id="seccionTitulo"]//div[contains(text(),"Nuevo - Responsable Inscripto - Comprobante de Venta")]
    Page Should Contain Element         xpath=(//div[@name='wdg_Organizacion']//input[@value='Responsable Inscripto'])[2]
    Page Should Contain Element         xpath=//div[@name="wdg_PuntoVenta"]//input[@value="0001"]
    Page Should Contain Element         xpath=//div[@name="wdg_NumeroDocumento"]//input[@value="${num_comprobante}"]
    Page Should Contain Element         xpath=//select[@class='readOnly']//option[@selected="1" and text() = 'Contado']
    #Columna Importe
    assertText                          xpath=(//td[@id='TransaccionCVItems_Importe_1']/div)[2]           2,500.00
    assertText                          xpath=(//td[@id='TransaccionCVItems_Importe_2']/div)[2]           14,850.00
    assertText                          xpath=(//td[@id='TransaccionCVItems_Importe_3']/div)[2]           1,250.00
    assertText                          xpath=(//td[@id='TransaccionCVItems_Importe_4']/div)[2]           480.00
    assertText                          xpath=(//td[@id='TransaccionCVItems_Importe_5']/div)[2]           175.00
    assertText                          xpath=(//td[@id='TransaccionCVItems_Importe_6']/div)[2]            -50.00
    #Columna Iva
    assertText                          xpath=(//td[@id='TransaccionCVItems_ImporteImpuesto_1']/div)[2]    675.00
    assertText                          xpath=(//td[@id='TransaccionCVItems_ImporteImpuesto_2']/div)[2]    3,118.50
    assertText                          xpath=(//td[@id='TransaccionCVItems_ImporteImpuesto_3']/div)[2]    0.00
    assertText                          xpath=(//td[@id='TransaccionCVItems_ImporteImpuesto_4']/div)[2]    24.00
    assertText                          xpath=(//td[@id='TransaccionCVItems_ImporteImpuesto_5']/div)[2]    4.38
    assertText                          xpath=(//td[@id='TransaccionCVItems_ImporteImpuesto_6']/div)[2]    -1.25
    #Columna Total
    assertText                           xpath=(//td[@id='TransaccionCVItems_ImporteTotal_1']/div)[2]       3,175.00
    assertText                           xpath=(//td[@id='TransaccionCVItems_ImporteTotal_2']/div)[2]       17,968.50
    assertText                           xpath=(//td[@id='TransaccionCVItems_ImporteTotal_3']/div)[2]       1,250.00
    assertText                           xpath=(//td[@id='TransaccionCVItems_ImporteTotal_4']/div)[2]       504.00
    assertText                           xpath=(//td[@id='TransaccionCVItems_ImporteTotal_5']/div)[2]       179.38
    assertText                           xpath=(//td[@id='TransaccionCVItems_ImporteTotal_6']/div)[2]       -51.25
    # percepcion e impuestos
    sleep   1s
    click                                xpath=(//div[@name="wdg_MostrarPercepciones"]//input)[2]
    assertText                           xpath=(//td[@id='TransaccionCVItemsPercepciones_Importe_1']/div)[2]    250.00
    assertText                           xpath=(//td[@id='TransaccionCVItemsPercepciones_Importe_2']/div)[2]    130.00
    assertText                           xpath=(//td[@id='TransaccionCVItemsPercepciones_Importe_3']/div)[2]    360.00
    assertText                           xpath=(//td[@id='TransaccionCVItemsPercepciones_Importe_4']/div)[2]    125.50

Instrumentos de Cobro (ventana)
    [Documentation]             validacion de los campos intrumentos de cobro y totalizadores en el popup
    log to console              Instrumentos de Cobro (ventana)
    sleep   1s
    comprobantes_venta.Agregar Instrumento De Cobro (ventana)    1   Caja    Caja en USD     Dólares   65.40   3891.13
    comprobantes_venta.Agregar Instrumento De Cobro (ventana)    2   Banco   Banco Galicia cuenta USD   Dólares   65.40   20000
    click    xpath=//td[@id='TransaccionTesoreriaIngresoItems_internal_delete_column_3']/div/div

    comprobantes_venta.Total Bruto            19205
    comprobantes_venta.Total Impuestos        4686.13
    comprobantes_venta.Total                  23891.13
    comprobantes_venta.Total Cobranza         1562479.902

Guardar (ventana)
    [Documentation]             se guardan los cambios en el popup
    log to console              Guardar (ventana)
    Sleep   1s
    click                                       xpath=(//a[@id="_onSave"])[2]

TC_012
    [Documentation]                     Creación de una Nota de Crédito A desde una factura total al contado en dólares
    KW_012.Factura A Al Contado En Dolares
    KW_012.Agregar Productos
    KW_012.Grilla Percepcion/Impuestos
    KW_012.Instrumentos de Cobro
    KW_012.Guardar Factura
    KW_012.Validaciones
    KW_012.Ir a Crear Nota de Credito
    KW_012.Instrumentos de Cobro (ventana)
    KW_012.Guardar (ventana)