from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def home():
    return "<h1>Ciao Wilson! 👋</h1><p>La tua app è viva in locale! 🚀</p>"

if __name__ == "__main__":
    app.run(debug=True)
