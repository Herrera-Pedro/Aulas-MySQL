CREATE DATABASE IF NOT EXISTS Loja;
USE Loja;

CREATE TABLE IF NOT EXISTS Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS ItensPedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(id)
);

INSERT INTO Clientes (nome, email, telefone) 
VALUES 
('John Doe', 'johndoe@exemplo.com', '(15)12345-7890'), 
('Jane Smith', 'janesmith@exemplo.com', '(15)98765-3210'), 
('Michael Johnson', 'michaeljohnson@exemplo.com', '(15)55555-5555'), 
('Emily Davis', 'emilydavis@exemplo.com', '(15)11111-1111'), 
('David Wilson', 'davidwilson@exemplo.com', '(15)99999-9999');

INSERT INTO Produtos (nome, preco, estoque) 
VALUES 
('Iphone 20', 10.99, 100), 
('RTX9090', 19.99, 50), 
('Ryzen 9999X', 5.99, 200), 
('Laptop da Xuxa', 8.99, 150), 
('Banana (Kg)', 5.99, 80);

INSERT INTO Pedidos (cliente_id, data_pedido) VALUES (1, NOW()), (2, NOW()), (3, NOW());

INSERT INTO ItensPedido (pedido_id, produto_id, quantidade, preco_unitario) 
VALUES 
(1, 1, 2, 10.99), 
(1, 3, 1, 5.99), 
(2, 2, 3, 19.99), 
(3, 4, 2, 8.99), 
(3, 5, 5, 12.99);

SELECT Pedidos.id, Clientes.nome, Pedidos.data_pedido FROM Pedidos JOIN Clientes ON Pedidos.cliente_id = Clientes.id;

SELECT Produtos.nome, ItensPedido.quantidade, ItensPedido.preco_unitario
FROM ItensPedido
JOIN Produtos ON ItensPedido.produto_id = Produtos.id
WHERE ItensPedido.pedido_id = $pedido_id;

UPDATE Produtos
SET estoque = estoque - $quantidade$
WHERE id = $ItensPedido_id$;

SELECT Clientes.nome, COUNT(Pedidos.id) AS total_pedidos
FROM Clientes
JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
GROUP BY Clientes.id
HAVING COUNT(Pedidos.id) > 1;

DELETE FROM Pedidos WHERE id = $pedido_id$;
DELETE FROM ItensPedido WHERE pedido_id = $pedido_id$;
