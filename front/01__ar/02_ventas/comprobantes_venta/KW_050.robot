*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/queries/consultas_sql.robot

*** Variables ***
${contador}=    ${0}

*** Keywords ***
Datos De Factura
    [Documentation]                         Se completan los primeros datos de la factura
    log to console                          Se completan los primeros datos de la factura
    recursos.Elegir Categoria de Empresa    Monotributista
    vision_general.Validar Ingreso Al Sitio
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente         Responsable Inscripto   default     Factura     Tarjeta de Crédito

Agregar Productos
    [Documentation]                         se completan los campos de productos
    log to console                          Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item       1   Cinta papel (EX)         1       1256.9     0
    comprobantes_venta.Agregar Item       2   Crayones (EX)            1       3250       10
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_3']/div/div

Guardar Factura
    [Documentation]                         se guarda la factura generada
    log to console                          Guardar Factura
    comprobantes_venta.Guardar
    #Guarda el nº de comprobante
    ${num_comprobante}       Get text       xpath=//div[@id='seccionTitulo']/div
    Set Global Variable                     ${num_comprobante}

Cambiar Categoria de Empresa
    [Documentation]                     cambia la empresa a responsable inscripto
    log to console                      Cambiar Categoria de Empresa
    recursos.Elegir Categoria de Empresa                 Responsable Inscripto

Validacion Con BD
    [Documentation]         Se obteniene el id de la transaccion para luego verificar los valores del asiento con la BD
    log to console          Validacion Con Base de Datos

    @{cuenta}=  Create List     Deudores por Venta
    ...                         Venta de Bienes

    @{debe}=    Create List     4181.9000
    ...                         0.0

    @{haber}=   Create List     0.0
    ...                         4181.9000

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

TC_050
    [Documentation]         Verificar contabilidad de factura de Venta C en tarjeta de crédito en pesos
    KW_050.Datos De Factura
    KW_050.Agregar Productos
    KW_050.Guardar Factura
    KW_050.Cambiar Categoria de Empresa
    KW_050.Validacion Con BD