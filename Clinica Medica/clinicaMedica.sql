CREATE DATABASE clinicamedica;
USE clinicamedica;

-- Criação das TABELAS
CREATE TABLE unidades (
    id_unidade INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    CONSTRAINT pk_unidades PRIMARY KEY (id_unidade)
);

CREATE TABLE especialidades (
    id_especialidade INT AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    CONSTRAINT pk_especialidades PRIMARY KEY (id_especialidade),
    CONSTRAINT uq_especialidade_nome UNIQUE (nome)
);

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    login VARCHAR(50) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    status_usuario VARCHAR(10) NOT NULL DEFAULT 'Ativo',
    CONSTRAINT pk_usuarios PRIMARY KEY (id_usuario),
    CONSTRAINT uq_usuarios_login UNIQUE (login)
);

CREATE TABLE pacientes (
    id_paciente INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL,
    telefone VARCHAR(15),
    CONSTRAINT pk_pacientes PRIMARY KEY (id_paciente),
    CONSTRAINT uq_paciente_cpf UNIQUE (cpf)
);

CREATE TABLE medicos (
    id_medico INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) NOT NULL,
    id_especialidade INT,
    id_unidade INT,
    CONSTRAINT pk_medicos PRIMARY KEY (id_medico),
    CONSTRAINT uq_medico_crm UNIQUE (crm),
    CONSTRAINT fk_medicos_especialidades FOREIGN KEY (id_especialidade) REFERENCES especialidades(id_especialidade) ON DELETE RESTRICT,
    CONSTRAINT fk_medicos_unidades FOREIGN KEY (id_unidade) REFERENCES unidades(id_unidade) ON DELETE RESTRICT
);

CREATE TABLE consultas (
    id_consulta INT AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    data_consulta DATE NOT NULL,
    hora_consulta TIME NOT NULL,
    status_consulta VARCHAR(20) NOT NULL DEFAULT 'Agendada',
    CONSTRAINT pk_consultas PRIMARY KEY (id_consulta),
    CONSTRAINT fk_consultas_pacientes FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente) ON DELETE RESTRICT,
    CONSTRAINT fk_consultas_medicos FOREIGN KEY (id_medico) REFERENCES medicos(id_medico) ON DELETE RESTRICT
);

ALTER TABLE pacientes ADD COLUMN telefone_emergencia VARCHAR(15);

-- Criação dos INDEXES
CREATE INDEX idx_pacientes_cpf ON pacientes(cpf);
CREATE INDEX idx_medicos_crm ON medicos(crm);
CREATE INDEX idx_consultas_data ON consultas(data_consulta);

-- Criação dos INSERTS
INSERT INTO unidades (nome, bairro) VALUES 
('Health Solutions Centro', 'Centro'),
('Health Solutions Zona Sul', 'Santo Amaro'),
('Health Solutions Zona Norte', 'Santana'),
('Health Solutions Zona Oeste', 'Lapa'),
('Health Solutions Filial Leste', 'Itaquera');

INSERT INTO especialidades (nome) VALUES 
('Cardiologia'), ('Pediatria'), ('Dermatologia'), ('Ortopedia'), ('Ginecologia'),
('Neurologia'), ('Oftalmologia'), ('Psiquiatria'), ('Clínica Médica'), ('Urologia'),
('Endocrinologia'), ('Otorrinolaringologia'), ('Gastroenterologia'), ('Geriatria'), ('Pneumologia');

INSERT INTO usuarios (nome, login, senha, cargo, status_usuario) VALUES 
('Administrador Geral', 'admin.root', 'hash123', 'Administrador', 'Ativo'),
('Recepcionista Ana', 'ana.rec', 'senha123', 'Recepcao', 'Ativo'),
('Recepcionista Lucas', 'lucas.rec', 'senha456', 'Recepcao', 'Inativo');

INSERT INTO medicos (nome, crm, id_especialidade, id_unidade) VALUES
('Dr. Arnaldo Silva', 'CRM-SP10001', 1, 1), ('Dra. Beatriz Santos', 'CRM-SP10002', 2, 2),
('Dr. Carlos Oliveira', 'CRM-SP10003', 3, 3), ('Dra. Daniela Lima', 'CRM-SP10004', 4, 4),
('Dr. Eduardo Costa', 'CRM-SP10005', 5, 5), ('Dra. Fernanda Souza', 'CRM-SP10006', 6, 1),
('Dr. Gabriel Almeida', 'CRM-SP10007', 7, 2), ('Dra. Helena Ribeiro', 'CRM-SP10008', 8, 3),
('Dr. Igor Carvalho', 'CRM-SP10009', 9, 4), ('Dra. Julia Pereira', 'CRM-SP10010', 10, 5),
('Dr. Kevin Martins', 'CRM-SP10011', 11, 1), ('Dra. Larissa Rocha', 'CRM-SP10012', 12, 2),
('Dr. Marcelo Gomes', 'CRM-SP10013', 13, 3), ('Dra. Natalia Dias', 'CRM-SP10014', 14, 4),
('Dr. Otavio Peres', 'CRM-SP10015', 15, 5), ('Dra. Patricia Melo', 'CRM-SP10016', 1, 2),
('Dr. Ricardo Antunes', 'CRM-SP10017', 2, 3), ('Dra. Sabrina Ramos', 'CRM-SP10018', 3, 4),
('Dr. Thiago Neves', 'CRM-SP10019', 4, 5), ('Dra. Vanessa Cruz', 'CRM-SP10020', 5, 1),
('Dr. Wagner Reis', 'CRM-SP10021', 6, 2), ('Dra. Yasmin Fontana', 'CRM-SP10022', 7, 3),
('Dr. André Macedo', 'CRM-SP10023', 8, 4), ('Dra. Camila Barbosa', 'CRM-SP10024', 9, 5),
('Dr. Diego Cardoso', 'CRM-SP10025', 10, 1), ('Dra. Elaine Vieira', 'CRM-SP10026', 11, 2),
('Dr. Fabio Teixeira', 'CRM-SP10027', 12, 3), ('Dra. Gisele Nogueira', 'CRM-SP10028', 13, 4),
('Dr. Heitor Castro', 'CRM-SP10029', 14, 5), ('Dra. Isabela Franco', 'CRM-SP10030', 15, 1);

INSERT INTO pacientes (nome, cpf, telefone, telefone_emergencia) VALUES
('Luisa Guimarães', '11122233345', '11988881111', '11977771111'), ('Bruno Souza', '22233344455', '11988882222', '11977772222'),
('Camila Lima', '33344455566', '11988883333', '11977773333'), ('Diego Costa', '44455566677', '11988884444', '11977774444'),
('Elena Ribeiro', '55566677788', '11988885555', '11977775555'), ('Felipe Oliveira', '66677788899', '11988886666', '11977776666'),
('Gabriela Santos', '77788899900', '11988887777', '11977777777'), ('Hugo Almeida', '88899900011', '11988888888', '11977778888'),
('Isabela Carvalho', '99900011122', '11988889999', '11977779999'), ('João Pereira', '00011122233', '11988880000', '11977770000'),
('Karina Martins', '12345678901', '11999990001', '11966660001'), ('Lucas Rocha', '23456789012', '11999990002', '11966660002'),
('Mariana Gomes', '34567890123', '11999990003', '11966660003'), ('Nicolas Dias', '45678901234', '11999990004', '11966660004'),
('Olivia Peres', '56789012345', '11999990005', '11966660005'), ('Pedro Melo', '67890123456', '11999990006', '11966660006'),
('Raquel Antunes', '78901234567', '11999990007', '11966660007'), ('Samuel Ramos', '89012345678', '11999990008', '11966660008'),
('Tatiana Neves', '90123456789', '11999990009', '11966660009'), ('Vitor Cruz', '01234567890', '11999990010', '11966660010'),
('Alice Reis', '11223344556', '11999990011', NULL), ('Breno Fontana', '22334455667', '11999990012', NULL),
('Clara Macedo', '33445566778', '11999990013', NULL), ('Daniel Barbosa', '44433322211', '11999990014', NULL),
('Eduarda Cardoso', '55544433322', '11999990015', NULL), ('Fabricio Vieira', '66655544433', NULL, NULL),
('Giovana Teixeira', '77766655544', '11999990017', NULL), ('Hélio Nogueira', '88877766655', NULL, NULL),
('Iara Castro', '99988877766', '11999990019', NULL), ('Jorge Franco', '00099988877', NULL, NULL),
('Larissa Souza', '10203040506', '11999990021', '11955550021'), ('Marcos Silva', '20304050607', '11999990022', '11955550022'),
('Nair Oliveira', '30405060708', '11999990023', '11955550023'), ('Otávio Lima', '40506070809', '11999990024', '11955550024'),
('Priscila Costa', '50607080910', '11999990025', '11955550025'), ('Quirino Ribeiro', '60708091011', '11999990026', '11955550026'),
('Rafaela Santos', '70809101112', '11999990027', '11955550027'), ('Sandro Almeida', '80910111213', '11999990028', '11955550028'),
('Telma Carvalho', '90910111213', '11999990029', '11955550029'), ('Ulysses Pereira', '01020304050', '11999990030', '11955550030'),
('Valéria Martins', '11133355577', '11999990031', '11944440031'), ('William Rocha', '22244466688', '11999990032', '11944440032'),
('Xavier Gomes', '33355577799', '11999990033', '11944440033'), ('Yara Dias', '44466688800', '11999990034', '11944440034'),
('Zeca Peres', '55577799911', '11999990035', '11944440035'), ('Arthur Melo', '66688800022', '11999990036', '11944440036'),
('Beatriz Antunes', '77799911133', '11999990037', '11944440037'), ('Caio Ramos', '88800022244', '11999990038', '11944440038'),
('Diana Neves', '99911133355', '11999990039', '11944440039'), ('Erick Cruz', '00022244466', '11999990040', '11944440040'),
('Flavia Reis', '12131415161', '11999990041', NULL), ('Guilherme Fontana', '23242526272', '11999990042', NULL),
('Heloisa Macedo', '34353637383', '11999990043', NULL), ('Ivan Barbosa', '45464748494', '11999990044', NULL),
('Janaína Cardoso', '56575859606', '11999990045', NULL), ('Kléber Vieira', '67686970717', '11999990046', NULL),
('Letícia Teixeira', '78798081828', '11999990047', NULL), ('Murilo Nogueira', '89808182838', '11999990048', NULL),
('Nádia Castro', '90919293949', '11999990049', NULL), ('Orlando Franco', '01020304051', '11999990050', NULL),
('Paola Souza', '12233445560', '11999990051', '11933330051'), ('Augusto Silva', '23344556671', '11999990052', '11933330052'),
('Cíntia Oliveira', '34455667782', '11999990053', '11933330053'), ('Douglas Lima', '45566778893', '11999990054', '11933330054'),
('Elisa Costa', '56677889904', '11999990055', '11933330055'), ('Frederico Ribeiro', '67788990015', '11999990056', '11933330056'),
('Gisele Santos', '78899001126', '11999990057', '11933330057'), ('Humberto Almeida', '89900112237', '11999990058', '11933330058'),
('Irene Carvalho', '90011223348', '11999990059', '11933330059'), ('Juliano Pereira', '01122334459', '11999990060', '11933330060'),
('Kátia Martins', '13579246800', '11999990061', NULL), ('Leonardo Rocha', '24680135799', '11999990062', NULL),
('Marta Gomes', '35791113151', '11999990063', NULL), ('Nelson Dias', '46802224262', '11999990064', NULL),
('Olga Peres', '57913335373', '11999990065', NULL), ('Patrício Melo', '68024446484', '11999990066', NULL),
('Regina Antunes', '79135557595', '11999990067', NULL), ('Silvio Ramos', '80246668606', '11999990068', NULL),
('Tânia Neves', '91357779717', '11999990069', NULL), ('Umar Cruz', '02468880828', '11999990070', NULL),
('Viviane Reis', '14141414141', '11999990071', '11922220071'), ('Waldir Fontana', '25252525252', '11999990072', '11922220072'),
('Xênia Macedo', '36363636363', '11999990073', '11922220073'), ('Yuri Barbosa', '47474747474', '11999990074', '11922220074'),
('Zuleica Cardoso', '58585858585', '11999990075', '11922220075'), ('Abner Vieira', '69696969696', '11999990076', '11922220076'),
('Bruna Teixeira', '70707070707', '11999990077', '11922220077'), ('Clodoaldo Nogueira', '81818181818', '11999990078', '11922220078'),
('Dora Castro', '92929292929', '11999990079', '11922220079'), ('Emanuel Franco', '03030303030', '11999990080', '11922220080'),
('Fátima Souza', '11111111111', NULL, NULL), ('Gustavo Silva', '22222222222', '11999990082', NULL),
('Helena Oliveira', '33333333333', NULL, NULL), ('Ismael Lima', '44444444444', '11999990084', NULL),
('Joana Costa', '55555555555', '11999990085', NULL), ('Lauro Ribeiro', '66666666666', NULL, NULL),
('Miriam Santos', '77777777777', '11999990087', NULL), ('Newton Almeida', '88888888888', NULL, NULL),
('Ofélia Carvalho', '99999999999', '11999990089', NULL), ('Pascoal Pereira', '00000000000', '11999990090', NULL);

INSERT INTO consultas (id_paciente, id_medico, data_consulta, hora_consulta, status_consulta) VALUES
(1, 1, '2026-05-18', '08:00:00', 'Realizada'), (2, 1, '2026-05-18', '09:00:00', 'Realizada'),
(3, 2, '2026-05-18', '10:00:00', 'Realizada'), (4, 3, '2026-05-18', '11:00:00', 'Realizada'),
(5, 4, '2026-05-18', '13:00:00', 'Realizada'), (6, 5, '2026-05-18', '14:00:00', 'Realizada'),
(7, 6, '2026-05-18', '15:00:00', 'Realizada'), (8, 7, '2026-05-18', '16:00:00', 'Realizada'),
(9, 8, '2026-05-19', '08:30:00', 'Realizada'), (10, 9, '2026-05-19', '09:30:00', 'Realizada'),
(11, 10, '2026-05-19', '10:30:00', 'Realizada'), (12, 11, '2026-05-19', '11:30:00', 'Realizada'),
(13, 12, '2026-05-19', '13:30:00', 'Realizada'), (14, 13, '2026-05-19', '14:30:00', 'Realizada'),
(15, 14, '2026-05-19', '15:30:00', 'Realizada'), (16, 15, '2026-05-19', '16:30:00', 'Realizada'),
(17, 16, '2026-05-20', '08:00:00', 'Realizada'), (18, 17, '2026-05-20', '09:00:00', 'Realizada'),
(19, 18, '2026-05-20', '10:00:00', 'Realizada'), (20, 19, '2026-05-20', '11:00:00', 'Realizada'),
(21, 20, '2026-05-20', '13:00:00', 'Realizada'), (22, 21, '2026-05-20', '14:00:00', 'Realizada'),
(23, 22, '2026-05-20', '15:00:00', 'Realizada'), (24, 23, '2026-05-20', '16:00:00', 'Realizada'),
(25, 24, '2026-05-21', '08:00:00', 'Agendada'), (26, 25, '2026-05-21', '09:00:00', 'Agendada'),
(27, 26, '2026-05-21', '10:00:00', 'Agendada'), (28, 27, '2026-05-21', '11:00:00', 'Agendada'),
(29, 28, '2026-05-21', '13:00:00', 'Agendada'), (30, 29, '2026-05-21', '14:00:00', 'Agendada'),
(31, 30, '2026-05-21', '15:00:00', 'Agendada'), (32, 1, '2026-05-21', '16:00:00', 'Agendada'),
(33, 2, '2026-05-22', '08:30:00', 'Agendada'), (34, 3, '2026-05-22', '09:30:00', 'Agendada'),
(35, 4, '2026-05-22', '10:30:00', 'Agendada'), (36, 5, '2026-05-22', '11:30:00', 'Agendada'),
(37, 6, '2026-05-22', '13:30:00', 'Agendada'), (38, 7, '2026-05-22', '14:30:00', 'Agendada'),
(39, 8, '2026-05-22', '15:30:00', 'Agendada'), (40, 9, '2026-05-22', '16:30:00', 'Agendada'),
(41, 10, '2026-05-25', '08:00:00', 'Agendada'), (42, 11, '2026-05-25', '09:00:00', 'Agendada'),
(43, 12, '2026-05-25', '10:00:00', 'Agendada'), (44, 13, '2026-05-25', '11:00:00', 'Agendada'),
(45, 14, '2026-05-25', '13:00:00', 'Agendada'), (46, 15, '2026-05-25', '14:00:00', 'Agendada'),
(47, 16, '2026-05-25', '15:00:00', 'Agendada'), (48, 17, '2026-05-25', '16:00:00', 'Agendada'),
(49, 18, '2026-05-26', '08:30:00', 'Agendada'), (50, 19, '2026-05-26', '09:30:00', 'Agendada'),
(51, 20, '2026-05-26', '10:30:00', 'Agendada'), (52, 21, '2026-05-26', '11:30:00', 'Agendada'),
(53, 22, '2026-05-26', '13:30:00', 'Agendada'), (54, 23, '2026-05-26', '14:30:00', 'Agendada'),
(55, 24, '2026-05-26', '15:30:00', 'Agendada'), (56, 25, '2026-05-26', '16:30:00', 'Agendada'),
(57, 26, '2026-05-27', '08:00:00', 'Agendada'), (58, 27, '2026-05-27', '09:00:00', 'Agendada'),
(59, 28, '2026-05-27', '10:00:00', 'Agendada'), (60, 29, '2026-05-27', '11:00:00', 'Agendada'),
(61, 30, '2026-05-27', '13:00:00', 'Agendada'), (62, 1, '2026-05-27', '14:00:00', 'Agendada'),
(63, 2, '2026-05-27', '15:00:00', 'Agendada'), (64, 3, '2026-05-27', '16:00:00', 'Agendada'),
(65, 4, '2026-05-15', '09:00:00', 'Cancelada'), (66, 5, '2026-05-15', '10:00:00', 'Cancelada'),
(67, 6, '2026-05-15', '11:00:00', 'Cancelada'), (68, 7, '2026-05-15', '14:00:00', 'Cancelada'),
(1, 1, '2026-06-01', '08:00:00', 'Agendada'), (2, 1, '2026-06-02', '09:00:00', 'Agendada'),
(3, 1, '2026-06-03', '10:00:00', 'Agendada'), (4, 1, '2026-06-04', '11:00:00', 'Agendada'),
(5, 2, '2026-06-01', '14:00:00', 'Agendada'), (6, 2, '2026-06-02', '15:00:00', 'Agendada'),
(7, 3, '2026-06-03', '16:00:00', 'Agendada'), (8, 4, '2026-06-04', '09:00:00', 'Agendada'),
(15, 1, '2026-05-19', '17:00:00', 'Realizada'), (16, 1, '2026-05-20', '17:00:00', 'Realizada'),
(1, 16, '2026-05-22', '10:00:00', 'Agendada'), (2, 16, '2026-05-23', '11:00:00', 'Agendada');

-- Criação dos UPDATE
UPDATE pacientes 
SET telefone = '11999991111' 
WHERE id_paciente = 1;

UPDATE consultas 
SET status_consulta = 'Realizada' 
WHERE id_consulta = 1;

UPDATE medicos 
SET id_especialidade = 9 
WHERE id_medico = 1;

-- Crição do DELETE
DELETE FROM consultas 
WHERE id_consulta IN (65, 66, 67, 68);

DELETE FROM usuarios 
WHERE id_usuario = 3;

-- Criação do SELECT, WHERE, ORDER BY, GROUP BY e INNER JOIN
SELECT * FROM pacientes 
ORDER BY nome ASC;

SELECT m.nome AS medico, m.crm, e.nome AS especialidade 
FROM medicos m
INNER JOIN especialidades e ON m.id_especialidade = e.id_especialidade;

SELECT * FROM consultas 
WHERE data_consulta = '2026-05-21';

SELECT id_paciente, nome, telefone FROM pacientes 
WHERE telefone IS NOT NULL;

SELECT nome, crm FROM medicos 
ORDER BY crm ASC;

SELECT * FROM consultas 
WHERE status_consulta = 'Agendada';

SELECT * FROM unidades;

CREATE VIEW vw_relatorio_geral_consultas AS
SELECT 
    c.id_consulta,
    p.nome AS paciente,
    p.cpf AS paciente_cpf,
    m.nome AS medico,
    m.crm AS medico_crm,
    e.nome AS especialidade,
    u.nome AS unidade_atendimento,
    c.data_consulta,
    c.hora_consulta,
    c.status_consulta
FROM consultas c
INNER JOIN pacientes p ON c.id_paciente = p.id_paciente
INNER JOIN medicos m ON c.id_medico = m.id_medico
INNER JOIN especialidades e ON m.id_especialidade = e.id_especialidade
INNER JOIN unidades u ON m.id_unidade = u.id_unidade;

