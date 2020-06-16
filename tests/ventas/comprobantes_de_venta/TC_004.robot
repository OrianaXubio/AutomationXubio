*** Settings ***
Documentation       Nueva venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_004.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_004
    KW_004.Factura A Al Contado En Dolares
    KW_004.Agregar Productos
    KW_004.Grilla Percepcion/Impuestos
    KW_004.Instrumentos de Cobro
    KW_004.Guardar Factura
    KW_004.Validaciones