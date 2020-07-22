*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
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
    # Se guarda el numero de comprobante en una variable
    ${num_comprobante}      Get value           xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                         ${num_comprobante}

Ir a Menu Cobrar
    log to console                      Ir a Menu Cobrar
    comprobantes_venta.Seleccionar Cobrar
    click                               id=ACEPTAR_0
    comprobantes_venta.Completar Campos en Grilla Cobro     1       Banco       Banco Galicia
    # guarda el numero de factura
    ${doc_destino}      Get value                                   xpath=//div[@id='df_popup']//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                                             ${doc_destino}
    log to console      Numero de recibo: ${doc_destino}

Guardar Factura II
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura popup
    click                               xpath=//div[@id="df_popup"]//a[@id="_onSave"]
    Wait Until Page Does Not Contain Element      xpath=//div[@id="df_popup"]

Eliminar el Comprobante Generado
    log to console                      Eliminar el Comprobante Generado
    comprobantes_venta.Ir a Comprobantes de Venta
    comprobantes_venta.Buscador         ${num_comprobante}
    Select Checkbox                     xpath=//div[@class="webix_cell"][1]//input
    comprobantes_venta.Eliminar Comprobante De Venta

Verificar Cobranza
    log to console                      Verificar Cobranza
    comprobantes_venta.Ir A Cobranzas
    comprobantes_venta.Buscador         ${doc_destino}
    click                               link=${doc_destino}
    Wait Until Element Is Visible       xpath=//a[@id="Tesoreria_openVinculacionCuentaCorriente"]
    click                               link=Aplicaciones
    assertText      xpath=((//div[@id="overDiv"]//div[@class="fafwebreport"]//div[@column="1"])[1]/div)[1]       ${EMPTY}
    Wait Until Element Is Visible       xpath=//div[@id="overDiv"]
    click                               xpath=//a[@id="APLICACIONSALIR_0"]

TC_036
    [Documentation]         Eliminar un comprobante de venta aplicado
    KW_036.Setear Cliente
    KW_036.Grilla Productos
    KW_036.Guardar Factura
    KW_036.Ir a Menu Cobrar
    KW_036.Guardar Factura II
    KW_036.Eliminar el Comprobante Generado
    KW_036.Verificar Cobranza