*** Settings ***
Documentation       Creación de una Nota de Crédito A
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_012.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_012
    [Documentation]                     Creación de una Nota de Crédito A desde una factura total al contado en dólares
    KW_012.Factura A Al Contado En Dolares
    KW_012.Agregar Productos
    KW_012.Grilla Percepcion/Impuestos
    KW_012.Instrumentos de Cobro
    KW_012.Guardar Factura
    KW_012.Validaciones
    KW_012.Ir a Crear Nota de Credito
    KW_012.Instrumentos de Cobro (ventana)
    KW_012.Guardar (ventana)