*** Settings ***
Resource            common.robot
Resource            ../01__ar/index_ar.robot
Resource            ../login/login.robot
Resource            ../01__ar/vision_general.robot
Resource            ../index.robot

*** Variables ***
${URL}              https://xubiotesting2.ddns.net/         # https://xubiotesting2.ddns.net/NXV/newlogin
${delay}            0s

*** Keywords ***
Ingresar Al Sitio
    [Documentation]                     Seteo del navegador, la url y el timeout de la sesion
    Open Browser                        ${URL}      chrome       #none     http://35.174.46.86:4444/wd/hub
    common.Validar Conexion
    Set Selenium Timeout                15s
    Set Selenium Implicit Wait          15s
    #Set Selenium Speed                  ${delay}
    Maximize Browser Window

Ingresar Al Sitio Login
    Ingresar Al Sitio
    login.Login