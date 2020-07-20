import subprocess


args = [
        'robot',
        '-d', 'reporte',
        '-i', 'tc_053',
        # 'tests/ventas/comprobantes_de_venta/TC_039.robot'
        'suites/'
        ]

subprocess.Popen(args)
