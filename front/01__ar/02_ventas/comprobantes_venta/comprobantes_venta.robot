*** Keywords ***
Ir a Nueva Venta
    click           link=Ventas
    sleep   1s
    click           link=Comprobantes de Venta
    click           link=Nueva Venta
    verifyText      xpath=//div[@id='seccionTitulo']/div    Nuevo - Comprobante de Venta

Tipo Cliente
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
    [Arguments]         ${num_item}     ${impuesto}     ${importe}
    click       xpath=//td[@id='TransaccionCVItemsPercepciones_ProductoID_${num_item}']/div
    type        xpath=//td[@id='TransaccionCVItemsPercepciones_ProductoID_${num_item}']/div/div/div/input     ${impuesto}
    click       xpath=//td/div/table/tbody/tr/td
    click       xpath=//td[@id='TransaccionCVItemsPercepciones_Importe_${num_item}']/div
    type        xpath=//td[@id='TransaccionCVItemsPercepciones_Importe_${num_item}']/div/div/input            ${importe}
    click       link=Agregar Percepción
    sleep       1s

Agregar Instrumento De Cobro
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
    [Arguments]     ${num_item}
    click       xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_${num_item}']/div/div

Mas Opciones - Moneda
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
    click       xpath=//input[@value='Más Opciones']

Guardar
    click                                       id=_onSave
    sleep   1s

# ======== Seccion validaciones ==================
Total Bruto
    [Arguments]     ${valor}
    Page Should Contain Element     xpath=//div[@class='widgetContainer']//div[text() = 'Total Bruto']//following-sibling::div//input[@value='${valor}']

Total Impuestos
    [Arguments]     ${valor}
    Page Should Contain Element     xpath=//div[@class='widgetContainer']//div[text() = 'Total Impuestos']//following-sibling::div//input[@value='${valor}']

Total
    [Arguments]     ${valor}
    Page Should Contain Element     xpath=//div[@class='widgetContainer']//div[text() = 'Total']//following-sibling::div//input[@value='${valor}']

Total Cobranza
    [Arguments]     ${valor}
    Page Should Contain Element     xpath=//div[@class='widgetContainer']//div[text() = 'Total Cobranza']//following-sibling::div//input[@value='${valor}']

Letra Numero Comprobante
    [Arguments]     ${letra}
    Page Should Contain Element     xpath=//div[@name='wdg_NumeroDocumento']//input[contains(@value, '${letra}')]

Condicion De Pago
    [Arguments]     ${condicion}
    Page Should Contain Element     xpath=//select//option[@selected="1" and text() = '${condicion}']

Validacion Botones
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
    assertText    id=_onPrint                                       Imprimir
    assertText    id=_onFileAttach                                  Adjuntar
    assertText    id=_onMail                                        Enviar
    assertText    id=verHistorial                                   Ver Historial
    assertText    id=cobrarFactura                                  Cobrar
    assertText    id=FacturaVenta_openVinculacionCuentaCorriente    Aplicaciones
    assertText    id=_onAnularTransaccion                           Anular
    assertText    id=calcularPercepciones                           Calcular Percepciones

Validacion Moneda
    [Arguments]                     ${moneda}
    Page Should Contain Element     xpath=//div[@name="wdg_MonedaID"]//input[@value="${moneda}"]

Validacion Cotizacion
    [Arguments]                     ${valor}
    Page Should Contain Element     xpath=//div[@name="wdg_Cotizacion"]//input[@value="${valor}"]

