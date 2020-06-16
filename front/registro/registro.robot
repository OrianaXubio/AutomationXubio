
*** Keywords ***
Campo Email
    [Documentation]                     Completar el campo email
    [Arguments]                         ${email}
    Page Should Contain Element         id=newUserName
    input text                          id=newUserName          ${email}
Campo Nombre
    [Documentation]                     Completar el campo nombre
    [Arguments]                         ${nombre}
    Page Should Contain Element         id=newNombre
    input text                          id=newNombre            ${nombre}
Campo Password
    [Documentation]                     Completar el campo password
    [Arguments]                         ${password}
    Page Should Contain Element         id=newPassword
    input password                      id=newPassword          ${password}
Campo Telefono
    [Documentation]                     Completar el campo telefono
    [Arguments]                         ${telefono}
    Page Should Contain Element         id=newTelefono
    input text                          id=newTelefono          ${telefono}
Combobox Pais
    [Documentation]                     Seleccionar el pais
    [Arguments]                         ${pais}
    Select from list by label           id=select_pais          ${pais}
Radiobutton Tipo
    [Documentation]                     Seleccionar tipo de compania (soyEmpresa - soyContador)
    [Arguments]                         ${tipo}
    Select radio button                 soyContador             ${tipo}
CheckBox Terminos
    [Documentation]                     Seleccionar los terminos
    Select CheckBox                     id=leiTerminos
Boton Crear Cuenta
    [Documentation]                     Boton para crear una cuenta
    Page Should Contain Element         id=botonEnviar
    Click Element                       id=botonEnviar
# ==============================================================
Completar Formulario de Registro
    [Documentation]                     Completar el formulario de Alta
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