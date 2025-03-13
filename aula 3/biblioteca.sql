CREATE DATABASE Biblioteca;

USE Biblioteca;

CREATE TABLE Livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Titulo VARCHAR(100) NOT NULL,
    Autor VARCHAR(100) NOT NULL,
    Ano INT NOT NULL,
    Genero VARCHAR(100) NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE,
    Quantidade INT DEFAULT 1
);

CREATE TABLE Emprestimos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livro_id INT,
    usuario VARCHAR(100) NOT NULL,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE NOT NULL,
    FOREIGN KEY (livro_id) REFERENCES Livros(id) ON DELETE CASCADE
);

INSERT INTO Livros (titulo, autor, ano, genero, quantidade) VALUES 
('O Senhor dos Anéis', 'J.R.R. Tolkien', 1954, 'Fantasia', 3),
('Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 1997, 'Fantasia', 2),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 1943, 'Infantil', 1);

INSERT INTO Emprestimos (livro_id, usuario, data_emprestimo, data_devolucao) VALUES 
(1, 'Pedro', '2021-01-01', '2021-01-15'),
(2, 'João', '2021-01-02', '2021-01-16'),
(3, 'Maria', '2021-01-03', '2021-01-17');

