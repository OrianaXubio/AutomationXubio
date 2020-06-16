import subprocess


args = [
        'robot',
        '-d', 'reporte',
        #'tests/ventas/comprobantes_de_venta/TC_015.robot'
        'suites/suite.robot'
        ]

subprocess.Popen(args)
