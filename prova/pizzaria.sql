CREATE DATABASE IF NOT EXISTS Pizzaria HTML;
USE Pizzaria HTML;

CREATE TABLE IF NOT EXISTS Clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  endereco VARCHAR(100) NOT NULL,
  telefone VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Sabores (
  id_sabor INT AUTO_INCREMENT PRIMARY KEY,
  nome_sabor VARCHAR(50) UNIQUE NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  preco DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS Ingredientes (
  id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
  nome_ingrediente VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Sabor_Ingrediente (
  id_sabor INT AUTO_INCREMENT PRIMARY KEY,
  id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
  FOREIGN KEY (id_sabor) REFERENCES Sabores(id_sabor),
  FOREIGN KEY (id_ingrediente) REFERENCES Ingredientes(id_ingrediente)
);

CREATE TABLE IF NOT EXISTS Pedidos (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  pizza_id INT NOT NULL,
  data_hora DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  forma_pagamento VARCHAR(20) NOT NULL,
  status VARCHAR(20) NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
  FOREIGN KEY (pizza_id) REFERENCES Sabores(id)
);

CREATE TABLE IF NOT EXISTS Entregadores (
  id_entregador INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  telefone VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Pizzas (
  id_pizza INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  tamanho VARCHAR(20) NOT NULL,
  observacoes TEXT,
  FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);

CREATE TABLE IF NOT EXISTS Pizza_sabor (
  id_pizza INT NOT NULL,
  id_sabor INT NOT NULL,
  FOREIGN KEY (id_pizza) REFERENCES Pizzas(id_pizza),
  FOREIGN KEY (id_sabor) REFERENCES Sabores(id_sabor)
);

-- Inserção de dados --

INSERT INTO Clientes (nome, endereco, telefone) VALUES 
('João Silva', 'Rua das Flores, 123', '11987654321'),
('Maria Oliveira', 'Avenida Central, 456', '11976543210'),
('Carlos Pereira', 'Praça da Liberdade, 789', '11965432109');

INSERT INTO Sabores (nome_sabor, descricao, preco) VALUES
('Calabresa', 'Pizza com calabresa, mussarela, molho de tomate e azeitonas', 30.00),
('Rúcula com queijo búfalo', 'Pizza com queijo búfalo, rúcula, molho de tomate e azeitonas', 40.00),
('Chocolate com M&Ms', 'Pizza com chocolate e M&Ms', 35.00);

INSERT INTO Ingredientes (nome_ingrediente) VALUES
('Molho de tomate'),
('Queijo Mussarela'),
('Calabresa'),
('Queijo Búfalo'),
('Rúcula'),
('Chocolate'),
('M&Ms'),
('Azeitonas');

INSERT INTO Sabor_Ingrediente (id_sabor, id_ingrediente) VALUES
(1, 1), -- Calabresa: Molho de tomate
(1, 2), -- Calabresa: Queijo Mussarela
(1, 3), -- Calabresa: Calabresa
(1, 8), -- Calabresa: Azeitonas
(2, 1), -- Rúcula com queijo búfalo: Molho de tomate
(2, 4), -- Rúcula com queijo búfalo: Queijo Búfalo
(2, 5), -- Rúcula com queijo búfalo: Rúcula
(2, 8), -- Rúcula com queijo búfalo: Azeitonas
(3, 6), -- Chocolate com M&Ms: Chocolate
(3, 7); -- Chocolate com M&Ms: M&Ms

INSERT INTO Pedidos (id_cliente, pizza_id, forma_pagamento, status) VALUES
(1, 1, 'Cartão de Crédito', 'Em preparo'),
(2, 2, 'Dinheiro', 'Entregue'),
(3, 3, 'Pix', 'Em entrega');

INSERT INTO Pizzas (id_pedido, tamanho, observacoes) VALUES
(1, 'Grande', 'Sem cebola'),
(2, 'Média', 'Extra queijo'),
(3, 'Pequena', 'Sem observações');

INSERT INTO Pizza_sabor (id_pizza, id_sabor) VALUES
(1, 1), -- Pizza 1 com sabor Calabresa
(2, 2), -- Pizza 2 com sabor Rúcula com queijo búfalo
(3, 3); -- Pizza 3 com sabor Chocolate com M&Ms

INSERT INTO Entregadores (nome, telefone) VALUES
('Pedro Santos', '11912345678');


-- Consultas --

SELECT nome, telefone FROM Clientes;
SELECT nome_sabor, preco
FROM Sabores
ORDER BY preco DESC;

SELECT i.nome_ingrediente
FROM Ingredientes i
JOIN Sabor_Ingrediente si ON i.id_ingrediente = si.id_ingrediente
JOIN Sabores s ON si.id_sabor = s.id_sabor
WHERE s.nome_sabor = 'Rúcula com queijo búfalo';

SELECT p.data_hora, p.status, p.forma_pagamento
FROM Pedidos p
JOIN Clientes c ON p.id_cliente = c.id_cliente
WHERE c.nome = 'João Silva';

SELECT 
    pi.tamanho AS tamanho_pizza,
    GROUP_CONCAT(s.nome_sabor SEPARATOR ', ') AS sabores
FROM Pizzas pi
JOIN Pizza_sabor ps ON pi.id_pizza = ps.id_pizza
JOIN Sabores s ON ps.id_sabor = s.id_sabor
WHERE pi.id_pedido = 1
GROUP BY pi.id_pizza;

SELECT COUNT(*) AS total_pizzas_calabresa
FROM Pizza_sabor ps
JOIN Sabores s ON ps.id_sabor = s.id_sabor
WHERE s.nome_sabor = 'Calabresa';

SELECT nome, telefone FROM Entregadores;