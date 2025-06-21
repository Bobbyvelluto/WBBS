#!/bin/bash

echo "🔧 Applico ottimizzazioni responsive…"

# Backup dei file
cp templates/tesserino.html templates/tesserino_backup.html
cp static/style.css static/style_backup.css

# Aggiorna moduli nel tesserino
sed -i '' 's/width: 60px;/width: 50px;/g' templates/tesserino.html
sed -i '' 's/height: 60px;/height: 50px;/g' templates/tesserino.html
sed -i '' 's/line-height: 60px;/line-height: 50px;/g' templates/tesserino.html

# Aggiunge media query per bottoni nel CSS
cat >> static/style.css <<'CSS'

/* 📱 Responsive fix per mobile (copialink ed elimina) */
@media screen and (max-width: 600px) {
  .copia-btn,
  .elimina-btn {
    padding: 0.3rem 0.5rem;
    font-size: 0.75rem;
    margin: 0 0.2rem;
  }
}
CSS

echo "✅ Ottimizzazione completata! Ricarica nel browser su iPhone 😉"
