*** Settings ***
Documentation       Factura de Crédito Mipyme C
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_020.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_020
    [Documentation]         Crear Factura de Crédito Mipyme C sin remito asociado en cuenta corriente
    KW_020.Factura de Credito Mipyme C
    KW_020.Agregar Productos
    KW_020.Guardar Factura
    KW_020.Validaciones
    KW_020.Cambiar Categoria de Empresa