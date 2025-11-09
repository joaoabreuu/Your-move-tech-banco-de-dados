CREATE DATABASE your_move_tech;
USE your_move_tech;

-- Armazena as informações básicas de quem usa o sistema.
DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    tipo ENUM('admin','educador','usuario') DEFAULT 'usuario', -- ENUM faz com que qualquer outro dados diferentes de (admin, educador, usuario) não seja permitido
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- tabela usuarios alimentada
INSERT INTO usuarios(nome, email, senha, tipo) VALUES
('João Almeida', 'joao.admin@yourmovetech.com', 'admin123', 'admin'),
('Maria Costa', 'maria.educadora@yourmovetech.com', 'maria123', 'educador'),
('Lucas Pereira', 'lucas.usuario@yourmovetech.com', 'lucas123', 'usuario');

-- vendo a tabela
SELECT * FROM usuarios;

-- Cada usuário pode criar rotinas com um título e descrição.
DROP TABLE IF EXISTS rotinas;
CREATE TABLE rotinas (
    id_rotina INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

INSERT INTO rotinas (id_usuario, titulo, descricao) VALUES
(1, 'Rotina de Estudos', 'Rotina focada em melhorar o aprendizado e a produtividade.'),
(2, 'Rotina de Trabalho', 'Organização das atividades diárias no ambiente profissional.'),
(3, 'Rotina de Saúde', 'Rotina voltada para hábitos saudáveis e bem-estar físico.');

SELECT * FROM rotinas;

-- Armazena as tarefas de uma rotina, com status e prazo.
DROP TABLE IF EXISTS tarefas;
CREATE TABLE tarefas (
    id_tarefa INT AUTO_INCREMENT PRIMARY KEY,
    id_rotina INT NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    status ENUM('pendente','concluida') DEFAULT 'pendente',
    prazo DATE,
    FOREIGN KEY (id_rotina) REFERENCES rotinas(id_rotina)
);
-- rotina 
INSERT INTO rotinas (id_usuario, titulo, descricao)
VALUES (1, 'Rotina de estudos', 'Rotina diária para melhorar a produtividade.');

-- referencia a tabela tarefas
INSERT INTO tarefas (id_rotina, descricao, status, prazo) VALUES
(1, 'Fazer alongamento matinal', 'pendente', '2025-11-01'),
(1, 'Assistir aula de lógica de programação', 'concluida', '2025-10-20'),
(1, 'Revisar conteúdo de Banco de Dados', 'pendente', '2025-11-03');

SELECT * FROM tarefas;

DROP TABLE IF EXISTS habitos;
CREATE TABLE habitos (
    id_habito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    frequencia VARCHAR(50), -- exemplo: "Diário", "Semanal"
    progresso INT DEFAULT 0, -- exemplo: % de conclusão
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

INSERT INTO habitos (id_usuario, nome, frequencia, progresso) VALUES
(1, 'Meditar', 'Diário', 60),
(2, 'Estudar 1 hora por dia', 'Diário', 80),
(3, 'Ler um livro por semana', 'Semanal', 30);

SELECT * FROM habitos;

DROP TABLE IF EXISTS cursos;
CREATE TABLE cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    carga_horaria INT,
    nivel ENUM('básico','intermediário','avançado') DEFAULT 'básico'
);

INSERT INTO cursos (titulo, carga_horaria, nivel) VALUES
('Introdução à Programação', 20, 'básico'),
('Banco de Dados com MySQL', 40, 'intermediário'),
('Desenvolvimento Web com Java', 60, 'avançado');

SELECT * FROM cursos;

DROP TABLE IF EXISTS certificacoes;
CREATE TABLE certificacoes (
    id_certificacao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_curso INT NOT NULL,
    data_emissao DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

INSERT INTO cursos (titulo, carga_horaria, nivel) VALUES
('Introdução à Programação', 20, 'básico'),
('Banco de Dados com MySQL', 40, 'intermediário'),
('Desenvolvimento Web com Java', 60, 'avançado');

SELECT * FROM cursos;

DROP TABLE IF EXISTS alertas;
CREATE TABLE alertas (
    id_alerta INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tempo_online INT, -- em minutos
    nivel_risco ENUM('baixo','moderado','alto'),
    data_geracao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

INSERT INTO alertas (id_usuario, tempo_online, nivel_risco) VALUES
(1, 120, 'moderado'),
(2, 45, 'baixo'),
(3, 200, 'alto');

SELECT * FROM alertas;