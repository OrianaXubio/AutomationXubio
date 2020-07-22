*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Comprobante Recibo Z
    [Documentation]                         Creación de un informe diario de cierre Z
    log to console                  Comprobante Recibo Z
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente         Consumidor Final - Sin identificación   default     Informe Diario de Cierre Z     Cuenta Corriente

Agregar Productos
    [Documentation]                         Se agregan productos
    log to console                  Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item     1    Carátulas       8       64500        0
    comprobantes_venta.Agregar Item     2    Cinta Papel     169     89600        0
    comprobantes_venta.Agregar Item     3    Alquiler        265     54700        0
    comprobantes_venta.Agregar Item     4    Goma de borrar  1       16500        0
    click       xpath=//td[@id='TransaccionCVItems_internal_delete_column_5']/div/div

    comprobantes_venta.Guardar

Validaciones
    [Documentation]                     validaciones de columna importe, totalizadores, letra en el comprobante, tipo
    ...                                 de comprobante, primer y ultimo tique, cant comprobantes emitidos y cancelados
    log to console          Validaciones
    assertText                          xpath=//div[@name="wdg_TransaccionCVItems"]//th[8]/div[2]       Importe
    Page Should Not Contain Element     xpath=//div[@name="wdg_TransaccionCVItems"]//th[9]/div[2]

    comprobantes_venta.Condicion De Pago              Cuenta Corriente
    comprobantes_venta.Letra Numero Comprobante       Z
    comprobantes_venta.Total Bruto                    27641280.9900
    comprobantes_venta.Total Impuestos                2529119.0100
    comprobantes_venta.Total                          30170400.0000
    comprobantes_venta.Validacion Comprobante         Informe Diario de Cierre Z

    comprobantes_venta.Validacion Primer Tique B/C Vacio
    comprobantes_venta.Validacion Ultimo Tique B/C Vacio
    comprobantes_venta.Validacion Cant Comprobantes Emitidos Vacio
    comprobantes_venta.Validacion Cant Comprobantes Cancelados Vacio

TC_018
    [Documentation]     Creación de Informe Diario de Cierre Z con los items opcionales sin
    ...                 completar en cuenta corriente en pesos
    KW_018.Comprobante Recibo Z
    KW_018.Agregar Productos
    KW_018.Validaciones