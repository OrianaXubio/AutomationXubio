from datetime import date
from selenium import webdriver
from selenium.webdriver.chrome import webdriver
import pandas as pd


def fecha_actual():
    hoy = date.today()

# def capabilities(browser):
#     if browser == 'chrome':
#         options = webdriver.ChromeOptions()
#         options.add_argument("--start-maximized")
#         prefs = {"profile.default_content_settings.popups": 0,
#                  "download.default_directory": r"descargas\\",
#                  "directory_upgrade": True}
#         options.add_experimental_option("prefs", prefs)
#         return webdriver.Chrome(executable_path=Base.chromedriver_dir, chrome_options=options)


# def archivo_excel(archivo=None, columna=None, posicion=0):
#     """
#     :param archivo: Nombre del archivo sin la extension
#     :param columna: Titulo o nombre de la columna
#     :param posicion: fila del dato a obtener (comenzando de cero)
#     :return: devuelve el valor encontrado
#     """
#     xls = pd.ExcelFile("/home/juan/Descargas/{}.xls".format(archivo))
#     hoja = xls.parse(0)
#     ar1 = hoja[columna]
#     valor = ar1[int(posicion)]
#     return str(valor)
