#!/bin/bash
echo "🎯 Ottimizzazione completa layout mobile WBBS..."

# Backup
cp static/style.css static/style_backup_compact_$(date +%H%M%S).css

# Aggiungi font FrontPageNeuve e stile nome verde
cat >> static/style.css <<'CSS'

@font-face {
  font-family: 'FrontPageNeuve';
  src: url('/static/fonts/FrontPageNeuve.ttf') format('truetype');
}

.studente-nome {
  font-family: 'FrontPageNeuve', sans-serif;
  color: #00cc66;
  font-size: 2.4rem;
  text-transform: uppercase;
  border: 2px solid #333;
  border-radius: 10px;
  padding: 0.5rem 1rem;
  text-align: center;
}
CSS

# Aggiungi media query per comandi compatti
cat >> static/style.css <<'CSS'

@media screen and (max-width: 600px) {
  .azioni {
    display: flex;
    flex-wrap: nowrap;
    justify-content: space-evenly;
    gap: 0.2rem;
  }

  .azioni a {
    font-size: 0.65rem;
    padding: 0.2rem 0.3rem;
    margin: 0 0.1rem;
    border-radius: 4px;
    white-space: nowrap;
  }
}
CSS

echo "✅ Ottimizzazione visiva completata! Ricarica la dashboard su iPhone"
