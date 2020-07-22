*** Settings ***
Library             SeleniumLibrary
Library             DateTime
Library             ../../../funciones_generales/funciones.py

Resource            ../../../funciones_generales/setup.robot
Resource            ../../../01__ar/vision_general.robot
Resource            ../../../funciones_generales/keywords.robot
Resource            ../../../01__ar/02_ventas/comprobantes_venta/comprobantes_venta.robot
Resource            ../../../funciones_generales/recursos.robot

*** Variables ***
${tipo}             Archivo

*** Keywords ***
Realiza una Nueva Venta
    [Documentation]                                     Realiza una venta con Cliente Monotributista
    log to console                                      Realiza una Nueva Venta
    comprobantes_venta.Ir a Nueva Venta
    comprobantes_venta.Tipo Cliente                     Monotributista   default   Factura   Cuenta Corriente

Agregar Productos
    [Documentation]                                     Se Completa la grilla Productos
    sleep   1s
    comprobantes_venta.Agregar Item                   1   Carpeta         1      2500.50     0
    click                                               xpath=//td[@id='TransaccionCVItems_internal_delete_column_2']/div/div

Guardar Factura
    comprobantes_venta.Guardar

Adjuntar Archivo
    [Documentation]                                     Selecciona un tipo de archivo y lo adjunta del ordenador
    click                                               xpath=//a[@id='_onFileAttach']
    ${archivo}=         funciones.ruta archivo         ./archivos_adjuntos/ArchivoXubio.pdf
    Select From List By Label                           xpath=//div[@class='FAFPopup']//select[@id='WDGADJUNTARTIPO_0']         ${tipo}
    Choose File                                         xpath=//input[@id='fileVerdad_0']                                       ${archivo}
    #Validaciones
    #campo Tipo
    Page Should Contain Element                         xpath=//div[@class='FAFPopup']//select[@id='WDGADJUNTARTIPO_0']
    #campo Archivo
    Page Should Contain Element                         xpath=//input[@id='fileVerdad_0']
    #Boton Adjuntar
    Page Should Contain Element                         xpath=//div[@class='FAFPopup']//a[@id='OK_0']
    #Boton Adjuntar
    click                                               xpath=//div[@class='FAFPopup']//a[@id='OK_0']
    #Valida que el Pop-up se haya cerrado
    Wait Until Element Is Not Visible                   xpath=//div[@id='df_popup']

Validacion Adjuntar Archivo
    Page Should Contain Element                         xpath=//span[@class='attachment'][contains(text(),'Adjuntos')]
    Page Should Contain Element                         xpath=//a[@class='fileName']

TC_035
    [Documentation]             Adjuntar un archivo a un comprobante de venta
    KW_035.Realiza una Nueva Venta
    KW_035.Agregar Productos
    KW_035.Guardar Factura
    KW_035.Adjuntar Archivo
    KW_035.Validacion Adjuntar Archivo