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
Factura B
    [Documentation]                     creacion de una factura B
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente    Consumidor Final - Con identificación   default     Factura     Contado

Grilla Productos
    [Documentation]                     se completan los campos de productos
    sleep   1s
    comprobantes_venta.Agregar Item CF    1   Carpeta         1       2500.50     0
    comprobantes_venta.Agregar Item CF    2   Alquiler        1       16500       10
    comprobantes_venta.Agregar Item CF    3   Cinta Papel     2.5     500         0
    comprobantes_venta.Agregar Item CF    4   Goma de borrar  4       120         0
    comprobantes_venta.Agregar Item CF    5   Carátulas       7       25          0
    comprobantes_venta.Agregar Item CF    6   Carátulas       2       -25         0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_7']/div/div

Grilla Percepcion/Impuestos
    [Documentation]                     se completan los campos de percepcion/impuestos
    sleep   1s
    click    xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion      1   Ingresos Brutos Buenos Aires (Percepción)   250
    comprobantes_venta.Agregar Percepcion      2   Impuestos Internos                          360
    comprobantes_venta.Agregar Percepcion      3   Categoría OTRO                              125.50
    click    xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_4']/div/div

Instrumentos de Cobro
    [Documentation]                     se completan los campos de instrumento de cobro
    sleep   1s
    comprobantes_venta.Agregar Instrumento De Cobro     1   Caja    Caja    Pesos   1   1941
    comprobantes_venta.Agregar Instrumento De Cobro     2   Banco   Banco Galicia   Pesos   1   18000
    click    xpath=//td[@id='TransaccionTesoreriaIngresoItems_internal_delete_column_3']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    comprobantes_venta.Guardar

Validaciones
    [Documentation]                     validacion de columnas importe, iva, total, totalizadores
    ...                                 y letra del comprobante
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_1']/div    2,500.50
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_2']/div    14,850.00
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_3']/div    1,250.00
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_4']/div    480.00
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_5']/div    175.00
    assertText    xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_6']/div    -50.00

    comprobantes_venta.Letra Numero Comprobante       B
    comprobantes_venta.Total Bruto                    16070.7200
    comprobantes_venta.Total Impuestos                3870.2800
    comprobantes_venta.Total                          19941.0000
    comprobantes_venta.Total Cobranza                 19941.0000
