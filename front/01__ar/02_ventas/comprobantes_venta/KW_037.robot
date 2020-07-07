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
    log to console                                      Realiza una Nueva Venta
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                     Monotributista   default   Nota de Débito   Cuenta Corriente
    #Guarda el nº de comprobante
    ${num_comprobante}      Get value                   xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                                 ${num_comprobante}

Agregar Productos
    [Documentation]                                    Se Completa la grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item CF                 1   Carpeta         1      2500.50     0
    click                                              xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura
      comprobantes_venta.Guardar

Cobrar Factura
    [Documentation]                                     Ingresa a la seccion "Cobrar" en el menu superior
    sleep                                               1s
    comprobantes_venta.Ir a Cobrar
    click                                              xpath=//td//a[@id='ACEPTAR_0']

Grilla Cobranza
    [Documentation]                                                 Completa los campos "Tipo de cuenta" y "Cuenta"
    comprobantes_venta.Completar Campos en Grilla Cobro             1           Banco            Banco Galicia
    #Hace click en Guardar
    click                                                           xpath=//div[@id='df_popup']//a[@id='_onSave']
    #Valida que el Pop-up se haya cerrado
    Wait Until Element Is Not Visible                               xpath=//div[@id='df_popup']

Eliminar Factura
    [Documentation]                                                 selecciona el boton "Eliminar" dentro de la factura
    click                                                           xpath=//div//a[@id='_onDelete']
    #confirma la operacion
    Page Should Contain Element                                     xpath=//div[@class='FAFPopup']
    click                                                           xpath=//div[@class='FAFPopup']//a[@id='showAskPopupYesButton']
    sleep    2s

Buscar Factura Eliminada
     [Documentation]                                                 Busca la factura eliminada en el buscador de "comprobantes de Venta"
     comprobantes_venta.Ir a Comprobantes de Venta
     sleep     2s
     sendKeys                                                       xpath=//div[@botonid="Buscar"]//input        ${num_comprobante}
     #Verifica que no se encontro la factura
     assertText                                                     xpath=//div[@class='dock']                 No se encontraron registros.
