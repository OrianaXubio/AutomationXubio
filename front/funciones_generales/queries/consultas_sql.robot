*** Settings ***
Library     PostgreSQLDB

*** Variable ***
${db}=      FAF_MULTITENANT_AR_6
${host}=    104.154.246.235
${user}=    postgres
${passw}=   Post66MM/
${port}=    5432
# variables de consultas
${relacion_remito_factura}=     set session authorization tnt_206093;
...                             SELECT factura.nombre
...                             FROM nxvtransaccion remito
...                             INNER JOIN nxvtransaccioncompraventa remitocv
...                             ON remitocv.transaccionid = remito.transaccionid
...                             INNER JOIN nxvtransaccion factura
...                             ON factura.transaccionid = remitocv.transaccionidsiguiente
...                             WHERE remito.nombre
...                             ILIKE

${transaccion_id}=      set session authorization tnt_206093;
...                     SELECT transaccionid
...                     FROM nxvtransaccion
...                     WHERE nombre
...                     ILIKE

${obt_contabilidad}=   set session authorization tnt_206093;
...                    SELECT cuenta, debe, haber
...                    FROM F_NXV_CN_0010

*** Keywords ***
Conectar a BD
    Connect To Postgresql       ${db}   ${user}     ${passw}    ${host}     ${port}

Desconectar a BD
    Close All Postgresql Connections

Validar Remito-Factura
    [Arguments]         ${remito}   ${factura}
    @{query}=           Execute Sql String      ${relacion_remito_factura} '${remito}';
    Should Be Equal     ${query[0][0]}          ${factura}
    Log                 ${query[0][0]}

Obtener Transaccion ID del comprobante
    [Documentation]     obtiene el numero de transaccion
    [Arguments]         ${factura}
    @{query}=           Execute Sql String       ${transaccion_ID} '${factura}';
    [Return]            ${query[0][0]}

Obtener Contabilidad De Factura
    [Documentation]     Verifica los valores del asiento con la base de datos.
    [Arguments]         ${ID_transaccion}
    @{query}=           Execute Sql String      ${obt_contabilidad}(${ID_transaccion});
    [Return]            ${query}
