CREATE DATABASE Empresa;

USE Empresa;

CREATE TABLE Funcionarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    cargo ENUM('Junior', 'Pleno', 'Senior') NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    data_admissao DATE NOT NULL,
    ativo BOOLEAN DEFAULT TRUE
);

INSERT INTO Funcionarios 
(nome, email, cargo, salario, data_admissao, ativo) 
VALUES
('Pedro', 'pedro.herrera@gmail.com', 'Senior', 9500.00, '2025-03-27'),
('Matheus', 'matheus.galdino@gmail.com', 'Pleno', 6000.00, '2025-01-20')

UPDATE Funcionarios SET salario = 8500.00 WHERE id = 1;
UPDATE Funcionarios SET ativo = FALSE WHERE id = 2;
