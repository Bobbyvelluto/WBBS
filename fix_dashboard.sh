#!/bin/bash
echo "🎯 Fix completo dashboard: nome maiuscolo, bottoni arancio, toggle_modulo attivo…"

# Backup file
cp templates/tesserino.html templates/tesserino_backup_$(date +%H%M%S).html
cp static/style.css static/style_backup_$(date +%H%M%S).css
cp app.py app_backup_$(date +%H%M%S).py

# ✅ 1. Forza nome allievo MAIUSCOLO
sed -i '' 's/{{ tess

\[1\]

 }}/{{ tess[1]|upper }}/g' templates/tesserino.html

# ✅ 2. Colorazione "Gestisci" e "QR" in arancione e dark bg
cat >> static/style.css <<'CSS'

/* 🎨 Bottoni Gestisci e QR in arancio */
.gestisci-btn,
.qr-btn {
  background-color: #2e2e2e;
  color: #f57c00;
  padding: 0.4rem 0.8rem;
  border-radius: 5px;
  text-transform: uppercase;
}
CSS

# ✅ 3. Aggiunge la route toggle_modulo in app.py
grep -q 'def toggle_modulo' app.py || cat >> app.py <<'PY'

@app.route("/toggle_modulo/<int:modulo_id>", methods=["POST"])
def toggle_modulo(modulo_id):
    # 🔧 Da personalizzare con la tua logica dati
    stato_attuale = ottieni_stato(modulo_id)
    nuovo_stato = "attivo" if stato_attuale == "annullato" else "annullato"
    aggiorna_stato(modulo_id, nuovo_stato)
    return redirect(request.referrer)
PY

# ✅ 4. Corregge il template per usare toggle_modulo
sed -i '' 's/annulla_modulo/toggle_modulo/g' templates/tesserino.html

echo "✅ Correzioni applicate! Rilancia il server Flask e accedi alla dashboard."
