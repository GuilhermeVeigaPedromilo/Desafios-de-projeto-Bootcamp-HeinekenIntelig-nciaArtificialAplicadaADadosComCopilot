# 📌 Construindo seu Primeiro Projeto Lógico de Banco de Dados

## 📜 Descrição do Projeto Lógico

Este projeto consiste na modelagem de um banco de dados relacional para um sistema de E-commerce, garantindo a integridade dos dados e o suporte a operações comerciais essenciais, como cadastro de clientes, produtos, pedidos, pagamentos, estoque, fornecedores e entregas.

### 📖 1. Visão Geral
O banco de dados foi estruturado para atender às principais necessidades de um E-commerce, permitindo:

O cadastro de clientes, tanto pessoa física quanto pessoa jurídica.
O gerenciamento de produtos, incluindo categorias, avaliações e disponibilidade.
O controle de pedidos, status e valores de frete.
A administração de pagamentos, aceitando múltiplas formas de pagamento.
O monitoramento do estoque, vinculando produtos a fornecedores e vendedores.
O rastreamento de entregas, garantindo a transparência no envio.
### 🏗️ 2. Modelagem Lógica do Banco de Dados

#### 🧑‍💼 2.1 Clientes
Os clientes podem ser Pessoa Física (PF) ou Pessoa Jurídica (PJ), armazenando informações como CPF/CNPJ, nome e endereço.

cliente_pf: Clientes individuais com CPF.
cliente_pj: Empresas cadastradas com CNPJ.

#### 📦 2.2 Produtos
Cada produto possui um nome, categoria, avaliação e informações de dimensão.

product: Armazena os produtos disponíveis na loja.

#### 💳 2.3 Pagamentos
Os pagamentos podem ser realizados via boleto, cartão de crédito ou dois cartões. O banco de dados gerencia o limite de crédito disponível para cada cliente.

payments: Relaciona clientes a métodos de pagamento.

#### 🛒 2.4 Pedidos
Cada pedido tem um status (Confirmado, Cancelado, Em Processamento) e um valor de frete. Os produtos comprados são registrados na relação entre produtos e pedidos.

orders: Armazena os pedidos realizados.
productOrder: Relaciona produtos aos pedidos.

#### 🚚 2.5 Entregas
O banco de dados armazena códigos de rastreamento e status das entregas para garantir visibilidade ao cliente.

delivery: Gerencia informações de rastreamento.

#### 📦 2.6 Estoque
O estoque armazena a localização dos produtos e a quantidade disponível.

productStorage: Gerencia os estoques da empresa.
storageLocation: Relaciona produtos ao estoque.

#### 🏭 2.7 Fornecedores
Os fornecedores são responsáveis por abastecer o estoque.

supplier: Registra os fornecedores.
productSupplier: Relaciona produtos aos fornecedores.

#### 🏪 2.8 Vendedores
Os vendedores podem ser empresas ou autônomos, vendendo produtos na plataforma.

seller: Registra os vendedores.
productSeller: Relaciona vendedores aos produtos.

### 🗂️ 3. Estrutura das Tabelas

| **Tabela**  | **Descrição** |
|------------------|------------------|	
cliente_pf| Armazena clientes pessoa física
cliente_pj|	Armazena clientes pessoa jurídica
product| Armazena produtos disponíveis
payments|	Relaciona clientes a pagamentos
orders|	Registra pedidos realizados
productOrder|	Relaciona produtos aos pedidos
delivery|	Gerencia entregas e rastreamento
productStorage|	Gerencia estoques
storageLocation|	Relaciona produtos ao estoque
supplier|	Registra fornecedores
productSupplier|	Relaciona fornecedores aos produtos
seller|	Registra vendedores
productSeller|s	Relaciona vendedores aos produtos

### 🎯 Funcionamento das Tabelas

- A tabela `Client` é relacionada com `Order`, onde cada cliente pode realizar múltiplas ordens.
- A tabela `Order` pode ser analisada por diferentes responsáveis na tabela `PersonInCharge` através da tabela intermediária `Analysis Order`.
- Uma vez analisada, a `Order` pode ser validada e gerar um registro na tabela `ServiceOrder` para acompanhar o status da ordem.

A estrutura lógica permite a rastreabilidade do ciclo de vida das ordens, desde a solicitação do cliente até a análise e validação do serviço.
