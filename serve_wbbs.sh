#!/bin/bash

echo "📡 Avvio server Flask sulla porta 5050..."

# Recupera IP locale
IP=$(ipconfig getifaddr en0)

if lsof -i :5050 >/dev/null 2>&1; then
  echo "⚠️  La porta 5050 è già occupata. Uscita."
  exit 1
fi

echo "🔗 URL da aprire su iPhone:"
echo ""
echo "    http://$IP:5050/dashboard"
echo ""

# Avvia Flask
FLASK_APP=app.py flask run --host=0.0.0.0 --port=5050
