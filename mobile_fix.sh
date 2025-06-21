#!/bin/bash
echo "📱 Ottimizzazione visuale per dispositivi mobili…"

# Backup style.css
cp static/style.css static/style_backup_mobile.css

# Aggiunge media query per mobile
cat >> static/style.css <<'CSS'

/* 📱 Dashboard Mobile Fix */
@media screen and (max-width: 600px) {
  .azioni a {
    padding: 0.3rem 0.5rem;
    font-size: 0.7rem;
    margin: 0.1rem;
    display: inline-block;
  }
}

@media screen and (max-width: 500px) {
  .azioni {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.3rem;
  }
}

@media screen and (max-width: 400px) {
  body {
    font-size: 90%;
  }
}
CSS

echo "✅ Style aggiornato! Ricarica la dashboard su iPhone per vedere le differenze"
