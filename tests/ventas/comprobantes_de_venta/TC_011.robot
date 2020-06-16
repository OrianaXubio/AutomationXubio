*** Settings ***
Documentation       Nueva venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_011.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_011
    KW_011.Nota de Credito
    KW_011.Agregar Productos
    KW_011.Grilla Percepcion/Impuestos
    KW_011.Guardar Factura
    KW_011.Validaciones