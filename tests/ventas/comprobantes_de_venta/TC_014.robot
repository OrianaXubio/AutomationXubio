*** Settings ***
Documentation       Creación de Nota de Débito B
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_014.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_014
    [Documentation]                 Creación de Nota de Débito B en cuenta corriente en dólares
    KW_014.Nota de Debito B en Dolares
    KW_014.Grilla Productos
    KW_014.Guardar Factura
    KW_014.Validaciones