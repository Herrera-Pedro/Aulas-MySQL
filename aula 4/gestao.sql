CREATE DATABASE Gestao;

USE Gestao;

CREATE TABLE Usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Senha VARCHAR(255) NOT NULL,
    tipo ENUM('admin', 'professor', 'aluno') NOT NULL
);

CREATE TABLE Cursos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(100) NOT NULL,
    Descricao TEXT NOT NULL,
    Professor_id INT NOT NULL,
    FOREIGN KEY (Professor_id) REFERENCES Usuario(id)
);

CREATE TABLE Matriculas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT NOT NULL,
    curso_id INT NOT NULL,
    data_matricula TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (aluno_id) REFERENCES Usuario(id),
    FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);

