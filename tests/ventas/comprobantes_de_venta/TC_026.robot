*** Settings ***
Documentation       Cobrar un comprobante de venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_026.robot
Suite Setup         setup.Ingresar Al Sitio
#Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_026
    [Documentation]         Cobrar un comprobante de venta en pesos desde el comprobante de forma parcial
    KW_026.Cobrar un comprobante de venta
    KW_026.Agregar Productos
    KW_026.Guardar Factura
    KW_026.Ir a Seccion Cobrar
    KW_026.Ir a Aplicaciones
