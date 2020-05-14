import subprocess

args = [
        'robot',
        '-d', 'reporte',
        'test/registrar_usuario.robot'
        ]

subprocess.Popen(args)
