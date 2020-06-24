*** Settings ***
Documentation       Creación de una factura M en Tarjeta de Débito
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_007.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_007
    [Documentation]             Creación de una factura M en Tarjeta de Débito con productos con
    ...                         diferentes tasas de IVA en pesos argentinos
    KW_007.Empresa con Emision de factura-M
    KW_007.Factura M
    KW_007.Agregar Productos
    KW_007.Grilla Percepcion/Impuestos
    KW_007.Guardar Factura
    KW_007.Validaciones
    KW_007.Destildar Emito Factura M