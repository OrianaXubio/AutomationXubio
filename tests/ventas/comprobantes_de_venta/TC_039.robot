*** Settings ***
Documentation       Ir a Lista de Precios
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_039.robot

Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_039
    [Documentation]         Setear una lista de precios default y que aparezca al hacer un comprobante de venta
    KW_039.Ir a Lista de Precios
    KW_039.Ir a Comprobantes de Venta
    KW_039.Agregar Producto
    KW_039.Ir a Lista de Precios_2
   
