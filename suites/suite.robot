*** Settings ***
Documentation       Suite de casos de pruebas de la seccion Ventas/Comprobantes de venta
Library             SeleniumLibrary

Resource            ../front/login/login.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_001.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_002.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_003.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_004.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_005.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_006.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_007.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_008.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_009.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_010.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_011.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_012.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_013.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_014.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_015.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_016.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_017.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_018.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_019.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_020.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_021.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_022.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_023.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_024.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_025.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_026.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_027.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_028.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_029.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_030.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_031.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_032.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_033.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_034.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_035.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_036.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_037.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_038.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_039.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_040.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_041.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_042.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_043.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_044.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_045.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_046.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_047.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_048.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_049.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_050.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_051.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_052.robot
Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_053.robot

Suite Setup         setup.Ingresar Al Sitio Login
Suite Teardown      Close All Browsers
Test Setup          Go To   ${URL}NXV/vision-general

*** Test Cases ***
TC_001
    [Documentation]         Creacion de una factura A en cuenta corriente con productos de
    ...                     distintas tasas de IVA en pesos argentinos
    [Tags]                  tc_001  suite
    KW_001.TC_001

TC_002
    [Documentation]         Creacion de una factura B al contado con diferentes tasas de IVA en pesos argentinos
    [Tags]                  tc_002  suite
    KW_002.TC_002

TC_003
    [Documentation]         Creacion de una factura B a cliente del exterior con servicio prestado en el
    ...                     país con diferentes tasas de IVA en pesos
    [Tags]                  tc_003  suite
    KW_003.TC_003

TC_004
    [Documentation]         Creacion de una factura A al contado con productos de distintas tasas de IVA en dólares
    [Tags]                  tc_004  suite
    KW_004.TC_004

TC_005
    [Documentation]         Creacion de una factura B en cuenta corriente con diferentes
    ...                     tasas de IVA en euros
    [Tags]                  tc_005  suite
    KW_005.TC_005

TC_006
    [Documentation]         Creacion de una factura C en Tarjeta de Crédito con productos exentos en pesos argentinos
    [Tags]                  tc_006  suite
    KW_006.TC_006

TC_007
    [Documentation]         Creación de una factura M en Tarjeta de Débito con productos con
    ...                     diferentes tasas de IVA en pesos argentinos
    [Tags]                  tc_007  suite
    KW_007.TC_007

TC_008
    [Documentation]         Creación de una factura E a un cliente del exterior con medio de pago
    ...                     Cheque con productos con diferentes tasas de IVA en pesos argentinos
    [Tags]                  tc_008  suite
    KW_008.TC_008

TC_009
    [Documentation]         Creación de una factura E a un cliente Responsable Inscripto con provincia
    ...                     destino tierra del fuego con medio de pago Otro con productos con diferentes
    ...                     tasas de IVA en pesos argentinos
    [Tags]                  tc_009  suite
    KW_009.TC_009

TC_010
    [Documentation]         Creación de una Nota de Crédito A desde una factura total en cuenta corriente
    [Tags]                  tc_010  suite
    KW_010.TC_010

TC_011
    [Documentation]         Creación de una Nota de Crédito A desde un nuevo comprobante
    ...                     con Condición de Ticket y percepciones
    [Tags]                  tc_011  suite
    KW_011.TC_011

TC_012
    [Documentation]         Creación de una Nota de Crédito A desde una factura total al contado en dólares
    [Tags]                  tc_012  suite
    KW_012.TC_012

TC_013
    [Documentation]         Creación de una Nota de Credito A
     ...                    desde una factura parcial en cuenta corriente
    [Tags]                  tc_013  suite
    KW_013.TC_013

TC_014
    [Documentation]         Creación de Nota de Débito B en cuenta corriente en dólares
    [Tags]                  tc_014  suite
    KW_014.TC_014

TC_015
    [Documentation]         Creación de Recibo A al contado en pesos
    [Tags]                  tc_015  suite
    KW_015.TC_015

TC_016
    [Documentation]         Validación de último usado para el widget "Comprobante"
    [Tags]                  tc_016  suite
    KW_16.TC_016

TC_017
    [Documentation]         Creación de Informe Diario de Cierre Z con los items opcionales
    ...                     completos al contado en pesos
    [Tags]                  tc_017  suite
    KW_017.TC_017

TC_018
    [Documentation]         Creación de Informe Diario de Cierre Z con los items opcionales sin
    ...                     completar en cuenta corriente en pesos
    [Tags]                  tc_018  suite
    KW_018.TC_018

TC_019
   [Documentation]          Crear Factura de Crédito Mipyme A con remito asociado en cuenta corriente
    [Tags]                  tc_019  suite
    KW_019.TC_019

TC_020
    [Documentation]         Crear Factura de Crédito Mipyme C sin remito asociado en cuenta corriente
    [Tags]                  tc-020  suite
    KW_020.TC_020

TC_021
    [Documentation]         Crear Factura de Crédito Mipyme A con remito asociado en cuenta corriente
    [Tags]                  tc_021  suite
    KW_021.TC_021

TC_022
    [Documentation]         Crear Nota de Crédito Mipyme C en cuenta corriente sin tildar es de anulación
    [Tags]                  tc_022  suite
    KW_022.TC_022

TC_023
    [Documentation]         Crear Nota de Débito Mipyme A en cuenta corriente
    [Tags]                  tc_023  suite
    KW_023.TC_023

TC_024
    [Documentation]         Crear Nota de Debito Mipyme C en cuenta corriente
    [Tags]                  tc_024  suite
    KW_024.TC_024

TC_025
    [Documentation]         Cobrar desde la grilla de comprobantes de venta masivamente y de distintos clientes
    [Tags]                  tc_025  suite
    KW_025.TC_025

TC_026
    [Documentation]         Cobrar un comprobante de venta en pesos desde el comprobante de forma parcial
    [Tags]                  tc_026  suite
    KW_026.TC_026

TC_027
    [Documentation]         Cobrar un comprobante de venta en dolares desde el comprobante
    ...                     de forma parcial con la misma cotización
    [Tags]                  tc_027      suite
    KW_027.TC_027

TC_028
    [Documentation]         Cobrar un comprobante de venta en pesos desde el comprobante de forma total
    [Tags]                  tc_028      suite
    KW_028.TC_028

TC_029
    [Documentation]         Cobrar un comprobante de venta en dolares desde el comprobante
    ...                     de forma total con la misma cotización
    [Tags]                  tc_029      suite
    KW_029.TC_029

TC_030
    [Documentation]         Cobrar un comprobante de venta en dolares desde el comprobante de forma parcial con
    ...                     diferente cotización (menor) y verificar la diferencia de cambio
    [Tags]                  tc_030      suite
    KW_030.TC_030

TC_031
    [Documentation]         Cobrar un comprobante de venta en dolares desde el comprobante de forma total con diferente cotización (menor)
    ...                     y verificar la diferencia de cambio
    [Tags]                  tc_031      suite
    KW_031.TC_031

TC_032
    [Documentation]         Cobrar un comprobante de venta en dolares desde el comprobante de forma parcial con
    ...                     diferente cotización (mayor) y verificar la diferencia de cambio
    [Tags]                  tc_032      suite
    KW_032.TC_032

TC_033
    [Documentation]         Cobrar un comprobante de venta en dolares desde el comprobante de forma total con diferente cotización (mayor)
    ...                     y verificar la diferencia de cambio
    [Tags]                  tc_033      suite
    KW_033.TC_033

TC_034
    [Documentation]         Remitir factura de venta
    [Tags]                  tc_034      suite
    KW_034.TC_034

TC_035
    [Documentation]         Adjuntar un archivo a un comprobante de venta
    [Tags]                  tc_035      suite
    KW_035.TC_035

TC_036
    [Documentation]         Eliminar un comprobante de venta aplicado
    [Tags]                  tc_036      suite
    KW_036.TC_036

TC_037
    [Documentation]         Eliminar un comprobante de venta sin aplicar
    [Tags]                  tc_037      suite
    KW_037.TC_037

TC_038
    [Documentation]         Desaplicar transacciones de venta
    [Tags]                  tc_038      suite   
    KW_038.TC_038

TC_039
    [Documentation]         Setear una lista de precios default y que aparezca al hacer un comprobante de venta
    [Tags]                  tc_039         nuevo
    KW_039.TC_039

TC_040
    [Documentation]         Importar facturas de venta desde excel
    [Tags]                  tc_040         nuevo
    KW_040.TC_040

TC_041
    [Documentation]         Importar facturas de venta desde .txt de AFIP
    [Tags]                  tc_041         nuevo
    KW_041.TC_041

TC_042
    [Documentation]         Verificar contabilidad de factura de Venta A en cuenta corriente en pesos
    [Tags]                  tc_042         nuevo
    KW_042.TC_042

TC_043
    [Documentation]         Verificar contabilidad de factura de Venta B al contado en pesos
    [Tags]                  tc_043         nuevo
    KW_043.TC_043

TC_044
    [Documentation]         Verificar contabilidad de factura de Venta E en cuenta corriente en dolares
    [Tags]                  tc_044         nuevo
    KW_044.TC_044

TC_045
    [Documentation]         Verificar contabilidad de factura de Venta M al contado en pesos
    [Tags]                  tc_045         nuevo
    KW_045.TC_045

TC_046
    [Documentation]         Verificar contabilidad de nota de Credito de venta A con condición de pago ticket en pesos
    [Tags]                  tc_046         nuevo
    KW_046.TC_046

TC_047
    [Documentation]         Verificar contabilidad de nota de Debito de venta B en cuenta corriente en dólares
    [Tags]                  tc_047         nuevo
    KW_047.TC_047

TC_048
    [Documentation]         Verficar contabilidad de un informe diario de cierre Z en pesos
    [Tags]                  tc_048
    KW_048.TC_048

TC_049
    [Documentation]         Verificar contabilidad de Recibo de venta A al contado en pesos
    [Tags]                  tc_049      nuevo
    KW_049.TC_049

TC_050
    [Documentation]         Verificar contabilidad de factura de Venta C en tarjeta de crédito en pesos
    [Tags]                  tc_050      nuevo
    KW_050.TC_050

TC_051
    [Documentation]         Verificar correlatividad en punto de venta con talonario unificado
    [Tags]                  tc_051      nuevo
    KW_051.TC_051

TC_052
    [Documentation]         Verificar correlatividad en punto de venta con talonario no unificado
    [Tags]                  tc_052      nuevo
    KW_052.TC_052

TC_053
    [Documentation]         Verificar grilla de comprobantes de venta después de crear cuatro tipos de comprobantes
    [Tags]                  tc_053      nuevo
    KW_053.TC_053
