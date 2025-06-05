CREATE DATABASE IF NOT EXISTS Pizzaria_HTML;
USE Pizzaria_HTML;

CREATE TABLE IF NOT EXISTS Clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(50) NOT NULL,
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
  id_sabor INT,
  id_ingrediente INT,
  FOREIGN KEY (id_sabor) REFERENCES Sabores(id_sabor),
  FOREIGN KEY (id_ingrediente) REFERENCES Ingredientes(id_ingrediente)
);

CREATE TABLE IF NOT EXISTS Cupons (
  id_cupom INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(50) NOT NULL UNIQUE,
  descricao VARCHAR(255),
  desconto_percentual DECIMAL(5,2) NOT NULL CHECK (desconto_percentual > 0 AND desconto_percentual <= 100),
  validade DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Pedidos (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  valor_total DECIMAL(10,2) NOT NULL,
  cupom_id INT NULL,
  pizza_id INT NOT NULL,
  data_hora DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  data_entrega DATETIME NULL,
  forma_pagamento VARCHAR(20) NOT NULL,
  STATUS VARCHAR(20) NOT NULL,
  FOREIGN KEY (cupom_id) REFERENCES Cupons(id_cupom),
  FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
  FOREIGN KEY (pizza_id) REFERENCES Sabores(id_sabor)
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

CREATE TABLE IF NOT EXISTS avaliacoes (
  id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido INT NOT NULL,
  id_sabor INT NULL,
  nota INT NOT NULL CHECK (nota BETWEEN 1 AND 5),
  comentario TEXT,
  data_avaliacao DATETIME NOT NULL,
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
  FOREIGN KEY (id_sabor) REFERENCES sabores(id_sabor) ON DELETE SET NULL
);



-- Inserção de dados --

INSERT INTO Clientes (nome, endereco, telefone, email) VALUES 
('João Silva', 'Rua das Flores, 123', '11987654321', 'joao.silva@email.com'),
('Maria Oliveira', 'Avenida Central, 456', '11976543210', 'maria.oliveira@email.com'),
('Carlos Pereira', 'Praça da Liberdade, 789', '11965432109', 'carlos.pereira@email.com');

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

INSERT INTO Pedidos (id_cliente, pizza_id, forma_pagamento, status, valor_total) VALUES
(1, 1, 'Cartão de Crédito', 'Em preparo', '32.00'),
(2, 2, 'Dinheiro', 'Entregue', '48.00'),
(3, 3, 'Pix', 'Em entrega', '52.00');

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

INSERT INTO avaliacoes (id_pedido, id_sabor, nota, comentario, data_avaliacao)
VALUES
  (1, 2, 5, 'Pizza maravilhosa, entrega rápida!', NOW()),
  (2, NULL, 4, 'Gostei do pedido, mas poderia vir mais quente.', NOW()),
  (3, 1, 2, 'O sabor era comum, nada demais.', NOW());

INSERT INTO cupons (codigo, descricao, desconto_percentual, validade)
VALUES 
  ('BEMVINDO10', 'Desconto de boas-vindas', 10.00, '2025-12-31'),
  ('FRETEGRATIS', 'Frete grátis para pedidos acima de R$50', 100.00, '2025-07-01'),
  ('PRIMEIRA15', '15% de desconto na primeira compra', 15.00, '2025-10-15');

UPDATE pedidos
SET cupom_id = 1, data_entrega = NOW()
WHERE id_pedido = 1;

UPDATE pedidos
SET cupom_id = 2, data_entrega = NOW()
WHERE id_pedido = 2;

UPDATE pedidos
SET cupom_id = 3, data_entrega = NOW()
WHERE id_pedido = 3; 

SELECT 
s.nome_sabor AS sabor,
AVG(a.nota) AS media_avaliacao
FROM avaliacoes a
JOIN sabores s ON a.id_sabor = s.id_sabor
WHERE a.id_sabor IS NOT NULL
GROUP BY s.nome_sabor
ORDER BY media_avaliacao DESC;

SELECT 
c.nome,
COUNT(p.id_pedido) AS total_pedidos
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY total_pedidos DESC
LIMIT 3;

SELECT 
p.id_pedido,
c.nome AS cliente,
c.email,
p.valor_total AS valor_original,
cup.codigo AS cupom_usado,
cup.desconto_percentual,
ROUND(p.valor_total * (1 - cup.desconto_percentual / 100), 2) AS valor_com_desconto
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN cupons cup ON p.cupom_id = cup.id_cupom;

SELECT 
s.nome_sabor AS sabor,
a.nota,
a.comentario
FROM avaliacoes a
JOIN sabores s ON a.id_sabor = s.id_sabor
WHERE a.nota < 3
ORDER BY a.nota ASC;

SELECT 
p.id_pedido,
c.nome AS cliente,
p.status,
TIMESTAMPDIFF(HOUR, p.data_hora, NOW()) AS horas_em_preparo
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE p.status = 'Em preparo'
AND TIMESTAMPDIFF(HOUR, p.data_hora, NOW()) > 24;

SELECT DISTINCT 
c.nome,
c.email
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE p.cupom_id IS NOT NULL;

SELECT 
DATE_FORMAT(p.data_hora, '%Y-%m') AS mes,
COUNT(p.cupom_id) AS total_cupons_usados
FROM pedidos p
WHERE p.cupom_id IS NOT NULL
GROUP BY mes
ORDER BY mes DESC;

SELECT 
  nome,
  telefone,
  email
FROM Clientes;

SELECT 
c.id_cliente,
c.nome,
c.endereco,
c.telefone
FROM Clientes c
LEFT JOIN Pedidos p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;

SELECT 
c.id_cliente,
c.nome,
SUM(s.preco) AS total_gasto
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN pizzas pi ON pi.id_pedido = p.id_pedido
JOIN pizza_sabor ps ON ps.id_pizza = pi.id_pizza
JOIN sabores s ON s.id_sabor = ps.id_sabor
WHERE p.status = 'Entregue'
GROUP BY c.id_cliente, c.nome
ORDER BY total_gasto DESC;


DELIMITER //

CREATE TRIGGER trg_atualiza_status_entregue
BEFORE UPDATE ON pedidos
FOR EACH ROW
BEGIN
  IF NEW.data_entrega IS NOT NULL AND OLD.data_entrega IS NULL THEN
    SET NEW.status = 'Entregue';
  END IF;
END;
//

DELIMITER ;
