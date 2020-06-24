*** Settings ***
Documentation       Creación de una factura E a un cliente del exterior
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_008.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_008
    [Documentation]         Creación de una factura E a un cliente del exterior con medio de pago
    ...                     Cheque con productos con diferentes tasas de IVA en pesos argentinos
    KW_008.Factura E
    KW_008.Grilla Productos
    KW_008.Instrumentos de Cobro
    KW_008.Guardar Factura
    KW_008.Validaciones
