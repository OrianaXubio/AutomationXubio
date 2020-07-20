*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/queries/consultas_sql.robot

*** Variables ***
${contador}=    ${0}

*** Keywords ***
Seleccionar Venta
    [Documentation]                                     Realiza un comprobante de venta en dolares
    log to console                                      Seleccionar Venta
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                     Exento   default   Nota de Débito   Cuenta Corriente
    comprobantes_venta.Mas Opciones - Moneda            Dólares        72

Agregar Productos
    [Documentation]                                se completan los campos de productos
    log to console                                 Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item CF             1   Carpeta         1       1250     0
    comprobantes_venta.Agregar Item CF             2   Alquiler        1       780       10
    click                                          xpath=//td[@id='TransaccionCVItems_internal_delete_column_3']/div/div

Guardar Factura
    [Documentation]                               se guarda la factura generada
    log to console                                Guardar Factura
    comprobantes_venta.Guardar
    #Guarda el nº de comprobante
    ${num_comprobante}      Get text              xpath=//div[@id='seccionTitulo']/div
    Set Global Variable                           ${num_comprobante}

Validacion Con Base de Datos
    [Documentation]         Se obteniene el id de la transaccion para luego verificar los valores del asiento con la BD
    log to console          Validacion Con Base de Datos
    @{cuenta}=  Create List     Deudores por Venta
    ...                         Ajuste por Redondeo Decimal
    ...                         Venta de Servicios
    ...                         Venta de Bienes
    ...                         IVA Débito Fiscal

    @{debe}=    Create List     140544.0000
    ...                         0.0
    ...                         0.0
    ...                         0.0
    ...                         0.0

    @{haber}=   Create List     0.0
    ...                         0.0100
    ...                         41771.9000
    ...                         70866.1400
    ...                         27905.9500

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

TC_047
    [Documentation]             Verificar contabilidad de nota de Debito de venta B en cuenta corriente en dólares
    KW_047.Seleccionar Venta
    KW_047.Agregar Productos
    KW_047.Guardar Factura
    KW_047.Validacion Con Base de Datos