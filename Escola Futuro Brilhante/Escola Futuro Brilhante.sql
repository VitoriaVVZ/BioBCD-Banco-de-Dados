create database Escola_futuro_Brilhante;
use escola_futuro_brilhante;

create table aluno (
	id_aluno INT Primary key auto_increment,
    nome VARCHAR(60) not null,
    turma VARCHAR(20)
);

create table email (
    id_email INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(250) not null,
    tipo_email ENUM('Pessoal', 'Escolar', 'Outro'),
    id_aluno INT, 
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
);

create table telefone (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    ddd CHAR(2),
    numero CHAR(9),
    id_aluno INT, 
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
);

create table autor (
    id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);

create table editora (
    id_editora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL
);

create table livro (
    id_livro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    tipo_genero ENUM('Romance', 'Terror', 'Ficcao'),
    id_autor INT,
    id_editora INT,
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor),
    FOREIGN KEY (id_editora) REFERENCES editora(id_editora)
);

create table emprestimo (
    id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
    tipo_status ENUM('Disponivel', 'Indisponivel', 'Reservado'),
    data_retirada DATE,
    data_devolucao DATE,
    multa DECIMAL(10,2),
    id_livro INT,
    id_aluno INT,
    FOREIGN KEY (id_livro) REFERENCES livro(id_livro),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
);

INSERT INTO aluno (nome, turma) VALUES 
('Luisa Guimarães', '101-A'), 
('Ana Beatriz', '101-A'), 
('Luiz Miguel', '202-B'),
('Fernando Rocha', '202-B'), 
('Igor Guimarães', '303-C'), 
('Helena Castro', '303-C'),
('Luisa Oliveira', '102-A'), 
('Bruno Rodrigues', '102-A'), 
('Julya Takanura', '201-B'), 
('William Silva', '301-C');

INSERT INTO email (email, tipo_email, id_aluno) VALUES 
('luisa.gui@email.com', 'Pessoal', 1), 
('ana.b@escola.com', 'Escolar', 2), 
('luiz.m@email.com', 'Pessoal', 3),
('fernando.r@email.com', 'Pessoal', 4), 
('igor.g@escola.com', 'Escolar', 5), 
('helena.c@email.com', 'Pessoal', 6),
('luisa.o@email.com', 'Pessoal', 7), 
('bruno.r@escola.com', 'Escolar', 8), 
('julya.t@email.com', 'Pessoal', 9), 
('william@email.com', 'Pessoal', 10);

INSERT INTO telefone (ddd, numero, id_aluno) VALUES
('11', '999990001', 1),
('11', '999990002', 2),
('21', '999990003', 3),
('21', '999990004', 4),
('31', '999990005', 5),
('31', '999990006', 6),
('41', '999990007', 7),
('41', '999990008', 8),
('51', '999990009', 9),
('51', '999990010', 10);

INSERT INTO editora (nome) VALUES
('Companhia das Letras'),
('Suma de Letras'),
('Aleph'),
('Darkside'),
('Intrínseca'),
('Rocco'),
('HarperCollins'),
('Record'),
('Arqueiro'),
('Sextante');

INSERT INTO livro (titulo, tipo_genero, id_autor, id_editora) VALUES
('Dom Casmurro', 'Romance', 1, 1),
('O Iluminado', 'Terror', 2, 2),
('Fundação', 'Ficcao', 3, 3),
('Frankenstein', 'Terror', 4, 4),
('2001: Uma Odisseia no Espaço', 'Ficcao', 5, 3),
('A Hora da Estrela', 'Romance', 6, 6),
('O Senhor dos Anéis', 'Ficcao', 7, 7),
('1984', 'Ficcao', 8, 1),
('E Não Sobrou Nenhum', 'Terror', 9, 7),
('O Chamado de Cthulhu', 'Terror', 10, 4);

INSERT INTO emprestimo (tipo_status, dt_retirada, dt_devolucao, multa, id_livro, id_aluno) VALUES
('Indisponivel', '2026-04-10', NULL, 0.00, 1, 1),
('Disponivel', '2026-04-01', '2026-04-15', 0.00, 2, 2),
('Indisponivel', '2026-04-20', NULL, 0.00, 3, 3),
('Disponivel', '2026-03-10', '2026-03-30', 5.50, 4, 4), 
('Reservado', '2026-04-29', NULL, 0.00, 5, 5),
('Indisponivel', '2026-04-05', NULL, 0.00, 6, 6),
('Disponivel', '2026-04-22', '2026-04-28', 0.00, 7, 7),
('Reservado', '2026-05-01', NULL, 0.00, 8, 8),
('Indisponivel', '2026-04-28', NULL, 0.00, 9, 9),
('Disponivel', '2026-01-15', '2026-01-20', 0.00, 10, 10);


