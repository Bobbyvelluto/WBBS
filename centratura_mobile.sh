#!/bin/bash
echo "📐 Ottimizzo centratura e posizione verticale..."

# Backup
cp static/style.css static/style_backup_center_$(date +%H%M%S).css

# Aggiungo regole CSS
cat >> static/style.css <<'CSS'

/* Centratura nome e moduli + posizionamento più in basso */

.tesserino-container {
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  min-height: 90vh;
  padding-bottom: 2rem;
}

.studente-nome {
  display: block;
  margin: 0 auto;
  text-align: center;
}

.moduli {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 0.4rem;
  margin-top: 1rem;
}
CSS

echo "✅ Completato! Ricarica la dashboard su iPhone per vedere i tesserini centrati in basso."
