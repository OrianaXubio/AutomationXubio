*** Keywords ***
Validar Alta Usuario
    Wait Until Page Contains element    //iframe[@id='content']                     timeout= 1m
    Select Frame                        //iframe[@id='content']
    sleep   10s
    #Title Should Be                     ¡TE DAMOS LA BIENVENIDA A XUBIO!
    Wait Until Page Contains element    xpath=//h2[contains(text(),'¡TE DAMOS LA BIENVENIDA A XUBIO!')]
    Unselect Frame
    Title Should Be                     Xubio - ¡BIENVENIDOS A XUBIO CONTADORES!
    Element Should Contain              xpath=(//li[@class='username']//span)[2]      ${nombre}