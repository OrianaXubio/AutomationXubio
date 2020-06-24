*** Settings ***
Documentation       Creación de Informe Diario de Cierre Z
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_018.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    [Documentation]     login al sistema
    login.Login

TC_018
    [Documentation]     Creación de Informe Diario de Cierre Z con los items opcionales sin
    ...                 completar en cuenta corriente en pesos
    KW_018.Comprobante Recibo Z
    KW_018.Agregar Productos
    KW_018.Validaciones