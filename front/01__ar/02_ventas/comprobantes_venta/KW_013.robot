*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Factura A
    [Documentation]                              Creacion de una factura A
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente              Responsable Inscripto   default     Factura     Cuenta Corriente


Agregar Productos
    [Documentation]                                Se Completa la grilla Productos
    sleep   2s
    comprobantes_venta.Agregar Item RI            1   Carpeta         1       2500.50     0
    comprobantes_venta.Agregar Item RI            2   Alquiler        1       16500       10
    comprobantes_venta.Agregar Item RI            3   Cinta Papel     2.5     500         0
    comprobantes_venta.Agregar Item RI            4   Goma de borrar  4       120         0
    comprobantes_venta.Agregar Item RI            5   Carátulas       7       25          0
    comprobantes_venta.Agregar Item RI            6   Carátulas       2       -25         0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_7']/div/div

Grilla Percepcion/Impuestos
    [Documentation]                                Completa la grilla Percepcion/Impuestos
    sleep  2s
    click                                           xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion           1   Ingresos Brutos Buenos Aires (Percepción)   250
    comprobantes_venta.Agregar Percepcion           2   IVA                                         130
    comprobantes_venta.Agregar Percepcion           3   Impuestos Internos                          360
    comprobantes_venta.Agregar Percepcion           4   Categoría OTRO                              125.50
    click                                           xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_5']/div/div

Guardar Factura
    [Documentation]                                 Guarda la factura creada
    comprobantes_venta.Guardar


Nota de Credito
    [Documentation]                                Crea una nota de credito y  modifica el importe a aplicar
    comprobantes_venta.Crear Nota de Credito
    comprobantes_venta.Validacion Popup NC
    comprobantes_venta.Validacion del Importe            23,891.76
    comprobantes_venta.Modificar importe en NC           200

Agregar Producto en Popup
    [Documentation]                                Agrega elemento a la grilla de producto del Pop-up
    ...                                            y realiza las validaciones de los datos
    comprobantes_venta.Agregar Item RI (ventana)                    1   Cinta Papel     1     200         0
    comprobantes_venta.Validacion Cliente (Pop-up)                  Responsable Inscripto
    comprobantes_venta.Validacion de Letra (Pop-up)                 A
    comprobantes_venta.Validacion Condicion de Pago_(Pop-up)        Cuenta Corriente
    comprobantes_venta.Validacion Comprobante (Pop-up)              Nota de Crédito
    comprobantes_venta.Validacion del campo Comprobante Asociado este Vacio (Pop-up)
    comprobantes_venta.click en mas opciones (Pop-up)
    comprobantes_venta.Validacion Campo Operacion Sujeta a Retencion (Pop-up)
    comprobantes_venta.Validacion columna IVA (Pop-up)
    comprobantes_venta.Validacion Importe IVA (Pop-up)              0.00
    comprobantes_venta.Total Bruto                                  200.00
    comprobantes_venta.Total Impuestos                              0.00
    comprobantes_venta.Total                                        200.00
    sleep                                                           1s
    comprobantes_venta.Guardar (ventana)

Aplicaciones
    [Documentation]                                                 Selecciona el boton aplicaciones de la factura
    comprobantes_venta.Seleccionar Aplicaciones

Campos de Aplicaciones
    [Documentation]                                                 Valida los campos del Pop-up aplicaciones
    comprobantes_venta.Validacion Campos Aplicaciones               Aplicado
    comprobantes_venta.Validacion Campos Aplicaciones               Pendiente
    comprobantes_venta.Validacion Campos Aplicaciones               Documento Destino
    comprobantes_venta.Validacion Campos Aplicaciones               Fecha Aplic.

Salir de la Aplicaciones
    [Documentation]                                                 sale del Pop-up Aplicaciones
    comprobantes_venta.Salir de Aplicaciones
