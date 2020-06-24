*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Nota de Debito B en Dolares
    [Documentation]                     creacion de nota de debito B
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                 Exento   default     Nota de Débito     Cuenta Corriente
    comprobantes_venta.Mas Opciones - Moneda        Dólares     72

Grilla Productos
    [Documentation]                     se completan los campos de productos
    sleep   1s
    comprobantes_venta.Agregar Item CF    1   Carpeta         1       1250     0
    comprobantes_venta.Agregar Item CF    2   Alquiler        1       780    10
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_3']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    comprobantes_venta.Guardar

Validaciones
    [Documentation]                     validacion de columnas importe, totalizadores
    ...                                 letra del comprobante, tipo de moneda, cotizacion y cond. de pago
    comprobantes_venta.Letra Numero Comprobante         B
    # click en Mas Opciones
    comprobantes_venta.Mas Opciones
    comprobantes_venta.Validacion Moneda                Dólares
    comprobantes_venta.Validacion Cotizacion            72.000000
    comprobantes_venta.Condicion De Pago                Nota de Débito
    #Columna Importe
    assertText                                          xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_1']/div      1,250.00
    assertText                                          xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_2']/div      702.00
    comprobantes_venta.Total Bruto                      1564.4200
    comprobantes_venta.Total Impuestos                  387.5800
    comprobantes_venta.Total                            1952.0000