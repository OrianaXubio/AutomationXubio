*** Settings ***
Documentation       Factura de Crédito Mipyme A
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_021.robot

Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_021
    [Documentation]           Crear Factura de Crédito Mipyme A con remito asociado en cuenta corriente
    KW_021.Crear Nota de Credito MiPyMe A
    KW_021.Agregar Productos
    KW_021.Guardar
    KW_021.Validaciones
