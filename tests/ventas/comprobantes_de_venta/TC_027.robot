*** Settings ***
Documentation       Realizar una Venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_027.robot

Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_027
    [Documentation]             Cobrar un comprobante de venta en dolares desde el comprobante
    ...                         de forma parcial con la misma cotización
    KW_027.Realizar una Venta
    KW_027.Agregar Productos
    KW_027.Guardar
    KW_027.Cobrar Factura
    KW_027.Ir a Aplicaciones

