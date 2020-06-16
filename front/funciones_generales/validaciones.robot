*** Keywords ***
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
    assertText    id=_onPrint    Imprimir
    assertText    id=_onFileAttach    Adjuntar
    assertText    id=_onMail    Enviar
    assertText    id=verHistorial    Ver Historial
    assertText    id=cobrarFactura    Cobrar
    assertText    id=FacturaVenta_openVinculacionCuentaCorriente    Aplicaciones
    assertText    id=_onAnularTransaccion    Anular
    assertText    id=generarNotaCredito    Crear Nota Crédito
    assertText    id=generarRemito    Remitir
    assertText    id=calcularPercepciones    Calcular Percepciones
