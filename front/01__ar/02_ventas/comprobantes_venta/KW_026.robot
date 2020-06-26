*** Settings ***
Library             SeleniumLibrary
Library             DateTime

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Cobrar un comprobante de venta
    [Documentation]                         Cobrar un comprobante de venta en pesos desde el comprobante de forma parcial
    log to console              Cobrar un comprobante de venta
    #vision_general.Validar Ingreso Al Sitio
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente         Responsable Inscripto   default   Factura    Cuenta Corriente

Agregar Productos
    [Documentation]                     se completan los campos de productos
    log to console              Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item RI    1   Carpeta         1       2500.50     0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    log to console              Guardar Factura
    comprobantes_venta.Guardar
    # Se guarda el numero de comprobante en una variable
    ${num_comprobante}      Get value           xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                         ${num_comprobante}

Ir a Seccion Cobrar
    [Documentation]             va a la seccion Cobrar y valida los campos dados
    # obtengo la fecha actual
    log to console              Ir a Seccion Cobrar
    ${CurrentDate}=     Get Current Date    result_format=%Y-%m-%d %H:%M:%S.%f
    ${datetime}=	    Convert Date        ${CurrentDate}      datetime

    comprobantes_venta.Ir a Cobrar
    # Validaciones
    Page Should Contain Element                xpath=//input[@name="Importe" and @value="3,175.64"]
    Page Should Contain Element                xpath=//input[@name="Cliente" and @value="Responsable Inscripto"]
    Page Should Contain Element                xpath=//input[@name="Documento" and contains(@value, "${num_comprobante}")]
    Page Should Contain Element                xpath=//input[@name="Moneda" and @value="Pesos Argentinos"]
    comprobantes_venta.Completar Campos en Cobrar               1575

    # Validaciones en popup Cobranza
    Page Should Contain Element                xpath=(//div[@name="wdg_Organizacion"]//input[@value= 'Responsable Inscripto'])[2]
    comprobantes_venta.Letra Numero Comprobante                 X
    # campo fecha
    ${dia1}=        Get Value            xpath=(//div[@name="wdg_Fecha"])[2]//input[@name="day"]
    ${mes1}=        Get Value            xpath=(//div[@name="wdg_Fecha"])[2]//input[@name="month"]
    ${anio1}=       Get Value            xpath=(//div[@name="wdg_Fecha"])[2]//input[@name="year"]
    ${dia}=         Convert To Integer      ${dia1}
    ${mes}=         Convert To Integer      ${mes1}
    ${anio}=        Convert To Integer      ${anio1}
    Should Be Equal     ${dia}      ${datetime.day}
    Should Be Equal     ${mes}      ${datetime.month}
    Should Be Equal     ${anio}     ${datetime.year}
    # Se guarda el numero de comprobante en una variable
    ${num_comprobante}      Get value           xpath=(//div[@name='wdg_NumeroDocumento']//input)[2]
    Set Global Variable                         ${num_comprobante}
    comprobantes_venta.Completar Campos en Grilla Cobro         1       Banco        Banco Galicia
    comprobantes_venta.Total Inst De Cobro                      1575
    comprobantes_venta.Total Cuenta Corriente                   1575.00

Ir a Aplicaciones
    [Documentation]             va a la seccion Aplicaciones y valida los campos dados
    log to console              Ir a Aplicaciones
    comprobantes_venta.Seleccionar Aplicaciones
    # Validacion Aplicado
    assertText           xpath=(//div[@class="webix_ss_center_scroll"])[5]//div[@column="1"]//div    1,575.00
    # Validacion Pendiente
    assertText           xpath=(//div[@class="webix_ss_center_scroll"])[5]//div[@column="2"]//div    1,600.64
    # Validacion Documento Destino
    assertText           xpath=(//div[@class="webix_ss_center_scroll"])[5]//div[@column="3"]//div    ${num_comprobante}
    # Validacion Moneda
    assertText           xpath=(//div[@class="webix_ss_center_scroll"])[5]//div[@column="5"]//div    Pesos Argentinos
    # Validacion Cotizacion
    assertText           xpath=(//div[@class="webix_ss_center_scroll"])[5]//div[@column="6"]//div    1.00

    comprobantes_venta.Salir de Aplicaciones