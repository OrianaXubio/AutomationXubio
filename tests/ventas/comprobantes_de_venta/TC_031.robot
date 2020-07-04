*** Settings ***
Documentation       Realiza una Nueva Venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_031.robot

Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_031
    [Documentation]                             Cobrar un comprobante de venta en dolares desde el comprobante de forma total con diferente cotización (menor)
    ...                                         y verificar la diferencia de cambio
    KW_031.Realiza una Nueva Venta
    KW_031.Agregar Productos
    KW_031.Guardar Factura
    KW_031.Cobrar Factura
    KW_031.Grilla Cobranza
    KW_031.Ir a Aplicaciones