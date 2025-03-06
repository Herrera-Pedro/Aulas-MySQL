CREATE DATABASE Multiplayer;
USE Multiplayer;

CREATE TABLE Jogadores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Nivel INT DEFAULT 1,
    xp INT DEFAULT 0,
    moeda INT DEFAULT 0
);

CREATE TABLE Guildas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    lider_id INT,
    FOREIGN KEY (lider_id) REFERENCES Jogadores(id) ON DELETE SET NULL
);

CREATE TABLE Membros_Guilda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    jogador_id INT,
    guilda_id INT,
    cargo ENUM('membro', 'oficial', 'lider') DEFAULT 'membro',
    FOREIGN KEY (jogador_id) REFERENCES Jogadores(id) ON DELETE CASCADE,
    FOREIGN KEY (guilda_id) REFERENCES Guildas(id) ON DELETE CASCADE
);

CREATE TABLE Missoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    recompensa_xp INT NOT NULL,
    recompensa_moeda DECIMAL(10,2) NOT NULL
);

CREATE TABLE Progresso_Missoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    jogador_id INT,
    missao_id INT,
    status ENUM('em andamento', 'concluída', 'falhou') DEFAULT 'em andamento',
    FOREIGN KEY (jogador_id) REFERENCES Jogadores(id),
    FOREIGN KEY (missao_id) REFERENCES Missoes(id)
);

INSERT INTO Jogadores (nome, nivel, xp, moeda) VALUES 
('Pedro', 10, 1200, 500.00),
('João', 5, 500, 200.00),
('Maria', 3, 300, 100.00),
('Batman', 9999, 1200, 10000000.00),
('Superman', 9999, 1200, 10000);

INSERT INTO Guildas (nome, lider_id) VALUES 
('Os Vingadores', 1),
('Liga da Justiça', 2);

INSERT INTO Membros_Guilda (jogador_id, guilda_id, cargo) VALUES 
(4, 2, 'lider'),
(5, 2, 'oficial');

INSERT INTO Missoes (nome, recompensa_xp, recompensa_moeda) VALUES 
('Derrotar Lex Luthor', 1000, 10000.00),
('Falar com Alfred', 200, 50.00),
('Vigiar Gotham por 1 noite', 50000, 0.00);

INSERT INTO Progresso_Missoes (jogador_id, missao_id, status) VALUES 
(5, 1, 'em andamento'),
(4, 2, 'concluída'),
(4, 3, 'em andamento');

CREATE VIEW Visao_Completa AS
SELECT 
    j.id AS jogador_id,
    j.Nome AS jogador_nome,
    j.Nivel AS jogador_nivel,
    j.xp AS jogador_xp,
    j.moeda AS jogador_moeda,
    g.id AS guilda_id,
    g.Nome AS guilda_nome,
    mg.cargo AS guilda_cargo,
    m.id AS missao_id,
    m.Nome AS missao_nome,
    m.recompensa_xp AS missao_recompensa_xp,
    m.recompensa_moeda AS missao_recompensa_moeda,
    pm.status AS missao_status
FROM 
    Jogadores j
LEFT JOIN 
    Membros_Guilda mg ON j.id = mg.jogador_id
LEFT JOIN 
    Guildas g ON mg.guilda_id = g.id
LEFT JOIN 
    Progresso_Missoes pm ON j.id = pm.jogador_id
LEFT JOIN 
    Missoes m ON pm.missao_id = m.id;

SELECT * FROM Visao_Completa;