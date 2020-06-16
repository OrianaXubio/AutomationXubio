*** Settings ***
Documentation       Nueva venta
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Informe Diario de Cierre Z
    [Documentation]                                   Creación de Informe Diario de Cierre Z con los items opcionales completos al contado en pesos
    [Tags]                                            Informe Diario de Cierre Z
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                   Consumidor Final - Sin identificación   default     Informe Diario de Cierre Z     Contado
    click                                             xpath=//div[@name='wdg_PrimerTktBC']
    type                                              xpath=//div[@name='wdg_PrimerTktBC']//input                     156
    click                                             xpath=//div[@name='wdg_UltimoTktBC']
    type                                              xpath=//div[@name='wdg_UltimoTktBC']//input                     269
    click                                             xpath=//div[@name='wdg_CantComprobantesEmitidos']
    type                                              xpath=//div[@name='wdg_CantComprobantesEmitidos']//input        113
    click                                             xpath=//div[@name='wdg_CantComprobantesCancelados']
    type                                              xpath=//div[@name='wdg_CantComprobantesCancelados']//input      0

Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item CF            1   Carpetas        1       3002        0
    comprobantes_venta.Agregar Item CF            2   Alquiler        1       18500       10

Grilla Instrumento de cobro
    sleep   1s
    #Agregar Instrumento De Cobro
    click                       xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_CuentaTipo_1']/div
    type                        xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_CuentaTipo_1']/div               Caja
    sendKeys                    xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_CuentaTipo_1']/div               TAB
    sendKeys                    xpath=//td[@id='TransaccionTesoreriaIngresoItems_M_CuentaTipo_1']/div               ENTER
    click                       xpath=//td[@id='TransaccionTesoreriaIngresoItems_CuentaID_1']/div
    type                        xpath=//td[@id='TransaccionTesoreriaIngresoItems_CuentaID_1']/div                   Caja
    sendKeys                    xpath=//td[@id='TransaccionTesoreriaIngresoItems_CuentaID_1']/div                   TAB
    click                       xpath=//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_1']/div
    type                        xpath=//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_1']/div        Pesos Argentinos
    sendKeys                    xpath=//td[@id='TransaccionTesoreriaIngresoItems_MonedaIDTransaccion_1']/div        TAB
    click                       xpath=//td[@id='TransaccionTesoreriaIngresoItems_CotizacionMonTransaccion_1']/div
    type                        xpath=//td[@id='TransaccionTesoreriaIngresoItems_CotizacionMonTransaccion_1']/div   1.000000
    sendKeys                    xpath=//td[@id='TransaccionTesoreriaIngresoItems_CotizacionMonTransaccion_1']/div   TAB
    click                       xpath=//td[@id='TransaccionTesoreriaIngresoItems_ImporteMonTransaccion_1']/div
    type                        xpath=(//input[@value='0'])[11]                                                     21,502.00
    click                       xpath=//td[@id="TransaccionTesoreriaIngresoItems_Descripcion_1"]/div
    sendKeys                    xpath=//td[@id="TransaccionTesoreriaIngresoItems_Descripcion_1"]/div                TAB

Guardar
    click    id=_onSave

Validaciones
    comprobantes_venta.Letra Numero Comprobante     Z
    #validación de comprobante
    assertText                                      xpath=//div[@name='wdg_Tipo']//select//option[5]                                  Informe Diario de Cierre Z
    #Validación primer Tique B/C
    Page Should Contain Element                     xpath=//div[@name='wdg_PrimerTktBC']//input[@value="156"]                         156
    #Validación Ultimo tique B/C
    Page Should Contain Element                     xpath=//div[@name='wdg_UltimoTktBC']//input[@value="269"]                         269
    #Validación de comprobantes cancelados
    Page Should Contain Element                     xpath=//div[@name='wdg_CantComprobantesCancelados']//input[@value="0"]            0
    #Validacion Cant. de comprobantes emitidos
    Page Should Contain Element                     xpath=//div[@name='wdg_CantComprobantesEmitidos']//input[@value="113"]            113
    #Validación columna importe
    Page Should Contain Element                     xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_1']/div                  3,002.00
    #Validacion Importe de percepción e Impuesto
    assertText                                      xpath=//td[@id='TransaccionTesoreriaIngresoItems_ImporteMonTransaccion_1']/div    21,502.00
    #Verificacion de los totales
    comprobantes_venta.Total Bruto                       16124.11
    comprobantes_venta.Total Impuestos                   3527.89
    comprobantes_venta.Total                             19652
    comprobantes_venta.Total Cobranza                    21502

    vision_general.Ir a Inicio