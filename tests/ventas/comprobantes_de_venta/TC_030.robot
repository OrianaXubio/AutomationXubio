*** Settings ***
Documentation       Cobrar un comprobante de venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_030.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_030
    [Documentation]     Cobrar un comprobante de venta en dolares desde el comprobante de forma parcial con
    ...                 diferente cotización (menor) y verificar la diferencia de cambio
    KW_030.Cobrar Comprobante de Venta en Dolares
    KW_030.Grilla Productos
    KW_030.Guardar Factura
    KW_030.Cobrar en Dolares
    KW_030.Guardar Factura II
    KW_030.Validaciones en Aplicaciones
