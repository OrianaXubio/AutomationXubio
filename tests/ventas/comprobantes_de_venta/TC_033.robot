*** Settings ***
Documentation       Realiza una Nueva Venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_033.robot

Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_033
    [Documentation]             Cobrar un comprobante de venta en dolares desde el comprobante de forma total con diferente cotización (mayor)
    ...                         y verificar la diferencia de cambio
    KW_033.Realiza una Nueva Venta
    KW_033.Agregar Productos
    KW_033.Guardar Factura
    KW_033.Cobrar Factura
    KW_033.Grilla Cobranza
    KW_033.Ir a Aplicaciones
    KW_033.Ir a Cobranza
    KW_033.Ir Aplicaciones-Cobranza