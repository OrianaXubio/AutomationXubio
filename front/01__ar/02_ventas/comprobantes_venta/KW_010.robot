*** Settings ***
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Nota de Credito A
    [Documentation]                       creacion de una nota de credito A
    log to console                          Nota de Credito A
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente       Responsable Inscripto   default     Factura     Cuenta Corriente

Grilla Productos
    [Documentation]                     se completan los campos de productos
    log to console                      Grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item RI    1   Carpeta         1       2500.50     0
    comprobantes_venta.Agregar Item RI    2   Alquiler        1       16500       10
    comprobantes_venta.Agregar Item RI    3   Cinta Papel     2.5     500         0
    comprobantes_venta.Agregar Item RI    4   Goma de borrar  4       120         0
    comprobantes_venta.Agregar Item RI    5   Carátulas       7       25          0
    comprobantes_venta.Agregar Item RI    6   Carátulas       2       -25         0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_7']/div/div

Grilla Percepcion/Impuestos
    [Documentation]                     se completan los campos de percepcion/impuestos
    log to console                      Grilla Percepcion/Impuestos
    sleep   1s
    click    xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion      1   Ingresos Brutos Buenos Aires (Percepción)   250
    comprobantes_venta.Agregar Percepcion      2   IVA                                         130
    comprobantes_venta.Agregar Percepcion      3   Impuestos Internos                          360
    comprobantes_venta.Agregar Percepcion      4   Categoría OTRO                              125.50
    comprobantes_venta.Borrar Item             5

Guardar Factura
    [Documentation]                     se guarda la factura generada
    log to console                      Guardar Factura
    comprobantes_venta.Guardar

Validaciones
    [Documentation]                     validacion de columnas importe, iva, total, totalizadores
    ...                                 y letra del comprobante
    log to console                      Validaciones
    # Verificacion del campo Operación Sujeta a Retención
    Checkbox Should Not Be Selected              xpath=//div[@id="masOpcionesWrapper"]/div[25]/div[2]/div/input
    #Columna Importe
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_1']/div           2,500.50
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_2']/div           14,850.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_3']/div           1,250.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_4']/div           480.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_5']/div           175.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_Importe_6']/div            -50.00
    #Columna Iva
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_1']/div    675.13
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_2']/div    3,118.50
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_3']/div    0.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_4']/div    24.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_5']/div    4.38
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_6']/div    -1.25
    #Columna Total
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_1']/div       3,175.64
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_2']/div       17,968.50
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_3']/div       1,250.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_4']/div       504.00
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_5']/div       179.38
    assertText                                  xpath=//td[@id='TransaccionCVItems_ImporteTotal_6']/div       -51.25

    comprobantes_venta.Validacion Botones
    comprobantes_venta.Letra Numero Comprobante       A
    comprobantes_venta.Total Bruto                    19205.5000
    comprobantes_venta.Total Impuestos                4686.2600
    comprobantes_venta.Total                          23891.7600
    # Se guarda el numero de comprobante en una variable
    ${num_comprobante}      Get value           xpath=//div[@name='wdg_NumeroDocumento']//input
    Set Global Variable                         ${num_comprobante}

Ir a Crear Nota de Credito
    [Documentation]                     se validan los datos en todos los campos
    log to console                      Ir a Crear Nota de Credito
    click                               xpath=//a[@id='generarNotaCredito']
    verifyText                          xpath=//h1[@id='fafPopUpTitle']/span            Importes a Aplicar por Factura
    Page Should Contain Element         xpath=//input[@id='CLIENTE_0' and @value ="Responsable Inscripto"]
    Page Should Contain Element         xpath=//input[@id='DOCUMENTO_0' and @value="Factura de Venta N° ${num_comprobante}"]
    Page Should Contain Element         xpath=//input[@id='IMPORTE_0' and @value ="23,891.76"]
    click                               id=ACEPTAR_0
    Page Should Contain Element         xpath=//div[@id="seccionTitulo"]//div[contains(text(),"Nuevo - Responsable Inscripto - Comprobante de Venta")]
    Page Should Contain Element         xpath=(//div[@name='wdg_Organizacion']//input[@value='Responsable Inscripto'])[2]
    Page Should Contain Element         xpath=//div[@name="wdg_PuntoVenta"]//input[@value="0001"]
    Page Should Contain Element         xpath=//div[@name="wdg_NumeroDocumento"]//input[@value="${num_comprobante}"]
    #Columna Importe
    assertText                          xpath=//td[@id='TransaccionCVItems_Importe_1']/div           2,500.50
    assertText                          xpath=//td[@id='TransaccionCVItems_Importe_2']/div           14,850.00
    assertText                          xpath=//td[@id='TransaccionCVItems_Importe_3']/div           1,250.00
    assertText                          xpath=//td[@id='TransaccionCVItems_Importe_4']/div           480.00
    assertText                          xpath=//td[@id='TransaccionCVItems_Importe_5']/div           175.00
    assertText                          xpath=//td[@id='TransaccionCVItems_Importe_6']/div            -50.00
    #Columna Iva
    assertText                          xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_1']/div    675.13
    assertText                          xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_2']/div    3,118.50
    assertText                          xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_3']/div    0.00
    assertText                          xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_4']/div    24.00
    assertText                          xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_5']/div    4.38
    assertText                          xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_6']/div    -1.25
    #Columna Total
    assertText                          xpath=//td[@id='TransaccionCVItems_ImporteTotal_1']/div       3,175.64
    assertText                          xpath=//td[@id='TransaccionCVItems_ImporteTotal_2']/div       17,968.50
    assertText                          xpath=//td[@id='TransaccionCVItems_ImporteTotal_3']/div       1,250.00
    assertText                          xpath=//td[@id='TransaccionCVItems_ImporteTotal_4']/div       504.00
    assertText                          xpath=//td[@id='TransaccionCVItems_ImporteTotal_5']/div       179.38
    assertText                          xpath=//td[@id='TransaccionCVItems_ImporteTotal_6']/div       -51.25

    sleep  1s
    click                               xpath=(//div[@name="wdg_MostrarPercepciones"])[2]
    assertText                          xpath=(//td[@id='TransaccionCVItemsPercepciones_Importe_1']/div)[2]    250.00
    assertText                          xpath=(//td[@id='TransaccionCVItemsPercepciones_Importe_2']/div)[2]    130.00
    assertText                          xpath=(//td[@id='TransaccionCVItemsPercepciones_Importe_3']/div)[2]    360.00
    assertText                          xpath=(//td[@id='TransaccionCVItemsPercepciones_Importe_4']/div)[2]    125.50

    Page Should Contain Element         xpath=(//div[@name="wdg_TotalGravado"]//input[@value="19205.50"])[1]
    Page Should Contain Element         xpath=(//div[@name="wdg_TotalImpuestos"]//input[@value="4686.26"])[1]
    Page Should Contain Element         xpath=(//div[@name="wdg_Total"]//input[@value="23891.76"])[1]
    click                               xpath=(//a[contains(text(),'Guardar')])[3]

Ir a Aplicaciones
    [Documentation]         se valida que existan los campos en el popup
    log to console          Ir a Aplicaciones
    click           id=FacturaVenta_openVinculacionCuentaCorriente
    assertText      xpath=//div[3]/div/div[2]/div/div/div[2]/table/tbody/tr[2]/td[2]/div/div    Aplicado
    #assertText      xpath=//div[3]/div/div[2]/div/div[2]/div[2]/div/div[2]/div                  23,891.76
    assertText      xpath=//div[3]/div/div[2]/div/div/div[2]/table/tbody/tr[2]/td[3]/div/div    Pendiente
    #assertText      xpath=//div[3]/div/div[2]/div/div[2]/div[2]/div/div[3]/div                  0.00
    assertText      xpath=//div[3]/div/div[2]/div/div/div[2]/table/tbody/tr[2]/td[4]/div/div    Documento Destino
    #assertText      link=Nota de Crédito N° ${num_factura}                                      Nota de Crédito N° ${num_factura}
    assertText      xpath=//div[3]/div/div[2]/div/div/div[2]/table/tbody/tr[2]/td[5]/div/div    Fecha Aplic.
    #assertText      xpath=//div[3]/div/div[2]/div/div[2]/div[2]/div/div[5]/div                  08-06-2020
    click           id=APLICACIONSALIR_0