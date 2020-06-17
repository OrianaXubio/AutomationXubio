*** Settings ***
Documentation       Nueva venta
Library             SeleniumLibrary

Resource            ../front/login/login.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_001.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_002.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_003.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_004.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_005.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_006.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_007.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_008.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_009.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_010.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_011.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_012.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close Browser


*** Test Cases ***
Login
    login.Login

TC_001
    KW_001.Factura A
    KW_001.Agregar Productos
    KW_001.Grilla Percepcion/Impuestos
    KW_001.Guardar Factura
    KW_001.Validaciones

TC_002
    KW_002.Factura B
    KW_002.Grilla Productos
    KW_002.Grilla Percepcion/Impuestos
    KW_002.Instrumentos de Cobro
    KW_002.Guardar Factura
    KW_002.Validaciones

TC_003
    KW_003.Factura B
    KW_003.Agregar Productos
    KW_003.Guardar Factura
    KW_003.Validaciones

TC_004
    KW_004.Factura A Al Contado En Dolares
    KW_004.Agregar Productos
    KW_004.Grilla Percepcion/Impuestos
    KW_004.Instrumentos de Cobro
    KW_004.Guardar Factura
    KW_004.Validaciones

TC_005
    [Documentation]                         Creación de una factura B con Cuenta Corriente
    [Tags]                                  faturaB_Cta.CTe
    KW_005.Factura B_CuentaCorriente
    KW_005.Agregar Productos
    KW_005.Grilla Percepcion/Impuestos
    KW_005.Guardar Factura
    KW_005.Validaciones

TC_006
    KW_006.Factura A Al Contado En Dolares
    KW_006.Agregar Productos
    KW_006.Guardar Factura
    KW_006.Validaciones
    KW_006.Cambiar Categoria de Empresa

TC_007
    KW_007.Empresa con Emision de factura-M
    KW_007.Factura M
    KW_007.Agregar Productos
    KW_007.Grilla Percepcion/Impuestos
    KW_007.Guardar Factura
    KW_007.Validaciones
    KW_007.Destildar Emito Factura M

TC_008
    KW_008.Factura E
    KW_008.Grilla Productos
    KW_008.Instrumentos de Cobro
    KW_008.Guardar Factura
    KW_008.Validaciones

TC_009
    KW_009.Factura E ClienteExterior
    KW_009.Agregar Productos
    KW_009.Guardar Factura
    KW_009.Validaciones

TC_010
    KW_010.Nota de Credito A
    KW_010.Grilla Productos
    KW_010.Grilla Percepcion/Impuestos
    KW_010.Guardar Factura
    KW_010.Validaciones
    KW_010.Ir a Crear Nota de Credito
    KW_010.Ir a Aplicaciones

TC_011
    KW_011.Nota de Credito
    KW_011.Agregar Productos
    KW_011.Grilla Percepcion/Impuestos
    KW_011.Guardar Factura
    KW_011.Validaciones

TC_012
    KW_012.Factura A Al Contado En Dolares
    KW_012.Agregar Productos
    KW_012.Grilla Percepcion/Impuestos
    KW_012.Instrumentos de Cobro
    KW_012.Guardar Factura
    KW_012.Validaciones
    KW_012.Ir a Crear Nota de Credito
    KW_012.Instrumentos de Cobro (ventana)
    KW_012.Guardar (ventana)