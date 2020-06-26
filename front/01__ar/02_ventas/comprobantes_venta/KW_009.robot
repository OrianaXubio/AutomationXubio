*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Factura E ClienteExterior
    [Documentation]                     creacion de una factura E
    log to console                      Factura E ClienteExterior
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente           Responsable Inscripto    default     Factura     Otra
    #Más Opciones - Provincia Destrino: Tierra del fuego
    click                                     xpath=//input[@value='Más Opciones']
    click                                     xpath=//div[@id='masOpcionesWrapper']/div[13]/div/div[2]/div/div/a/span
    click                                     xpath=//tr[23]/td

Agregar Productos
    [Documentation]                     se completan los campos de productos
    log to console                      Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item RI    1   Honorarios      1       5000        0
    comprobantes_venta.Agregar Item RI    2   Alquiler        1       16985       10
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_3']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura
    comprobantes_venta.Guardar

Validaciones
    [Documentation]                     validacion de columnas importe, totalizadores
    ...                                 letra del comprobante y provincia
    log to console                      Validaciones
    comprobantes_venta.Letra Numero Comprobante       E
    #verificar que la opcion sea Tierra del Fuego
    Page Should Contain Element               xpath=//div[@name='wdg_Provincia']//input[@value="Tierra del Fuego"]
    #Columna Importe
    assertText                                xpath=//td[@id='TransaccionCVItems_Importe_1']/div           5,000.00
    assertText                                xpath=//td[@id='TransaccionCVItems_Importe_2']/div           15,286.50
    #Verificacion de los totales
    comprobantes_venta.Total Bruto             20286.5000
    comprobantes_venta.Total Impuestos         0.0000
    comprobantes_venta.Total                   20286.5000
