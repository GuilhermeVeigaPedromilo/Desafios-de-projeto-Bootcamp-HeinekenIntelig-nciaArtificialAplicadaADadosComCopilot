-- 1. Criar o banco de dados
CREATE DATABASE ecommerce_desafio_de_projeto;
USE ecommerce_desafio_de_projeto;

-- 2. Criação das tabelas

-- Cliente Pessoa Física
CREATE TABLE cliente_pf (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(25),
    Minit CHAR(3),
    Lname VARCHAR(25),
    CPF CHAR(14) UNIQUE NOT NULL,
    Address VARCHAR(50)
);

-- Cliente Pessoa Jurídica
CREATE TABLE cliente_pj (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(18) UNIQUE NOT NULL,
    Address VARCHAR(50)
);

-- Produtos
CREATE TABLE product (
    idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(25) NOT NULL,
    classification_kids BOOL DEFAULT FALSE,
    category ENUM('Eletrônico', 'Vestimenta', 'Brinquedo', 'Alimentos', 'Móveis') NOT NULL,
    avaliacao FLOAT DEFAULT 0,
    size VARCHAR(10)
);

-- Pagamentos
CREATE TABLE payments (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT NOT NULL,
    typePayment ENUM('Boleto', 'Cartão', 'Dois Cartões'),
    limitAvailable FLOAT,
    CONSTRAINT fk_payments_client FOREIGN KEY (idClient) REFERENCES cliente_pf(idClient)
);

-- Pedidos
CREATE TABLE orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT NOT NULL,
    orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
    orderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentCash BOOL DEFAULT FALSE,
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) REFERENCES cliente_pf(idClient)
);

-- Entrega
CREATE TABLE delivery (
    idDelivery INT AUTO_INCREMENT PRIMARY KEY,
    idOrder INT NOT NULL,
    trackingCode VARCHAR(50) NOT NULL,
    deliveryStatus ENUM('Aguardando Envio', 'Em Transporte', 'Entregue') DEFAULT 'Aguardando Envio',
    CONSTRAINT fk_delivery_order FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
);

-- Estoque
CREATE TABLE productStorage (
    idProductStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocations VARCHAR(255) NOT NULL,
    quantity INT DEFAULT 0
);

-- Fornecedor
CREATE TABLE supplier (
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(18) NOT NULL UNIQUE,
    contact CHAR(11) NOT NULL
);

-- Vendedor
CREATE TABLE seller (
    idSeller INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    AbstName VARCHAR(255),
    CNPJ CHAR(18) UNIQUE,
    CPF CHAR(14) UNIQUE,
    location VARCHAR(255),
    contact CHAR(11) NOT NULL
);

-- Relacionamento entre Produto e Vendedor
CREATE TABLE productSeller (
    idSeller INT,
    idProduct INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY (idSeller, idProduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idSeller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

-- Relacionamento entre Produto e Pedido
CREATE TABLE productOrder (
    idProduct INT,
    idOrder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem Estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idProduct, idOrder),
    CONSTRAINT fk_product_order_product FOREIGN KEY (idProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_product_order_order FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
);

-- Relacionamento entre Produto e Fornecedor
CREATE TABLE productSupplier (
    idSupplier INT,
    idProduct INT,
    quantity INT NOT NULL,
    PRIMARY KEY (idSupplier, idProduct),
    CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idSupplier) REFERENCES supplier(idSupplier),
    CONSTRAINT fk_product_supplier_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

-- Localização do Produto no Estoque
CREATE TABLE storageLocation (
    idProduct INT,
    idStorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idProduct, idStorage),
    CONSTRAINT fk_storage_location_product FOREIGN KEY (idProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storage_location_storage FOREIGN KEY (idStorage) REFERENCES productStorage(idProductStorage)
);

-- 3. Inserção de Dados

INSERT INTO cliente_pf (Fname, Minit, Lname, CPF, Address) VALUES
('João', 'A', 'Silva', '111.111.111-11', 'Rua A, 123'),
('Maria', 'B', 'Souza', '222.222.222-22', 'Rua B, 456');

INSERT INTO cliente_pj (SocialName, CNPJ, Address) VALUES
('Empresa X', '13.854.638/1000-25', 'Avenida Principal, 789');

INSERT INTO product (Pname, classification_kids, category, avaliacao, size) VALUES
('Smartphone', FALSE, 'Eletrônico', 4.5, '15x7 cm'),
('Camiseta', FALSE, 'Vestimenta', 4.0, 'M');

INSERT INTO payments (idClient, typePayment, limitAvailable) VALUES
(1, 'Cartão', 5000),
(2, 'Boleto', 3000);

INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) VALUES
(1, 'Confirmado', 'Compra de 2 produtos', 15, TRUE);

INSERT INTO delivery (idOrder, trackingCode, deliveryStatus) VALUES
(1, 'BR123456789', 'Em Transporte');

-- 4. Consultas SQL Avançadas

-- Recuperação Simples
SELECT * FROM cliente_pf;
SELECT * FROM orders;

-- Filtro com WHERE
SELECT * FROM product WHERE category = 'Eletrônico';

-- Atributo Derivado (Total de Compras por Cliente)
SELECT o.idOrderClient, COUNT(*) AS total_pedidos
FROM orders o
GROUP BY o.idOrderClient;

-- Ordenação
SELECT * FROM product ORDER BY avaliacao DESC;

-- Agrupamento e Filtro com HAVING
SELECT idOrderClient, COUNT(*) AS total_orders
FROM orders
GROUP BY idOrderClient
HAVING COUNT(*) > 1;

-- Junção Entre Tabelas
SELECT c.Fname, c.Lname, p.Pname, o.orderStatus
FROM orders o
JOIN cliente_pf c ON o.idOrderClient = c.idClient
JOIN productOrder po ON o.idOrder = po.idOrder
JOIN product p ON po.idProduct = p.idProduct;