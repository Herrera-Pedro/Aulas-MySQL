CREATE DATABASE Empresa;
USE Empresa;

CREATE TABLE Departamentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Funcionarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    cargo ENUM('Junior', 'Pleno', 'Senior') NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    data_admissao DATE NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES Departamentos(id)
);

INSERT INTO Departamentos (nome) 
VALUES 
('Desenvolvimento'), ('Recursos Humanos'), ('Financeiro');

INSERT INTO Funcionarios
(nome, email, cargo, salario, data_admissao, ativo, departamento_id)
VALUES
('Pedro', 'pedro.herrera@gmail.com', 'Pleno', '2020-05-05', TRUE, 1),
('Thiago', 'thiago.conceicao@gmail.com', 'Senior', '2015-01-20', TRUE, 1)

SELECT f.nome, f.cargo, d.nome AS departamento
FROM Funcionarios f