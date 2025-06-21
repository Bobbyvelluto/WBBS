#!/bin/bash

echo "🛠️ Applico aggiornamenti dashboard WBBS..."

# Backup dei file originali
cp templates/tesserino.html templates/tesserino_backup_$(date +%H%M%S).html
cp static/style.css static/style_backup_$(date +%H%M%S).css

# 🔧 PATCH 1: Modifica tesserino.html — attivazione moduli cliccabili
sed -i '' 's|annulla_modulo|toggle_modulo|g' templates/tesserino.html
sed -i '' 's|{{ m

\[2\]

 == "annullato" }}|{{ "annullato" if m[2] == "annullato" else "" }}|g' templates/tesserino.html
sed -i '' 's|{{ m

\[1\]

 }}|{{ "X" if m[2] == "annullato" else m[1] }}|g' templates/tesserino.html

# 🔧 PATCH 2: Aggiunta stile bottoni Gestisci / QR
cat >> static/style.css <<'CSS'

/* 🎛️ Gestisci / QR bottoni */
.gestisci-btn,
.qr-btn {
  background-color: #2e2e2e;
  color: #fff;
  padding: 0.4rem 0.8rem;
  border-radius: 5px;
  text-transform: uppercase;
}
CSS

# 🔧 PATCH 3: Forza maiuscolo nome allievo
sed -i '' 's|{{ tess

\[1\]

 }}|{{ tess[1]|upper }}|g' templates/tesserino.html

# 🔧 PATCH 4: Stile avanzato box nome nel tesserino
sed -i '' '/.studente-nome {/!b;n;c\
  background-color: #5ca7d8;\
  border: 3px solid #5c0000;\
  border-radius: 12px;\
  padding: 0.8rem 2rem;\
  font-size: 3.2rem;\
  font-weight: bold;\
  text-transform: uppercase;\
  text-align: center;\
  color: #f57c00;\
  box-shadow: 0 4px 8px rgba(0,0,0,0.5);\
  text-shadow: 1px 1px 0 #2b2b2b, 2px 2px 4px rgba(0,0,0,0.4);' templates/tesserino.html

echo "✅ Dashboard aggiornata con successo! Rilancia Flask e ricarica su iPhone per vedere tutto."
