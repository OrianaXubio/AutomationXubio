*** Settings ***
Documentation
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Crear Nota de Debito MiPyMe A
    [Documentation]                              Crea una Nota de Débito Mipyme A en cuenta corriente y asocia una factura
    log to console          Crear Nota de Debito MiPyMe A
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente              Responsable Inscripto   default   Nota de Débito MiPyME (FCE)   Cuenta Corriente
    comprobantes_venta.Comprobante Asociado      Factura de Crédito MiPyME (FCE) N° A-0002-00000001

Agregar Productos
    [Documentation]                                Se Completa la grilla Productos
    log to console          Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item             1   Carpeta         1       2500.50     0
    comprobantes_venta.Agregar Item             2   Alquiler        1       16500       10
    click                                         xpath=//td[@id='TransaccionCVItems_internal_delete_column_3']/div/div

Guardar
    log to console          guardar
    comprobantes_venta.Guardar

Validaciones
    [Documentation]                                             Realiza la validaciones de los campos
    log to console          validaciones
    comprobantes_venta.Validacion Comprobante                   Nota de Débito MiPyME (FCE)
    comprobantes_venta.Letra Numero Comprobante                 A
    comprobantes_venta.Condicion De Pago                        Cuenta Corriente
    comprobantes_venta.Validacion Comprobante Asociado        A-0002-00000001
    comprobantes_venta.Validacion Columna Importe               1       2,500.50
    comprobantes_venta.Validacion Columna Iva                   1       675.13
    comprobantes_venta.Validacion Columna Total                 1       3,175.64
    comprobantes_venta.Validacion Columna Importe               2       14,850.00
    comprobantes_venta.Validacion Columna Iva                   2       3,118.50
    comprobantes_venta.Validacion Columna Total                 2       17,968.50
    comprobantes_venta.Total Bruto                              17350.5000
    comprobantes_venta.Total Impuestos                          3793.6400
    comprobantes_venta.Total                                    21144.1400

TC_023
    [Documentation]     Crear Nota de Débito Mipyme A en cuenta corriente
    KW_023.Crear Nota de Debito MiPyMe A
    KW_023.Agregar Productos
    KW_023.Guardar
    KW_023.Validaciones