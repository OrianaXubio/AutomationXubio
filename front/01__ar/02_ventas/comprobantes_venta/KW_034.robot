*** Settings ***
Library             SeleniumLibrary
Library             DateTime

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot
Resource            ../../../funciones_generales/queries/consultas_sql.robot

*** Keywords ***
Setear Cliente
    [Documentation]                     Configurar el cliente y tipo de comprobante
    log to console                      Configurar el cliente y tipo de comprobante
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                 Responsable Inscripto   default     Factura     Cuenta Corriente
    comprobantes_venta.Mas Opciones - Moneda        Dólares     102

Grilla Productos
    [Documentation]                     se completan los campos de productos
    log to console                      Grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item RI    1   Carpetas         1       125     0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura
    comprobantes_venta.Guardar
    # Se guarda el numero de comprobante en una variable
    ${num_comprobante}      Get value           xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                         ${num_comprobante}

Ir a Remitir
    log to console                      Ir a Remitir
    ${CurrentDate}=         Get Current Date        result_format=%Y-%m-%d %H:%M:%S.%f
    ${datetime}=            Convert Date            ${CurrentDate}       datetime
    comprobantes_venta.Seleccionar Remitir
    # campo fecha
    ${dia1}=        Get Value                   xpath=//div[@id="df_popup"]//div[@name="wdg_Fecha"]//input[@name="day"]
    ${mes1}=        Get Value                   xpath=//div[@id="df_popup"]//div[@name="wdg_Fecha"]//input[@name="month"]
    ${anio1}=       Get Value                   xpath=//div[@id="df_popup"]//div[@name="wdg_Fecha"]//input[@name="year"]
    ${dia}=         Convert To Integer          ${dia1}
    ${mes}=         Convert To Integer          ${mes1}
    ${anio}=        Convert To Integer          ${anio1}
    Should Be Equal      ${dia}                 ${datetime.day}
    Should Be Equal      ${mes}                 ${datetime.month}
    Should Be Equal      ${anio}                ${datetime.year}
    # validaciones
    comprobantes_venta.validacion Cliente Formulario Cobranza       Responsable Inscripto
    comprobantes_venta.Validacion de Letra (Pop-up)                 X
    # guarda el numero de factura
    ${doc_destino}      Get value                                   xpath=//div[@id='df_popup']//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                                             ${doc_destino}

    assertText          xpath=//div[@id="df_popup"]//td[@id="TransaccionCVItems_ProductoID_1"]/div      Carpetas (27%)
    assertText          xpath=//div[@id="df_popup"]//td[@id="TransaccionCVItems_Cantidad_1"]/div        1.00
    assertText          xpath=//div[@id="df_popup"]//td[@id="TransaccionCVItems_Precio_1"]/div          125.0000

Guardar Factura II
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura popup
    click                               xpath=//div[@id="df_popup"]//a[@id="_onSave"]

Remito Ventas
    log to console                      Remito Ventas
    comprobantes_venta.Ir A Remitos De Venta
    comprobantes_venta.Buscador                 ${doc_destino}
    assertText          xpath=//div[@class="gridLayout"]//div[@class="webix_span_layer"]//div           Estado: Facturado
    click                                       link=Remito de Venta N° ${doc_destino}
    Wait Until Element Is Visible               xpath=//a[@id="_onPrint"]
    # FECHA
    ${CurrentDate}=         Get Current Date        result_format=%Y-%m-%d %H:%M:%S.%f
    ${datetime}=            Convert Date            ${CurrentDate}       datetime

    # campo fecha
    ${dia1}=        Get Value                   xpath=//div[@name="wdg_Fecha"]//input[@name="day"]
    ${mes1}=        Get Value                   xpath=//div[@name="wdg_Fecha"]//input[@name="month"]
    ${anio1}=       Get Value                   xpath=//div[@name="wdg_Fecha"]//input[@name="year"]
    ${dia}=         Convert To Integer          ${dia1}
    ${mes}=         Convert To Integer          ${mes1}
    ${anio}=        Convert To Integer          ${anio1}
    Should Be Equal      ${dia}                 ${datetime.day}
    Should Be Equal      ${mes}                 ${datetime.month}
    Should Be Equal      ${anio}                ${datetime.year}
    Page Should Contain Element                 xpath=//div[@name='wdg_NumeroDocumento']//input[contains(@value, '${doc_destino}')]
    Page Should Contain Element                 xpath=//div[@name='wdg_Organizacion']//input[@value='Responsable Inscripto']
    assertText          xpath=//td[@id="TransaccionCVItems_ProductoID_1"]/div      Carpetas (27%)
    assertText          xpath=//td[@id="TransaccionCVItems_Cantidad_1"]/div        1.00
    assertText          xpath=//td[@id="TransaccionCVItems_Precio_1"]/div          125.0000

Validacion Con BD
    consultas_sql.Conectar A BD
    consultas_sql.Validar Remito-Factura      Remito de Venta N° ${doc_destino}       Factura de Venta N° ${num_comprobante}
    consultas_sql.Desconectar A BD

TC_034
    [Documentation]     Remitir factura de venta
    KW_034.Setear Cliente
    KW_034.Grilla Productos
    KW_034.Guardar Factura
    KW_034.Ir a Remitir
    KW_034.Guardar Factura II
    KW_034.Remito Ventas
    KW_034.Validacion Con BD