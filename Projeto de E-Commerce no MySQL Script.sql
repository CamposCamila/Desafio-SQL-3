-- Criação de banco de dados para o cenário de E-Commerce
create database ecommerce;
use ecommerce;

-- Criar tabela cliente
create table cliente(
        idClient int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(30),
        constraint unique_cpf_client unique (cpf)
        );
     
-- Criar tabela produto
create table product(
        idproduct int auto_increment primary key,
        Pname varchar(10) not null,
        Classification_kids bool default false,
        Category enum('eletrônico','vestimenta','brinquedos','alimentos','móveis') not null,
        Avaliação float default 0,
        size varchar(10),
);

 -- Criar tabela pagamentos 
  create table payments(
		idclient int,
        idpayment int,
        typepayment enum('boleto','cartão','dois cartões'),
	    limitAvaliable float,
        primary key(idclient, id_payment)
);

-- Criar tabela pedido
create table orders(
        idorder int auto_increment primary key,
        idorderclient int,
        orderstatus enum('cancelado','confirmado','em processamento') default 'Em processamento',
        orderdescription varchar(255),
        sendvalue float default 10,
        paymentCash boolean default false,
        constraint fk_orders_client foreign key (idorderclient) references clients(idclient)
);
        
-- Criar tabela estoque 
create table productstorage(
        idproductstorage int auto_increment primary key,
        storagelocation varchar(255),
        quantity int default 0
);

-- Criar tabela fornecedor
create table supplier(
	    idsupplier int auto_increment primary key,
		Socialname varchar(255) not null,
        CNPJ char(15) not null,
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);

-- Criar tabela terceiro vendedor
create table seller(
	    idseller int auto_increment primary key,
		Socialname varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15),
        CPF char(9),
        location varchar(255),
        contact char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique (CPF)
        );
        
-- Criar tabela Produtos Vendedor (terceiro)
create table productseller(
        idPseller int,
        idPproduct int,
        prodQuantity int default 1,
        primary key (idseller, idPproduct),
        constraint fk_product_seller foreign key (idseller) references seller(idseller),
        constraint fk_product_product foreign key (idPproduct) references product(idproduct)
        );

-- Criar tabela Produto/pedido      
create table productorder(
		idPOproduct int,
        idPOorder int,
        poQuantity int default 1,
        poStatus enum('Disponivel','Sem estoque') default 'Disponivel',
        primary key (idPOproduct, idPOorder),
        constraint fk_productoder_seller foreign key (idPOproduct) references product(idproduct),
        constraint fk_productorder_product foreign key (idPOorder) references orders(idporder)
        );
        
-- Criar tabela Produto_em_Estoque (localização)        
create table storagelocation(
        idLproduct int,
        idLstorage int,
        location varchar(255) not null,
        primary key (idLproduct, idLstorage),
        constraint fk_storage_location_product foreign key (idLproduct) references product(idproduct),
        constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
        );
        
-- Criar tabela Produto Fornecedor
create table productSupplier(
	    idPsSupplier int,
        idPsProduct int,
        quantity int not null,
        primary key (idPsSupplier, idPsProduct),
        constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
        constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);