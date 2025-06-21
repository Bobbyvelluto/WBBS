#!/bin/bash
echo "🚀 Applico patch completa WBBS: stile + backend..."

# 🧾 Backup
cp templates/tesserino.html templates/tesserino_backup_$(date +%H%M%S).html
cp static/style.css static/style_backup_$(date +%H%M%S).css
cp app.py app_backup_$(date +%H%M%S).py

# 🆙 Forza maiuscolo nel tesserino
sed -i '' 's/{{ tess

\[1\]

 }}/{{ tess[1]|upper }}/g' templates/tesserino.html

# 🎨 Bottoni Gestisci e QR arancioni
cat >> static/style.css <<'CSS'

/* Bottoni arancioni eleganti */
.gestisci-btn,
.qr-btn {
  background-color: #2b2b2b;
  color: #f57c00;
  padding: 0.4rem 0.8rem;
  border-radius: 6px;
  text-transform: uppercase;
}
CSS

# 🔁 Corregge nome endpoint in tesserino.html
sed -i '' 's/url_for('"'"'annulla_modulo'"'"'/url_for('"'"'toggle_modulo'"'"'/g' templates/tesserino.html

# ➕ Aggiunge route toggle_modulo solo se non presente
grep -q 'def toggle_modulo' app.py || cat >> app.py <<'PY'

@app.route("/toggle_modulo/<int:modulo_id>", methods=["POST"])
def toggle_modulo(modulo_id):
    # 🔧 Personalizza in base alla tua struttura dati
    stato_attuale = ottieni_stato(modulo_id)
    nuovo_stato = "attivo" if stato_attuale == "annullato" else "annullato"
    aggiorna_stato(modulo_id, nuovo_stato)
    return redirect(request.referrer)
PY

echo "✅ Completato! Rilancia Flask e la dashboard WBBS sarà aggiornata."
