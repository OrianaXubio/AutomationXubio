*** Settings ***
Documentation       Factura de Crédito Mipyme A
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_019.robot

Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_019
   [Documentation]           Crear Factura de Crédito Mipyme A con remito asociado en cuenta corriente
    KW_019.Factura de Credito Mipyme A
    KW_019.Agregar Productos
    KW_019.Seleccionar Remitos Asociados
    KW_019.Validaciones