*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Empresa con Emision de factura-M
    [Documentation]                         se configura la empresa para que emita factura M
    recursos.Ir a Mi Empresa
    recursos.Mas Opciones-Facturacion M
    Checkbox Should Be Selected                      xpath=//div[@name='wdg_FacturasM']//input
    recursos.Guardar Cambios de Empresa
    vision_general.Validar Ingreso Al Sitio

Factura M
    [Documentation]                             creacion de factura M con tarjeta de debito
    sleep   1s
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                  Responsable Inscripto    default     Factura     Tarjeta de Débito

Agregar Productos
    [Documentation]                     se completan los campos de productos
    sleep   1s
    comprobantes_venta.Agregar Item RI                1   Carpeta         1       2500.50     0
    comprobantes_venta.Agregar Item RI                2   Alquiler        1       16500       10
    comprobantes_venta.Agregar Item RI                3   Cinta Papel     2.5     500         0
    comprobantes_venta.Agregar Item RI                4   Goma de borrar  4       120         0
    comprobantes_venta.Agregar Item RI                5   Carátulas       7       25          0
    comprobantes_venta.Agregar Item RI                6   Carátulas       2       -25         0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_7']/div/div

Grilla Percepcion/Impuestos
    [Documentation]                     se completan los campos de percepcion/impuestos
    sleep   1s
    click                                             xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion             1   Ingresos Brutos Buenos Aires (Percepción)   250
    comprobantes_venta.Agregar Percepcion             2   Impuestos Internos                          360
    comprobantes_venta.Agregar Percepcion             3   Categoría OTRO                              125.50
    click    xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_4']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    comprobantes_venta.Guardar

Validaciones
    [Documentation]                     validacion de columnas importe, iva, total, totalizadores
    ...                                 y letra del comprobante
    comprobantes_venta.Letra Numero Comprobante       M
    #Columna Importe
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_1']/div           2,500.50
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_2']/div           14,850.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_3']/div           1,250.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_4']/div           480.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_5']/div           175.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_6']/div           -50.00
    #Columna Iva
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_1']/div   675.13
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_2']/div   3,118.50
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_3']/div   0.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_4']/div   24.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_5']/div   4.38
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_6']/div   -1.25
    #Columna Total
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_1']/div      3,175.64
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_2']/div      17,968.50
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_3']/div      1,250.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_4']/div      504.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_5']/div      179.38
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_6']/div      -51.25
    #Verificacion de los totales
    comprobantes_venta.Total Bruto              19205.5000
    comprobantes_venta.Total Impuestos          4556.2600
    comprobantes_venta.Total                    23761.7600

Destildar Emito Factura M
    [Documentation]                             se deshabilita la opcion de generar factura M
    recursos.Ir a Mi Empresa
    recursos.Destildar Facturacion M
    Checkbox Should Not Be Selected             xpath=//div[@name='wdg_FacturasM']//input
    recursos.Guardar Cambios de Empresa