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
    log to console                  Comprobante Recibo
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                       Responsable Inscripto   default     Recibo     Contado

Agregar Productos
    [Documentation]                     se completan los campos de productos
    log to console                  Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item                     1   Carpeta         1       3002        0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Grilla Percepcion/Impuestos
    [Documentation]                     se completan los campos de percepcion/impuestos
    log to console                  Grilla Percepcion/Impuestos
    sleep    1s
    click                                                 xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion                 1   Ingresos Brutos Buenos Aires (Percepción)   250
    click       xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_2']/div/div

Grilla Instrumento de cobro
    [Documentation]                     se completan los campos de instrumento de cobro
    log to console          Grilla Instrumento de cobro
    sleep   1s
    comprobantes_venta.Agregar Instrumento De Cobro       1       Caja        Caja       Pesos Argentinos        1.000000          4062.54
    click    xpath=//td[@id='TransaccionTesoreriaIngresoItems_internal_delete_column_2']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    log to console          Guardar Factura
    comprobantes_venta.Guardar

Verificar Comprobante Sugerido
    log to console          Verificar Comprobante Sugerido
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Validacion Comprobante       Recibo

Comprobante Factura
    log to console          Comprobante Factura
    comprobantes_venta.Tipo Cliente                 Responsable Inscripto   default     Factura     Cuenta Corriente

Verificar Comprobante Sugerido II
    log to console          Verificar Comprobante Sugerido II
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Validacion Comprobante       Factura

Comprobante Nota de Credito
    log to console          Comprobante Nota de Credito
    comprobantes_venta.Tipo Cliente                 Responsable Inscripto   default     Nota de Crédito     Ticket

Ventana
    [Documentation]                             cierra el popup de confirmacion
    log to console          Ventana
    click                                       id=fafPopUpTitle
    assertText                                  xpath=//h1[@id='fafPopUpTitle']//span             Pregunta
    click                                       id=showAskPopupNoButton

TC_016
    [Documentation]             Validación de último usado para el widget "Comprobante"
    # tc-15
    KW_016.Comprobante Recibo
    KW_016.Agregar Productos
    KW_016.Grilla Percepcion/Impuestos
    KW_016.Grilla Instrumento de cobro
    KW_016.Guardar Factura
    # validacion
    KW_016.Verificar Comprobante Sugerido
    # tc-01
    KW_016.Comprobante Factura
    KW_016.Agregar Productos
    KW_016.Grilla Percepcion/Impuestos
    KW_016.Guardar Factura
    # validacion
    KW_016.Verificar Comprobante Sugerido II
    # tc-11
    KW_016.Comprobante Nota de Credito
    KW_016.Agregar Productos
    KW_016.Grilla Percepcion/Impuestos
    KW_016.Guardar Factura
    KW_016.Ventana
    # validadion
    KW_016.Verificar Comprobante Sugerido II