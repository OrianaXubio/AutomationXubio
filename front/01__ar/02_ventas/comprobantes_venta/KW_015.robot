*** Settings ***
Documentation       Nueva venta
Library             SeleniumLibrary

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Recibo A
    [Documentation]                                       Creación de Recibo A al contado en pesos
    [Tags]                                                Recibo A
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                       Responsable Inscripto   default     Recibo     Contado

Agregar Productos
    sleep   1s
    comprobantes_venta.Agregar Item RI                    1   Carpeta         1       3002        0
    comprobantes_venta.Agregar Item RI                    2   Alquiler        1       18500       10
    comprobantes_venta.Agregar Item RI                    3   Cinta Papel     2.5     360         0
    click    xpath=//td[@id='TransaccionCVItems_internal_delete_column_4']/div/div

Grilla Percepcion/Impuestos
    sleep    1s
    click                                                 xpath=//input[@value='Percepciones e Impuestos']
    comprobantes_venta.Agregar Percepcion                 1   Ingresos Brutos Buenos Aires (Percepción)   250
    comprobantes_venta.Agregar Percepcion                 2   IVA                                         130
    comprobantes_venta.Agregar Percepcion                 3   Impuestos Internos                          360
    comprobantes_venta.Agregar Percepcion                 4   Categoría OTRO                              125.50
    click       xpath=//td[@id='TransaccionCVItemsPercepciones_internal_delete_column_5']/div/div

Grilla Instrumento de cobro
    sleep   1s
    comprobantes_venta.Agregar Instrumento De Cobro       1       Caja        Caja       Pesos Argentinos        1.000000          25,724.54
    click    xpath=//td[@id='TransaccionTesoreriaIngresoItems_internal_delete_column_2']/div/div

Guardar
    click    id=_onSave

Validaciones
    comprobantes_venta.Letra Numero Comprobante         A
    #validación de comprobante
    assertText                                          xpath=//div[@name='wdg_Tipo']//select//option[4]                Recibo
    #Validación condición de pago
    assertText                                          xpath=//div[@name='wdg_CondicionDePago']//select//option[2]     Contado
    #Columna Importe
    assertText                                          xpath=//td[@id='TransaccionCVItems_Importe_1']/div              3,002.00
    assertText                                          xpath=//td[@id='TransaccionCVItems_Importe_2']/div              16,650.00
    assertText                                          xpath=//td[@id='TransaccionCVItems_Importe_3']/div              900.00
    #Columna Iva
    assertText                                          xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_1']/div      810.54
    assertText                                          xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_2']/div      3,496.50
    assertText                                          xpath=//td[@id='TransaccionCVItems_ImporteImpuesto_3']/div      0.00
    #Columna Total
    assertText                                         xpath=//td[@id='TransaccionCVItems_ImporteTotal_1']/div          3,812.54
    assertText                                         xpath=//td[@id='TransaccionCVItems_ImporteTotal_2']/div          20,146.50
    assertText                                         xpath=//td[@id='TransaccionCVItems_ImporteTotal_3']/div          900.00
    #Verificacion de los totales
    comprobantes_venta.Total Bruto                     20552
    comprobantes_venta.Total Impuestos                 5172.54
    comprobantes_venta.Total                           25724.54
    comprobantes_venta.Total Cobranza                  25724.54

    vision_general.Ir a Inicio