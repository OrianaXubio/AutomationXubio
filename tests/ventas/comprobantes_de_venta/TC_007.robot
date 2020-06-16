*** Settings ***
Documentation       Nueva venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_007.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_007
    KW_007.Empresa con Emision de factura-M
    KW_007.Factura M
    KW_007.Agregar Productos
    KW_007.Grilla Percepcion/Impuestos
    KW_007.Guardar Factura
    KW_007.Validaciones
    KW_007.Destildar Emito Factura M