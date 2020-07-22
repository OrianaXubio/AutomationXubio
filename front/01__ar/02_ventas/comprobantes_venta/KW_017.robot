*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Informe Diario de Cierre Z
    [Documentation]                                   Creación de Informe Diario de Cierre Z con los items opcionales completos al contado en pesos
    log to console              Informe Diario de Cierre Z
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                   Consumidor Final - Sin identificación   default     Informe Diario de Cierre Z     Contado
    comprobantes_venta.Campo Comprobantes/Tkt         156       269     113     0

Agregar Productos
    [Documentation]                                   Se Completa la grilla Productos
    log to console              Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item                 1   Carpetas        1       3002        0
    comprobantes_venta.Agregar Item                 2   Alquiler        1       18500       0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_3']/div/div

Grilla Instrumento de cobro
    [Documentation]                                   Completa la grilla Instrumentos de cobro
    log to console              Grilla Instrumento de cobro
    sleep   1s
    comprobantes_venta.Agregar Instrumento De Cobro_2    1   Caja    Caja    Pesos Argentinos    1.000000       21,502.00
    click    xpath=//td[@id='TransaccionTesoreriaIngresoItems_internal_delete_column_2']/div/div

Validaciones
    [Documentation]                                   Realiza la validaciones de los campos
    log to console              Validaciones
    comprobantes_venta.Letra Numero Comprobante                         Z
    comprobantes_venta.Validacion Comprobante                           Informe Diario de Cierre Z
    comprobantes_venta.Validacion primer Tique B/C                      156
    comprobantes_venta.Validacion Ultimo tique B/C                      269
    comprobantes_venta.Validacion de comprobantes cancelados            0
    comprobantes_venta.Validacion Cant. de comprobantes emitidos        113
    comprobantes_venta.Validacion Columna Importe Con IVA               1       3,002.00
    comprobantes_venta.Validacion Importe de percepcion e Impuesto      1       21,502.00
    #Verificacion de los totales
    comprobantes_venta.Total Bruto                                     17653.0400
    comprobantes_venta.Total Impuestos                                 3848.9600
    comprobantes_venta.Total                                           21502.0000
    comprobantes_venta.Total Cobranza                                  21502.0000

Guardar
    log to console          Guardar
    comprobantes_venta.Guardar

TC_017
    [Documentation]             Creación de Informe Diario de Cierre Z con los items opcionales
    ...                         completos al contado en pesos
    KW_017.Informe Diario de Cierre Z
    KW_017.Agregar Productos
    KW_017.Grilla Instrumento de cobro
    KW_017.Guardar
    KW_017.Validaciones