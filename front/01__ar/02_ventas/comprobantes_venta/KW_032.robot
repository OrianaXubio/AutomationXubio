*** Settings ***
Library             SeleniumLibrary
Library             DateTime

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Cobrar Comprobante de Venta en Dolares
    [Documentation]                     Cobrar un comprobante de venta en dolares desde el comprobante de forma parcial
    log to console                      Cobrar Comprobante de Venta en Dolares
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


Cobrar en Dolares
    [Documentation]         ir a "Cobrar" y cobrar en dolares
    ${CurrentDate}=         Get Current Date        result_format=%Y-%m-%d %H:%M:%S.%f
    ${datetime}=            Convert Date            ${CurrentDate}       datetime
    comprobantes_venta.Ir a Cobrar
    comprobantes_venta.Cambiar Cotizacion Dolar         140
    # validaciones
    comprobantes_venta.Validacion de todos los campos en la grilla cobro
    Page Should Contain Element         xpath=//td//input[@id="CLIENTE_0" and @value="Responsable Inscripto"]
    Page Should Contain Element         xpath=//td//input[@id="DOCUMENTO_0" and @value="Factura de Venta N° ${num_comprobante}"]
    Page Should Contain Element         xpath=//td//input[@id="IMPORTE_0" and @value="158.75"]
    comprobantes_venta.Modificar importe en NC          50
    # validaciones
    comprobantes_venta.validacion Cliente Formulario Cobranza       Responsable Inscripto
    comprobantes_venta.Validacion de Letra (Pop-up)                 X
    # guarda el numero de factura
    ${doc_destino}      Get value                                   xpath=//div[@id='df_popup']//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                                             ${doc_destino}
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
    comprobantes_venta.Total Inst De Cobro                  7000.00
    comprobantes_venta.Total Cuenta Corriente               7000.00

    comprobantes_venta.Completar Campos en Grilla Cobro             1     Banco     Banco Galicia

Guardar Factura II
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura popup
    click                               xpath=//div[@id="df_popup"]//a[@id="_onSave"]

Validaciones en Aplicaciones
    log to console                      Validaciones en Aplicaciones
    comprobantes_venta.Seleccionar Aplicaciones
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="1"])[1]/div)[1]       50.00
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="2"])[1]/div)[1]       108.75
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="3"])[1]/div)[1]       ${doc_destino}
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="5"])[1]/div)[1]       Dólares
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="6"])[1]/div)[1]       140.00
    comprobantes_venta.Salir de Aplicaciones

Comprobante Cobranza
    log to console                              ir a comprobante cobranza
    Ir A Cobranzas
    comprobantes_venta.Buscador                 ${doc_destino}
    click                                       link=${doc_destino}
    Wait Until Element Is Visible               xpath=//a[@id="Tesoreria_openVinculacionCuentaCorriente"]
    click                                       link=Aplicaciones
    # validaciones
    # fILA 1
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="1"])[1]/div)[1]       1,900.00
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="2"])[1]/div)[1]       0.00
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="3"])[1]/div)[1]       Asiento Manual
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="5"])[1]/div)[1]       Pesos Argentinos
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="6"])[1]/div)[1]       1.00
     # Fila 2
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="1"])[1]/div)[2]       50.00
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="2"])[1]/div)[2]       0.00
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="3"])[1]/div)[2]       ${num_comprobante}
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="5"])[1]/div)[2]       Dólares
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="6"])[1]/div)[2]       140.00
    comprobantes_venta.Salir de Aplicaciones
