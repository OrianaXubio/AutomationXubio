*** Keywords ***
Titulo de la pagina
    Title Should Be                     Xubio - ¡BIENVENIDOS A XUBIO CONTADORES!
Nombre Del Usuario
    [Arguments]                         ${nombre}
    Element Should Contain              xpath=(//li[@class='username']//span)[2]      ${nombre}
Texto de Bienvenida
    Wait Until Page Contains element    xpath=//iframe[@id='content']                    # timeout= 1m
    Select Frame                        xpath=//iframe[@id='content']
    Wait Until Page Contains element    xpath=//h2[contains(text(),'¡TE DAMOS LA BIENVENIDA A XUBIO!')]     timeout= 1m
    Unselect Frame
#==========================================================
Validar Alta Usuario
    [Documentation]                     Valida que el usuario haya sido dado de alta en la pagina de Bienvenida
    Texto de Bienvenida
    Titulo de la pagina
    Nombre Del Usuario                  ${nombre}