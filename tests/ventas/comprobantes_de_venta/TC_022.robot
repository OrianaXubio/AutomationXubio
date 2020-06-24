*** Settings ***
Documentation       Nota de Crédito Mipyme C
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_022.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_022
    [Documentation]         Crear Nota de Crédito Mipyme C en cuenta corriente sin tildar es de anulación
    KW_022.Nota de Credito Mipyme C
    KW_022.Agregar Productos
    KW_022.Guardar Factura
    KW_022.Validaciones
    KW_022.Cambiar Categoria de Empresa