*** Settings ***
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
Factura A 001
    [Documentation]                     creacion de una factura A
    Log To Console                      Factura A
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente       Responsable Inscripto   default     Factura     Cuenta Corriente

Agregar Productos
    [Documentation]                     se completan los campos de produtos
    Log To Console                      Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item RI    1   Carpeta         1       2500.50     0
    comprobantes_venta.Agregar Item RI    2   Alquiler        1       16500       10
    comprobantes_venta.Agregar Item RI    3   Cinta Papel     2.5     500         0
    comprobantes_venta.Agregar Item RI    4   Goma de borrar  4       120         0
    comprobantes_venta.Agregar Item RI    5   Carátulas       7       25          0
    comprobantes_venta.Agregar Item RI    6   Carátulas       2       -25         0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_7']/div/div

Grilla Percepcion/Impuestos
    [Documentation]                     se completan los campos de percepcion/impuestos
    Log To Console                      Grilla Percepcion/Impuestos
    sleep  1s
    click    xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion      1   Ingresos Brutos Buenos Aires (Percepción)   250
    comprobantes_venta.Agregar Percepcion      2   IVA                                         130
    comprobantes_venta.Agregar Percepcion      3   Impuestos Internos                          360
    comprobantes_venta.Agregar Percepcion      4   Categoría OTRO                              125.50
    click    xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_5']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    Log To Console                      Grilla Percepcion/Impuestos
    comprobantes_venta.Guardar

Validaciones
    [Documentation]                         validacion de comlumnas importe, iva, total, totalizadores,
    ...                                     letra en el comprobante y botones
    Log To Console                          Validaciones
    #Verificacion del campo Operación Sujeta a Retención
    Checkbox Should Not Be Selected             xpath=//div[@id="masOpcionesWrapper"]/div[25]/div[2]/div/input
    #Columna Importe
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_1']/div           2,500.50
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_2']/div           14,850.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_3']/div           1,250.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_4']/div           480.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_5']/div           175.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_6']/div            -50.00
    #Columna Iva
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_1']/div    675.13
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_2']/div    3,118.50
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_3']/div    0.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_4']/div    24.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_5']/div    4.38
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_6']/div    -1.25
    #Columna Total
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_1']/div       3,175.64
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_2']/div       17,968.50
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_3']/div       1,250.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_4']/div       504.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_5']/div       179.38
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_6']/div       -51.25

    comprobantes_venta.Letra Numero Comprobante       A
    comprobantes_venta.Validacion Botones
    #Verificacion de los totales
    comprobantes_venta.Total Bruto                    19205.5000
    comprobantes_venta.Total Impuestos                4686.2600
    comprobantes_venta.Total                          23891.7600

TC_001
    KW_001.Factura A 001
    KW_001.Agregar Productos
    KW_001.Grilla Percepcion/Impuestos
    KW_001.Guardar Factura
    KW_001.Validaciones