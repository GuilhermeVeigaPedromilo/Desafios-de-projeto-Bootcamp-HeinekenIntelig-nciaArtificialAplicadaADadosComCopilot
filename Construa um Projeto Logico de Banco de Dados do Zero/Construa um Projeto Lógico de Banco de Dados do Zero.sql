CREATE DATABASE service_management;
USE service_management;

-- Tabela Client
CREATE TABLE Client (
    idClient INT PRIMARY KEY,
    Name VARCHAR(45),
    SSN VARCHAR(45),
    Contact VARCHAR(45)
);

-- Tabela PersonInCharge
CREATE TABLE PersonInCharge (
    idPersonInCharge INT PRIMARY KEY,
    HelpDesk_Level VARCHAR(45),
    Name VARCHAR(45),
    Department VARCHAR(45)
);

-- Tabela Order
CREATE TABLE `Order` (
    idOrder INT PRIMARY KEY,
    Service VARCHAR(45),
    Description VARCHAR(45),
    Request_Date DATE,
    Client_idClient INT,
    Validate TINYINT,
    FOREIGN KEY (Client_idClient) REFERENCES Client(idClient)
);

-- Tabela Analysis_Order
CREATE TABLE Analysis_Order (
    PersonInCharge_idPersonInCharge INT,
    Order_idOrder INT,
    PRIMARY KEY (PersonInCharge_idPersonInCharge, Order_idOrder),
    FOREIGN KEY (PersonInCharge_idPersonInCharge) REFERENCES PersonInCharge(idPersonInCharge),
    FOREIGN KEY (Order_idOrder) REFERENCES `Order`(idOrder)
);

-- Tabela ServiceOrder
CREATE TABLE ServiceOrder (
    idServiceOrder INT PRIMARY KEY,
    ServiceOrder_Status VARCHAR(45),
    Order_idOrder INT,
    Order_client_idClient INT,
    FOREIGN KEY (Order_idOrder) REFERENCES `Order`(idOrder),
    FOREIGN KEY (Order_client_idClient) REFERENCES Client(idClient)
);

-- Inserir dados fictícios
INSERT INTO Client VALUES (1, 'John Doe', '123-456-789', 'john@example.com');
INSERT INTO Client VALUES (2, 'Jane Smith', '987-654-321', 'jane@example.com');

INSERT INTO PersonInCharge VALUES (1, 'Nível 1', 'Carlos Silva', 'TI');
INSERT INTO PersonInCharge VALUES (2, 'Nível 2', 'Ana Costa', 'Suporte');

INSERT INTO `Order` VALUES (1, 'Instalação', 'Configuração de rede', '2024-03-10', 1, 1);
INSERT INTO `Order` VALUES (2, 'Reparo', 'Conserto de servidor', '2024-03-12', 2, 1);

INSERT INTO Analysis_Order VALUES (1, 1);
INSERT INTO Analysis_Order VALUES (2, 2);

INSERT INTO ServiceOrder VALUES (1, 'Concluído', 1, 1);
INSERT INTO ServiceOrder VALUES (2, 'Em andamento', 2, 2);

-- Recuperações simples com SELECT
SELECT * FROM Client;

-- Filtro com WHERE
SELECT * FROM ServiceOrder WHERE ServiceOrder_Status = 'Concluído';

-- Atributo derivado (dias desde a solicitação)
SELECT idOrder, Service, DATEDIFF(CURRENT_DATE, Request_Date) AS Days_Passed FROM `Order`;

-- Ordenação com ORDER BY
SELECT * FROM PersonInCharge ORDER BY Name ASC;

-- Filtro com HAVING (pedidos validados)
SELECT Client_idClient, COUNT(*) AS Total_Orders
FROM `Order`
GROUP BY Client_idClient
HAVING COUNT(*) > 1;

-- JOIN entre tabelas
SELECT so.idServiceOrder, c.Name AS Client_Name, o.Service, so.ServiceOrder_Status
FROM ServiceOrder so
JOIN `Order` o ON so.Order_idOrder = o.idOrder
JOIN Client c ON so.Order_client_idClient = c.idClient;
