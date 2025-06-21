#!/bin/bash

echo "🔧 Controllo e inserisco route 'toggle_modulo'…"

# 1. Backup
cp app.py app_backup_toggle_$(date +%H%M%S).py

# 2. Verifica se la route è già definita
if ! grep -q 'def toggle_modulo' app.py; then
  echo "➕ Aggiungo @app.route per toggle_modulo..."

  # Inserisco la route prima del blocco 'if __name__ == "__main__":'
  awk '
  /if __name__ == "__main__"/ && !found {
    print "";
    print "@app.route(\"/toggle_modulo/<int:modulo_id>\", methods=[\"POST\"])";
    print "def toggle_modulo(modulo_id):";
    print "    # 👉 Sostituisci con la tua logica reali:";
    print "    stato_attuale = ottieni_stato(modulo_id)";
    print "    nuovo_stato = \"attivo\" if stato_attuale == \"annullato\" else \"annullato\"";
    print "    aggiorna_stato(modulo_id, nuovo_stato)";
    print "    return redirect(request.referrer)";
    print "";
    found=1
  }
  { print }
  ' app.py > tmp_app.py && mv tmp_app.py app.py
else
  echo "✅ Route 'toggle_modulo' già presente."
fi

echo "🎯 Patch completata. Ora riavvia Flask:"
echo ""
echo "    flask run --host=0.0.0.0 --port=5000"
echo ""
