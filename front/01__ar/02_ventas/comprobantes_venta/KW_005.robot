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
Factura B_CuentaCorriente
    [Documentation]                         Creación de una factura B con Cuenta Corriente
    Log To Console                          Factura B_CuentaCorriente
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                   Consumidor Final - Con identificación      default     Factura     Cuenta Corriente
    sleep   1s
    #Mas Opciones - Moneda Euro
    click                                  xpath=//input[@value='Más Opciones']
    click                                  xpath=//div[@name='wdg_MonedaID']
    click                                  xpath=//div[@id='masOpcionesWrapper']/div[11]/div/div[2]/div/div/a/span
    click                                  xpath=//td/div/table/tbody/tr[2]/td
    click                                  xpath=//input[@value='1']
    type                                   xpath=//input[@value='1']    72

Agregar Productos
    [Documentation]                     se completan los campos de productos
    Log To Console                      Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item                 1   Carpeta         1       2500.50     0
    comprobantes_venta.Agregar Item                 2   Alquiler        1       16500       10
    comprobantes_venta.Agregar Item                 3   Cinta Papel     2.5     500         0
    comprobantes_venta.Agregar Item                 4   Goma de borrar  4       120         0
    comprobantes_venta.Agregar Item                 5   Carátulas       7       25          0
    comprobantes_venta.Agregar Item                 6   Carátulas       2       -25         0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_7']/div/div

Grilla Percepcion/Impuestos
    [Documentation]                     se completan los campos de percepcion/impuestos
    Log To Console                      Grilla Percepcion/Impuestos
    sleep   1s
    click                                   xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion             1   Ingresos Brutos Buenos Aires (Percepción)   250
    comprobantes_venta.Agregar Percepcion             2   Impuestos Internos                          360
    comprobantes_venta.Agregar Percepcion             3   Categoría OTRO                              125.50
    click    xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_4']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    Log To Console                      Guardar Factura
    comprobantes_venta.Guardar

Validaciones
    [Documentation]                     validacion de columnas importe, iva, total, totalizadores
    ...                                 y letra del comprobante
    Log To Console                      Validaciones
    # validación Columna Importe
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_1']/div    2,500.50
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_2']/div    14,850.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_3']/div    1,250.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_4']/div    480.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_5']/div    175.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_6']/div    -50.00

    comprobantes_venta.Letra Numero Comprobante       B
    #Validación de Importes Totales
    comprobantes_venta.Total Bruto                    16070.7200
    comprobantes_venta.Total Impuestos                3870.2800
    comprobantes_venta.Total                          19941.0000
    #Validacion Campo Moneda
    Page Should Contain Element                 xpath=//div[@name="wdg_MonedaID"]//input[@value="Euros"]
    Page Should Contain Element                 xpath=//div[@name="wdg_Cotizacion"]//input[@value="72.000000"]

TC_005
    [Documentation]                         Creacion de una factura B en cuenta corriente con diferentes
    ...                                     tasas de IVA en euros
    KW_005.Factura B_CuentaCorriente
    KW_005.Agregar Productos
    KW_005.Grilla Percepcion/Impuestos
    KW_005.Guardar Factura
    KW_005.Validaciones