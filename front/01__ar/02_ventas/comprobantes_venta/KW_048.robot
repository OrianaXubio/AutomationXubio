*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/queries/consultas_sql.robot

*** Variables ***
${contador}=    ${0}

*** Keywords ***
Datos De Factura
    [Documentation]                       Se completan los primeros datos de la factura
    log to console                        Se completan los primeros datos de la factura
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente       Consumidor Final - Sin identificación   default     Informe Diario de Cierre Z     Cuenta Corriente

Agregar Productos
    [Documentation]                       Se agregan productos
    log to console                        Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item     1    Carátulas       8       64500        0
    comprobantes_venta.Agregar Item     2    Cinta Papel     169     89600        0
    comprobantes_venta.Agregar Item     3    Alquiler        265     54700        0
    comprobantes_venta.Agregar Item     4    Goma de borrar  1       16500        0
    click       xpath=//td[@id='TransaccionCVItems_internal_delete_column_5']/div/div

Guardar Factura
    [Documentation]                      se guarda la factura generada
    log to console                       Guardar Factura
    comprobantes_venta.Guardar
    #Guarda el nº de comprobante
    ${num_comprobante}       Get text    xpath=//div[@id='seccionTitulo']/div
    Set Global Variable                  ${num_comprobante}

Validacion Con BD
    [Documentation]         Se obteniene el id de la transaccion para luego verificar los valores del asiento con la BD
    log to console          Validacion Con Base de Datos

    @{cuenta}=  Create List     Deudores por Venta
    ...                         Venta de Servicios
    ...                         Venta de Bienes
    ...                         IVA Débito Fiscal

    @{debe}=    Create List     30170400.0000
    ...                         0.0
    ...                         0.0
    ...                         0.0

    @{haber}=   Create List     0.0
    ...                         11979752.0700
    ...                         15661528.9200
    ...                         2529119.0100

    consultas_sql.Conectar A BD
    ${id_comprobante}=      consultas_sql.Obtener Transaccion ID del comprobante    ${num_comprobante}
    @{resultado}=           consultas_sql.Obtener Contabilidad De Factura           ${id_comprobante}

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

TC_048
    [Documentation]         Verficar contabilidad de un informe diario de cierre Z en pesos
    KW_048.Datos De Factura
    KW_048.Agregar Productos
    KW_048.Guardar Factura
    KW_048.Validacion Con BD