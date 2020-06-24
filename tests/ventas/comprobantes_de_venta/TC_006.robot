*** Settings ***
Documentation       Creacion de una factura C en Tarjeta de Crédito
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_006.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_006
    [Documentation]         Creacion de una factura C en Tarjeta de Crédito con productos exentos en pesos argentinos
    KW_006.Factura C
    KW_006.Agregar Productos
    KW_006.Guardar Factura
    KW_006.Validaciones
    KW_006.Cambiar Categoria de Empresa