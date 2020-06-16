*** Settings ***
Documentation       Nueva venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_010.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_010
    KW_010.Nota de Credito A
    KW_010.Grilla Productos
    KW_010.Grilla Percepcion/Impuestos
    KW_010.Guardar Factura
    KW_010.Validaciones
    KW_010.Ir a Crear Nota de Credito
    KW_010.Ir a Aplicaciones
