*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Nota de Credito
    [Documentation]                     creacion de una nota de credito A
    log to console                      Nota de Credito
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente         Responsable Inscripto   default     Nota de Crédito     Ticket
    click                                   xpath=//div//input[@value='Más Opciones']

Agregar Productos
    [Documentation]                     se completan los campos de productos
    log to console                      Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item     1   Carpeta         1       2500.50     0
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

Guardar Factura
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura
    comprobantes_venta.Guardar

Validaciones
    [Documentation]                     validacion de columnas importe, iva, total, totalizadores
    ...                                 y letra del comprobante, botones
    log to console                      validaciones
    comprobantes_venta.Validacion Botones NC
    comprobantes_venta.Letra Numero Comprobante        A
    assertText                                  xpath=//div[@name='wdg_Tipo']//select//option[3]                Nota de Crédito
    Checkbox Should Not Be Selected             xpath=//div[@id="masOpcionesWrapper"]/div[25]/div[2]/div/input
    #Columna Iva
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_1']/div      675.13
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_2']/div      3,118.50
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_3']/div      0.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_4']/div      24.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_5']/div      4.38
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_6']/div      -1.25
    #Columna Total
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_1']/div       3,175.64
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_2']/div       17,968.50
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_3']/div       1,250.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_4']/div       504.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_5']/div       179.38
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_6']/div       -51.25
    #validacion Percepciones e impuesto -columna importe
    assertText                                  xpath=//td[@id='TransaccionCVItemsPercepciones_Importe_1']     250.00
    assertText                                  xpath=//td[@id='TransaccionCVItemsPercepciones_Importe_2']     130.00
    assertText                                  xpath=//td[@id='TransaccionCVItemsPercepciones_Importe_3']     360.00
    assertText                                  xpath=//td[@id='TransaccionCVItemsPercepciones_Importe_4']     125.50

    click                                       id=fafPopUpTitle
    assertText                                  xpath=//h1[@id='fafPopUpTitle']//span             Pregunta
    click                                       id=showAskPopupNoButton

TC_011
    [Documentation]                 Creación de una Nota de Crédito A desde un nuevo comprobante
    ...                             con Condición de Ticket y percepciones
    KW_011.Nota de Credito
    KW_011.Agregar Productos
    KW_011.Grilla Percepcion/Impuestos
    KW_011.Guardar Factura
    KW_011.Validaciones