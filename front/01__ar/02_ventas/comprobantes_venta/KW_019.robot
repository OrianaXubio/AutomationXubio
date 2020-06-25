*** Settings ***
Documentation
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
#Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Factura de Credito Mipyme A
    [Documentation]
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente              Responsable Inscripto   default   Factura de Crédito MiPyME (FCE)   Cuenta Corriente
    comprobantes_venta.Mas Opciones

Agregar Productos
    [Documentation]                                Se Completa la grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item RI            1   Carpeta         1       2500.50     0
    comprobantes_venta.Agregar Item RI            2   Alquiler        1       16500       10
    comprobantes_venta.Agregar Item RI            3   Cinta Papel     2.5     500         0
    comprobantes_venta.Agregar Item RI            4   Goma de borrar  4       120         0
    comprobantes_venta.Agregar Item RI            5   Carátulas       7       25          0
    comprobantes_venta.Agregar Item RI            6   Carátulas       2       -25         0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_7']/div/div

Seleccionar Remitos Asociados
    [Documentation]                               Despliega la opcion Remito Asociados y completa los campos
    comprobantes_venta.Remitos Asociados        1     X-0001-00000003       Factura de Crédito MiPyME (FCE) asociada con el remito X-0001-00000003

Guardar
    comprobantes_venta.Guardar

Validaciones
    [Documentation]                                             Realiza la validaciones de los campos
    comprobantes_venta.Validacion Comprobante                   Factura de Crédito MiPyME (FCE)
    comprobantes_venta.Letra Numero Comprobante                 A
    comprobantes_venta.Condicion De Pago                        Cuenta Corriente
    comprobantes_venta.Validacion Operacion Sujeta a Ret.
    comprobantes_venta.Validacion Columna Importe             1       2,500.50
    comprobantes_venta.Validacion Columna Iva                 1       675.13
    comprobantes_venta.Validacion Columna Total               1       3,175.64
    comprobantes_venta.Validacion Columna Importe             2       14,850.00
    comprobantes_venta.Validacion Columna Iva                 2       3,118.50
    comprobantes_venta.Validacion Columna Total               2       17,968.50
    comprobantes_venta.Validacion Columna Importe             3       1,250.00
    comprobantes_venta.Validacion Columna Iva                 3       0.00
    comprobantes_venta.Validacion Columna Total               3       1,250.00
    comprobantes_venta.Validacion Columna Importe             4       480.00
    comprobantes_venta.Validacion Columna Iva                 4       24.00
    comprobantes_venta.Validacion Columna Total               4       504.00
    comprobantes_venta.Validacion Columna Importe             5       175.00
    comprobantes_venta.Validacion Columna Iva                 5       4.38
    comprobantes_venta.Validacion Columna Total               5       179.38
    comprobantes_venta.Validacion Columna Importe             6       -50.00
    comprobantes_venta.Validacion Columna Iva                 6       -1.25
    comprobantes_venta.Validacion Columna Total               6       -51.25
    comprobantes_venta.Validacion Remito ingresado            X-0001-00000003
    comprobantes_venta.Validacion Observaciones               Factura de Crédito MiPyME (FCE) asociada con el remito X-0001-00000003
    comprobantes_venta.Total Bruto                            19205.5000
    comprobantes_venta.Total Impuestos                        3820.7600
    comprobantes_venta.Total                                  23026.2600