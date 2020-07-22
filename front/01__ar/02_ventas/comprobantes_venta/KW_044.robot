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
    comprobantes_venta.Tipo Cliente       Cliente del exterior   default     Factura     Cuenta Corriente
    comprobantes_venta.Mas Opciones - Moneda        Dólares     75

Grilla Productos
    [Documentation]                     se completan los campos de productos
    log to console                      Grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item     1   HONORARIOS         1       5000     0
    comprobantes_venta.Agregar Item     2   Alquiler           1       16985    10
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_3']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura
    comprobantes_venta.Guardar
    # Se guarda el tipo y numero de comprobante completo
    ${nombre_comprobante}      Get Text     xpath=//div[@id='seccionTitulo']/div
    Set Global Variable                     ${nombre_comprobante}

validacion Con BD
    @{cuenta}=  Create List     Deudores por Venta
    ...                         Venta de Servicios

    @{debe}=    Create List     1521487.5000
    ...                         0.0

    @{haber}=   Create List     0.0
    ...                         1521487.5000

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

TC_044
    [Documentation]             Verificar contabilidad de factura de Venta E en cuenta corriente en dolares
    KW_044.Datos De Factura
    KW_044.Grilla Productos
    KW_044.Guardar Factura
    KW_044.validacion Con BD