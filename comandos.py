import subprocess


args = [
        'robot',
        '-d', 'reporte',
        'tests/ventas/comprobantes_de_venta/TC_035.robot'
        # 'suites/suite_prueba.robot'
        ]

subprocess.Popen(args)
