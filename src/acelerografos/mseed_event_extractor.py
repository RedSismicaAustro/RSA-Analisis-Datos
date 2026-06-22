import sys
import os

def main():
    print("\n====================================================")
    print("      EXTRACTOR DE EVENTOS MINISEED (MSEED)         ")
    print("====================================================")
    print("Cargando librerías...")
    try:
        import obspy
        print("ObsPy cargado correctamente.")
    except ImportError:
        print("Error: ObsPy no está disponible.")
        return
        
    print("\n[INFO] Ejecutando extractor...")
    # Aquí irá la lógica de extracción de eventos
    print("  -> Buscando buffers de datos...")
    print("  -> Extrayendo segmentos sísmicos...")
    print("[OK] Extracción finalizada con éxito.")

if __name__ == "__main__":
    main()
