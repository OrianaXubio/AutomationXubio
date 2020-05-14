*** Settings ***
Documentation       Suite description
Library             SeleniumLibrary
Resource            ../front/funciones_generales/common.robot
Resource            ../front/index.robot
Resource            ../front/01__ar/index_ar.robot
Resource            ../front/login/login.robot
Resource            ../front/registro/registro.robot
Resource            ../front/01__ar/vision_general.robot
Resource            ../front/registro/bienvenida.robot
Resource            ../front/desloguear/desloguear.robot

Suite Setup         Open Browser        ${URL}      chrome       none      http://35.174.46.86:4444/wd/hub
Suite Teardown      Close All Browsers

*** Variables ***
${URL}              https://xubiotesting2.ddns.net/ar/
${email}            test_nit50@nit.com
${password}         12345678
${nombre}           Juan Perez
${telefono}         110000000
${pais}             Argentina
${tipo}             soyContador

*** Test Cases ***
Registro de Usuario
    [Tags]      smoke
    common.Validar Conexion
    Maximize Browser Window
    index_ar.Registrarme Ar
    registro.Completar Formulario de Registro
    bienvenida.Validar Alta Usuario
Salir del Sistema
    [Tags]      smoke
    desloguear.Desloguearse
Reingresar al Sistema
    [Tags]      smoke
    Elegir Pais                         ${pais}
Login
    index_ar.Loguearse Ar
    login.Completar Formulario de Login
