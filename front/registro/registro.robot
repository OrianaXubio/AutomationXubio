
*** Keywords ***
Campo Email
    [Arguments]                         ${email}
    Page Should Contain Element         id=newUserName
    input text                          id=newUserName          ${email}
Campo Nombre
    [Arguments]                         ${nombre}
    Page Should Contain Element         id=newNombre
    input text                          id=newNombre            ${nombre}
Campo Password
    [Arguments]                         ${password}
    Page Should Contain Element         id=newPassword
    input password                      id=newPassword          ${password}
Campo Telefono
    [Arguments]                         ${telefono}
    Page Should Contain Element         id=newTelefono
    input text                          id=newTelefono          ${telefono}
Combobox Pais
    [Arguments]                         ${pais}
    Select from list by label           id=select_pais          ${pais}
Radiobutton Tipo
    [Arguments]                         ${tipo}
    Select radio button                 soyContador             ${tipo}
CheckBox Terminos
    Select CheckBox                     id=leiTerminos
Boton Crear Cuenta
    Page Should Contain Element         id=botonEnviar
    Click Element                       id=botonEnviar
# ==============================================================
Completar Formulario de Registro
#    [Arguments]                         ${email}    ${nombre}   ${password}     ${telefono}     ${pais}
    Location Should Be                  https://xubiotesting2.ddns.net/NXV/registro
    Wait Until Page Contains            Registrate gratis
    Campo Email                         ${email}
    Campo Nombre                        ${nombre}
    Campo Telefono                      ${telefono}
    Campo Password                      ${password}
    Combobox Pais                       ${pais}
    Radiobutton Tipo                    ${tipo}
    CheckBox Terminos
    Checkbox Should Be Selected         id=leiTerminos
    Boton Crear Cuenta