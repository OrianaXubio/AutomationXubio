*** Settings ***
Documentation       Nueva venta
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../funciones_generales/common.robot
Resource            ../../../index.robot
Resource            ../../../01__ar/index_ar.robot
Resource            ../../../login/login.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Factura A Al Contado En Dolares
    recursos.Elegir Categoria de Empresa                 Monotributista
    vision_general.Validar Ingreso Al Sitio
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente         Responsable Inscripto   default     Factura     Tarjeta de Crédito

Agregar Productos
    sleep   2s
    comprobantes_venta.Agregar Item RI    1   Cinta papel (EX)         1       1256.9     0
    comprobantes_venta.Agregar Item RI    2   Crayones (EX)            1       3250       10
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_3']/div/div

Guardar Factura
    comprobantes_venta.Guardar

Validaciones
    assertText                                  xpath=//div[@name="wdg_TransaccionCVItems"]//th[8]/div[2]    Importe
    Page Should Not Contain Element             xpath=//div[@name="wdg_TransaccionCVItems"]//th[9]/div[2]
    comprobantes_venta.Letra Numero Comprobante       C
    comprobantes_venta.Total Bruto                    4181.9000
    comprobantes_venta.Total Impuestos                0.0000
    comprobantes_venta.Total                          4181.9000
    comprobantes_venta.Condicion De Pago              Tarjeta de Crédito

Cambiar Categoria de Empresa
    recursos.Elegir Categoria de Empresa                 Responsable Inscripto
    vision_general.Ir a Inicio