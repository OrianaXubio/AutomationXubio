*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Factura E
    [Documentation]                     creacion de factura E para cliente del exterior
    log to console                      Factura E
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente       Cliente del exterior   default     Factura     Cheque

Grilla Productos
    [Documentation]                     se completan los campos de productos
    log to console                      Grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item     1   HONORARIOS         1       5000     0
    comprobantes_venta.Agregar Item     2   Alquiler           1       16985    10
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_3']/div/div

Instrumentos de Cobro
    [Documentation]                     se completan los campos de instrumento de cobro
    log to console                      Instrumentos de Cobro
    sleep   1s
    comprobantes_venta.Agregar Instrumento De Cobro     1   Valores a depositar    Valores a depositar    Pesos   1   20286.5
    comprobantes_venta.Agregar Cheque                   1   12345678  31  12  2020    Banco Bica
    click    xpath=//td[@id='TransaccionTesoreriaIngresoItems_internal_delete_column_2']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura
    comprobantes_venta.Guardar

Validaciones
    [Documentation]                     validacion de columnas importe, totalizadores, condicion de pago
    ...                                 letra del comprobante y datos del cheque
    log to console                      Validaciones
    assertText                          xpath=//div[@name="wdg_TransaccionCVItems"]//th[8]/div[2]       Importe
    Page Should Not Contain Element     xpath=//div[@name="wdg_TransaccionCVItems"]//th[9]/div[2]
    assertText    xpath=//td[@id='TransaccionCVItems_Importe_1']/div                                    5,000.00
    assertText    xpath=//td[@id='TransaccionCVItems_Importe_2']/div                                    15,286.50
    assertText    xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_NumeroCheque_1']/div               12345678
    assertText    xpath=//td[@id='TransaccionTesoreriaIngresoItems_FechaVto_1']/div                     31-12-2020
    assertText    xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_Banco_1']/div                      Banco Bica
    # TODO: Verificar valores a depositar
    assertText    xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_CuentaTipo_1']/div                 Valores a Depositar

    comprobantes_venta.Letra Numero Comprobante       E
    comprobantes_venta.Total Bruto                    20286.5000
    comprobantes_venta.Total Impuestos                0.0000
    comprobantes_venta.Total                          20286.5000
    comprobantes_venta.Total Cobranza                 20286.5000
    comprobantes_venta.Condicion De Pago              Cheque

TC_008
    [Documentation]         Creación de una factura E a un cliente del exterior con medio de pago
    ...                     Cheque con productos con diferentes tasas de IVA en pesos argentinos
    KW_008.Factura E
    KW_008.Grilla Productos
    KW_008.Instrumentos de Cobro
    KW_008.Guardar Factura
    KW_008.Validaciones
