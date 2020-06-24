*** Settings ***
Documentation       Validación de último usado
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_016.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_016
    [Documentation]             Validación de último usado para el widget "Comprobante"
    # tc-15
    KW_016.Comprobante Recibo
    KW_016.Agregar Productos
    KW_016.Grilla Percepcion/Impuestos
    KW_016.Grilla Instrumento de cobro
    KW_016.Guardar Factura
    # validacion
    KW_016.Verificar Comprobante Sugerido
    # tc-01
    KW_016.Comprobante Factura
    KW_016.Agregar Productos
    KW_016.Grilla Percepcion/Impuestos
    KW_016.Guardar Factura
    # validacion
    KW_016.Verificar Comprobante Sugerido II
    # tc-11
    KW_016.Comprobante Nota de Credito
    KW_016.Agregar Productos
    KW_016.Grilla Percepcion/Impuestos
    KW_016.Guardar Factura
    KW_016.Ventana
    # validadion
    KW_016.Verificar Comprobante Sugerido II