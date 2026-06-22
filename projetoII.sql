-- =================================================================
-- SCRIPT DE CRIAÇÃO DO BANCO DE DADOS - CÍRCULOS DE LEITURA ACESSÍVEL
-- PROJETO INTEGRADOR II - MÓDULO 3
-- =================================================================

-- 1. Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS circulos_leitura;
USE circulos_leitura;

-- 2. Criação da Tabela de Voluntários (Quem grava os áudios)
CREATE TABLE Voluntarios (
    id_voluntario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Criação da Tabela de Obras Literárias (Dados dos livros)
CREATE TABLE Obras_Literarias (
    id_obra INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor_original VARCHAR(100) NOT NULL,
    genero VARCHAR(50)
);

-- 4. Criação da Tabela de Capítulos de Áudio (Relacionamento e arquivos)
CREATE TABLE Capitulos_Audio (
    id_capitulo INT AUTO_INCREMENT PRIMARY KEY,
    id_obra INT,
    id_voluntario INT,
    numero_capitulo INT NOT NULL,
    titulo_capitulo VARCHAR(150),
    url_arquivo_audio VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_obra) REFERENCES Obras_Literarias(id_obra) ON DELETE CASCADE,
    FOREIGN KEY (id_voluntario) REFERENCES Voluntarios(id_voluntario)
);

-- =================================================================
-- OPERAÇÕES DML: INSERÇÃO DE DADOS PARA TESTE (POPULAR O BANCO)
-- =================================================================

-- Inserindo Voluntários
INSERT INTO Voluntarios (nome, email) VALUES 
('Carlos Silva', 'carlos.narrador@email.com'),
('Ana Santos', 'ana.leitura@email.com');

-- Inserindo Obras
INSERT INTO Obras_Literarias (titulo, autor_original, genero) VALUES 
('Dom Casmurro', 'Machado de Assis', 'Romance'),
('O Cortiço', 'Aluísio Azevedo', 'Naturalismo');

-- Inserindo Capítulos de Áudio relacionados
INSERT INTO Capitulos_Audio (id_obra, id_voluntario, numero_capitulo, titulo_capitulo, url_arquivo_audio) VALUES 
(1, 1, 1, 'Do Titulo e do Capatulo', 'audios/dom_casmurro_cap1.mp3'),
(1, 1, 2, 'Do Livro', 'audios/dom_casmurro_cap2.mp3'),
(2, 2, 1, 'O Despertar do Cortiço', 'audios/o_cortico_cap1.mp3');

-- =================================================================
-- CONSULTA SQL (JOIN) UTILIZADA NA APLICAÇÃO WEB
-- =================================================================
-- Esta consulta busca os livros com seus respectivos capítulos e o nome do narrador para o player

SELECT 
    O.titulo AS Livro, 
    C.numero_capitulo AS Capitulo, 
    C.titulo_capitulo AS Titulo_Capitulo, 
    C.url_arquivo_audio AS Arquivo, 
    V.nome AS Narrador
FROM Capitulos_Audio C
JOIN Obras_Literarias O ON C.id_obra = O.id_obra
JOIN Voluntarios V ON C.id_voluntario = V.id_voluntario
ORDER BY O.titulo, C.numero_capitulo;