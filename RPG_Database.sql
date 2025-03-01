CREATE DATABASE RPG;
USE RPG;

CREATE TABLE Itens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Tipo ENUM('Arma', 'Armadura', 'Pocao', 'Material') NOT NULL,
    Raridade ENUM('Comum', 'Incomum', 'Raro', 'Epico', 'Lendario') NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL,
    Descricao TEXT NOT NULL
);

CREATE TABLE Jogadores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Nivel INT DEFAULT 1,
    Classe ENUM('Guerreiro', 'Mago', 'Arqueiro') NOT NULL
);

CREATE TABLE Inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    jogador_id INT,
    Item_id INT,
    quantidade INT DEFAULT 1,
    FOREIGN KEY (jogador_id) REFERENCES Jogadores(id),
    FOREIGN KEY (Item_id) REFERENCES Itens(id)
); 

INSERT INTO Jogadores (nome, nivel, classe) VALUES 
('Pedro', 1, 'Guerreiro'),
('Maria', 5, 'Mago'),
('Joao', 10, 'Arqueiro');
ADD CONSTRAINT unique_jogador UNIQUE (Nome, Nivel, Classe);

INSERT INTO Itens (nome, tipo, raridade, preco, descricao) VALUES
('Espada', 'Arma', 'Comum', 150.00, 'Uma espada comum de aço.'),
('Armadura de Couro', 'Armadura', 'Comum', 50.00, 'Uma armadura de couro comum. Oferece pouca protecao.'),
('Pocao de Vida', 'Pocao', 'Comum', 10.00, 'Uma pocao de vida comum (cura 50 de vida)'),
('Ferro', 'Material', 'Comum', 5.00, 'Um material comum. Pode ser usado para forjar armas e armaduras.');

INSERT INTO Inventario (jogador_id, item_id, quantidade) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 5),
(3, 4, 10);

--Consultar a tabela de Itens
SELECT * FROM Itens;

--Consultar os itens que cada jogador possui
SELECT 
    Jogadores.Nome AS Jogador,
    Itens.Nome AS Item,
    Inventario.quantidade AS Quantidade
FROM 
    Inventario
JOIN 
    Jogadores ON Inventario.jogador_id = Jogadores.id
JOIN 
    Itens ON Inventario.Item_id = Itens.id
ORDER BY 
    Jogadores.Nome;
