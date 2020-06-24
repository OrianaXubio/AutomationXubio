*** Keywords ***
Ir a Nueva Venta
    [Documentation]     ingresa a la seccion Nueva Venta
    click           link=Ventas
    sleep   1s
    click           link=Comprobantes de Venta
    click           link=Nueva Venta
    verifyText      xpath=//div[@id='seccionTitulo']/div    Nuevo - Comprobante de Venta

Tipo Cliente
    [Documentation]     se completan los campos basicos del cliente para la creacion de una factura
    [Arguments]     ${cliente}  ${punto_venta}  ${factura}  ${condicion_pago}
    # seleccionar cliente
    click       css=div[name="wdg_Organizacion"] > div.selector > input[type="textbox"]
    type        css=div[name="wdg_Organizacion"] > div.selector > input[type="textbox"]                                    ${cliente}
    click       xpath=//td/div/table/tbody/tr/td
    # seleccionar punto de venta
    click       xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div[9]/div[3]/div[2]/div/input
    wait until keyword succeeds  20x  1s  Clear Element Text   xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div[9]/div[3]/div[2]/div/input
    type        xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div[9]/div[3]/div[2]/div/input     ${punto_venta}
    click       xpath=//td/div/table/tbody/tr/td[2]
    # seleccionar tipo de comprobante
    click       xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div[11]/div/div[2]/select
    select      xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div[11]/div/div[2]/select         ${factura}
    # seleccionar condicion de pago
    sleep       1s
    click       xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div[19]/div[3]/div[2]/select
    select      xpath=//div[@id='webreport_container']/div/div[5]/div[2]/div/div[2]/div/div[19]/div[3]/div[2]/select      ${condicion_pago}

Agregar Percepcion
    [Documentation]     agrega una nueva percepcion, enviando por parametros el tipo de impuesto y el importe
    ...                 la variable ${num_item} hace referencia al numero de fila en la grilla
    [Arguments]         ${num_item}     ${impuesto}     ${importe}
    click       xpath=//td[@id='TransaccionCVItemsPercepciones_ProductoID_${num_item}']/div
    type        xpath=//td[@id='TransaccionCVItemsPercepciones_ProductoID_${num_item}']/div/div/div/input     ${impuesto}
    click       xpath=//td/div/table/tbody/tr/td
    click       xpath=//td[@id='TransaccionCVItemsPercepciones_Importe_${num_item}']/div
    type        xpath=//td[@id='TransaccionCVItemsPercepciones_Importe_${num_item}']/div/div/input            ${importe}
    click       link=Agregar Percepción
    sleep       1s

Agregar Instrumento De Cobro
    [Documentation]     agrega un nuevo instrumento de cobro
    ...                 la variable ${num_item} hace referencia al numero de fila en la grilla
    [Arguments]         ${num_item}     ${tipo_cuenta}  ${cuenta}   ${moneda}   ${cotizacion}   ${importe}
    click       xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_CuentaTipo_${num_item}']/div
    type        xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_CuentaTipo_${num_item}']/div/div/div/input           ${tipo_cuenta}
    click       xpath=//td/div/table/tbody/tr/td
    click       xpath=//td[@id='TransaccionTesoreriaIngresoItems_CuentaID_${num_item}']/div
    type        xpath=//td[@id='TransaccionTesoreriaIngresoItems_CuentaID_${num_item}']/div/div/div/input               ${cuenta}
    click       xpath=//td/div/table/tbody/tr/td
    sleep  1s
    click       xpath=//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_${num_item}']/div
    wait until keyword succeeds     20x      1s       clear element text  xpath=//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_${num_item}']/div/div/div/input
    click       xpath=//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_${num_item}']/div
    type        xpath=//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_${num_item}']/div/div/div/input    ${moneda}
    click       xpath=//td/div/table/tbody/tr/td
    click       xpath=//td[@id='TransaccionTesoreriaIngresoItems_CotizacionMonTransaccion_${num_item}']/div
    type        xpath=//td[@id='TransaccionTesoreriaIngresoItems_CotizacionMonTransaccion_${num_item}']/div/div/input   ${cotizacion}
    sendKeys    xpath=//td[@id='TransaccionTesoreriaIngresoItems_CotizacionMonTransaccion_${num_item}']/div             TAB
    click       xpath=//td[@id='TransaccionTesoreriaIngresoItems_ImporteMonTransaccion_${num_item}']/div
    type        xpath=//td[@id='TransaccionTesoreriaIngresoItems_ImporteMonTransaccion_${num_item}']/div/div/input      ${importe}
    sendKeys    xpath=//td[@id='TransaccionTesoreriaIngresoItems_ImporteMonTransaccion_${num_item}']/div                TAB
    click       link=Agregar Instrumento de Cobro

Agregar Instrumento De Cobro (ventana)
    [Documentation]     agrega un nuevo instrumento de cobro en el popup "Crear Nota Credito"
    ...                 la variable ${num_item} hace referencia al numero de fila en la grilla
    [Arguments]         ${num_item}     ${tipo_cuenta}  ${cuenta}   ${moneda}   ${cotizacion}   ${importe}
    click       xpath=(//td[@id='TransaccionTesoreriaIngresoItems_M_CuentaTipo_${num_item}']/div)[2]
    type        xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_CuentaTipo_${num_item}']/div/div/div/input           ${tipo_cuenta}
    click       xpath=//td/div/table/tbody/tr/td
    click       xpath=(//td[@id='TransaccionTesoreriaIngresoItems_CuentaID_${num_item}']/div)[2]
    type        xpath=//td[@id='TransaccionTesoreriaIngresoItems_CuentaID_${num_item}']/div/div/div/input               ${cuenta}
    click       xpath=//td/div/table/tbody/tr/td
    sleep  1s
    click       xpath=(//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_${num_item}']/div)[2]
    wait until keyword succeeds     20x      1s       clear element text  xpath=//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_${num_item}']/div/div/div/input
    click       xpath=(//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_${num_item}']/div)[2]
    type        xpath=//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_${num_item}']/div/div/div/input    ${moneda}
    click       xpath=//td/div/table/tbody/tr/td
    click       xpath=(//td[@id='TransaccionTesoreriaIngresoItems_CotizacionMonTransaccion_${num_item}']/div)[2]
    type        xpath=//td[@id='TransaccionTesoreriaIngresoItems_CotizacionMonTransaccion_${num_item}']/div/div/input   ${cotizacion}
    sendKeys    xpath=//td[@id='TransaccionTesoreriaIngresoItems_CotizacionMonTransaccion_${num_item}']/div             TAB
    click       xpath=(//td[@id='TransaccionTesoreriaIngresoItems_ImporteMonTransaccion_${num_item}']/div)[2]
    type        xpath=//td[@id='TransaccionTesoreriaIngresoItems_ImporteMonTransaccion_${num_item}']/div/div/input      ${importe}
    sendKeys    xpath=//td[@id='TransaccionTesoreriaIngresoItems_ImporteMonTransaccion_${num_item}']/div                TAB
    sleep   1s
    click       xpath=(//div[@class="pageControls"]//a[text() = "Agregar Instrumento de Cobro"])[2]

Agregar Cheque
    [Documentation]     agrega un nuevo cheque
    ...                 la variable ${num_item} hace referencia al numero de fila en la grilla
    [Arguments]     ${num_item}     ${num_cheque}   ${dia}  ${mes}  ${anio}  ${banco}
    click       xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_NumeroCheque_${num_item}']/div
    type        xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_NumeroCheque_${num_item}']/div/div/input     ${num_cheque}
    sendKeys    xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_NumeroCheque_${num_item}']/div               TAB
    click       xpath=//td[@id='TransaccionTesoreriaIngresoItems_FechaVto_${num_item}']/div
    type        xpath=(//input[@name='day'])[5]                                                                 ${dia}
    type        xpath=(//input[@name='month'])[5]                                                               ${mes}
    type        xpath=(//input[@name='year'])[5]                                                                ${anio}
    click       xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_Banco_${num_item}']/div
    type        xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_Banco_${num_item}']/div/div/div/input        ${banco}
    click       xpath=//td/div/table/tbody/tr/td
    sleep   1s

Agregar Item RI
    [Documentation]     agrega un nuevo producto a la grilla. El cliente debe ser de tipo Sin IVA incluido
    ...                 la variable ${num_item} hace referencia al numero de fila en la grilla
    [Arguments]     ${num_item}  ${producto}  ${cantidad}  ${precio}  ${descuento}
    click       xpath=//td[@id='TransaccionCVItems_ProductoID_${num_item}']/div
    type        xpath=//td[2]/div/div/div/input                                                         ${producto}
    click       xpath=//td/div/table/tbody/tr/td
    click       xpath=//td[@id='TransaccionCVItems_Cantidad_${num_item}']/div
    type        xpath=//td[@id='TransaccionCVItems_Cantidad_${num_item}']/div/div/input                 ${cantidad}
    sendKeys    xpath=//td[@id='TransaccionCVItems_Cantidad_${num_item}']/div                           TAB
    click       xpath=//td[@id='TransaccionCVItems_Precio_${num_item}']/div
    type        xpath=//td[@id='TransaccionCVItems_Precio_${num_item}']/div/div/input                   ${precio}
    sendKeys    xpath=//td[@id='TransaccionCVItems_Precio_${num_item}']/div                             TAB
    click       xpath=//td[@id='TransaccionCVItems_PorcentajeDescuento_${num_item}']/div
    type        xpath=//td[@id='TransaccionCVItems_PorcentajeDescuento_${num_item}']/div/div/input      ${descuento}
    sendKeys    xpath=//td[@id='TransaccionCVItems_PorcentajeDescuento_${num_item}']/div                TAB

Agregar Item CF
    [Documentation]     agrega un nuevo producto a la grilla. El cliente debe ser de tipo Con IVA incluido (o consumidor final)
    ...                 la variable ${num_item} hace referencia al numero de fila en la grilla
    [Arguments]     ${num_item}  ${producto}  ${cantidad}  ${precio}  ${descuento}
    click       xpath=//td[@id='TransaccionCVItems_ProductoID_${num_item}']/div
    type        xpath=//td[2]/div/div/div/input                                                         ${producto}
    click       xpath=//td/div/table/tbody/tr/td
    click       xpath=//td[@id='TransaccionCVItems_Cantidad_${num_item}']/div
    type        xpath=//td[@id='TransaccionCVItems_Cantidad_${num_item}']/div/div/input                 ${cantidad}
    sendKeys    xpath=//td[@id='TransaccionCVItems_Cantidad_${num_item}']/div                           TAB
    click       xpath=//td[@id='TransaccionCVItems_PrecioConIvaIncluido_${num_item}']/div
    type        xpath=//td[@id='TransaccionCVItems_PrecioConIvaIncluido_${num_item}']/div/div/input     ${precio}
    sendKeys    xpath=//td[@id='TransaccionCVItems_PrecioConIvaIncluido_${num_item}']/div               TAB
    click       xpath=//td[@id='TransaccionCVItems_PorcentajeDescuento_${num_item}']/div
    type        xpath=//td[@id='TransaccionCVItems_PorcentajeDescuento_${num_item}']/div/div/input      ${descuento}
    sendKeys    xpath=//td[@id='TransaccionCVItems_PorcentajeDescuento_${num_item}']/div                TAB

Borrar Item
    [Documentation]     elimina la fila enviada por parametro, de la grilla productos
    ...                 la variable ${num_item} hace referencia al numero de fila en la grilla
    [Arguments]     ${num_item}
    click       xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_${num_item}']/div/div

Mas Opciones - Moneda
    [Documentation]         despliega la seccion "Mas opciones" y se envia por parametro el tipo de moneda
    ...                     y la cotizacion
    [Arguments]     ${moneda}   ${cotizacion}
    click       xpath=//input[@value='Más Opciones']
    click       xpath=//div[@id='masOpcionesWrapper']/div[11]/div/div[2]/div/input
    wait until keyword succeeds     20x      1s       clear element text  xpath=//div[@id='masOpcionesWrapper']/div[11]/div/div[2]/div/input
    click       xpath=//div[@id='masOpcionesWrapper']/div[11]/div/div[2]/div/input
    type        xpath=//div[@id='masOpcionesWrapper']/div[11]/div/div[2]/div/input      ${moneda}
    click       xpath=//td/div/table/tbody/tr/td
    click       css=div[name="wdg_Cotizacion"] > input[type="textbox"]
    type        css=div[name="wdg_Cotizacion"] > input[type="textbox"]                  ${cotizacion}
    sendKeys    css=div[name="wdg_Cotizacion"] > input[type="textbox"]      TAB

Mas Opciones
    [Documentation]     despliega la seccion "Mas opciones"
    click       xpath=//input[@value='Más Opciones']
    sleep       2s

Ir a Remitos Asociados
    [Documentation]         despliega la seccion "Remitos Asociados"
    sleep   1s
    click           xpath=//div[@name='wdg_MostrarRemitos']//input
    sleep   2s

Guardar
    [Documentation]         click en el boton Guardar de la factura, luego hay un sleep para esperar que se guarde la factura
    sleep   2s
    click                                       id=_onSave
    #sleep   1s
    Wait Until Element Is Visible              xpath=//a[@id='_onPrint']

Crear Nota de Credito
    [Documentation]                              Ir a Nota de Credito
    click                                        id=generarNotaCredito

Modificar importe en NC
    [Documentation]                              Modifica el importe de la Nota de Credito
    [Arguments]                                  ${valor}
    click                                        id=IMPORTE_0
    type                                         id=IMPORTE_0     ${valor}
    click                                        id=ACEPTAR_0

Agregar Item RI (ventana)
    [Documentation]                             Completa la grilla Productos en el popup
    [Arguments]                                 ${num_item}  ${producto}  ${cantidad}  ${precio}  ${descuento}
    click                                       xpath=(//td[@id='TransaccionCVItems_ProductoID_${num_item}']/div)[2]
    type                                        xpath=//td[2]/div/div/div/input                                                         ${producto}
    click                                       xpath=//td/div/table/tbody/tr/td
    click                                       xpath=(//td[@id='TransaccionCVItems_Cantidad_${num_item}']/div)[2]
    type                                        xpath=//td[@id='TransaccionCVItems_Cantidad_${num_item}']/div/div/input                 ${cantidad}
    sendKeys                                    xpath=//td[@id='TransaccionCVItems_Cantidad_${num_item}']/div                           TAB
    click                                       xpath=(//td[@id='TransaccionCVItems_Precio_${num_item}']/div)[2]
    type                                        xpath=//td[@id='TransaccionCVItems_Precio_${num_item}']/div/div/input                   ${precio}
    sendKeys                                    xpath=//td[@id='TransaccionCVItems_Precio_${num_item}']/div                             TAB
    click                                       xpath=(//td[@id='TransaccionCVItems_PorcentajeDescuento_${num_item}']/div)[2]
    type                                        xpath=//td[@id='TransaccionCVItems_PorcentajeDescuento_${num_item}']/div/div/input      ${descuento}
    sendKeys                                    xpath=//td[@id='TransaccionCVItems_PorcentajeDescuento_${num_item}']/div                TAB

click en mas opciones (Pop-up)
    [Documentation]                             Selecciona mas opciones (Pop-up)
    click                                       xpath=(//div//input[@value='Más Opciones'])[2]

Guardar (ventana)
    [Documentation]                             Guarda el Pop-up
    click                                       xpath=(//a[@id="_onSave"])[2]
    sleep                                       2s

Seleccionar Aplicaciones
    [Documentation]                             Selecciona el boton aplicaciones
    click                                       xpath=//a[@id='FacturaVenta_openVinculacionCuentaCorriente']

Salir de Aplicaciones
    [Documentation]                             Sale de la ventana de Aplicaciones
    click                                       xpath=//a[@id='APLICACIONSALIR_0']

Campo Comprobantes/Tkt
    [Documentation]                              Completa los campos de Comprobantes/Tkt
    [Arguments]                                  ${primerT}  ${ultimoT}  ${cant_emitido}  ${cant_cancelado}
    click                                        xpath=//div[@name='wdg_PrimerTktBC']
    type                                         xpath=//div[@name='wdg_PrimerTktBC']//input                     ${primerT}
    click                                        xpath=//div[@name='wdg_UltimoTktBC']
    type                                         xpath=//div[@name='wdg_UltimoTktBC']//input                     ${ultimoT}
    click                                        xpath=//div[@name='wdg_CantComprobantesEmitidos']
    type                                         xpath=//div[@name='wdg_CantComprobantesEmitidos']//input        ${cant_emitido}
    click                                        xpath=//div[@name='wdg_CantComprobantesCancelados']
    type                                         xpath=//div[@name='wdg_CantComprobantesCancelados']//input      ${cant_cancelado}

Agregar Instrumento De Cobro_2
   [Documentation]                              Completa los campos de instrumento de cobro
   [Arguments]                                  ${num_item}     ${tipo_cuenta}  ${cuenta}   ${moneda}   ${cotizacion}   ${importe}
    click                                       xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_CuentaTipo_${num_item}']/div
    type                                        xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_CuentaTipo_${num_item}']/div                         ${tipo_cuenta}
    click                                       xpath=//td/div/table/tbody/tr/td
    click                                       xpath=//td[@id='TransaccionTesoreriaIngresoItems_CuentaID_${num_item}']/div
    type                                        xpath=//td[@id='TransaccionTesoreriaIngresoItems_CuentaID_${num_item}']/div/div/div/input               ${cuenta}
    click                                       xpath=//td/div/table/tbody/tr/td
    sleep                                       1s
    click                                       xpath=//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_${num_item}']/div
    wait until keyword succeeds                 20x      1s       clear element text  xpath=//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_${num_item}']/div/div/div/input
    click                                       xpath=//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_${num_item}']/div
    type                                        xpath=//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_${num_item}']/div/div/div/input    ${moneda}
    click                                       xpath=//td/div/table/tbody/tr/td
    click                                       xpath=//td[@id='TransaccionTesoreriaIngresoItems_CotizacionMonTransaccion_${num_item}']/div
    type                                        xpath=//td[@id='TransaccionTesoreriaIngresoItems_CotizacionMonTransaccion_${num_item}']/div/div/input   ${cotizacion}
    sendKeys                                    xpath=//td[@id='TransaccionTesoreriaIngresoItems_CotizacionMonTransaccion_${num_item}']/div             TAB
    click                                       xpath=//td[@id='TransaccionTesoreriaIngresoItems_ImporteMonTransaccion_${num_item}']/div
    type                                        xpath=//td[@id='TransaccionTesoreriaIngresoItems_ImporteMonTransaccion_${num_item}']/div/div/input      ${importe}
    sendKeys                                    xpath=//td[@id='TransaccionTesoreriaIngresoItems_ImporteMonTransaccion_${num_item}']/div                TAB
    click                                       link=Agregar Instrumento de Cobro

Remitos Asociados
     [Documentation]                                     Despliega la opcion Remitos Asociados y completa los campos
     [Arguments]                                         ${num_item}    ${remito}       ${observacion}
     Ir a Remitos Asociados
     click                                              xpath=//td[@id='ComprobanteRemitosItems_RemitoID_${num_item}']/div
     type                                               xpath=//td[@id='ComprobanteRemitosItems_RemitoID_${num_item}']/div/div/div/input    ${remito}
     click                                              xpath=//td/div/table/tbody/tr/td
     click                                              xpath=//td[@id='ComprobanteRemitosItems_Descripcion_${num_item}']
     type                                               xpath=//td[@id='ComprobanteRemitosItems_Descripcion_${num_item}']/div/div/input      ${observacion}

Comprobante Asociado
    [Documentation]                                      Realiza un click en el campo Comprobante Asociado y selecciona
    ...                                                  el comprobante asociado la Factura de Crédito MiPyME (FCE)
    [Arguments]                                          ${fact_cred}
    click                                                xpath=//div[@name='wdg_ComprobanteAsociadoID']
    type                                                 xpath=//div[@name='wdg_ComprobanteAsociadoID']//input          ${fact_cred}
    sendKeys                                             xpath=(//input[@value=''])[14]                                 ENTER
    click                                                xpath=//td/div/table/tbody/tr/td

Es Anulacion
    [Documentation]                                     selecciona la opcion "Es Anulacion"
    Select Checkbox                                     xpath=//div[@name='wdg_anulacion']//input

Ir a Cobrar
    [Documentation]                                     ingresa a la seccion "Cobrar" en el menu superior
    click                                               xpath=//a[@id='cobrarFactura']
    wait until page contains element                    xpath=//h1[@id='fafPopUpTitle']

Completar Campos en Cobrar
    [Arguments]                 ${valor}
    type                        xpath=//input[@id='IMPORTE_0']          ${valor}
    sendKeys                    xpath=//input[@id='IMPORTE_0']          TAB
    click                       xpath=//a[@id='ACEPTAR_0']

Completar Campos en Grilla Cobro
    [Documentation]                 Completa los campos de instrumento de cobro en el popup "Cobro"
    [Arguments]                     ${num_item}     ${tipo_cuenta}  ${cuenta}
    click                           xpath=(//td[@id='TransaccionTesoreriaIngresoItems_M_CuentaTipo_${num_item}']/div)[2]
    type                            xpath=(//td[@id='TransaccionTesoreriaIngresoItems_M_CuentaTipo_${num_item}']/div)[2]          ${tipo_cuenta}
    click                           xpath=//td/div/table/tbody/tr/td
    click                           xpath=(//td[@id='TransaccionTesoreriaIngresoItems_CuentaID_${num_item}']/div)[2]
    type                            xpath=(//td[@id='TransaccionTesoreriaIngresoItems_CuentaID_${num_item}']/div)[2]               ${cuenta}
    click                           xpath=//td/div/table/tbody/tr/td
    sleep                           1s
    click                           xpath=(//a[@id="_onSave"])[2]


# ======== Seccion validaciones ==================
Total Cuenta Corriente
    [Documentation]     validacion de Total Cuenta Corriente en el popup Cobranza
    [Arguments]     ${valor}
    Page Should Contain Element     xpath=//div[@class='widgetContainer']//div[text() = 'Total Cuenta Corriente']//following-sibling::div//input[@value='${valor}']

Total Inst De Cobro
    [Documentation]     validacion de Total Inst. de Cobro en el popup Cobranza
    [Arguments]     ${valor}
    Page Should Contain Element     xpath=//div[@class='widgetContainer']//div[text() = 'Total Inst. de Cobro']//following-sibling::div//input[@value='${valor}']

Total Bruto
    [Documentation]     validacion de Total Bruto
    [Arguments]     ${valor}
    Page Should Contain Element     xpath=//div[@class='widgetContainer']//div[text() = 'Total Bruto']//following-sibling::div//input[@value='${valor}']

Total Impuestos
    [Documentation]     validacion de Total impuestos
    [Arguments]     ${valor}
    Page Should Contain Element     xpath=//div[@class='widgetContainer']//div[text() = 'Total Impuestos']//following-sibling::div//input[@value='${valor}']

Total
    [Documentation]     validacion del Total
    [Arguments]     ${valor}
    Page Should Contain Element     xpath=//div[@class='widgetContainer']//div[text() = 'Total']//following-sibling::div//input[@value='${valor}']

Total Cobranza
    [Documentation]     validacion de Total Cobranza
    [Arguments]     ${valor}
    Page Should Contain Element     xpath=//div[@class='widgetContainer']//div[text() = 'Total Cobranza']//following-sibling::div//input[@value='${valor}']

Letra Numero Comprobante
    [Documentation]     validacion de la primer letra que esta en el numero de comprobante de la factura
    [Arguments]     ${letra}
    Page Should Contain Element     xpath=//div[@name='wdg_NumeroDocumento']//input[contains(@value, '${letra}')]

Condicion De Pago
    [Documentation]     validacion de la condicion de pago
    [Arguments]     ${condicion}
    Page Should Contain Element     xpath=//select//option[@selected="1" and text() = '${condicion}']

Validacion Botones
    [Documentation]     validacion de los botones del menu que aparece despues de guardar la factura
    assertText    id=_onPrint                                       Imprimir
    assertText    id=_onFileAttach                                  Adjuntar
    assertText    id=_onMail                                        Enviar
    assertText    id=verHistorial                                   Ver Historial
    assertText    id=cobrarFactura                                  Cobrar
    assertText    id=FacturaVenta_openVinculacionCuentaCorriente    Aplicaciones
    assertText    id=_onAnularTransaccion                           Anular
    assertText    id=generarNotaCredito                             Crear Nota Crédito
    assertText    id=generarRemito                                  Remitir
    assertText    id=calcularPercepciones                           Calcular Percepciones

Validacion Botones NC
    [Documentation]     validacion de los botones del menu que aparece despues de guardar la factura
    ...                 cuando la factura es Nota de Credito
    assertText    id=_onPrint                                       Imprimir
    assertText    id=_onFileAttach                                  Adjuntar
    assertText    id=_onMail                                        Enviar
    assertText    id=verHistorial                                   Ver Historial
    assertText    id=cobrarFactura                                  Cobrar
    assertText    id=FacturaVenta_openVinculacionCuentaCorriente    Aplicaciones
    assertText    id=_onAnularTransaccion                           Anular
    assertText    id=calcularPercepciones                           Calcular Percepciones

Validacion Moneda
    [Documentation]     valida el tipo de moneda de cobro de la factura
    [Arguments]                     ${moneda}
    Page Should Contain Element     xpath=//div[@name="wdg_MonedaID"]//input[@value="${moneda}"]

Validacion Cotizacion
    [Documentation]     valida la cotizacion de la moneda indicada
    [Arguments]                     ${valor}
    Page Should Contain Element     xpath=//div[@name="wdg_Cotizacion"]//input[@value="${valor}"]

Validacion Comprobante
    [Documentation]     valida el tipo de comprobante
    [Arguments]                     ${comprobante}
    Page Should Contain Element     xpath=//div[@name='wdg_Tipo']//select//option[@selected="1" and text() = '${comprobante}']

Validacion Primer Tique B/C Vacio
    [Documentation]     valida que el campo "Primer Tique B/C" este vacio
    Textfield Value Should Be       xpath=//div[@name='wdg_PrimerTktBC']//input        ${EMPTY}

Validacion Ultimo Tique B/C Vacio
    [Documentation]     valida que el campo "Ultimo Tique B/C" este vacio
    Textfield Value Should Be       xpath=//div[@name='wdg_UltimoTktBC']//input        ${EMPTY}

Validacion Cant Comprobantes Emitidos Vacio
    [Documentation]     valida que el campo "Cantidad de comprobantes Emitidos" este vacio
    Textfield Value Should Be       xpath=//div[@name='wdg_CantComprobantesEmitidos']//input        ${EMPTY}

Validacion Cant Comprobantes Cancelados Vacio
    [Documentation]     valida que el campo "Cantidad de comprobantes Cancelados" este vacio
    Textfield Value Should Be       xpath=//div[@name='wdg_CantComprobantesCancelados']//input        ${EMPTY}

Validacion Popup NC
    [Documentation]                                    Validacion Popup Nota de Credito
    Page Should Contain Element                        xpath=//span[contains(text(),'Importes a Aplicar por Factura')]

Validacion del Importe
    [Documentation]                                     Valida el valor de la columna importe
    [Arguments]                                         ${valor}
    Page Should Contain Element                         xpath=//input[@id='IMPORTE_0' and @value ="${valor}"]

Validacion Cliente (Pop-up)
    [Documentation]                                     Valida el cliente en la ventana del Pop-up
    [Arguments]                                         ${cliente}
    Page Should Contain Element                         xpath=//div[@name='wdg_Organizacion']//input[@class='readOnly']         ${cliente}

Validacion de Letra (Pop-up)
    [Documentation]                                     Valida letra del campo Numero
    [Arguments]     ${letra}
    Page Should Contain Element                         xpath=(//div[@name='wdg_NumeroDocumento']//input[contains(@value, '${letra}')] )[2]

Validacion Condicion de Pago_(Pop-up)
    [Documentation]                                     Valida el dato del campo Condicion de Pago del Pop-up
    [Arguments]     ${condicion}
    Page Should Contain Element                         xpath=//div[@name='wdg_CondicionDePago']//select[@class='readOnly']         ${condicion}

Validacion Comprobante (Pop-up)
    [Documentation]                                     Valida el dato del campo Comprobante del Pop-up
    [Arguments]     ${comprobante}
    assertText                                           xpath=(//div[@name='wdg_Tipo']//select//option[3])[2]                      ${comprobante}

Validacion del campo Comprobante Asociado este Vacio (Pop-up)
    [Documentation]                                       Valida el campo Comprobante Asociado este Vacio (Pop-up)
    Textfield Value Should Be                             xpath=//div[@name='wdg_ComprobanteAsociadoID']//input                      ${EMPTY}

Validacion Campo Operacion Sujeta a Retencion (Pop-up)
    [Documentation]                                      Valida que exista el Campo Operación Sujeta a Retencion (Pop-up)
    Checkbox Should Not Be Selected                      xpath=(//div[@name='wdg_CBUInformada']//input)[2]

Validacion Operacion Sujeta a Ret.
    [Documentation]                                      Valida que exista el Campo Operación Sujeta a Retencion
    Checkbox Should Not Be Selected                        xpath=//div[@name='wdg_CBUInformada']//input

Validacion columna IVA (Pop-up)
    [Documentation]                                      Valida que se encuentre la columna Iva del Pop-up
    Page Should Contain Element                           xpath=(//div[@name='wdg_TransaccionCVItems']//th[9])[2]                    IVA

Validacion Importe IVA (Pop-up)
    [Documentation]                                      Valida el importe que figura en la columna Iva del Pop-up
    [Arguments]     ${importe}
    assertText                                           xpath=(//td[@id='TransaccionCVItems_ImporteImpuesto_1']/div )[2]           ${importe}

Validacion Campos Aplicaciones
    [Documentation]                                       Valida que se encuentre los campos de la ventana Aplicaciones
    [Arguments]     ${valor1}
    Page Should Contain Element                           xpath=(//div[@class='header'][contains(text(),'Aplicado')])[1]               ${valor1}
    Page Should Contain Element                           xpath=(//div[@class='header'][contains(text(),'Pendiente')])[1]               ${valor1}
    Page Should Contain Element                           xpath=(//div[@class='header'][contains(text(),'Documento Destino')])[1]       ${valor1}
    Page Should Contain Element                           xpath=(//div[@class='header'][contains(text(),'Fecha Aplic.')])[1]            ${valor1}

Validacion primer Tique B/C
    [Documentation]                                       Verifica el valor del tique B/C ingresado
    [Arguments]                                           ${valor}
    Page Should Contain Element                            xpath=//div[@name='wdg_PrimerTktBC']//input                    ${valor}

Validacion Ultimo tique B/C
    [Documentation]                                       Verifica el valor del ultimo tique B/C ingresado
    [Arguments]                                           ${valor}
    Page Should Contain Element                           xpath=//div[@name='wdg_UltimoTktBC']//input                    ${valor}

Validacion de comprobantes cancelados
    [Documentation]                                       Verifica la cantidad de los comprobantes cancelados
    [Arguments]                                          ${valor}
    Page Should Contain Element                          xpath=//div[@name='wdg_CantComprobantesCancelados']//input     ${valor}

Validacion Cant. de comprobantes emitidos
    [Documentation]                                       Verifica la cantidad de los comprobantes emitidos
    [Arguments]                                           ${valor}
    Page Should Contain Element                           xpath=//div[@name='wdg_CantComprobantesEmitidos']//input       ${valor}

Validacion Columna Importe Con IVA
    [Documentation]                                       Verifica el valor de la columna importe
    [Arguments]                                           ${item}     ${valor}
    Page Should Contain Element                           xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_${item}']/div     ${valor}

Validacion Importe de percepcion e Impuesto
    [Documentation]                                       Verifica el Importe de percepción e Impuesto
    [Arguments]                                          ${item}     ${valor}
     assertText                                          xpath=//td[@id='TransaccionTesoreriaIngresoItems_ImporteMonTransaccion_${item}']/div    ${valor}

Validacion Columna Importe
    [Documentation]                                      Verifica el valor de la columna Importe
    [Arguments]                                          ${item}     ${valor}
     assertText                                          xpath=//td[@id='TransaccionCVItems_Importe_${item}']/div       ${valor}

Validacion Columna Iva
    [Documentation]                                      Verifica el valor de la columna Iva
    [Arguments]                                          ${item}     ${valor}
    assertText                                          xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_${item}']/div    ${valor}

Validacion Columna Total
     [Documentation]                    Verifica el valor de la columna Total
     [Arguments]                        ${item}     ${valor}
     assertText                         xpath=//td[@id='TransaccionCVItems_ImporteTotal_${item}']/div      ${valor}

Verificacion Comprobante Asociado
    [Documentation]             se verifica la existencia del campo "Comprobante Asociado"
    Page Should Contain Element         xpath=//div[@class="widgetContainer"]//div[@name="wdg_ComprobanteAsociadoID"]

Varificacion Es Anulacion
    [Documentation]             se verifica la existencia del campo "Es Anulacion"
    Page Should Contain Element         xpath=//div[@class="widgetContainer"]//div[text() = "Es Anulación"]

Verificacion Remitos Asociados
    [Documentation]             se verifica la existencia del campo "Remitos Asociados"
    Page Should Contain Element         xpath=//tr[@class='gridRow']//td[contains(@id, "ComprobanteRemitosItems")]

Validacion Remito ingresado
    [Documentation]                     Despliega la opcion Remitos Asociados y completa los campos
     [Arguments]                        ${remito}
     Page Should Contain Element        xpath=//td[@id='ComprobanteRemitosItems_RemitoID_1']//div//input            ${remito}

Validacion Observaciones
    [Documentation]                     Despliega la opcion Remitos Asociados y completa los campos
    [Arguments]                         ${observacion}
    Page Should Contain Element         xpath=//td[@id="ComprobanteRemitosItems_Descripcion_1"]/div/div/input       ${observacion}

Validacion Comprobante Asociado
    [Documentation]                     valida que el comprobante asociado sea correcto
    [Arguments]                         ${comprobante}
    Page Should Contain Element         xpath=//div[@name='wdg_ComprobanteAsociadoID']//input[contains(@value, '${comprobante}')]

Validacion de casilla Es Anulacion
    [Documentation]                     Verifica que la casilla de "Es Anulacion" se encuentre tildada
    Checkbox Should Be Selected         xpath=//div[@name='wdg_anulacion']//input
