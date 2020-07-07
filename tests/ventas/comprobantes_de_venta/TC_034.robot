*** Settings ***
Documentation       Remitir factura de venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_034.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_034
    [Documentation]     Remitir factura de venta
    KW_034.Setear Cliente
    KW_034.Grilla Productos
    KW_034.Guardar Factura
    KW_034.Ir a Remitir
    KW_034.Guardar Factura II
    KW_034.Remito Ventas