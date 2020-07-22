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

Setear Cliente
    [Documentation]                     Configurar el cliente y tipo de comprobante
    log to console                      Configurar el cliente y tipo de comprobante
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                 Monotributista   default     Nota de Débito     Cuenta Corriente

Grilla Productos
    [Documentation]                     se completan los campos de productos
    log to console                      Grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item     1   Carpetas         1       2500.50     0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura
    comprobantes_venta.Guardar
    # Se guarda el tipo y numero de comprobante completo
    ${nombre_comprobante}      Get Text    xpath=//div[@id='seccionTitulo']/div
    Set Global Variable                 ${nombre_comprobante}
    # Se guarda el numero de comprobante
    ${num_comprobante}      Get value           xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                         ${num_comprobante}

Cobrar Factura
    [Documentation]             se cobra la factura con el comprobante generado
    log to console              Cobrar Factura
    comprobantes_venta.Ir a Comprobantes de Venta
    comprobantes_venta.Buscador         ${nombre_comprobante}
    Select Checkbox                     xpath=//div[@class="webix_cell"][1]//input
    comprobantes_venta.Cobrar Comprobante De Venta
    click                               xpath=//a[@id="ACEPTAR_0"]
    comprobantes_venta.Completar Campos en Grilla Cobro        1       Caja        Caja
    # guarda el numero de factura
    ${doc_destino}      Get value       xpath=//div[@id='df_popup']//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                 ${doc_destino}

Guardar Aplicar Factura
    [Documentation]             se guarda la factura cobranaza
    log to console              Guardar Aplicar Factura
    click                                   xpath=//div[@id="df_popup"]//a[@id="_onSave"]
    Wait Until Element Is Not Visible       xpath=//div[@id="df_popup"]

Ir a Aplicaciones y Desaplicar
    [Documentation]             va a la seccion Aplicaciones y desaplica la cobranza anterior
    log to console              Ir a Aplicaciones y Desaplicar
    click                       link=${num_comprobante}
    comprobantes_venta.Seleccionar Aplicaciones
    # Validaciones I
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="1"])[1]/div)[1]       2,500.50
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="3"])[1]/div)[1]       ${doc_destino}
    # desaplicar
    Select Checkbox             xpath=(//div[@class="webix_ss_center"]//input)[2]
    click                       xpath=//a[@id="APLICACIONDESVINCULAR_0"]
    Sleep  2s
    click                       xpath=//a[@id="APLICACIONSALIR_0"]
    Wait Until Element Is Not Visible       xpath=//div[@id="overDiv"]
    comprobantes_venta.Seleccionar Aplicaciones
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="1"])[1]/div)[1]       ${EMPTY}
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="3"])[1]/div)[1]       ${EMPTY}
    click                       xpath=//a[@id="APLICACIONSALIR_0"]
    Wait Until Element Is Not Visible       xpath=//div[@id="overDiv"]

TC_038
    [Documentation]         Desaplicar transacciones de venta
    KW_038.Filtra Hasta Fecha Actual
    KW_038.Setear Cliente
    KW_038.Grilla Productos
    KW_038.Guardar Factura
    KW_038.Cobrar Factura
    KW_038.Guardar Aplicar Factura
    KW_038.Ir a Aplicaciones y Desaplicar