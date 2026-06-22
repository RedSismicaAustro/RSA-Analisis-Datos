import sys
import os
import subprocess

def verificar_entorno():
    print("====================================================")
    print("   SISTEMA DE ANÁLISIS DE ACELERÓGRAFOS (RSA)       ")
    print("====================================================")
    print(f"Ruta del intérprete: {sys.executable}")
    print(f"Versión de Python: {sys.version}\n")
    
    print("Verificando librerías científicas y de IA...")
    try:
        import tensorflow as tf
        import obspy
        print(f"  [OK] TensorFlow: {tf.__version__}")
        print(f"  [OK] ObsPy: {obspy.__version__}")
        print("\nVerificación de entorno completada con éxito.\n")
        return True
    except ImportError as e:
        print(f"  [ERROR] No se pudo cargar una dependencia crítica: {e}")
        return False

def ejecutar_script(nombre_script):
    # Obtiene la ruta absoluta del script hermano dentro de src/acelerografos/
    ruta_script = os.path.join(os.path.dirname(__file__), nombre_script)
    
    if not os.path.exists(ruta_script):
        print(f"\n[ERROR] El archivo {nombre_script} no se encuentra en {ruta_script}")
        return
        
    print(f"\n[INICIANDO] Ejecutando: {nombre_script}...")
    try:
        # Ejecuta el script usando el mismo intérprete de Python activo
        subprocess.run([sys.executable, ruta_script], check=True)
    except subprocess.CalledProcessError as e:
        print(f"\n[ERROR] El script finalizó con un código de error: {e}")
    except Exception as e:
        print(f"\n[ERROR] Ocurrió un fallo inesperado al ejecutar el script: {e}")
    print(f"[FINALIZADO] Retornando al menú principal.\n")

def menu_principal():
    while True:
        print("====================================================")
        print("                 MENÚ DE ANÁLISIS                   ")
        print("====================================================")
        print(" 1. Extractor de eventos miniSEED (mseed_event_extractor.py)")
        print(" 2. Inspector de eventos miniSEED (mseed_event_inspector.py)")
        print(" 0. Salir")
        print("====================================================")
        
        opcion = input("Seleccione una opción: ").strip()
        
        if opcion == "1":
            ejecutar_script("mseed_event_extractor.py")
        elif opcion == "2":
            ejecutar_script("mseed_event_inspector.py")
        elif opcion == "0" or opcion.lower() == "q":
            print("\nSaliendo del sistema de análisis de la RSA. ¡Hasta luego!")
            break
        else:
            print("\n[ERROR] Opción no válida. Intente de nuevo.\n")

def main():
    if verificar_entorno():
        menu_principal()
    else:
        print("\n[CRÍTICO] No se puede iniciar el menú debido a fallos en el entorno.")
        sys.exit(1)

if __name__ == "__main__":
    main()
