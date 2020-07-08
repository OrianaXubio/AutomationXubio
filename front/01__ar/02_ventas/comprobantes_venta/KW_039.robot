*** Settings ***
Library             SeleniumLibrary
Library             DateTime

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Keywords ***
Ir a Lista de Precios
    [documentation]                                                 Ingresar a la "Lista de precios 1" , tildar la opción "Es default" y hace click en "Guardar"
     log to console                                                 Ir a Lista de Precios
     click                                                          link=Ventas
     comprobantes_venta.Ir a Lista de Precios
     comprobantes_venta.Buscador                                    Lista de precios 1
     #Selecciona la Lista
     Select Checkbox                                                xpath=(//input[@class='itemCheckbox'])[1]
     click                                                          xpath=//a[contains(text(),'Lista de Precios 1')]
     #Selecciona la opcion es Default
     Select Checkbox                                                xpath=//div[@name='wdg_EsDefault']//input
     click                                                          xpath=//a[@id='_onSave']

Ir a Comprobantes de Venta
    [Documentation]                                                 Se dirije a Comprobantes de Ventas "+"
     click                                                          link=Ventas
     click                                                          xpath=//li[@class='ventas']//li[1]//a[2]
     # seleccionar cliente
     click                                                          css=div[name="wdg_Organizacion"] > div.selector > input[type="textbox"]
     type                                                           css=div[name="wdg_Organizacion"] > div.selector > input[type="textbox"]          Monotributista
     click                                                          xpath=//td/div/table/tbody/tr/td
     comprobantes_venta.Mas Opciones
     Page Should Contain Element                                   xpath=//input[@value='Lista de Precios 1 (Pesos Argentinos)']

Agregar Producto
    [Documentation]                                                Se Completa la grilla Productos
    #Selecciona el producto
     click                                                         xpath=//td[@id='TransaccionCVItems_ProductoID_1']/div
     type                                                          xpath=//td[2]/div/div/div/input                                        Alquiler (21%)
     click                                                         xpath=//td/div/table/tbody/tr/td
     #Ingresa la cantidad
     click                                                         xpath=//td[@id='TransaccionCVItems_Cantidad_1']/div
     sendKeys                                                      xpath=//td[@id='TransaccionCVItems_Cantidad_1']/div                        DELETE
     type                                                          xpath=//td[@id='TransaccionCVItems_Cantidad_1']/div     1
     sendKeys                                                      xpath=//td[@id='TransaccionCVItems_Cantidad_1']/div                           TAB
     #Este campo se autocompleta
     sendKeys                                                      xpath=//td[@id='TransaccionCVItems_PrecioConIvaIncluido_1']/div               TAB
     sendKeys                                                      xpath=//td[@id='TransaccionCVItems_PorcentajeDescuento_1']/div                TAB
     #validacion
      assertText                                                   xpath=//td[@id='TransaccionCVItems_ProductoID_1']/div                      Alquiler (21%)
      sleep          1s
      assertText                                                   xpath=//td[@id='TransaccionCVItems_PrecioConIvaIncluido_1']/div            45,000.0000

Ir a Lista de Precios_2
    [Documentation]                                                Ingresar a la "Lista de precios 1" , destilda la opción "Es default" y hace click en "Guardar"
    click                                                          link=Ventas
    comprobantes_venta.Ir a Lista de Precios
    comprobantes_venta.Buscador                                    Lista de precios 1
    #Selecciona la Lista
     Select Checkbox                                               xpath=(//input[@class='itemCheckbox'])[1]
     click                                                         xpath=//a[contains(text(),'Lista de Precios 1')]
     #Selecciona destilda opcion es Default
     Unselect Checkbox                                             xpath=//div[@name='wdg_EsDefault']//input
     Checkbox Should Not Be Selected                               xpath=//div[@name='wdg_EsDefault']//input
     click                                                         xpath=//a[@id='_onSave']
