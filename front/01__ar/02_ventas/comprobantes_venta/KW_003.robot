*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../funciones_generales/common.robot
Resource            ../../../index.robot
Resource            ../../../01__ar/index_ar.robot
Resource            ../../../login/login.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot

*** Keywords ***
Factura B
    [Documentation]                Creación de factura B con Cliente Exterior
    Log To Console                  Factura B
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente          Cliente del exterior      default     Factura     Tarjeta de Débito
    sleep                          1s
    # Mas Opciones - Servicios prestados en el país para un sujeto del exterior
    comprobantes_venta.Mas Opciones
    Select Checkbox                      xpath=//div[@name='wdg_FacturaNoExportacion']//input

Agregar Productos
    [Documentation]                     se completan los campos de productos
    Log To Console                      Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item CF    1   Carpeta         1       2500.50     0
    comprobantes_venta.Agregar Item CF    2   Alquiler        1       16500       10
    comprobantes_venta.Agregar Item CF    3   Cinta Papel     2.5     500         0
    comprobantes_venta.Agregar Item CF    4   Goma de borrar  4       120         0
    comprobantes_venta.Agregar Item CF    5   Carátulas       7       25          0
    comprobantes_venta.Agregar Item CF    6   Carátulas       2       -25         0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_7']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    Log To Console                      Guardar Factura
    comprobantes_venta.Guardar

Validaciones
    [Documentation]                     validacion de columnas importe, totalizadores, letra del comprobante
    ...                                 y checkbox servicios prestados
    Log To Console                      Validaciones
    #Validacion Columna Importe
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_1']/div    2,500.50
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_2']/div    14,850.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_3']/div    1,250.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_4']/div    480.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_5']/div    175.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteConIvaIncluido_6']/div    -50.00
    comprobantes_venta.Letra Numero Comprobante       B
    #Validación de Inportes Totales
    comprobantes_venta.Total Bruto                    16070.7200
    comprobantes_venta.Total Impuestos                3134.7800
    comprobantes_venta.Total                          19205.5000
    #Validación del Checkbox
    Checkbox Should Be Selected                 xpath=//div[@name='wdg_FacturaNoExportacion']//input

TC_003
    [Documentation]         Creacion de una factura B a cliente del exterior con servicio prestado en el
    ...                     país con diferentes tasas de IVA en pesos
    KW_003.Factura B
    KW_003.Agregar Productos
    KW_003.Guardar Factura
    KW_003.Validaciones