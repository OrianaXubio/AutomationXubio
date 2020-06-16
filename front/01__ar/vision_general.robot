*** Keywords ***
Validar Ingreso Al Sitio
    [Documentation]                     valida el ingreso a pagina principal en Vision General
    Wait Until Page Contains element    //iframe[@id='content']                     timeout= 1m
    Select Frame                        //iframe[@id='content']
    Wait Until Page Contains Element    xpath=//div[@class='pageWidth']             timeout= 1m
    Unselect Frame
    Title Should Be                     Xubio - Visión General

Ir a Inicio
    click                               xpath=//div[@id='bannerHeader']/a/h1
    Validar Ingreso Al Sitio