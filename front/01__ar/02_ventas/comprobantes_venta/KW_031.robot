*** Settings ***
Library             SeleniumLibrary
Library             DateTime

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Realiza una Nueva Venta
    [Documentation]                                     Realiza un comprobante de venta en dolares
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                     Responsable Inscripto   default   Factura   Cuenta Corriente
    comprobantes_venta.Mas Opciones - Moneda            Dólares        102
     #Guarda el nº de comprobante
    ${num_comprobante}      Get value                   xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                                 ${num_comprobante}

Agregar Productos
    [Documentation]                                    Se Completa la grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item                  1   Carpeta         1      125     0
    click                                              xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura
      comprobantes_venta.Guardar

Cobrar Factura
    [Documentation]                                                  Selecciona el boton Cobrar ,destildar la opción "Utiliza misma cotización", coloca 90 y Valida los campos
    comprobantes_venta.Ir a Cobrar
    Unselect Checkbox                                               xpath=//div[@class='FAFPopup']//input[@id='USACOTIZACIONORIGEN_0']
    click                                                           xpath=//div[@class='FAFPopup']//input[@id='COTIZACIONMONTRANSACCION_0']
    sendKeys                                                        xpath=//div[@class='FAFPopup']//input[@id='COTIZACIONMONTRANSACCION_0']              DELETE
    type                                                            xpath=//div[@class='FAFPopup']//input[@id='COTIZACIONMONTRANSACCION_0']              90
    #Validacion de las valores en los campos
    Page Should Contain Element                                     xpath=//div[@class='FAFPopup']//td//input[@id='CLIENTE_0'][contains(@value,'Responsable Inscripto')]
    Page Should Contain Element                                     xpath=//div[@class='FAFPopup']//td//input[@id='DOCUMENTO_0'][contains(@value,'${num_comprobante}')]
    Page Should Contain Element                                     xpath=//div[@class='FAFPopup']//td//input[@id='IMPORTE_0'][contains(@value,'158.75')]
    click                                                           xpath=//td//a[@id='ACEPTAR_0']

Grilla Cobranza
    [Documentation]                                                 Completa los campos "Tipo de cuenta" , "Cuenta" y Realiza las validaciones Correspondientes
    ${CurrentDate}=     Get Current Date                            result_format=%Y-%m-%d %H:%M:%S  #.%f
    ${datetime}=       Convert Date            ${CurrentDate}       datetime
     comprobantes_venta.Completar Campos en Grilla Cobro             1           Banco            Banco Galicia
     comprobantes_venta.validacion Cliente Formulario Cobranza       Responsable Inscripto
    #guarda el numero de factura
    ${doc_destino}      Get value                                   xpath=//div[@id='df_popup']//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                                             ${doc_destino}
    # campo fecha
    ${dia1}=        Get Value                                       xpath=//div[@class='FAFPopup']//div[@name="wdg_Fecha"]//input[@name="day"]
    ${mes1}=        Get Value                                       xpath=//div[@class='FAFPopup']//div[@name="wdg_Fecha"]//input[@name="month"]
    ${anio1}=       Get Value                                       xpath=//div[@class='FAFPopup']//div[@name="wdg_Fecha"]//input[@name="year"]
    ${dia}=         Convert To Integer      ${dia1}
    ${mes}=         Convert To Integer      ${mes1}
    ${anio}=        Convert To Integer      ${anio1}
    Should Be Equal     ${dia}      ${datetime.day}
    Should Be Equal     ${mes}      ${datetime.month}
    Should Be Equal     ${anio}     ${datetime.year}
    #Valida el numero de factura
    Page Should Contain Element                                     xpath=//div[@id='df_popup']//div[@name='wdg_NumeroDocumento']//input[contains(@value,'${doc_destino}')]
    #valida los Totales
    comprobantes_venta.Total Retenciones                            0
    comprobantes_venta.Total Inst De Cobro                          14287.5
    comprobantes_venta.Total Cuenta Corriente                       14287.50
    click                                                           xpath=//div[@id='df_popup']//a[@id='_onSave']
    #Valida que el Pop-up se haya cerrado
    Wait Until Element Is Not Visible                               xpath=//div[@id='df_popup']

Ir a Aplicaciones
    [Documentation]                                                Ingresa a "Aplicaciones",luego oprime "Salir" y Realiza las validaciones Correspondientes
    sleep                                                           1s
    comprobantes_venta.Seleccionar Aplicaciones
    # Fila 1
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="1"])[1]/div)[1]       1,905.00
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="2"])[1]/div)[1]       0.00
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="3"])[1]/div)[1]       Asiento Manual
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="5"])[1]/div)[1]       Pesos Argentinos
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="6"])[1]/div)[1]       1.00
    # Fila 2
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="1"])[1]/div)[2]       158.75
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="2"])[1]/div)[2]       0.00
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="3"])[1]/div)[2]       ${doc_destino}
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="5"])[1]/div)[2]       Dólares
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="6"])[1]/div)[2]       90.00
    comprobantes_venta.Salir de Aplicaciones

TC_031
    [Documentation]                             Cobrar un comprobante de venta en dolares desde el comprobante de forma total con diferente cotización (menor)
    ...                                         y verificar la diferencia de cambio
    KW_031.Realiza una Nueva Venta
    KW_031.Agregar Productos
    KW_031.Guardar Factura
    KW_031.Cobrar Factura
    KW_031.Grilla Cobranza
    KW_031.Ir a Aplicaciones