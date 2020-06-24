*** Settings ***
Documentation       Creacion de una factura B al contado
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_002.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_002
    [Documentation]         Creacion de una factura B al contado con diferentes tasas de IVA en pesos argentinos
    KW_002.Factura B
    KW_002.Grilla Productos
    KW_002.Grilla Percepcion/Impuestos
    KW_002.Instrumentos de Cobro
    KW_002.Guardar Factura
    KW_002.Validaciones