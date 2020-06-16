
*** Keywords ***
Validar Conexion
    [Documentation]                     ingresa a xubio aceptando el la advertencia de https
    click element                       id=details-button
    click element                       id=proceed-link
    sleep   3s
