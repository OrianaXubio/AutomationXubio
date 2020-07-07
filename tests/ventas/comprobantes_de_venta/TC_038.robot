*** Settings ***
Documentation       Desaplicar transacciones de venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_038.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_038
    [Documentation]         Desaplicar transacciones de venta
    KW_038.Filtra Hasta Fecha Actual
    KW_038.Setear Cliente
    KW_038.Grilla Productos
    KW_038.Guardar Factura
    KW_038.Cobrar Factura
    KW_038.Guardar Aplicar Factura
    KW_038.Ir a Aplicaciones y Desaplicar