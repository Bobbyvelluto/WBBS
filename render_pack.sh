#!/bin/bash

echo "📦 Creo Procfile e requirements.txt per deploy WBBS su Render"

# Crea Procfile se non esiste
if [ ! -f Procfile ]; then
  echo "web: gunicorn app:app" > Procfile
  echo "✔️  Creato Procfile"
else
  echo "⚠️  Procfile già presente"
fi

# Crea requirements.txt base se non esiste
if [ ! -f requirements.txt ]; then
  echo -e "Flask\ngunicorn" > requirements.txt
  echo "✔️  Creato requirements.txt"
else
  echo "⚠️  requirements.txt già presente"
fi

# Aggiunta, commit e push su GitHub
git add Procfile requirements.txt
git commit -m "Setup Render deploy files"
git push

echo ""
echo "✅ Fatto! Ora vai su https://render.com/ → New → Web Service"
echo "   Collega il repo: Bobbyvelluto/WBBS"
echo "   Build command: pip install -r requirements.txt"
echo "   Start command: gunicorn app:app"
