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
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente         Monotributista   default   Nota de Débito    Cuenta Corriente

Agregar Productos
    [Documentation]                     se completan los campos de productos
    log to console              Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item RI    1   Carpeta         1       2500.50     0
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
    comprobantes_venta.Ir a Nueva Venta
