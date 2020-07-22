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
Empresa con Emision de factura-M
    [Documentation]                                  se configura la empresa para que emita factura M
    log to console                                   Empresa con Emision de factura-M
    recursos.Ir a Mi Empresa
    recursos.Mas Opciones-Facturacion M
    Checkbox Should Be Selected                      xpath=//div[@name='wdg_FacturasM']//input
    recursos.Guardar Cambios de Empresa
    vision_general.Validar Ingreso Al Sitio

Factura M
    [Documentation]                                 creacion de factura M con tarjeta de debito
    log to console                                  Factura M
    sleep   1s
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                 Responsable Inscripto    default     Factura     Tarjeta de Débito

Agregar Productos
    [Documentation]                                se completan los campos de productos
    log to console                                 Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item              1   Carpeta         1       2500.50     0
    comprobantes_venta.Agregar Item              2   Alquiler        1       16500       10
    comprobantes_venta.Agregar Item              3   Cinta Papel     2.5     500         0
    click                                          xpath=//td[@id='TransaccionCVItems_internal_delete_column_4']/div/div

Guardar Factura
    [Documentation]                               se guarda la factura generada
    log to console                                Guardar Factura
    comprobantes_venta.Guardar
    #Guarda el nº de comprobante
    ${num_comprobante}      Get text              xpath=//div[@id='seccionTitulo']/div
    Set Global Variable                           ${num_comprobante}

Destildar Emito Factura M
    [Documentation]                              se deshabilita la opcion de generar factura M
    log to console                               Destildar Emito Factura M
    recursos.Ir a Mi Empresa
    recursos.Destildar Facturacion M
    Checkbox Should Not Be Selected              xpath=//div[@name='wdg_FacturasM']//input
    recursos.Guardar Cambios de Empresa

Validacion Con Base de Datos
    [Documentation]                                              Se obteniene el id de la transaccion para luego verificar los valores del asiento con la BD
    log to console                                               Validacion Con Base de Datos
    @{cuenta}=  Create List     Deudores por Venta
    ...                         Venta de Servicios
    ...                         Venta de Bienes
    ...                         IVA Débito Fiscal

    @{debe}=    Create List     22394.1400
    ...                         0.0
    ...                         0.0
    ...                         0.0

    @{haber}=   Create List     0.0
    ...                         14850.0000
    ...                         3750.5000
    ...                         3793.6400

    consultas_sql.Conectar A BD
    ${id_comprobante}=      consultas_sql.Obtener Transaccion ID del comprobante    ${num_comprobante}
    @{resultado}=           consultas_sql.Obtener Contabilidad De Factura           ${id_comprobante}

    FOR     ${datos}  IN    @{resultado}
        ${registro[0]}=     Convert To String   ${datos[0]}
        ${registro[1]}=     Convert To String   ${datos[1]}
        ${registro[2]}=     Convert To String   ${datos[2]}
        Should Be Equal     ${registro[0]}  ${cuenta[${contador}]}
        Should Be Equal     ${registro[1]}  ${debe[${contador}]}
        Should Be Equal     ${registro[2]}  ${haber[${contador}]}
        ${contador}=        Evaluate        ${contador} + 1
    END
    consultas_sql.Desconectar A BD

TC_045
    [Documentation]             Verificar contabilidad de factura de Venta M al contado en pesos
    KW_045.Empresa con Emision de factura-M
    KW_045.Factura M
    KW_045.Agregar Productos
    KW_045.Guardar Factura
    KW_045.Destildar Emito Factura M
    KW_045.Validacion Con Base de Datos