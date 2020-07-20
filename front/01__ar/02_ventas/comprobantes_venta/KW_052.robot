*** Settings ***
Library             SeleniumLibrary
Library             Collections

Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/queries/consultas_sql.robot

*** Variables ***
@{nombre_fac}
@{numero_fac}
@{nombre_fac2}
@{numero_fac2}
${contador}=    ${0}

*** Keywords ***
Obtener Listado de Facturas
    log to console                      Obtener Listado de Facturas
    Go To                               https://xubiotesting2.ddns.net/NXV/configuracion/mi-cuenta/mis-facturas
    wait until element is visible       link=Nuevo Punto de Venta
    sleep   2s
    click                               xpath=//a[contains(text(),'default')]
    wait until element is visible       xpath=//table//tr[@class="gridRow"]
    ${nombres}=     comprobantes_venta.Obtener Valores De Tabla     xpath=//table//tr[@class="gridRow"]/td[1]/div       ${nombre_fac}
    ${numeros}=     comprobantes_venta.Obtener Valores De Tabla     xpath=//table//tr[@class="gridRow"]/td[5]/div       ${numero_fac}
    Set Global Variable                 ${nombres}
    Set Global Variable                 ${numeros}

Datos De Factura
    [Documentation]                     Se completan los primeros datos de la factura
    log to console                      Se completan los primeros datos de la factura
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente     Responsable Inscripto   default     Factura     Cuenta Corriente

Grilla Productos
    [Documentation]                     se completan los campos de productos
    log to console                      Grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item RI    1   Carpeta         1       2500.50     0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura
    comprobantes_venta.Guardar
    # Se guarda el numero de comprobante en una variable
    ${num_comprobante}      Get value   xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                 ${num_comprobante}

Comparar Dos Valores
    [Documentation]     Compara el numero de comprobante y valida que se haya sumado un valor al anterior
    ${valor1}=         Set Variable     ${numeros[0]}
    ${valor2}=         Set Variable     ${numeros2[0]}
    ${num1}=           Convert To Integer      ${valor1}
    ${num2}=           Convert To Integer      ${valor2}
    ${suma_valor}=     Evaluate         ${num1} + 1
    Should Be Equal    ${num2}          ${suma_valor}

Cantidad De Elementos
    [Documentation]     devuelve la cantidad de elementos que tiene la lista
    [Arguments]         ${lista}
    ${cnt}=             Get length      ${lista}
    [Return]            ${cnt}

Validacion Listado de Facturas
    log to console                      Validacion Listado de Facturas
    Go To                               https://xubiotesting2.ddns.net/NXV/configuracion/mi-cuenta/mis-facturas
    wait until element is visible       link=Nuevo Punto de Venta
    sleep   2s
    click                               xpath=//a[contains(text(),'default')]
    wait until element is visible       xpath=//table//tr[@class="gridRow"]
    ${nombres2}=     comprobantes_venta.Obtener Valores De Tabla     xpath=//table//tr[@class="gridRow"]/td[1]/div       ${nombre_fac2}
    ${numeros2}=     comprobantes_venta.Obtener Valores De Tabla     xpath=//table//tr[@class="gridRow"]/td[5]/div       ${numero_fac2}
    Set Global Variable                 ${numeros2}

    # Validacion Nombres
    Lists Should Be Equal   ${nombres2}     ${nombres}

    # Validacion numeros
    ${valor}=   Convert To Integer      ${numeros[0]}
    ${suma_valor}=          Evaluate    ${valor} + 1
    ${fin}=     Cantidad De Elementos   ${numeros2}
    FOR     ${i}      IN RANGE          ${fin}
            ${contador}=        Evaluate            ${contador} + 1
            Run Keyword If      ${contador}== 1     Comparar Dos Valores
            ...                 ELSE                Should Be Equal         ${numeros2[${i}]}         ${numeros[${i}]}
    END

TC_052
    [Documentation]     Verificar correlatividad en punto de venta con talonario no unificado
    KW_052.Obtener Listado de Facturas
    KW_052.Datos De Factura
    KW_052.Grilla Productos
    KW_052.Guardar Factura
    KW_052.Validacion Listado de Facturas
