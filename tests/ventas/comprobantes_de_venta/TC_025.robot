*** Settings ***
Documentation       Selecciona Fecha_Hasta
Library             SeleniumLibrary

Resource            ../../../front/login/login.robot
Resource            ../../../front/01__ar/02_ventas/comprobantes_venta/KW_025.robot

Suite Setup         setup.Ingresar Al Sitio
Suite Teardown      Close All Browsers

*** Test Cases ***
Login
    login.Login

TC_025
    [Documentation]                             Cobrar desde la grilla de comprobantes de venta masivamente y de distintos clientes
    KW_025.Selecciona Fecha_Hasta
    KW_025.Realiza Nueva Venta_1
    KW_025.Agregar Productos_1
    KW_025.Guardar_1
    KW_025.Realizar Nueva Venta_2
    KW_025.Agregar Productos_2
    KW_025.Guardar_2
    KW_025.Realizar Nueva Venta_3
    KW_025.Agregar Productos_3
    KW_025.Guardar_3
    KW_025.Ralizar busqueda
    KW_025.Seleccionar Facturas
    KW_025.Cobrar Factura
    KW_025.Validaciones
    KW_025.Detalle del proceso Pop-up