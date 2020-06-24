*** Settings ***
Documentation       Creación de Recibo A
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_015.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_015
    [Documentation]             Creación de Recibo A al contado en pesos
    KW_015.Recibo A
    KW_015.Agregar Productos
    KW_015.Grilla Percepcion/Impuestos
    KW_015.Grilla Instrumento de cobro
    KW_015.Guardar
    KW_015.Validaciones





