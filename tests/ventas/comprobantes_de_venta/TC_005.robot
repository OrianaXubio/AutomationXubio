*** Settings ***
Documentation       Nueva venta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_005.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_005
    [Documentation]                         Creación de una factura B con Cuenta Corriente
    [Tags]                                  faturaB_Cta.CTe
    KW_005.Factura B_CuentaCorriente
    KW_005.Agregar Productos
    KW_005.Grilla Percepcion/Impuestos
    KW_005.Guardar Factura
    KW_005.Validaciones
