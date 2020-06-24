*** Settings ***
Documentation       Creación de una factura E a un cliente Responsable Inscripto
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_009.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_009
    [Documentation]             Creación de una factura E a un cliente Responsable Inscripto con provincia
    ...                         destino tierra del fuego con medio de pago Otro con productos con diferentes
    ...                         tasas de IVA en pesos argentinos
    KW_009.Factura E ClienteExterior
    KW_009.Agregar Productos
    KW_009.Guardar Factura
    KW_009.Validaciones