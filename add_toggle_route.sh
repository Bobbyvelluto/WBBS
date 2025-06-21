#!/bin/bash

echo "📌 Aggiungo la route toggle_modulo in app.py…"

# Inserisci la funzione alla fine di app.py
cat >> app.py <<'PYTHON'

@app.route("/toggle_modulo/<int:modulo_id>", methods=["POST"])
def toggle_modulo(modulo_id):
    # TODO: personalizza queste due funzioni in base alla tua logica dati
    stato_attuale = ottieni_stato(modulo_id)
    nuovo_stato = "attivo" if stato_attuale == "annullato" else "annullato"
    aggiorna_stato(modulo_id, nuovo_stato)
    return redirect(request.referrer)
PYTHON

echo "✅ Route toggle_modulo aggiunta! Ora modifica o implementa 'ottieni_stato' e 'aggiorna_stato'."
