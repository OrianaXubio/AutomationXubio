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
    [Documentation]                         Cobrar un comprobante de venta en pesos desde el comprobante de forma total
    log to console              Cobrar un comprobante de venta
    comprobantes_venta.Ir a Comprobantes de Venta
    comprobantes_venta.Filtro Fecha_Hasta
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente         Monotributista   default   Nota de Débito    Cuenta Corriente

Agregar Productos
    [Documentation]                     se completan los campos de productos
    log to console              Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item     1   Carpeta         1       2500.50     0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura
    [Documentation]                             se guarda la factura generada
    log to console              Guardar Factura
    comprobantes_venta.Guardar
    # Se guarda el numero de comprobante en una variable
    ${num_comprobante}      Get value           xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                         ${num_comprobante}

Cobrar Desde Comprobante De Forma Total
    [Documentation]                    Cobrar Desde Comprobante De Forma Total en el PopUp
    log to console             Cobrar Desde Comprobante De Forma Total
    ${CurrentDate}=     Get Current Date    result_format=%Y-%m-%d %H:%M:%S.%f
    ${datetime}=	    Convert Date        ${CurrentDate}      datetime
    comprobantes_venta.Ir a Comprobantes de Venta
    comprobantes_venta.Buscador                 ${num_comprobante}
    Select Checkbox                             xpath=//div[@class="webix_cell"][1]//input
    comprobantes_venta.Cobrar Comprobante De Venta
    # validaciones primer popup
    Page Should Contain Element                xpath=//input[@name="Importe" and @value="2,500.50"]
    Page Should Contain Element                xpath=//input[@name="Cliente" and @value="Monotributista"]
    Page Should Contain Element                xpath=//input[@name="Documento" and contains(@value, "${num_comprobante}")]
    click                           xpath=//a[@id='ACEPTAR_0']
    # segundo popup - Nuevo Monotributista - Cobranza
    comprobantes_venta.Completar Campos en Grilla Cobro            1     Valores a depositar     Valores a depositar
    comprobantes_venta.Agregar Cheque                              1     12345678      12   12   2020     BACS
    # Validaciones
    # campo fecha
    ${dia1}=        Get Value            xpath=//div[@name="wdg_Fecha"]//input[@name="day"]
    ${mes1}=        Get Value            xpath=//div[@name="wdg_Fecha"]//input[@name="month"]
    ${anio1}=       Get Value            xpath=//div[@name="wdg_Fecha"]//input[@name="year"]
    ${dia}=         Convert To Integer      ${dia1}
    ${mes}=         Convert To Integer      ${mes1}
    ${anio}=        Convert To Integer      ${anio1}

    comprobantes_venta.Validacion Cliente (Pop-up)              Monotributista
    Should Be Equal     ${dia}      ${datetime.day}
    Should Be Equal     ${mes}      ${datetime.month}
    Should Be Equal     ${anio}     ${datetime.year}
    comprobantes_venta.Total Inst De Cobro                      2500.5
    comprobantes_venta.Total Retenciones                        0
    comprobantes_venta.Total Cuenta Corriente                   2500.50

Guardar Factura II
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura
    click                               id=_onSave

Validaciones en Aplicaciones
    log to console                      Validaciones en Aplicaciones
    click                               xpath=(//div[@class="webix_ss_center"]//div//a[text() = '${num_comprobante}'])[1]
    comprobantes_venta.Seleccionar Aplicaciones
    assertText                          xpath=(//div[@class="webix_ss_body"])[2]//div[@class="webix_column "][1]/div    2,500.50
    assertText                          xpath=(//div[@class="webix_ss_body"])[2]//div[@class="webix_column "][2]/div    0.00
    comprobantes_venta.Salir de Aplicaciones

TC_028
    [Documentation]         Cobrar un comprobante de venta en pesos desde el comprobante de forma total
    KW_028.Cobrar un comprobante de venta
    KW_028.Agregar Productos
    KW_028.Guardar Factura
    KW_028.Cobrar Desde Comprobante De Forma Total
    KW_028.Guardar Factura II
    KW_028.Validaciones en Aplicaciones