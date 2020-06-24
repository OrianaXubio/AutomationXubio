*** Settings ***
Documentation       Creación de una Nota de Crédito A
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_011.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_011
    [Documentation]                 Creación de una Nota de Crédito A desde un nuevo comprobante
    ...                             con Condición de Ticket y percepciones
    KW_011.Nota de Credito
    KW_011.Agregar Productos
    KW_011.Grilla Percepcion/Impuestos
    KW_011.Guardar Factura
    KW_011.Validaciones