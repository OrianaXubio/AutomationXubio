*** Keywords ***
Desloguearse
    Mouse Over                          xpath=(//li[@class='username']//span)[2]
    Wait Until Element Is Visible       xpath=//a[contains(text(),'Cerrar Sesión')]
    CLick Element                       xpath=//a[contains(text(),'Cerrar Sesión')]
    Wait Until Page Contains Element    xpath=//img[@class='img-fluid']
