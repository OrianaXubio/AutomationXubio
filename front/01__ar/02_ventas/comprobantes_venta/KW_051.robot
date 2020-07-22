*** Settings ***
Library             SeleniumLibrary
Library             String

Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot

*** Keywords ***
Seleccionar Comprobantes de Venta
    [Documentation]                         Se dirije a Comprobantes de Ventas
    Log To Console                          Seleccionar Comprobantes de Venta
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente         Responsable Inscripto     Talonario Unificado     Factura    Cuenta Corriente
    #Guarda el nº de comprobante
    ${num_comprobante}      Get value       xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                     ${num_comprobante}
    #Realiza un incremento en el numero de factura
    #y lo guarda en una variable
    ${num_factura}=         comprobantes_venta.Numero de Factura     ${num_comprobante}
    ${acum}=                Evaluate        ${num_factura} + 1
    Set Global Variable                     ${acum}
    ${acum_dos}=            Evaluate        ${num_factura} + 2
    Set Global Variable                     ${acum_dos}

Agregar Productos
    [Documentation]                         se completan los campos de productos
    log to console                          Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item       1   Cinta Papel     1     1256,9         0
    click        xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura
    [Documentation]                         se guarda la factura generada
    log to console                          Guardar Factura
    comprobantes_venta.Guardar

Seleccionar Comprobantes de Venta 2
    [Documentation]                         Se dirije a Comprobantes de Ventas "+"
    Log To Console                          Seleccionar Comprobantes de Venta 2
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente         Responsable Inscripto     Talonario Unificado     Factura    Cuenta Corriente
    #Guarda el nº de comprobante
    ${num_comprobante_dos}      Get value   xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                     ${num_comprobante_dos}
    #Hace la convesion del numero de factura de  string a numero
    ${num_fact_dos}       comprobantes_venta.Numero de Factura     ${num_comprobante_dos}
    Set Global Variable                     ${num_fact_dos}

Agregar Productos 2
    [Documentation]                         se completan los campos de productos
    log to console                          Agregar Productos 2
    sleep   1s
    comprobantes_venta.Agregar Item       1   Cinta Papel     1     1256,9         0
    click        xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura 2
    [Documentation]                         se guarda la factura generada
    log to console                          Guardar Factura 2
    comprobantes_venta.Guardar

Validar correlatividad dos
    [Documentation]                         Compara si la factura obtenida tiene la misma numeracion que la guardada en la variable
    Should Be Equal                         ${acum}   ${num_fact_dos}

Seleccionar Comprobantes de Venta 3
    [Documentation]                         Se dirije a Comprobantes de Ventas "+"
    Log To Console                          Seleccionar Comprobantes de Venta 3
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente         Responsable Inscripto     Talonario Unificado     Nota de Crédito     Cuenta Corriente
    #Guarda el nº de comprobante
    ${num_comprobante_tres}     Get value   xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                     ${num_comprobante_tres}
    #Hace la convesion de string a numero
    ${num_factura_tres}=       comprobantes_venta.Numero de Factura      ${num_comprobante_tres}
    Set Global Variable                     ${num_factura_tres}

Agregar Productos 3
    [Documentation]                         se completan los campos de productos
    log to console                          Agregar Productos 3
    sleep   1s
    comprobantes_venta.Agregar Item       1   Cinta Papel     1     1256,9         0
    click        xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura 3
    [Documentation]                         se guarda la factura generada
    log to console                          Guardar Factura 3

Validar correlatividad tres
    [Documentation]                         Compara si la factura obtenida tiene la misma numeracion que la guardada en la variable
     Should Be Equal         ${acum_dos}    ${num_factura_tres}

TC_051
    [Documentation]                         Verificar correlatividad en punto de venta con talonario unificado
    KW_051.Seleccionar Comprobantes de Venta
    KW_051.Agregar Productos
    KW_051.Guardar Factura
    KW_051.Seleccionar Comprobantes de Venta 2
    KW_051.Agregar Productos 2
    KW_051.Guardar Factura 2
    KW_051.Validar correlatividad dos
    KW_051.Seleccionar Comprobantes de Venta 3
    KW_051.Agregar Productos 3
    KW_051.Guardar Factura 3
    KW_051.Validar correlatividad tres
