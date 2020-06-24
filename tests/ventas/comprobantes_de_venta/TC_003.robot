*** Settings ***
Documentation       Creacion de una factura B a cliente del exterior
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_003.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_003
    [Documentation]         Creacion de una factura B a cliente del exterior con servicio prestado en el
    ...                     país con diferentes tasas de IVA en pesos
    KW_003.Factura B
    KW_003.Agregar Productos
    KW_003.Guardar Factura
    KW_003.Validaciones
