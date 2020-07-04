*** Settings ***
Documentation       Realiza una Nueva Venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_035.robot

Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_035
    [Documentation]             Adjuntar un archivo a un comprobante de venta
    KW_035.Realiza una Nueva Venta
    KW_035.Agregar Productos
    KW_035.Guardar Factura
    KW_035.Adjuntar Archivo
    KW_035.Validacion Adjuntar Archivo