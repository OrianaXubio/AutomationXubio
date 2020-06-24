*** Settings ***
Documentation       Nota de Débito Mipyme A
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_023.robot

Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_023
    [Documentation]     Crear Nota de Débito Mipyme A en cuenta corriente
    KW_023.Crear Nota de Debito MiPyMe A
    KW_023.Agregar Productos
    KW_023.Guardar
    KW_023.Validaciones
