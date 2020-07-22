*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot
Resource            ../../../funciones_generales/queries/consultas_sql.robot

*** Variables ***
${contador}=    ${0}

*** Keywords ***
Datos De Factura
    [Documentation]                       Se completan los primeros datos de la factura
    log to console                        Se completan los primeros datos de la factura
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente       Responsable Inscripto   default     Factura     Cuenta Corriente

Grilla Productos
    [Documentation]                     se completan los campos de productos
    log to console                      Grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item     1   Carpeta         1       2500.50     0
    comprobantes_venta.Agregar Item     2   Alquiler        1       16500       10
    comprobantes_venta.Agregar Item     3   Cinta Papel     2.5     500         0
    comprobantes_venta.Agregar Item     4   Goma de borrar  4       120         0
    comprobantes_venta.Agregar Item     5   Carátulas       7       25          0
    comprobantes_venta.Agregar Item     6   Carátulas       2       -25         0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_7']/div/div

Grilla Percepcion/Impuestos
    [Documentation]                     se completan los campos de percepcion/impuestos
    log to console                      Grilla Percepcion/Impuestos
    sleep   1s
    click    xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion      1   Ingresos Brutos Buenos Aires (Percepción)   250
    comprobantes_venta.Agregar Percepcion      2   IVA                                         130
    comprobantes_venta.Agregar Percepcion      3   Impuestos Internos                          360
    comprobantes_venta.Agregar Percepcion      4   Categoría OTRO                              125.50
    comprobantes_venta.Borrar Item             5

Guardar Factura
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura
    comprobantes_venta.Guardar
    # Se guarda el tipo y numero de comprobante completo
    ${nombre_comprobante}      Get Text     xpath=//div[@id='seccionTitulo']/div
    Set Global Variable                     ${nombre_comprobante}

validacion Con BD
    @{cuenta}=  Create List  Venta de Bienes
    ...         Deudores por Venta
    ...         Otras Percepciones Efectuadas
    ...         Impuestos Internos Efectuada
    ...         Percepción Ingresos Brutos Efectuada
    ...         Percepción de IVA Efectuada
    ...         Venta de Servicios
    ...         Venta de Bienes
    ...         IVA Débito Fiscal
    @{debe}=    Create List  50.0000
    ...         23891.7600
    ...         0.0
    ...         0.0
    ...         0.0
    ...         0.0
    ...         0.0
    ...         0.0
    ...         0.0
    @{haber}=   Create List  0.0
    ...         0.0
    ...         125.5000
    ...         360.0000
    ...         250.0000
    ...         130.0000
    ...         14850.0000
    ...         4405.5000
    ...         3820.7600

    consultas_sql.Conectar A BD
    ${id_comprobante}=    consultas_sql.Obtener Transaccion ID del comprobante    ${nombre_comprobante}
    @{resultado}=   consultas_sql.Obtener Contabilidad De Factura   ${id_comprobante}
    FOR     ${datos}  IN   @{resultado}
        ${registro[0]}=     Convert To String   ${datos[0]}
        ${registro[1]}=     Convert To String   ${datos[1]}
        ${registro[2]}=     Convert To String   ${datos[2]}
        Should Be Equal     ${registro[0]}  ${cuenta[${contador}]}
        Should Be Equal     ${registro[1]}  ${debe[${contador}]}
        Should Be Equal     ${registro[2]}  ${haber[${contador}]}
        ${contador}=    Evaluate    ${contador} + 1
    END
    consultas_sql.Desconectar A BD

TC_042
    [Documentation]             Verificar contabilidad de factura de Venta A en cuenta corriente en pesos
    KW_042.Datos De Factura
    KW_042.Grilla Productos
    KW_042.Grilla Percepcion/Impuestos
    KW_042.Guardar Factura
    KW_042.validacion Con BD