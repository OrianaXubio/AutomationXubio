*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Recibo A
    [Documentation]                                       Creación de Recibo A al contado en pesos
    log to console                      Recibo A
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                       Responsable Inscripto   default     Recibo     Contado

Agregar Productos
    [Documentation]                                       Se Completa la grilla Productos
    log to console                      Agregar Productos
    sleep   2s
    comprobantes_venta.Agregar Item                     1   Carpeta         1       3002        0
    comprobantes_venta.Agregar Item                     2   Alquiler        1       18500       10
    comprobantes_venta.Agregar Item                     3   Cinta Papel     2.5     360         0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_4']/div/div

Grilla Percepcion/Impuestos
    [Documentation]                                       Completa la grilla Percepcion/Impuestos
    log to console                      Grilla Percepcion/Impuestos
    sleep     1s
    click                                                 xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion                 1   Ingresos Brutos Buenos Aires (Percepción)   250
    comprobantes_venta.Agregar Percepcion                 2   IVA                                         130
    comprobantes_venta.Agregar Percepcion                 3   Impuestos Internos                          360
    comprobantes_venta.Agregar Percepcion                 4   Categoría OTRO                              125.50
    click    xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_5']/div/div

Grilla Instrumento de cobro
    [Documentation]                                       Completa la grilla Instrumentos de cobro
    log to console                      Grilla Instrumento de cobro
    sleep       1s
    comprobantes_venta.Agregar Instrumento De Cobro       1       Caja        Caja       Pesos Argentinos        1.000000          25,724.54
    click    xpath=//td[@id='TransaccionTesoreriaIngresoItems_internal_delete_column_2']/div/div

Validaciones
    [Documentation]                                     Realiza la validaciones de los campos
    log to console                      Validaciones
    comprobantes_venta.Letra Numero Comprobante         A
    comprobantes_venta.Validacion Comprobante         Recibo
    comprobantes_venta.Condicion De Pago              Contado
    comprobantes_venta.Validacion Columna Importe     1   3,002.00
    comprobantes_venta.Validacion Columna Importe     2   16,650.00
    comprobantes_venta.Validacion Columna Importe     3   900.00
    comprobantes_venta.Validacion Columna Iva         1   810.54
    comprobantes_venta.Validacion Columna Iva         2   3,496.50
    comprobantes_venta.Validacion Columna Iva         3   0.00
    comprobantes_venta.Validacion Columna Total       1   3,812.54
    comprobantes_venta.Validacion Columna Total       2   20,146.50
    comprobantes_venta.Validacion Columna Total       3   900.00

     #Verificacion de los totales
    comprobantes_venta.Total Bruto                      20552.0000
    comprobantes_venta.Total Impuestos                  5172.5400
    comprobantes_venta.Total                            25724.5400
    comprobantes_venta.Total Cobranza                   25724.5400

Guardar
    log to console              guardar
    comprobantes_venta.Guardar

TC_015
    [Documentation]             Creación de Recibo A al contado en pesos
    KW_015.Recibo A
    KW_015.Agregar Productos
    KW_015.Grilla Percepcion/Impuestos
    KW_015.Grilla Instrumento de cobro
    KW_015.Guardar
    KW_015.Validaciones