*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Variables ***
${contador}=    ${0}

*** Keywords ***
Nueva Venta
    [Documentation]                                   Realiza un comprobante de venta
    log to console                                    Nueva Venta
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                   Responsable Inscripto     default    Recibo    Contado

Agregar Productos
    [Documentation]                                   se completan los campos de productos
    log to console                                    Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item RI                1   Carpeta         1       3002     0
    comprobantes_venta.Agregar Item RI                2   Alquiler        1       18500       10
    comprobantes_venta.Agregar Item RI                3   Cinta Papel     2.5     360         0
    click                                             xpath=//td[@id='TransaccionCVItems_internal_delete_column_4']/div/div

Grilla Percepcion/Impuestos
    [Documentation]                                   se completan los campos de percepcion/impuestos
    log to console                                    Grilla Percepcion/Impuestos
    sleep   1s
    click                                             xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion             1   Ingresos Brutos Buenos Aires (Percepción)   250
    comprobantes_venta.Agregar Percepcion             2   IVA                                         130
    comprobantes_venta.Agregar Percepcion             3   Impuestos Internos                          360
    comprobantes_venta.Agregar Percepcion             4   Categoría OTRO                              125.50
    click                                             xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_5']/div/div

Grilla Instrumento de cobro
    [Documentation]                                   Completa la grilla Instrumentos de cobro
    log to console                                    Grilla Instrumento de cobro
    sleep       1s
    comprobantes_venta.Agregar Instrumento De Cobro   1       Caja        Caja       Pesos Argentinos        1.000000          25,724.54
    click                                             xpath=//td[@id='TransaccionTesoreriaIngresoItems_internal_delete_column_2']/div/div

Guardar Factura
    [Documentation]                                   se guarda la factura generada
    log to console                                    Guardar Factura
    comprobantes_venta.Guardar
    #Guarda el nº de comprobante
    ${num_comprobante}      Get text                  xpath=//div[@id='seccionTitulo']/div
    Set Global Variable                               ${num_comprobante}


Verificacion con la BD
    [Documentation]             Se obteniene el id de la transaccion para luego verificar los valores del asiento con la BD
    log to console              Verificacion con la BD

    @{cuenta}=  Create List     Caja
    ...                         Otras Percepciones Efectuadas
    ...                         Impuestos Internos Efectuada
    ...                         Percepción Ingresos Brutos Efectuada
    ...                         Percepción de IVA Efectuada
    ...                         Venta de Servicios
    ...                         Venta de Bienes
    ...                         IVA Débito Fiscal

    @{debe}=    Create List     25724.5400
    ...                         0.0
    ...                         0.0
    ...                         0.0
    ...                         0.0
    ...                         0.0
    ...                         0.0
    ...                         0.0

    @{haber}=   Create List     0.0
    ...                         125.5000
    ...                         360.0000
    ...                         250.0000
    ...                         130.0000
    ...                         16650.0000
    ...                         3902.0000
    ...                         4307.0400

    consultas_sql.Conectar A BD
    ${id_comprobante}=      consultas_sql.Obtener Transaccion ID del comprobante    ${num_comprobante}
    @{resultado}=           consultas_sql.Obtener Contabilidad De Factura           ${id_comprobante}

    #Recorre la lista y compara los datos
    FOR     ${datos}  IN    @{resultado}
        ${registro[0]}=     Convert To String   ${datos[0]}
        ${registro[1]}=     Convert To String   ${datos[1]}
        ${registro[2]}=     Convert To String   ${datos[2]}
        Should Be Equal     ${registro[0]}      ${cuenta[${contador}]}
        Should Be Equal     ${registro[1]}      ${debe[${contador}]}
        Should Be Equal     ${registro[2]}      ${haber[${contador}]}
        ${contador}=        Evaluate            ${contador} + 1
    END
    consultas_sql.Desconectar A BD

TC_049
    [Documentation]             Verificar contabilidad de Recibo de venta A al contado en pesos
    KW_049.Nueva Venta
    KW_049.Agregar Productos
    KW_049.Grilla Percepcion/Impuestos
    KW_049.Grilla Instrumento de cobro
    KW_049.Guardar Factura
    kw_049.Verificacion con la BD