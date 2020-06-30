*** Settings ***
Documentation
Library             SeleniumLibrary
Library             DateTime

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Realizar una Venta
    [Documentation]                                     Realiza un comprobante de venta en dolares
    log to console                                      Realizar una Venta
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                     Exento   default   Factura   Cuenta Corriente
    comprobantes_venta.Mas Opciones - Moneda            Dólares        72

Agregar Productos
    [Documentation]                                    Se Completa la grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item CF                 1   Carpeta         1      1250     0
    click                                              xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar
      comprobantes_venta.Guardar

Cobrar Factura
    [Documentation]                                                 selecciona el boton Cobrar , se modifica y completa los campos de la grilla.
    ...                                                             Tambien se efectuan las validaciones de los campos
    ${CurrentDate}=     Get Current Date                            result_format=%Y-%m-%d %H:%M:%S.%f
    ${datetime}=        Convert Date            ${CurrentDate}       datetime
    comprobantes_venta.Ir a Cobrar
    Checkbox Should Be Selected                                    xpath=//input[@id='USACOTIZACIONORIGEN_0']
    comprobantes_venta.Validacion de todos los campos en la grilla cobro
    comprobantes_venta.Completar Campos en Cobrar                   1000
    sleep                                                           1s
    comprobantes_venta.validacion Cliente Formulario Cobranza       Exento
    comprobantes_venta.Validacion de Letra (Pop-up)                 X
    #guarda el numero de factura
    ${doc_destino}      Get value                                   xpath=//div[@id='df_popup']//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                                             ${doc_destino}
    # campo fecha
    ${dia1}=        Get Value                                      xpath=(//div[@name="wdg_Fecha"])[2]//input[@name="day"]
    ${mes1}=        Get Value                                      xpath=(//div[@name="wdg_Fecha"])[2]//input[@name="month"]
    ${anio1}=       Get Value                                      xpath=(//div[@name="wdg_Fecha"])[2]//input[@name="year"]
    ${dia}=         Convert To Integer                             ${dia1}
    ${mes}=         Convert To Integer                             ${mes1}
    ${anio}=        Convert To Integer                             ${anio1}
    Should Be Equal      ${dia}                                    ${datetime.day}
    Should Be Equal      ${mes}                                    ${datetime.month}
    Should Be Equal      ${anio}                                   ${datetime.year}
    comprobantes_venta.click en mas opciones (Pop-up)
    comprobantes_venta.Validacion Moneda (Pop-up)                   Dólares
    comprobantes_venta.validacion Mensaje Cotizacion                Se utiliza la cotización de la factura origen
    comprobantes_venta.Validacion Importe Cobranza                  1       72,000.00
    comprobantes_venta.Total Inst De Cobro                          72000.00
    comprobantes_venta.Total Cuenta Corriente                       72000.00
    comprobantes_venta.Completar Campos en Grilla Cobro             1           Banco            Banco Galicia
    click                                                           xpath=//div[@id="df_popup"]//a[@id="_onSave"]

Ir a Aplicaciones
    [Documentation]                                                ingresa a "Aplicaciones" y luego oprime "Salir"
    comprobantes_venta.Seleccionar Aplicaciones
    comprobantes_venta.Validacion Campos Aplicaciones              1,000.00     250.00     ${doc_destino}      Dólares     72.00
    comprobantes_venta.Salir de Aplicaciones











