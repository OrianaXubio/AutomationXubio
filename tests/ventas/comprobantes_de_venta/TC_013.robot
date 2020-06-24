*** Settings ***
Documentation       Nueva venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_013.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login


TC_013
    [Documentation]  Creación de una Nota de Credito A
     ...             desde una factura parcial en cuenta corriente
    KW_013.Factura A
    KW_013.Agregar Productos
    KW_013.Grilla Percepcion/Impuestos
    KW_013.Guardar Factura
    KW_013.Nota de Credito
    KW_013.Agregar Producto en Popup
    KW_013.Aplicaciones
    KW_013.Campos de Aplicaciones
    KW_013.Salir de la Aplicaciones
