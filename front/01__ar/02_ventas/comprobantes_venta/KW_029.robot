*** Settings ***
Library             SeleniumLibrary
Library             DateTime

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Filtra Hasta Fecha Actual
    [Documentation]                                     Selecciona el campo fecha hasta
    log to console                                      Filtra Hasta Fecha Actual
    comprobantes_venta.Ir a Comprobantes de Venta
    comprobantes_venta.Filtro Fecha_Hasta

Realiza una Nueva Venta
    [Documentation]                                     Realiza un comprobante de venta en dolares
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                     Responsable Inscripto   default   Factura   Cuenta Corriente
    #Guarda el nº de comprobante
    ${num_comprobante}      Get value                   xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                                 ${num_comprobante}
    comprobantes_venta.Mas Opciones - Moneda            Dólares        75

Agregar Productos
    [Documentation]                                    Se Completa la grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item RI                 1   Carpeta         1      100     0
    click                                              xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura
      comprobantes_venta.Guardar

Comprobantes de Venta
    [Documentation]                                   Hace click en Comprobantes de Venta
    comprobantes_venta.Ir a Comprobantes de Venta

Selecionar Factura
    [Documentation]                                   Selecciona la facturas de la grilla de "Comprobantes de Venta"
    comprobantes_venta.Buscador                       ${num_comprobante}
    Select Checkbox                                   xpath=(//input[@class='itemCheckbox'])[1]
    click                                             xpath=//a[contains(text(),'${num_comprobante}')]

Cobrar Factura
     [Documentation]                                    Selecciona el boton Cobrar  y Valida los campos
    comprobantes_venta.Ir a Cobrar
    #Validacion de las valores en los campos
    Page Should Contain Element                         xpath=//div[@class='FAFPopup']//td//input[@id='CLIENTE_0'][contains(@value,'Responsable Inscripto')]
    Page Should Contain Element                         xpath=//div[@class='FAFPopup']//td//input[@id='DOCUMENTO_0'][contains(@value,'${num_comprobante}')]
    Page Should Contain Element                         xpath=//div[@class='FAFPopup']//td//input[@id='IMPORTE_0'][contains(@value,'127.00')]
    click                                               xpath=//td//a[@id='ACEPTAR_0']

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
    ${dia1}=        Get Value            xpath=//div[@class='FAFPopup']//div[@name="wdg_Fecha"]//input[@name="day"]
    ${mes1}=        Get Value            xpath=//div[@class='FAFPopup']//div[@name="wdg_Fecha"]//input[@name="month"]
    ${anio1}=       Get Value            xpath=//div[@class='FAFPopup']//div[@name="wdg_Fecha"]//input[@name="year"]
    ${dia}=         Convert To Integer      ${dia1}
    ${mes}=         Convert To Integer      ${mes1}
    ${anio}=        Convert To Integer      ${anio1}
    Should Be Equal     ${dia}      ${datetime.day}
    Should Be Equal     ${mes}      ${datetime.month}
    Should Be Equal     ${anio}     ${datetime.year}
    comprobantes_venta.Total Retenciones                            0
    comprobantes_venta.Total Inst De Cobro                          9525
    comprobantes_venta.Total Cuenta Corriente                       9525.00
    click                                   xpath=//div[@id="df_popup"]//a[@id="_onSave"]
    Wait Until Element Is Not Visible       xpath=//div[@id="df_popup"]

Ir a Aplicaciones
    [Documentation]                                                Ingresa a "Aplicaciones",luego oprime "Salir" y Realiza las validaciones Correspondientes
    comprobantes_venta.Seleccionar Aplicaciones
    comprobantes_venta.Validacion Campos Aplicaciones              127.00     0.00     ${doc_destino}      Dólares     75.00
    comprobantes_venta.Salir de Aplicaciones

