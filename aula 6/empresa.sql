CREATE DATABASE EMPRESA;
USE EMPRESA;

CREATE TABLE IF NOT EXISTS Funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES Departamentos(id)
);

CREATE TABLE IF NOT EXISTS Departamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
);

INSERT INTO Departamentos (nome) 
VALUES
('TI'), ('RH'), ('Financeiro'), ('Marketing'), ('Vendas');

INSERT INTO Funcionarios (nome, cargo, salario, departamento_id)
VALUES
('John Doe', 'Desenvolvedor', 5000.00, 1), 
('Jane Smith', 'Gerente de RH', 6000.00, 2), 
('Mike Johnson', 'Contador', 4500.00, 3), 
('Sarah Williams', 'Especialista de Marketing', 5500.00, 4), 
('David Brown', 'Representante de Vendas', 4000.00, 5);

SELECT * FROM Funcionarios;

SELECT nome, salario FROM Funcionarios ORDER BY salario DESC;

SELECT MAX(salario) FROM Funcionarios;

SELECT Funcionarios.nome, Departamentos.nome AS departamento FROM Funcionarios JOIN Departamentos ON Funcionarios.departamento_id = Departamentos.id;

UPDATE Funcionarios SET salario = 6000.00 WHERE id = 1; -- O salário do funcionário com o id "1 (John Doe)" foi alterado para 6000.00.

DELETE FROM Funcionarios WHERE nome = 'John Doe';