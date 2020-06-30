*** Settings ***
Library             SeleniumLibrary
Library             DateTime

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Selecciona Fecha_Hasta
    [Documentation]                             Selecciona el campo fecha hasta
    log to console                              Selecciona Fecha_Hasta
    comprobantes_venta.Ir a Comprobantes de Venta
    comprobantes_venta.Filtro Fecha_Hasta

Realiza Nueva Venta_1
    [Documentation]                             Realiza una Venta con cliente RI
    comprobantes_venta.Ir a Nueva Venta
    ${CurrentDate}=     Get Current Date        result_format=%Y-%m-%d %H:%M:%S     #.%f
    ${datetime}=       Convert Date             ${CurrentDate}      datetime
    Set Global Variable                         ${datetime}
    comprobantes_venta.Tipo Cliente             Responsable Inscripto   default   Factura   Cuenta Corriente
    ${num_comprobante_1}      Get value         xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                         ${num_comprobante_1}
    sleep                                       1s
    comprobantes_venta.Mas Opciones
    comprobantes_venta.Mas Opciones - Observaciones     Caso25_${datetime}

Agregar Productos_1
    [Documentation]                               Se Completa la grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item RI            1   Carpeta         1       2500.50     0
    click                                         xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar_1
      comprobantes_venta.Guardar

Realizar Nueva Venta_2
    [Documentation]                               Realiza una Venta con cliente Monotributista
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                Monotributista   default   Factura   Cuenta Corriente
    ${num_comprobante_2}      Get value            xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                            ${num_comprobante_2}
    comprobantes_venta.Mas Opciones
    comprobantes_venta.Mas Opciones - Observaciones        Caso25_${datetime}

Agregar Productos_2
    [Documentation]                                   Se Completa la grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item CF                1   Carpeta         1       3679     0
    click                                             xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar_2
      comprobantes_venta.Guardar

Realizar Nueva Venta_3
    [Documentation]                                    Realiza una Venta con cliente Responsable Inscripto 2
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                    Responsable Inscripto 2   default   Factura   Cuenta Corriente
    ${num_comprobante_3}      Get value                xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                                ${num_comprobante_3}
    comprobantes_venta.Mas Opciones
    comprobantes_venta.Mas Opciones - Observaciones    Caso25_${datetime}

Agregar Productos_3
    [Documentation]                                    Se Completa la grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item RI                 1   Carpeta         1       4582     0
    click                                              xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar_3
    comprobantes_venta.Guardar

Ralizar busqueda
   [Documentation]                                     Localiza las tres facturas realizadas utilizando el buscador ingresando la observación "caso25.."
    comprobantes_venta.Ir a Comprobantes de Venta
    comprobantes_venta.Buscador                        Caso25_${datetime}

Seleccionar Facturas
    [Documentation]                                    Selecciona las facturas en el checkbox
    Select Checkbox                                    xpath=(//input[@class='itemCheckbox'])[1]
    Select Checkbox                                    xpath=(//input[@class='itemCheckbox'])[2]
    Select Checkbox                                    xpath=(//input[@class='itemCheckbox'])[3]

Cobrar Factura
    [Documentation]                                    Hace click en cobrar , Selecciona un medio de cobro, Click en Aceptar
    click                                              xpath=//a[contains(@class,'TOOLBARBtnStandard agrupador')]
    click                                              Link=Cobrar
    click                                              xpath=//input[@id='NAME_INSTRUMENTOCANCELACIONCOBRO_0']
    type                                               xpath=//input[@id='NAME_INSTRUMENTOCANCELACIONCOBRO_0']          Banco
    click                                              xpath=//tr[contains(@class,'checked')]//td[contains(text(),'Banco')]
     # campo fecha
    ${dia1}=        Get Value                          xpath=//input[@id='FechaCobro_Day']
    ${mes1}=        Get Value                          xpath=//input[@id='FechaCobro_Month']
    ${anio1}=       Get Value                          xpath=//input[@id='FechaCobro_Year']
    ${dia}=         Convert To Integer                 ${dia1}
    ${mes}=         Convert To Integer                 ${mes1}
    ${anio}=        Convert To Integer                 ${anio1}
    Should Be Equal      ${dia}                        ${datetime.day}
    Should Be Equal      ${mes}                        ${datetime.month}
    Should Be Equal      ${anio}                       ${datetime.year}
    click                                               xpath=//td//a[@id='ACEPTAR_0']

Validaciones
    [Documentation]                                             Realiza las validacion de los campos del Pop-up
    comprobantes_venta.Validacion Campos Cobro Pop-up           0       Responsable Inscripto       ${num_comprobante_1}        Pesos Argentinos        1.00        3,175.64
    comprobantes_venta.Validacion Campos Cobro Pop-up           1       Monotributista              ${num_comprobante_2}        Pesos Argentinos        1.00        3,679.00
    comprobantes_venta.Validacion Campos Cobro Pop-up           2       Responsable Inscripto 2     ${num_comprobante_3}        Pesos Argentinos        1.00        5,819.14

Detalle del proceso Pop-up
    [Documentation]                     Comprueba que aparezca los campos en Detalle del proceso
    Page Should Contain Element         xpath=//tr[1]//td[contains(text(),' para el cliente: Monotributista')]
    Page Should Contain Element         xpath=//tr[2]//td[contains(text(),' para el cliente: Responsable Inscripto')]
    Page Should Contain Element         xpath=//tr[3]//td[contains(text(),' para el cliente: Responsable Inscripto 2')]
    click                               xpath=//a[@id="btnOK"]
    Wait Until Element Is Not Visible   xpath=//div[@id="overDiv"]
