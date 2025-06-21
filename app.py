from flask import Flask, render_template, request, redirect, url_for
import sqlite3

app = Flask(__name__)

def connettiti():
    conn = sqlite3.connect("tesserino.db")
    return conn

@app.route("/")
def home():
    return redirect(url_for("dashboard"))

@app.route("/dashboard")
def dashboard():
    conn = connettiti()
    tesserini = conn.execute("SELECT id, nome FROM tesserini").fetchall()
    conn.close()
    return render_template("dashboard.html", tesserini=tesserini)

@app.route("/tesserino/<int:tesserino_id>")
def tesserino_view(tesserino_id):
    conn = connettiti()
    tess = conn.execute("SELECT id, nome FROM tesserini WHERE id=?", (tesserino_id,)).fetchone()
    moduli = conn.execute("SELECT id, modulo_text, stato FROM moduli WHERE tesserino_id=?", (tesserino_id,)).fetchall()
    conn.close()
    return render_template("tesserino.html", tess=tess, moduli=moduli)

@app.route("/crea", methods=["POST"])
def crea_tesserino():
    nome = request.form["nome"]
    num_tess = int(request.form["num_tess"])
    conn = connettiti()
    cur = conn.cursor()
    cur.execute("INSERT INTO tesserini (nome) VALUES (?)", (nome,))
    tid = cur.lastrowid
    for i in range(num_tess):
        cur.execute("INSERT INTO moduli (modulo_text, stato, tesserino_id) VALUES (?, ?, ?)", (i+1, "attivo", tid))
    conn.commit()
    conn.close()
    return redirect(url_for("dashboard"))

@app.route("/annulla/<int:modulo_id>", methods=["POST"])
def annulla_modulo(modulo_id):
    conn = connettiti()
    cur = conn.cursor()
    cur.execute("UPDATE moduli SET stato='annullato' WHERE id=?", (modulo_id,))
    conn.commit()
    conn.close()
    return redirect(request.referrer or url_for("dashboard"))

@app.route("/elimina/<int:tesserino_id>", methods=["POST"])
def elimina_tesserino(tesserino_id):
    conn = connettiti()
    cur = conn.cursor()
    cur.execute("DELETE FROM moduli WHERE tesserino_id=?", (tesserino_id,))
    cur.execute("DELETE FROM tesserini WHERE id=?", (tesserino_id,))
    conn.commit()
    conn.close()
    return redirect(url_for("dashboard"))

if __name__ == "__main__":
    app.run(debug=True)


@app.route("/toggle_modulo/<int:modulo_id>", methods=["POST"])
def toggle_modulo(modulo_id):
    # TODO: personalizza queste due funzioni in base alla tua logica dati
    stato_attuale = ottieni_stato(modulo_id)
    nuovo_stato = "attivo" if stato_attuale == "annullato" else "annullato"
    aggiorna_stato(modulo_id, nuovo_stato)
    return redirect(request.referrer)

@app.route('/')
def index():
    return redirect('/dashboard')

@app.route('/dashboard')
def dashboard():
    return render_template('dashboard.html')
