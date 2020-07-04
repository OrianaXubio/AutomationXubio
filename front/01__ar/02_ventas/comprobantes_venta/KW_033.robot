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
    comprobantes_venta.Agregar Item RI                 1   Carpeta         1      125     0
    click                                              xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura
      comprobantes_venta.Guardar

Cobrar Factura
    [Documentation]                                                 Selecciona el boton Cobrar ,destildar la opción "Utiliza misma cotización", coloca 140 y Valida los campos
    comprobantes_venta.Ir a Cobrar
    Unselect Checkbox                                               xpath=//div[@class='FAFPopup']//input[@id='USACOTIZACIONORIGEN_0']
    click                                                           xpath=//div[@class='FAFPopup']//input[@id='COTIZACIONMONTRANSACCION_0']
    sendKeys                                                        xpath=//div[@class='FAFPopup']//input[@id='COTIZACIONMONTRANSACCION_0']              DELETE
    type                                                            xpath=//div[@class='FAFPopup']//input[@id='COTIZACIONMONTRANSACCION_0']              140
   #VALIDACIONES
   #Verifica que se encuentre el campo Cotizacion
    Page Should Contain Element                                     xpath=//div[@class='FAFPopup']//table[@id='widgetCotizacion']//span[contains(text(),'Cotización')]
    #verifica los campos de la grilla
    Page Should Contain Element                                     xpath=//div[@class='FAFPopup']//td//input[@id='CLIENTE_0'][contains(@value,'Responsable Inscripto')]
    Page Should Contain Element                                     xpath=//div[@class='FAFPopup']//td//input[@id='DOCUMENTO_0'][contains(@value,'${num_comprobante}')]
    Page Should Contain Element                                     xpath=//div[@class='FAFPopup']//td//input[@id='MONEDA_0'][contains(@value,'Dólares')]
    Page Should Contain Element                                     xpath=//div[@class='FAFPopup']//td//input[@id='COTIZACION_0'][contains(@value,'102.00')]
    Page Should Contain Element                                     xpath=//div[@class='FAFPopup']//td//input[@id='IMPORTE_0'][contains(@value,'158.75')]
    #verifica que el check este destildado
    Checkbox Should Not Be Selected                                 xpath=//div[@class='FAFPopup']//input[@id='USACOTIZACIONORIGEN_0']
    click                                                           xpath=//td//a[@id='ACEPTAR_0']

Grilla Cobranza
    [Documentation]                                                 Completa los campos "Tipo de cuenta" , "Cuenta" y Realiza las validaciones Correspondientes
    ${CurrentDate}=     Get Current Date                            result_format=%Y-%m-%d %H:%M:%S  #.%f
    ${datetime}=       Convert Date            ${CurrentDate}       datetime
    comprobantes_venta.Completar Campos en Grilla Cobro             1           Banco            Banco Galicia
    #guarda el numero de factura
    ${doc_destino}      Get value                                   xpath=//div[@id='df_popup']//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                                             ${doc_destino}
    comprobantes_venta.click en mas opciones (Pop-up)
    #VALIDACIONES
    comprobantes_venta.validacion Cliente Formulario Cobranza       Responsable Inscripto
    #Valida campo fecha con el sitema
    ${dia1}=        Get Value                                       xpath=//div[@class='FAFPopup']//div[@name="wdg_Fecha"]//input[@name="day"]
    ${mes1}=        Get Value                                       xpath=//div[@class='FAFPopup']//div[@name="wdg_Fecha"]//input[@name="month"]
    ${anio1}=       Get Value                                       xpath=//div[@class='FAFPopup']//div[@name="wdg_Fecha"]//input[@name="year"]
    ${dia}=         Convert To Integer      ${dia1}
    ${mes}=         Convert To Integer      ${mes1}
    ${anio}=        Convert To Integer      ${anio1}
    Should Be Equal     ${dia}      ${datetime.day}
    Should Be Equal     ${mes}      ${datetime.month}
    Should Be Equal     ${anio}     ${datetime.year}
    comprobantes_venta.Validacion Moneda (Pop-up)                   Dólares
    #valida que el campo Cotizacion contenga el importe
    Page Should Contain Element                                     xpath=//div[@class='FAFPopup']//div[@name="wdg_Cotizacion"]//input[@value="140"]
    comprobantes_venta.Validacion Importe Cobranza                 1         22,225.00
    #valida los Totales
    comprobantes_venta.Total Retenciones                            0
    comprobantes_venta.Total Inst De Cobro                          22225
    comprobantes_venta.Total Cuenta Corriente                       22225.00
    click                                                           xpath=//div[@id='df_popup']//a[@id='_onSave']
    #Valida que el Pop-up se haya cerrado
    Wait Until Element Is Not Visible                               xpath=//div[@id='df_popup']

Ir a Aplicaciones
    [Documentation]                                                Ingresa a "Aplicaciones",luego oprime "Salir" y Realiza las validaciones Correspondientes
    sleep                                                          1s
    comprobantes_venta.Seleccionar Aplicaciones
    Page Should Contain Element                                    xpath=//div[@class='FAFPopup']//input[@id='VNOMBRETRANSACCION_0' and @value='Factura de Venta N° ${num_comprobante}']
    comprobantes_venta.Validacion Campos Aplicaciones              158.75       0.00       ${doc_destino}       Dólares      140.00
    comprobantes_venta.Salir de Aplicaciones

Ir a Cobranza
    [Documentation]                                                 Ingresa a cobranzas desde el menu de "Ventas", selecciona el documento
     click                                                          link=Ventas
     click                                                          link=Cobranzas
     comprobantes_venta.Buscador                                    ${doc_destino}
     #Selecciona la factura
     Select Checkbox                                                xpath=(//input[@class='itemCheckbox'])[1]
     click                                                          xpath=//a[contains(text(),'${doc_destino}')]
Ir Aplicaciones-Cobranza
    [Documentation]                                                 Ingresa a "Aplicaciones" desde Cobranza,Tambien se realizan las validaciones de los campos
    #Aplicaciones-Cobranza
    click                                                          xpath=//a[@id='Tesoreria_openVinculacionCuentaCorriente']
    # Fila 1
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="1"])[1]/div)[1]       6,032.50
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="2"])[1]/div)[1]       0.00
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="3"])[1]/div)[1]       Asiento Manual
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="5"])[1]/div)[1]       Pesos Argentinos
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="6"])[1]/div)[1]       1.00
    # Fila 2
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="1"])[1]/div)[2]       158.75
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="2"])[1]/div)[2]       0.00
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="3"])[1]/div)[2]       ${num_comprobante}
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="5"])[1]/div)[2]       Dólares
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="6"])[1]/div)[2]       140.00
    comprobantes_venta.Salir de Aplicaciones
