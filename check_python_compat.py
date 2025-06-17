import sys
import pkg_resources
import requests

PYTHON_VERSION = f"{sys.version_info.major}.{sys.version_info.minor}"
REQ_FILE = "requirements.txt"

def check_package(name, version):
    url = f"https://pypi.org/pypi/{name}/{version}/json"
    try:
        res = requests.get(url, timeout=5)
        data = res.json()
        requires_python = data["info"].get("requires_python")
        if requires_python:
            if PYTHON_VERSION not in requires_python:
                print(f"⚠️  {name}=={version} richiede Python {requires_python} (tu hai {PYTHON_VERSION})")
        else:
            print(f"✅ {name}=={version} - Nessuna restrizione di versione trovata.")
    except:
        print(f"❓ {name}=={version} - Non trovato o errore nella richiesta.")

def main():
    print(f"🔎 Controllo compatibilità con Python {PYTHON_VERSION}...\n")
    with open(REQ_FILE) as f:
        for line in f:
            if "==" in line:
                name, version = line.strip().split("==")
                check_package(name, version)

if __name__ == "__main__":
    main()

