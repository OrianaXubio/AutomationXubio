*** Settings ***

Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Comprobante Recibo
    [Documentation]                                       Creación de Recibo A al contado en pesos
    [Tags]                                                Recibo A
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                       Responsable Inscripto   default     Recibo     Contado

Agregar Productos
    [Documentation]                     se completan los campos de productos
    sleep   1s
    comprobantes_venta.Agregar Item RI                    1   Carpeta         1       3002        0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Grilla Percepcion/Impuestos
    [Documentation]                     se completan los campos de percepcion/impuestos
    sleep    1s
    click                                                 xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion                 1   Ingresos Brutos Buenos Aires (Percepción)   250
    click       xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_2']/div/div

Grilla Instrumento de cobro
    [Documentation]                     se completan los campos de instrumento de cobro
    sleep   1s
    comprobantes_venta.Agregar Instrumento De Cobro       1       Caja        Caja       Pesos Argentinos        1.000000          4062.54
    click    xpath=//td[@id='TransaccionTesoreriaIngresoItems_internal_delete_column_2']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    comprobantes_venta.Guardar

Verificar Comprobante Sugerido
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Validacion Comprobante       Recibo

Comprobante Factura
    comprobantes_venta.Tipo Cliente                 Responsable Inscripto   default     Factura     Cuenta Corriente

Verificar Comprobante Sugerido II
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Validacion Comprobante       Factura

Comprobante Nota de Credito
    comprobantes_venta.Tipo Cliente                 Responsable Inscripto   default     Nota de Crédito     Ticket

Ventana
    [Documentation]                             cierra el popup de confirmacion
    click                                       id=fafPopUpTitle
    assertText                                  xpath=//h1[@id='fafPopUpTitle']//span             Pregunta
    click                                       id=showAskPopupNoButton