*** Settings ***
Documentation       Cobrar un comprobante de venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_032.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_032
    [Documentation]     Cobrar un comprobante de venta en dolares desde el comprobante de forma parcial con
    ...                 diferente cotización (mayor) y verificar la diferencia de cambio
    KW_032.Cobrar Comprobante de Venta en Dolares
    KW_032.Grilla Productos
    KW_032.Guardar Factura
    KW_032.Cobrar en Dolares
    KW_032.Guardar Factura II
    KW_032.Validaciones en Aplicaciones
    KW_032.Comprobante Cobranza