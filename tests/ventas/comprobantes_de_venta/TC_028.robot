*** Settings ***
Documentation       Cobrar un comprobante de venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_028.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_028
    [Documentation]         Cobrar un comprobante de venta en pesos desde el comprobante de forma total
    KW_028.Cobrar un comprobante de venta
    KW_028.Agregar Productos
    KW_028.Guardar Factura
    KW_028.Cobrar Desde Comprobante De Forma Total
    KW_028.Guardar Factura II
    KW_028.Validaciones en Aplicaciones