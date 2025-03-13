from flask import Flask, render_template, request, redirect
import mysql.connector

app = Flask(__name__)

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Root",
    database="Biblioteca"
)

cursor = db.cursor()

@app.route('/')

def index():
    cursor.execute("SELECT * FROM Livros")
    livros = cursor.fetchall()
    return render_template('index.html', livros=livros)

@app.route('/adicionar', methods=['POST'])
def adicionar():
    return render_template('add.html')

    # titulo = request.form['titulo']
    # autor = request.form['autor']
    # ano = request.form['ano']
    # cursor.execute("INSERT INTO Livros (titulo, autor, ano) VALUES (%s, %s, %s)", (titulo, autor, ano))
    # db.commit()
    # return redirect('/')

@app.route('/salvar', methods=['POST'])
def salvar():

    titulo = request.form['titulo']
    autor = request.form['autor']
    ano = request.form['ano']
    sql = "INSERT INTO Livros (titulo, autor, ano) VALUES (%s, %s, %s)"
    cursor.execute(sql, (titulo, autor, ano))
    db.commit()
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)

# @app.route('/delete/<int:id>', methods=['POST'])
# def delete_livro(id):
#     cursor.execute("DELETE FROM Livros WHERE id=%s", (id,))
#     db.commit()
#     return redirect('/')