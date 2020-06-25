*** Keywords ***
Ir a Mi Empresa
    sleep   2s
    click           link=Configuración
    sleep   1s
    click           link=Mi Empresa
    verifyText      xpath=//div[@id='seccionTitulo']/div        Mi Empresa

Elegir Categoria de Empresa
    [Arguments]         ${categoria}
    Ir a Mi Empresa
    wait until keyword succeeds     20x      1s       clear element text       xpath=//div[@name="wdg_CategoriaFiscal"]//input
    type        xpath=//div[@name="wdg_CategoriaFiscal"]//input             ${categoria}
    click       xpath=//td/div/table/tbody/tr/td
    Guardar Cambios De Empresa
    click       id=showAskPopupYesButton

Mas Opciones-Facturacion M
    click                           xpath=//input[@value='Más Opciones']
    wait until keyword succeeds     10x      1s     Select Checkbox                 xpath=//div[@name='wdg_FacturasM']//input

Destildar Facturacion M
    click                           xpath=//input[@value='Más Opciones']
    wait until keyword succeeds     10x      1s     Unselect Checkbox                 xpath=//div[@name='wdg_FacturasM']//input

Guardar Cambios de Empresa
    sleep   1s
    click                           xpath=//div//a[@id="_onSave"]