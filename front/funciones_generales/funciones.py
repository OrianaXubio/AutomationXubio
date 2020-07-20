import os
from selenium import webdriver
from selenium.webdriver.chrome import webdriver


def ruta_archivo(path):
    """devuelve la ruta absoluta de donde se ejecuta el proyecto"""
    return os.path.abspath(path)


# def capabilities(browser):
#     if browser == 'chrome':
#         options = webdriver.ChromeOptions()
#         options.add_argument("--start-maximized")
#         prefs = {"profile.default_content_settings.popups": 0,
#                  "download.default_directory": r"queries\\",
#                  "directory_upgrade": True}
#         options.add_experimental_option("prefs", prefs)
#         return webdriver.Chrome(executable_path=Base.chromedriver_dir, chrome_options=options)
