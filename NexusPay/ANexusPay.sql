create database NexusPay;
USE nexuspay;
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    dt_cadastro DATETIME
);

CREATE TABLE endereco (
    id_endereco INT PRIMARY KEY,
    longradouro VARCHAR(100),
    numero VARCHAR(10),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado CHAR(2),
    cep CHAR(8),
    tipo_endereco ENUM('Residencial', 'Comercial', 'Entrega'),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE conta (
    id_conta INT PRIMARY KEY,
    numero_conta CHAR(10) UNIQUE,
    agencia CHAR(4),
    saldo DECIMAL(10,2) DEFAULT 0.00,
    tipo_conta ENUM('Conta Corrente', 'Conta Poupança', 'Conta Pessoa Juridica'),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE telefones (
    id_telefone INT PRIMARY KEY,
    ddd CHAR(2),
    numero VARCHAR(9),
    tipo_telefone ENUM('Particular', 'Residencial', 'Comercial'),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE emails (
    id_email INT PRIMARY KEY,
    email VARCHAR(64) UNIQUE,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE transacao (
    id_transacao INT PRIMARY KEY,
    valor DECIMAL(10,2) NOT NULL,
    id_conta INT,
    dt_transacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_conta) REFERENCES conta(id_conta)
);

INSERT INTO clientes (id_cliente, nome, cpf, dt_cadastro) VALUES
(1, 'Lucas Oliveira', '01234567890', '2026-01-10 10:00:00'),
(2, 'Beatriz Souza', '12345678901', '2026-01-12 11:30:00'),
(3, 'Carlos Alberto', '23456789012', '2026-01-15 09:15:00'),
(4, 'Mariana Silva', '04567890123', '2026-01-20 14:20:00'),
(5, 'Ricardo Santos', '56789012345', '2026-01-22 16:45:00'),
(6, 'Fernanda Lima', '67890123456', '2026-02-01 08:00:00'),
(7, 'Roberto Nunes', '07890123457', '2026-02-05 13:10:00'),
(8, 'Juliana Costa', '89012345678', '2026-02-10 17:30:00'),
(9, 'Marcio Garcia', '90123456789', '2026-02-15 11:00:00'),
(10, 'Sofia Helena', '00122233344', '2026-02-20 10:20:00');

INSERT INTO endereco (id_endereco, longradouro, numero, bairro, cidade, estado, cep, tipo_endereco, id_cliente) VALUES
(1, 'Rua das Flores', '100', 'Centro', 'São Paulo', 'SP', '01001000', 'Residencial', 1),
(2, 'Av. Paulista', '1500', 'Bela Vista', 'São Paulo', 'SP', '01311200', 'Comercial', 1),
(3, 'Rua Bahia', '45', 'Gonzaga', 'Santos', 'SP', '11060450', 'Residencial', 2),
(4, 'Rua do Sol', '99', 'Meireles', 'Fortaleza', 'CE', '60165080', 'Residencial', 3),
(5, 'Av. Brasil', '2000', 'Funcionários', 'Belo Horizonte', 'MG', '30140000', 'Entrega', 4),
(6, 'Rua Chile', '12', 'Rebouças', 'Curitiba', 'PR', '80215170', 'Residencial', 5),
(7, 'Rua Riachuelo', '500', 'Centro', 'Rio de Janeiro', 'RJ', '20230010', 'Residencial', 6),
(8, 'Av. Ipiranga', '321', 'Azenha', 'Porto Alegre', 'RS', '90160090', 'Comercial', 7),
(9, 'Rua das Palmeiras', '77', 'Setor Oeste', 'Goiânia', 'GO', '74110150', 'Residencial', 8),
(10, 'Rua Amazonas', '10', 'Centro', 'Manaus', 'AM', '69005000', 'Residencial', 9);

INSERT INTO conta (id_conta, numero_conta, agencia, saldo, tipo_conta, id_cliente) VALUES
(1, '10001-5', '0001', 1500.50, 'Conta Corrente', 1),
(2, '20002-8', '0001', 5000.00, 'Conta Poupança', 2),
(3, '30003-1', '0001', 10.25, 'Conta Corrente', 3),
(4, '40004-4', '0002', 12500.00, 'Conta Pessoa Juridica', 4),
(5, '50005-7', '0001', 0.00, 'Conta Corrente', 5),
(6, '60006-0', '0003', 450.75, 'Conta Corrente', 6),
(7, '70007-3', '0001', 8900.00, 'Conta Poupança', 7),
(8, '80008-6', '0001', 120.00, 'Conta Corrente', 8),
(9, '90009-9', '0002', 3300.40, 'Conta Corrente', 9),
(10, '10101-0', '0001', 1050.00, 'Conta Corrente', 10);

INSERT INTO telefones (id_telefone, ddd, numero, tipo_telefone, id_cliente) VALUES
(1, '11', '988887777', 'Particular', 1),
(2, '11', '33334444', 'Residencial', 1),
(3, '13', '977776666', 'Particular', 2),
(4, '85', '966665555', 'Particular', 3),
(5, '31', '955554444', 'Comercial', 4),
(6, '41', '944443333', 'Particular', 5),
(7, '21', '933332222', 'Particular', 6),
(8, '51', '32221111', 'Residencial', 7),
(9, '62', '911110000', 'Particular', 8),
(10, '92', '999991111', 'Particular', 9);

INSERT INTO emails (id_email, email, id_cliente) VALUES
(1, 'lucas.oliveira@email.com', 1),
(2, 'beatriz.souza@provedor.com', 2),
(3, 'carlos.alberto@empresa.com', 3),
(4, 'mariana.silva@email.com', 4),
(5, 'ricardo.santos@email.com', 5),
(6, 'fernanda.lima@web.com', 6),
(7, 'roberto.nunes@email.com', 7),
(8, 'juliana.costa@email.com', 8),
(9, 'marcio.garcia@gmail.com', 9),
(10, 'sofia.helena@email.com', 10);

INSERT INTO transacao (id_transacao, valor, id_conta) VALUES
(1, 100.00, 1),
(2, 50.50, 1),
(3, 1200.00, 2),
(4, 5.00, 3),
(5, 450.00, 4),
(6, 1000.00, 4),
(7, 25.00, 6),
(8, 800.00, 7),
(9, 30.40, 9),
(10, 200.00, 10);