*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Nota de Debito Mipyme C
    [Documentation]                         Creación de una Nota de Debito Mipyme C
    recursos.Elegir Categoria de Empresa    Monotributista
    vision_general.Validar Ingreso Al Sitio
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente         Responsable Inscripto   default   Nota de Débito MiPyME (FCE)    Cuenta Corriente

Agregar Productos
    [Documentation]                     se completan los campos de productos
    sleep   1s
    comprobantes_venta.Agregar Item RI    1   Cinta papel (EX)         1       1256.9     0
    comprobantes_venta.Agregar Item RI    2   Crayones (EX)            1       3250       10
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_3']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    comprobantes_venta.Guardar
    comprobantes_venta.Mas Opciones

Validaciones
    [Documentation]                     validacion de columnas importe, totalizadores, condicion de pago
    ...                                 y letra del comprobante
    comprobantes_venta.Letra Numero Comprobante     C
    comprobantes_venta.Condicion De Pago            Cuenta Corriente
    # verificacion de columna Importe
    assertText                                      xpath=//div[@name="wdg_TransaccionCVItems"]//th[8]/div[2]    Importe
    Page Should Not Contain Element                 xpath=//div[@name="wdg_TransaccionCVItems"]//th[9]/div[2]
    Validacion Columna Importe                      1       1,256.90
    Validacion Columna Importe                      2       2,925.00
    # Totalizadores
    comprobantes_venta.Total Bruto                  4181.9000
    comprobantes_venta.Total Impuestos              0.0000
    comprobantes_venta.Total                        4181.9000
    # verificacion de comprobante
    comprobantes_venta.Validacion Comprobante       Nota de Débito MiPyME (FCE)
    comprobantes_venta.Verificacion Comprobante Asociado
    comprobantes_venta.Varificacion Es Anulacion
    Reload Page

Cambiar Categoria de Empresa
    [Documentation]                     cambia la empresa a responsable inscripto
    Sleep   2s
    recursos.Elegir Categoria de Empresa            Responsable Inscripto