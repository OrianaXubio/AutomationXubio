*** Settings ***
Documentation       Realiza una Nueva Venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_037.robot

Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_037
    [Documentation]           Eliminar un comprobante de venta sin aplicar
    KW_037.Realiza una Nueva Venta
    KW_037.Agregar Productos
    KW_037.Guardar Factura
    KW_037.Cobrar Factura
    KW_037.Grilla Cobranza
    KW_037.Eliminar Factura
    KW_037.Buscar Factura Eliminada