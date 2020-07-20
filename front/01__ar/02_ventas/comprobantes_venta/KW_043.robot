*** Settings ***
Library             SeleniumLibrary
Library             DateTime

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot
Resource            ../../../funciones_generales/queries/consultas_sql.robot

*** Variables ***
${contador}=    ${0}

*** Keywords ***
Seleccionar Comprobantes de Venta
    [Documentation]                                                Se dirije a Comprobantes de Ventas "+"
    Log To Console                                                 Seleccionar Comprobantes de Venta
    click                                                          link=Ventas
    click                                                          xpath=//li[@class='ventas']//li[1]//a[2]
    comprobantes_venta.Tipo Cliente                                Consumidor Final - Con identificación   default   Factura   Contado

Agregar Productos
    [Documentation]                     se completan los campos de productos
    Log To Console                      Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item CF    1   Carpeta         1       2500.50     0
    comprobantes_venta.Agregar Item CF    2   Alquiler        1       16500       10
    comprobantes_venta.Agregar Item CF    3   Cinta Papel     2.5     500         0
    comprobantes_venta.Agregar Item CF    4   Goma de borrar  4       120         0
    comprobantes_venta.Agregar Item CF    5   Carátulas       7       25          0
    comprobantes_venta.Agregar Item CF    6   Carátulas       2       -25         0
    #click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_7']/div/div


Agregar Percepcion/Impuestos
    [Documentation]                                                se completan los campos de percepcion/impuestos
     log to console                                                Grilla Percepcion/Impuestos
     sleep                                                         2s
     click                                                         xpath=//input[@value='Percepciones e Impuestos']
     comprobantes_venta.Agregar Percepcion                         1   Ingresos Brutos Buenos Aires (Percepción)   250
     comprobantes_venta.Agregar Percepcion                         2   Impuestos Internos                          360
     comprobantes_venta.Agregar Percepcion                         3   Categoría OTRO                              125.50
     click                                                         xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_4']/div/div

Grilla Instrumento de cobro
    [Documentation]                                               Completa la grilla Instrumentos de cobro
    log to console                                                Grilla Instrumento de cobro
    sleep                                                         1s
    comprobantes_venta.Agregar Instrumento De Cobro               1       Caja        Caja              Pesos Argentinos        1        1941
    comprobantes_venta.Agregar Instrumento De Cobro               2       Banco       Banco Galicia     Pesos Argentinos        1        18000
    click                                                         xpath=//td[@id='TransaccionTesoreriaIngresoItems_internal_delete_column_3']/div/div

Guardar Factura
    [Documentation]                                              se guarda la factura generada
    log to console                                               Guardar Factura
    sleep                                                        2s
    comprobantes_venta.Guardar
   #Guarda el nº de comprobante
    ${num_comprobante}      Get text                             xpath=//div[@id='seccionTitulo']/div
    Set Global Variable                                          ${num_comprobante}

Verificacion con la BD
    [Documentation]                                              Se obteniene el id de la transaccion para luego verificar los valores del asiento con la BD
    log to console                                               Verificacion con la BD

    @{cuenta}=  Create List     Caja
    ...                         Venta de Bienes
    ...                         Banco Galicia
    ...                         Otras Percepciones Efectuadas
    ...                         Impuestos Internos Efectuada
    ...                         Percepción Ingresos Brutos Efectuada
    ...                         Venta de Servicios
    ...                         Venta de Bienes
    ...                         IVA Débito Fiscal

    @{debe}=    Create List     1941.0000
    ...                         48.7800
    ...                         18000.0000
    ...                         0.0
    ...                         0.0
    ...                         0.0
    ...                         0.0
    ...                         0.0
    ...                         0.0

    @{haber}=   Create List     0.0
    ...                         0.0
    ...                         0.0
    ...                         125.5000
    ...                         360.0000
    ...                         250.0000
    ...                         12272.7300
    ...                         3846.7700
    ...                         3134.7800

   consultas_sql.Conectar A BD
    ${id_comprobante}=      consultas_sql.Obtener Transaccion ID del comprobante    ${num_comprobante}
    @{resultado}=           consultas_sql.Obtener Contabilidad De Factura           ${id_comprobante}

    #Recorre la lista y compara los datos
    FOR     ${datos}  IN    @{resultado}
        ${registro[0]}=     Convert To String   ${datos[0]}
        ${registro[1]}=     Convert To String   ${datos[1]}
        ${registro[2]}=     Convert To String   ${datos[2]}
        Should Be Equal     ${registro[0]}  ${cuenta[${contador}]}
        Should Be Equal     ${registro[1]}  ${debe[${contador}]}
        Should Be Equal     ${registro[2]}  ${haber[${contador}]}
        ${contador}=        Evaluate    ${contador} + 1
    END
    consultas_sql.Desconectar A BD

TC_043
    [Documentation]         Verificar contabilidad de factura de Venta B al contado en pesos
    KW_043.Seleccionar Comprobantes de Venta
    KW_043.Agregar Productos
    KW_043.Agregar Percepcion/Impuestos
    KW_043.Grilla Instrumento de cobro
    KW_043.Guardar Factura
    KW_043.Verificacion con la BD
