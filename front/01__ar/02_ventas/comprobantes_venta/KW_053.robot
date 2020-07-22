*** Settings ***
Library             SeleniumLibrary
Library             DateTime

Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot

*** Keywords ***
Nueva Venta
    [Documentation]         Ingresar al formulario de Comprobantes de Venta y guarda la fecha-hora del comprobante creado
    comprobantes_venta.Ir a Nueva Venta
    ${CurrentDate}=     Get Current Date        result_format=%Y-%m-%d %H:%M:%S     #.%f
    ${datetime}=       Convert Date             ${CurrentDate}      datetime
    Set Global Variable                         ${datetime}
    comprobantes_venta.Tipo Cliente             Responsable Inscripto   default   Factura   Cuenta Corriente
    ${num_comprobante_1}      Get value         xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                         ${num_comprobante_1}
    sleep                                       1s
    comprobantes_venta.Mas Opciones
    comprobantes_venta.Mas Opciones - Observaciones     Caso53_${datetime}

Agregar Productos
    [Documentation]                             Se Completa la grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item           1   Carpeta         1       2500.50     0
    click           xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Grilla Percepcion/Impuestos
    [Documentation]                             se completan los campos de percepcion/impuestos
    log to console                              Grilla Percepcion/Impuestos
    sleep   1s
    click                                       xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion       1   Ingresos Brutos Buenos Aires (Percepción)   250
    comprobantes_venta.Agregar Percepcion       2   IVA                                         130
    comprobantes_venta.Agregar Percepcion       3   Impuestos Internos                          360
    comprobantes_venta.Agregar Percepcion       4   Categoría OTRO                              125.50
    click         xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_5']/div/div

Guardar Factura
    [Documentation]                             se guarda la factura generada
    log to console                              Guardar Factura
    comprobantes_venta.Guardar

Nueva Venta 2
    [Documentation]                             Ingresar al formulario de Comprobantes de Venta y genera una nueva Venta
    sleep                                       2s
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente             Responsable Inscripto   default   Nota de Crédito MiPyME (FCE)   Cuenta Corriente
    ${num_comprobante_2}      Get value         xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                         ${num_comprobante_2}
    comprobantes_venta.Mas Opciones
    comprobantes_venta.Mas Opciones - Observaciones        Caso53_${datetime}

Agregar Productos 2
    [Documentation]                             Se Completa la grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item           1   Carpeta         1       2500.50     0
    click           xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura 2
    [Documentation]                             se guarda la factura generada
    log to console                              Guardar Factura
    comprobantes_venta.Guardar

Nueva Venta 3
    [Documentation]                             Se dirije a Comprobantes de Ventas "+"
    Log To Console                              Seleccionar Comprobantes de Venta
    click                                       link=Ventas
    sleep                                       2s
    click                                       xpath=//li[@class='ventas']//li[1]//a[2]
    comprobantes_venta.Tipo Cliente             Monotributista   default   Nota de Crédito MiPyME (FCE)   Cuenta Corriente
    ${num_comprobante_3}      Get value         xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                         ${num_comprobante_3}
    comprobantes_venta.Mas Opciones
    comprobantes_venta.Mas Opciones - Observaciones    Caso53_${datetime}

Agregar Productos 3
    [Documentation]                             Se Completa la grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item           1   Cinta Papel         1       1256.9     0
    click                                       xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura 3
    [Documentation]                             se guarda la factura generada
    log to console                              Guardar Factura
    comprobantes_venta.Guardar

Selecciona FechaHasta
    [Documentation]                             Selecciona el campo fecha hasta y filtra por fecha de creacion del comprobante
    log to console                              Selecciona FechaHasta
    sleep                                       2s
    comprobantes_venta.Ir a Comprobantes de Venta
    # elegir las fechas actuales
    comprobantes_venta.Filtro Fecha_Desde
    comprobantes_venta.Filtro Fecha_Hasta

Ralizar busqueda
    [Documentation]                             Localiza las tres facturas realizadas utilizando el buscador ingresando la observación "caso53.."
    comprobantes_venta.Ir a Comprobantes de Venta
    comprobantes_venta.Buscador                 Caso53_${datetime}
    #VALIDACIONES
    #Columna Tipo
    assertText                      xpath=(//div[@column='3']//div)[1]         Nota de Crédito MiPyME (FCE)
    assertText                      xpath=(//div[@column='3']//div)[2]         Nota de Crédito MiPyME (FCE)
    assertText                      xpath=(//div[@column='3']//div)[3]         Factura
    #Columna Comprobante
    assertText                      xpath=(//div[@column='4']//div)[1]         ${num_comprobante_3}
    assertText                      xpath=(//div[@column='4']//div)[2]         ${num_comprobante_2}
    assertText                      xpath=(//div[@column='4']//div)[3]         ${num_comprobante_1}
    #Columna Importe Bruto
    assertText                      xpath=(//div[@column='8']//div)[1]         -1,256.90
    assertText                      xpath=(//div[@column='8']//div)[2]         -2,500.50
    assertText                      xpath=(//div[@column='8']//div)[3]          2,500.50
    #Columna Impuesto
    assertText                      xpath=(//div[@column='9']//div)[1]          0.00
    assertText                      xpath=(//div[@column='9']//div)[2]          -675.14
    assertText                      xpath=(//div[@column='9']//div)[3]          1,540.64
    #Columna total
    assertText                      xpath=(//div[@column='10']//div)[1]         -1,256.90
    assertText                      xpath=(//div[@column='10']//div)[2]         -3,175.64
    assertText                      xpath=(//div[@column='10']//div)[3]         4,041.14
    Page Should Contain Element     xpath=//span[contains(text(),'Total Mon. Principal: -391.40')]

TC_053
    [Documentation]                 Verificar grilla de comprobantes de venta después de crear cuatro tipos de comprobantes
    KW_053.Nueva Venta
    KW_053.Agregar Productos
    KW_053.Grilla Percepcion/Impuestos
    KW_053.Guardar Factura
    KW_053.Nueva Venta 2
    KW_053.Agregar Productos 2
    KW_053.Guardar Factura 2
    KW_053.Nueva Venta 3
    KW_053.Agregar Productos 3
    KW_053.Guardar Factura 3
    KW_053.Selecciona FechaHasta
    KW_053.Ralizar busqueda
