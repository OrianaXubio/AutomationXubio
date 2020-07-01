*** Settings ***
Documentation       Filtra Hasta Fecha Actual
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_029.robot

Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_029
    [Documentation]                             Cobrar un comprobante de venta en dolares desde el comprobante de forma total con la misma cotización
    KW_029.Filtra Hasta Fecha Actual
    KW_029.Realiza una Nueva Venta
    KW_029.Agregar Productos
    KW_029.Guardar Factura
    KW_029.Comprobantes de Venta
    KW_029.Selecionar Factura
    KW_029.Cobrar Factura
    KW_029.Grilla Cobranza
    KW_029.Ir a Aplicaciones