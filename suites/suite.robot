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
# Resource            ../front/01__ar/02_ventas/comprobantes_venta/KW_039.robot

Suite Setup         setup.Ingresar Al Sitio Login
Suite Teardown      Close All Browsers
Test Setup          Go To   ${URL}NXV/vision-general

*** Test Cases ***
TC_001
    [Documentation]         Creacion de una factura A en cuenta corriente con productos de
    ...                     distintas tasas de IVA en pesos argentinos
    [Tags]          suite
    KW_001.Factura A
    KW_001.Agregar Productos
    KW_001.Grilla Percepcion/Impuestos
    KW_001.Guardar Factura
    KW_001.Validaciones

TC_002
    [Documentation]         Creacion de una factura B al contado con diferentes tasas de IVA en pesos argentinos
    [Tags]          suite
    KW_002.Factura B
    KW_002.Grilla Productos
    KW_002.Grilla Percepcion/Impuestos
    KW_002.Instrumentos de Cobro
    KW_002.Guardar Factura
    KW_002.Validaciones

TC_003
    [Documentation]         Creacion de una factura B a cliente del exterior con servicio prestado en el
    ...                     país con diferentes tasas de IVA en pesos
    KW_003.Factura B
    KW_003.Agregar Productos
    KW_003.Guardar Factura
    KW_003.Validaciones

TC_004
    [Documentation]         Creacion de una factura A al contado con productos de distintas tasas de IVA en dólares
    KW_004.Factura A Al Contado En Dolares
    KW_004.Agregar Productos
    KW_004.Grilla Percepcion/Impuestos
    KW_004.Instrumentos de Cobro
    KW_004.Guardar Factura
    KW_004.Validaciones

TC_005
    [Documentation]         Creacion de una factura B en cuenta corriente con diferentes
    ...                     tasas de IVA en euros
    [Tags]                                  faturaB_Cta.CTe
    KW_005.Factura B_CuentaCorriente
    KW_005.Agregar Productos
    KW_005.Grilla Percepcion/Impuestos
    KW_005.Guardar Factura
    KW_005.Validaciones

TC_006
    [Documentation]         Creacion de una factura C en Tarjeta de Crédito con productos exentos en pesos argentinos
    KW_006.Factura C
    KW_006.Agregar Productos
    KW_006.Guardar Factura
    KW_006.Validaciones
    KW_006.Cambiar Categoria de Empresa

TC_007
    [Documentation]         Creación de una factura M en Tarjeta de Débito con productos con
    ...                     diferentes tasas de IVA en pesos argentinos
    KW_007.Empresa con Emision de factura-M
    KW_007.Factura M
    KW_007.Agregar Productos
    KW_007.Grilla Percepcion/Impuestos
    KW_007.Guardar Factura
    KW_007.Validaciones
    KW_007.Destildar Emito Factura M

TC_008
    [Documentation]         Creación de una factura E a un cliente del exterior con medio de pago
    ...                     Cheque con productos con diferentes tasas de IVA en pesos argentinos
    KW_008.Factura E
    KW_008.Grilla Productos
    KW_008.Instrumentos de Cobro
    KW_008.Guardar Factura
    KW_008.Validaciones

TC_009
    [Documentation]         Creación de una factura E a un cliente Responsable Inscripto con provincia
    ...                     destino tierra del fuego con medio de pago Otro con productos con diferentes
    ...                     tasas de IVA en pesos argentinos
    KW_009.Factura E ClienteExterior
    KW_009.Agregar Productos
    KW_009.Guardar Factura
    KW_009.Validaciones

TC_010
    [Documentation]         Creación de una Nota de Crédito A desde una factura total en cuenta corriente
    KW_010.Nota de Credito A
    KW_010.Grilla Productos
    KW_010.Grilla Percepcion/Impuestos
    KW_010.Guardar Factura
    KW_010.Validaciones
    KW_010.Ir a Crear Nota de Credito
    KW_010.Ir a Aplicaciones

TC_011
    [Documentation]         Creación de una Nota de Crédito A desde un nuevo comprobante
    ...                     con Condición de Ticket y percepciones
    KW_011.Nota de Credito
    KW_011.Agregar Productos
    KW_011.Grilla Percepcion/Impuestos
    KW_011.Guardar Factura
    KW_011.Validaciones

TC_012
    [Documentation]         Creación de una Nota de Crédito A desde una factura total al contado en dólares
    KW_012.Factura A Al Contado En Dolares
    KW_012.Agregar Productos
    KW_012.Grilla Percepcion/Impuestos
    KW_012.Instrumentos de Cobro
    KW_012.Guardar Factura
    KW_012.Validaciones
    KW_012.Ir a Crear Nota de Credito
    KW_012.Instrumentos de Cobro (ventana)
    KW_012.Guardar (ventana)

TC_013
    [Documentation]             Creación de una Nota de Credito A
     ...                        desde una factura parcial en cuenta corriente
    KW_013.Factura A
    KW_013.Agregar Productos
    KW_013.Grilla Percepcion/Impuestos
    KW_013.Guardar Factura
    KW_013.Nota de Credito
    KW_013.Agregar Producto en Popup
    KW_013.Aplicaciones
    KW_013.Campos de Aplicaciones
    KW_013.Salir de la Aplicaciones

TC_014
    [Documentation]             Creación de Nota de Débito B en cuenta corriente en dólares
    KW_014.Nota de Debito B en Dolares
    KW_014.Grilla Productos
    KW_014.Guardar Factura
    KW_014.Validaciones

TC_015
    [Documentation]             Creación de Recibo A al contado en pesos
    KW_015.Recibo A
    KW_015.Agregar Productos
    KW_015.Grilla Percepcion/Impuestos
    KW_015.Grilla Instrumento de cobro
    KW_015.Guardar
    KW_015.Validaciones

TC_016
    [Documentation]             Validación de último usado para el widget "Comprobante"
    # tc-15
    KW_016.Comprobante Recibo
    KW_016.Agregar Productos
    KW_016.Grilla Percepcion/Impuestos
    KW_016.Grilla Instrumento de cobro
    KW_016.Guardar Factura
    # validacion
    KW_016.Verificar Comprobante Sugerido
    # tc-01
    KW_016.Comprobante Factura
    KW_016.Agregar Productos
    KW_016.Grilla Percepcion/Impuestos
    KW_016.Guardar Factura
    # validacion
    KW_016.Verificar Comprobante Sugerido II
    # tc-11
    KW_016.Comprobante Nota de Credito
    KW_016.Agregar Productos
    KW_016.Grilla Percepcion/Impuestos
    KW_016.Guardar Factura
    KW_016.Ventana
    # validadion
    KW_016.Verificar Comprobante Sugerido II

TC_017
    [Documentation]             Creación de Informe Diario de Cierre Z con los items opcionales
    ...                         completos al contado en pesos
    KW_017.Informe Diario de Cierre Z
    KW_017.Agregar Productos
    KW_017.Grilla Instrumento de cobro
    KW_017.Guardar
    KW_017.Validaciones

TC_018
    [Documentation]             Creación de Informe Diario de Cierre Z con los items opcionales sin
    ...                         completar en cuenta corriente en pesos
    KW_018.Comprobante Recibo Z
    KW_018.Agregar Productos
    KW_018.Validaciones

TC_019
   [Documentation]           Crear Factura de Crédito Mipyme A con remito asociado en cuenta corriente
    KW_019.Factura de Credito Mipyme A
    KW_019.Agregar Productos
    KW_019.Seleccionar Remitos Asociados
    KW_019.Guardar
    KW_019.Validaciones

TC_020
    [Documentation]         Crear Factura de Crédito Mipyme C sin remito asociado en cuenta corriente
    KW_020.Factura de Credito Mipyme C
    KW_020.Agregar Productos
    KW_020.Guardar Factura
    KW_020.Validaciones
    KW_020.Cambiar Categoria de Empresa

TC_021
    [Documentation]           Crear Factura de Crédito Mipyme A con remito asociado en cuenta corriente
    KW_021.Crear Nota de Credito MiPyMe A
    KW_021.Agregar Productos
    KW_021.Guardar
    KW_021.Validaciones

TC_022
    [Documentation]         Crear Nota de Crédito Mipyme C en cuenta corriente sin tildar es de anulación
    KW_022.Nota de Credito Mipyme C
    KW_022.Agregar Productos
    KW_022.Guardar Factura
    KW_022.Validaciones
    KW_022.Cambiar Categoria de Empresa

TC_023
    [Documentation]     Crear Nota de Débito Mipyme A en cuenta corriente
    KW_023.Crear Nota de Debito MiPyMe A
    KW_023.Agregar Productos
    KW_023.Guardar
    KW_023.Validaciones

TC_024
    [Documentation]         Crear Nota de Debito Mipyme C en cuenta corriente
    KW_024.Nota de Debito Mipyme C
    KW_024.Agregar Productos
    KW_024.Guardar Factura
    KW_024.Validaciones
    KW_024.Cambiar Categoria de Empresa

TC_025
    [Documentation]        Cobrar desde la grilla de comprobantes de venta masivamente y de distintos clientes
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

TC_026
    [Documentation]         Cobrar un comprobante de venta en pesos desde el comprobante de forma parcial
    KW_026.Cobrar un comprobante de venta
    KW_026.Agregar Productos
    KW_026.Guardar Factura
    KW_026.Ir a Seccion Cobrar
    KW_026.Ir a Aplicaciones

TC_027
    [Documentation]             Cobrar un comprobante de venta en dolares desde el comprobante
    ...                         de forma parcial con la misma cotización
    [Tags]          suite
    KW_027.Realizar una Venta
    KW_027.Agregar Productos
    KW_027.Guardar
    KW_027.Cobrar Factura
    KW_027.Ir a Aplicaciones

TC_028
    [Documentation]         Cobrar un comprobante de venta en pesos desde el comprobante de forma total
    [Tags]          suite
    KW_028.Cobrar un comprobante de venta
    KW_028.Agregar Productos
    KW_028.Guardar Factura
    KW_028.Cobrar Desde Comprobante De Forma Total
    KW_028.Guardar Factura II
    KW_028.Validaciones en Aplicaciones

TC_029
    [Documentation]         Cobrar un comprobante de venta en dolares desde el comprobante
    ...                     de forma total con la misma cotización
    [Tags]          suite
    KW_029.Filtra Hasta Fecha Actual
    KW_029.Realiza una Nueva Venta
    KW_029.Agregar Productos
    KW_029.Guardar Factura
    KW_029.Comprobantes de Venta
    KW_029.Selecionar Factura
    KW_029.Cobrar Factura
    KW_029.Grilla Cobranza
    KW_029.Ir a Aplicaciones

TC_030
    [Documentation]         Cobrar un comprobante de venta en dolares desde el comprobante de forma parcial con
    ...                     diferente cotización (menor) y verificar la diferencia de cambio
    [Tags]          suite
    KW_030.Cobrar Comprobante de Venta en Dolares
    KW_030.Grilla Productos
    KW_030.Guardar Factura
    KW_030.Cobrar en Dolares
    KW_030.Guardar Factura II
    KW_030.Validaciones en Aplicaciones

TC_031
    [Documentation]                             Cobrar un comprobante de venta en dolares desde el comprobante de forma total con diferente cotización (menor)
    ...                                         y verificar la diferencia de cambio
    [Tags]          suite
    KW_031.Realiza una Nueva Venta
    KW_031.Agregar Productos
    KW_031.Guardar Factura
    KW_031.Cobrar Factura
    KW_031.Grilla Cobranza
    KW_031.Ir a Aplicaciones

TC_032
    [Documentation]     Cobrar un comprobante de venta en dolares desde el comprobante de forma parcial con
    ...                 diferente cotización (mayor) y verificar la diferencia de cambio
    [Tags]          suite
    KW_032.Cobrar Comprobante de Venta en Dolares
    KW_032.Grilla Productos
    KW_032.Guardar Factura
    KW_032.Cobrar en Dolares
    KW_032.Guardar Factura II
    KW_032.Validaciones en Aplicaciones
    KW_032.Comprobante Cobranza

TC_033
    [Documentation]             Cobrar un comprobante de venta en dolares desde el comprobante de forma total con diferente cotización (mayor)
    ...                         y verificar la diferencia de cambio
    [Tags]          suite
    KW_033.Realiza una Nueva Venta
    KW_033.Agregar Productos
    KW_033.Guardar Factura
    KW_033.Cobrar Factura
    KW_033.Grilla Cobranza
    KW_033.Ir a Aplicaciones
    KW_033.Ir a Cobranza
    KW_033.Ir Aplicaciones-Cobranza

TC_034
    [Documentation]     Remitir factura de venta
    [Tags]          suite
    KW_034.Setear Cliente
    KW_034.Grilla Productos
    KW_034.Guardar Factura
    KW_034.Ir a Remitir
    KW_034.Guardar Factura II
    KW_034.Remito Ventas

TC_035
    [Documentation]             Adjuntar un archivo a un comprobante de venta
    [Tags]          suite
    KW_035.Realiza una Nueva Venta
    KW_035.Agregar Productos
    KW_035.Guardar Factura
    KW_035.Adjuntar Archivo
    KW_035.Validacion Adjuntar Archivo

TC_036
    [Documentation]         Eliminar un comprobante de venta aplicado
    [Tags]          suite
    KW_036.Setear Cliente
    KW_036.Grilla Productos
    KW_036.Guardar Factura
    KW_036.Ir a Menu Cobrar
    KW_036.Guardar Factura II
    KW_036.Eliminar el Comprobante Generado
    KW_036.Verificar Cobranza

TC_037
    [Documentation]           Eliminar un comprobante de venta sin aplicar
    [Tags]          suite
    KW_037.Realiza una Nueva Venta
    KW_037.Agregar Productos
    KW_037.Guardar Factura
    KW_037.Cobrar Factura
    KW_037.Grilla Cobranza
    KW_037.Eliminar Factura
    KW_037.Buscar Factura Eliminada

TC_038
    [Documentation]         Desaplicar transacciones de venta
    [Tags]          suite
    KW_038.Filtra Hasta Fecha Actual
    KW_038.Setear Cliente
    KW_038.Grilla Productos
    KW_038.Guardar Factura
    KW_038.Cobrar Factura
    KW_038.Guardar Aplicar Factura
    KW_038.Ir a Aplicaciones y Desaplicar

#TC_039
#    [Documentation]         Setear una lista de precios default y que aparezca al hacer un comprobante de venta
#    [Tags]          suite
#    KW_039.Ir a Lista de Precios
#    KW_039.Ir a Comprobantes de Venta
#    KW_039.Agregar Producto
#    KW_039.Ir a Lista de Precios_2