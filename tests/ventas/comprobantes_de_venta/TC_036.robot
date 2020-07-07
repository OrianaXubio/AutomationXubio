*** Settings ***
Documentation       Eliminar un comprobante de venta aplicado
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_036.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_036
    [Documentation]         Eliminar un comprobante de venta aplicado
    KW_036.Setear Cliente
    KW_036.Grilla Productos
    KW_036.Guardar Factura
    KW_036.Ir a Menu Cobrar
    KW_036.Guardar Factura II
    KW_036.Eliminar el Comprobante Generado
    KW_036.Verificar Cobranza