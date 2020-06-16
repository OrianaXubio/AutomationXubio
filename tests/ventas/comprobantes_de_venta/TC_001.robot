*** Settings ***
Documentation       Nueva venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_001.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_001
    KW_001.Factura A
    KW_001.Agregar Productos
    KW_001.Grilla Percepcion/Impuestos
    KW_001.Guardar Factura
    KW_001.Validaciones