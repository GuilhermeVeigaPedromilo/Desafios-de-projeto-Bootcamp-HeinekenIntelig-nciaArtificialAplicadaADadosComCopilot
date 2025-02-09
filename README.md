<img src="./public/banner.png" alt="">

---

# 📌 Refinando um Projeto Conceitual de Banco de Dados – E-COMMERCE

Este **Diagrama Entidade-Relacionamento (DER)** representa a estrutura de um **E-commerce**, organizando os principais elementos do sistema, como cliente, fornecedores e terceiros, produtos, estoque, pedidos, formas de pagamento, parcelas e entrega.

---

## **🛒 1. CLIENT (Pessoa Física e Jurídica)**
Os client podem ser **Pessoa Física (PF) ou Pessoa Jurídica (PJ)**, mas nunca ambas ao mesmo tempo. A estrutura garante essa restrição usando uma relação **1:1** entre `Client`, `Client_SSN` e `Client_ENI`. Cada cliente pode ter ínumeros pedidos e vários cartões cadastrados.

---

## **📦 2. Product, Order e Delivery**
Cada **pedido** pode ter um processo de **entrega** associado, armazenando status e código de rastreamento. As relações acontecem entre `Order` e `Delivery`. Cada pedido pode ter ínumeros produtos. As relações também acontecem entre `Product` e `Order`.

---

## **💳 3. Types_Pagaments, Small_Part, Cards e Tax**
O sistema de pagamento aceita múltiplas **formas de pagamento**, onde **Cartões (Cards) possuem Taxas (Tax) específicas de acordo com a bandeira (CardBrand) e número de parcelas permitidas (Small_Part_Min e Small_Part_Max)**, sendo esta relação vinculada a `Product`. As formas de pagamentos podem ser além do cartão, assim a coluna `Tax` pode ser um desconto dependendo da forma de pagamento.

---

## **📑 4. Supplier, Product, Small_Part, Stock e ThirdPart-Sellers**
Os produtos estão organizados por categorias, possuem preços, descrição, **números de parcelas relacionadas a cada produto**, **relação com localização no estoque**, **relação com terceiros e fornecedores**.

---

## **🔍 5. RESUMO DA ESTRUTURA GERAL**

| **Módulo**        | **Fluxo** |
|------------------|------------------|
| **Cliente** | Client → Client_SSN **OU** Client_ENI → Card
| **Produtos** | Supplier **OU** ThirdPart-Sellers → Product → Stock 
| **Compra com Cartão** | Client → Product → Card → Small_Part → Type_Pagaments → Order → Deliver
| **Compra sem ser com Cartão** | Client → Product → Types_Pagament → Order → Delivery (se houver **OU** se o pedido não for cancelado) |
