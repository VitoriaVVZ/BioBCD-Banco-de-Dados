create database LojaDB;
use LojaDB;

create table Clientes (
	cliente_id int primary key,
    nomeClientes varchar(100),
    cidade varchar(50)
);

create table Categorias (
	categoria_id int primary key,
    nomeCategorias varchar(100)
);

create table Produtos (
	produto_id int primary key,
    nomeProduto varchar(100),
    categoria_id int,
    preco decimal(10,2),
    
    foreign key (categoria_id) references Categorias(categoria_id)
);

create table Pedidos(
	pedido_id int primary key,
    cliente_id int,
    dataPedido date,
    
    foreign key (cliente_id) references Clientes(cliente_id)
);

CREATE TABLE DetalhesPedidos (
    detalhe_id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    produto_id INT,
    quantidade INT,

    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(produto_id)
);

INSERT INTO Clientes (cliente_id, nomeClientes, cidade) VALUES
(1, 'Luisa Guimarães', 'São Paulo'),
(2, 'João Santos', 'Rio de Janeiro'),
(3, 'Ana Costa', 'Belo Horizonte');

INSERT INTO Categorias (categoria_id, nomeCategorias) VALUES
(1, 'Eletrônicos'),
(2, 'Vestuário');

INSERT INTO Produtos (produto_id, nomeProduto, categoria_id, preco) VALUES
(1, 'Celular', 1, 1500.00),
(2, 'Televisão', 1, 3000.00),
(3, 'Camiseta', 2, 50.00);

INSERT INTO Pedidos (pedido_id, cliente_id, dataPedido) VALUES
(1, 1, '2024-01-15'),
(2, 2, '2024-01-20'),
(3, 1, '2024-02-10');

INSERT INTO DetalhesPedidos (pedido_id, produto_id, quantidade) VALUES
(1, 1, 2),
(1, 2, 1), 
(2, 3, 5), 
(3, 2, 2);

-- EXERCÍCIOS

SELECT
    Clientes.nomeClientes,
    Pedidos.dataPedido
FROM Clientes
INNER JOIN Pedidos
    ON Clientes.cliente_id = Pedidos.cliente_id;
    
SELECT
    Clientes.nomeClientes,
    Pedidos.pedido_id,
    Pedidos.dataPedido
FROM Clientes
LEFT JOIN Pedidos
    ON Clientes.cliente_id = Pedidos.cliente_id;

SELECT
    Clientes.nomeClientes,
    Pedidos.dataPedido,
    Produtos.nomeProduto,
    DetalhesPedidos.quantidade
FROM Clientes

INNER JOIN Pedidos
    ON Clientes.cliente_id = Pedidos.cliente_id

INNER JOIN DetalhesPedidos
    ON Pedidos.pedido_id = DetalhesPedidos.pedido_id

INNER JOIN Produtos
    ON DetalhesPedidos.produto_id = Produtos.produto_id;

SELECT
    Clientes.nomeClientes,
    COUNT(Pedidos.pedido_id) AS TotalPedidos
FROM Clientes

LEFT JOIN Pedidos
    ON Clientes.cliente_id = Pedidos.cliente_id

GROUP BY Clientes.cliente_id, Clientes.nomeClientes;

SELECT
    Clientes.nomeClientes,
    SUM(DetalhesPedidos.quantidade) AS TotalItens
FROM Clientes

INNER JOIN Pedidos
    ON Clientes.cliente_id = Pedidos.cliente_id

INNER JOIN DetalhesPedidos
    ON Pedidos.pedido_id = DetalhesPedidos.pedido_id

GROUP BY Clientes.cliente_id, Clientes.nomeClientes;

SELECT
    Clientes.nomeClientes,
    SUM(DetalhesPedidos.quantidade * Produtos.preco) AS TotalGasto
FROM Clientes

INNER JOIN Pedidos
    ON Clientes.cliente_id = Pedidos.cliente_id

INNER JOIN DetalhesPedidos
    ON Pedidos.pedido_id = DetalhesPedidos.pedido_id

INNER JOIN Produtos
    ON DetalhesPedidos.produto_id = Produtos.produto_id

GROUP BY Clientes.cliente_id, Clientes.nomeClientes;

SELECT
    Produtos.nomeProduto,
    SUM(DetalhesPedidos.quantidade) AS QuantidadeVendida
FROM Produtos

INNER JOIN DetalhesPedidos
    ON Produtos.produto_id = DetalhesPedidos.produto_id

GROUP BY Produtos.produto_id, Produtos.nomeProduto

ORDER BY QuantidadeVendida DESC;

SELECT
    Pedidos.dataPedido,
    SUM(DetalhesPedidos.quantidade * Produtos.preco) AS Faturamento
FROM Pedidos

INNER JOIN DetalhesPedidos
    ON Pedidos.pedido_id = DetalhesPedidos.pedido_id

INNER JOIN Produtos
    ON DetalhesPedidos.produto_id = Produtos.produto_id

GROUP BY Pedidos.dataPedido

ORDER BY Pedidos.dataPedido DESC;

CREATE VIEW vw_PedidosClientes AS
SELECT
    Clientes.nomeClientes,
    Pedidos.pedido_id,
    Pedidos.dataPedido
FROM Clientes

INNER JOIN Pedidos
    ON Clientes.cliente_id = Pedidos.cliente_id;

SELECT * FROM vw_PedidosClientes;

CREATE VIEW vw_ProdutosCategorias AS
SELECT
    Produtos.nomeProduto,
    Categorias.nomeCategorias,
    Produtos.preco
FROM Produtos

INNER JOIN Categorias
    ON Produtos.categoria_id = Categorias.categoria_id;

SELECT * FROM vw_ProdutosCategorias;

CREATE VIEW vw_VendasPorProduto AS
SELECT
    Produtos.nomeProduto,
    SUM(DetalhesPedidos.quantidade * Produtos.preco) AS TotalVendido
FROM Produtos

INNER JOIN DetalhesPedidos
    ON Produtos.produto_id = DetalhesPedidos.produto_id

GROUP BY Produtos.produto_id, Produtos.nomeProduto;

SELECT *
FROM vw_VendasPorProduto
ORDER BY TotalVendido DESC;

CREATE VIEW vw_DetalhesPedidos AS
SELECT
    detalhe_id,
    pedido_id,
    produto_id,
    quantidade
FROM DetalhesPedidos;

SELECT * FROM vw_DetalhesPedidos;