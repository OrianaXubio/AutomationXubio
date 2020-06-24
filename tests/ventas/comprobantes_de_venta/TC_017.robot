*** Settings ***
Documentation       Informe Diario de Cierre Z
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_017.robot
Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_017
    [Documentation]             Creación de Informe Diario de Cierre Z con los items opcionales
    ...                         completos al contado en pesos
    KW_017.Informe Diario de Cierre Z
    KW_017.Agregar Productos
    KW_017.Grilla Instrumento de cobro
    KW_017.Guardar
    KW_017.Validaciones
