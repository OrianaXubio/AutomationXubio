*** Settings ***
Documentation       Nota de Debito Mipyme C
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_024.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_024
    [Documentation]         Crear Nota de Debito Mipyme C en cuenta corriente
    KW_024.Nota de Debito Mipyme C
    KW_024.Agregar Productos
    KW_024.Guardar Factura
    KW_024.Validaciones
    KW_024.Cambiar Categoria de Empresa