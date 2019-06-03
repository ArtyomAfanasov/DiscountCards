/*CREATE ====================================================================================================================================*/

CREATE TABLE Shops
	(	ID_Shop int NOT NULL,
		AddressShop varchar(250) NOT NULL UNIQUE,
		ForDescription varchar(200),
	Constraint Shops_PK primary key (ID_Shop))

Create table Purchases
	(	ID_Purchase int NOT NULL,
		DataOfPurchase date NOT NULL,
		NumberOfCashbox varchar(50) NOT NULL,
		isDone bit NOT NULL,
		Cost int NOT NULL Check (Cost >= 0),
		FK_ID_Card int NOT NULL,
		FK_ID_Shop int NOT NULL,
		ForDescription varchar(200) 
	Constraint Purchases_PK primary key (ID_Purchase))

Create table Purchases_Products 
	(	ID_Current int NOT NULL,
		FK_ID_Purchase int NOT NULL,
		FK_ID_Product int NOT NULL,
		AmountOfProduct int NOT NULL CHECK (AmountOfProduct > 0),
		ForDescription varchar(200),
	Constraint Purchases_Products_PK primary key (ID_Current))

create table Products
	(	ID_Product int NOT NULL,
		ProdactName varchar(100),
		CostForUnit int NOT NULL CHECK (CostForUnit > 0),
		FK_ID_TypeOfProduct int NOT NULL,
		ForDescription varchar(200),
	Constraint Products_PK primary key (ID_Product))

create table Cards
	(	ID_Card int NOT NULL,
		CardNumber int,
		/*DiscountPercentage int NOT NULL CHECK (DiscountPercentage >= 0), Не нужно, т.к. есть в таблице типов карт */ 
		AccumulatedPoints int CHECK (AccumulatedPoints >= 0),
		DateOfReceiving date,
		FK_ID_Client int NOT NULL,
		FK_ID_TypeOfCard int NOT NULL,
		ForDescription varchar(200),
	Constraint Cards_PK primary key (ID_Card))

Create table Type_of_cards
	(	ID_TypeOfCard int NOT NULL,
		QuantityOfDiscount int NOT NULL CHECK (QuantityOfDiscount >= 0),
		ForDescription varchar(200),
	Constraint Type_of_cards_PK primary key (ID_TypeOfCard))

create table Type_of_product
	(	ID_TypeOfProduct int NOT NULL,
		CoefficientForAddingPoints real NOT NULL CHECK (CoefficientForAddingPoints >= 0),
		ForDescription varchar(200),
	Constraint Type_of_product_PK primary key (ID_TypeOfProduct))

create table Clients
	(	ID_Client int NOT NULL,
		FirstName varchar (100) NOT NULL,
		LastName varchar (100) NOT NULL,
		Birthday date,
		Phone varchar(30) NOT NULL,
		Email varchar(100) UNIQUE,
		ForDescription varchar(200),
	Constraint Clients_PK primary key (ID_Client))

/*ALTER ====================================================================================================================================*/

ALTER Table Purchases ADD Constraint FK_Purchases_Shops
	Foreign Key (FK_ID_Shop)
	References Shops(ID_Shop)	

/*alter table Purchases drop constraint FK_FK_Purchases_Shops*/

Alter table Purchases add constraint FK_Purchases_Cards
	Foreign key (FK_ID_Card)
	references Cards(ID_Card)	

/*alter table Purchases drop constraint FK_FK_Purchases_Cards*/

alter table Purchases_Products add constraint FK_Purchases_Products_Purchases
	foreign key (FK_ID_Purchase)
	references Purchases(ID_Purchase)

/*alter table Purchases_Products drop constraint FK_FK_Purchases_Products_Purchases*/

alter table Purchases_Products add constraint FK_Purchases_Products_Products
	foreign key (FK_ID_Product)
	references Products(ID_Product)

/*alter table Purchases_Products drop constraint FK_Purchases_Products_Products*/
	
alter table Products Add constraint FK_Pdoructs_Type_of_product
	foreign key (FK_ID_TypeOfProduct)
	references Type_of_product(ID_TypeOfProduct)
	on delete cascade

/*alter table Products drop constraint FK_Pdoructs_Type_of_product*/


alter table Cards add constraint FK_Cards_Type_of_cards
	foreign key (FK_ID_TypeOfCard)
	references Type_of_cards (ID_TypeOfCard)
	on delete cascade

/*alter table Cards drop constraint FK_Cards_Type_of_cards*/

alter table Cards add constraint FK_Cards_Clients
	foreign key (FK_ID_Client)
	references Clients(ID_Client) ON DELETE CASCADE

/*alter table Cards drop constraint FK_Cards_Clients*/

/* Проверка каскада
insert Clients values (1,'aart', 'afa', '03-03-03', 8981, 'arikul', 'some')
insert Cards values (1, 0, '12-12-21',1,1,'aa')
DELETE FROM Clients Where (ID_Client = 1)*/	


/*Индексы INDEX =======================================================================================================================================*/

create index idx_dataOfPurchase_cost ON Purchases (DataOfPurchase, Cost);

CREATE UNIQUE INDEX idx_cardNumber_dateOfReceiving ON Cards(CardNumber, DateOfReceiving);

-- DROP index idx_dataOfPurchase_cost ON Purchases

-- Drop index idx_cardNumber_dateOfReceiving ON Cards

/*INSERT =======================================================================================================================================*/

/*====================================================================================*/
insert into Type_of_cards (ID_TypeOfCard, QuantityOfDiscount, ForDescription) values
	(
	1,
	1,
	'Стартовый уровень.'
	)
insert into Type_of_cards (ID_TypeOfCard, QuantityOfDiscount) values
	(
	(select Max(ID_TypeOfCard) + 1 from Type_of_cards),
	2
	)
insert into Type_of_cards (ID_TypeOfCard, QuantityOfDiscount) values
	(
	(select Max(ID_TypeOfCard) + 1 from Type_of_cards),
	3
	)
insert into Type_of_cards (ID_TypeOfCard, QuantityOfDiscount) values
	(
	(select Max(ID_TypeOfCard) + 1 from Type_of_cards),
	4
	)
insert into Type_of_cards (ID_TypeOfCard, QuantityOfDiscount) values
	(
	(select Max(ID_TypeOfCard) + 1 from Type_of_cards),
	5
	)
--select * from Type_of_cards
/*====================================================================================*/

/*====================================================================================*/
insert into Clients (ID_Client, FirstName, LastName, Birthday, Phone, Email, ForDescription) values
	(
	1,
	'Артем',
	'Афанасов',
	'1999-01-03',
	'+7(981)748-65-95',
	'artikul396@mail.ru',
	'Создатель'
	)
insert into Clients (ID_Client, FirstName, LastName, Birthday, Phone, Email) values
	(
	(select MAX(ID_Client) + 1 from Clients),
	'Максим',
	'Кузнецов',
	'2000-04-24',
	'+7(981)679-51-26',
	'ololosha@mail.ru'
	)
insert into Clients (ID_Client, FirstName, LastName, Birthday, Phone, Email) values
	(
	(select MAX(ID_Client) + 1 from Clients),
	'Ива',
	'Елсаков',
	'1999-04-22',
	'+7(981)634-83-07',
	'hehehe@mail.ru'
	)
insert into Clients (ID_Client, FirstName, LastName, Birthday, Phone, Email) values
	(
	(select MAX(ID_Client) + 1 from Clients),
	'Ега',
	'Половинкин',
	'1999-06-20',
	'+7(981)347-98-84',
	'gg@mail.ru'
	)
insert into Clients (ID_Client, FirstName, LastName, Birthday, Phone, Email) values
	(
	(select MAX(ID_Client) + 1 from Clients),
	'Евгений',
	'Слободкин',
	'1999-12-31',
	'+7(981)631-75-73',
	'joskiy@mail.ru'
	)
--Select * from Clients
/*====================================================================================*/

/*====================================================================================*/
insert into Cards (ID_Card, CardNumber, AccumulatedPoints, DateOfReceiving, FK_ID_Client, FK_ID_TypeOfCard, ForDescription) values (
	1,
	834,
	10000,
	'07-05-2019',
	1,
	5,
	'Владельца')
/*====================================================================================*/

/*====================================================================================*/
insert into Type_of_product (ID_TypeOfProduct, CoefficientForAddingPoints) values
	(
	1,
	0.85
	)
insert into Type_of_product (ID_TypeOfProduct, CoefficientForAddingPoints) values
	(
	2,
	0.5
	)
insert into Type_of_product (ID_TypeOfProduct, CoefficientForAddingPoints) values
	(
	3,
	0
	)
/*====================================================================================*/

/*======================================Test===========================*/
/*insert into Type_of_product (ID_TypeOfProduct, CoefficientForAddingPoints) values
	(
	4,
	(Select MAX(ID_TypeOfProduct) from Type_of_product) * (Select CoefficientForAddingPoints from Type_of_product where CoefficientForAddingPoints = 0.85)
	)
delete from Type_of_product where (CoefficientForAddingPoints > 2)*/
/*======================================Test==========================================*/

/*======================================Test==========================================*/
insert into Products (ID_Product, ProdactName, CostForUnit, FK_ID_TypeOfProduct) values
	(
	1,
	'Хлеб',
	'30',
	1
	)
insert into Products (ID_Product, ProdactName, CostForUnit, FK_ID_TypeOfProduct) values
	(
	(Select MAX(ID_Product) + 1 from Products),
	'Молоко',
	'50',
	1
	)
insert into Products (ID_Product, ProdactName, CostForUnit, FK_ID_TypeOfProduct) values
	(
	(Select MAX(ID_Product) + 1 from Products),
	'Яйца',
	'60',
	1
	)
insert into Products (ID_Product, ProdactName, CostForUnit, FK_ID_TypeOfProduct) values
	(
	(Select MAX(ID_Product) + 1 from Products),
	'Сигареты',
	'125',
	3
	)
insert into Products (ID_Product, ProdactName, CostForUnit, FK_ID_TypeOfProduct) values
	(
	(Select MAX(ID_Product) + 1 from Products),
	'Моющее средство',
	'90',
	2
	)
insert into Products (ID_Product, ProdactName, CostForUnit, FK_ID_TypeOfProduct) values
	(
	(Select MAX(ID_Product) + 1 from Products),
	'Кастрюля',
	'1500',
	2
	)
insert into Products (ID_Product, ProdactName, CostForUnit, FK_ID_TypeOfProduct) values
	(
	(Select MAX(ID_Product) + 1 from Products),
	'Сковородка',
	'2500',
	2
	)
insert into Products (ID_Product, ProdactName, CostForUnit, FK_ID_TypeOfProduct) values
	(
	(Select MAX(ID_Product) + 1 from Products),
	'Вино',
	'750',
	3
	)
insert into Products (ID_Product, ProdactName, CostForUnit, FK_ID_TypeOfProduct) values
	(
	(Select MAX(ID_Product) + 1 from Products),
	'Мясо',
	'280',
	1
	)
insert into Products (ID_Product, ProdactName, CostForUnit, FK_ID_TypeOfProduct) values
	(
	(Select MAX(ID_Product) + 1 from Products),
	'Вода',
	'50',
	1
	)
--delete from Products where ID_Product >= 1
/*======================================Test==========================================*/

/*======================================Test==========================================*/
insert into Shops (ID_Shop, AddressShop) values
	(
	1,
	'Ботаническая'
	)
insert into Shops (ID_Shop, AddressShop) values
	(
	(Select MAX(ID_Shop) + 1 from Shops),
	'В.О.'
	)
insert into Shops (ID_Shop, AddressShop) values
	(
	(Select MAX(ID_Shop) + 1 from Shops),
	'Пискаревский проспект'
	)
insert into Shops (ID_Shop, AddressShop) values
	(
	(Select MAX(ID_Shop) + 1 from Shops),
	'Невский проспект'
	)
insert into Shops (ID_Shop, AddressShop) values
	(
	(Select MAX(ID_Shop) + 1 from Shops),
	'Садовая'
	)
insert into Shops (ID_Shop, AddressShop) values
	(
	(Select MAX(ID_Shop) + 1 from Shops),
	'Гороховая'
	)
insert into Shops (ID_Shop, AddressShop) values
	(
	(Select MAX(ID_Shop) + 1 from Shops),
	'Ломоносова'
	)
--delete from Shops where ID_Shop >= 1
/*======================================Test==========================================*/

/*======================================Test==========================================*/
insert into Purchases (ID_Purchase, DataOfPurchase, NumberOfCashbox, isDone, Cost, FK_ID_Card, FK_ID_Shop, ForDescription) values
			(1, '2019-06-01', 'init', 1, 1, 1, 1, 'Инициализация')		
/*======================================Test==========================================*/

/*======================================Test==========================================*/
insert into Purchases_Products(ID_Current, FK_ID_Purchase, FK_ID_Product, AmountOfProduct, ForDescription) values
	(
	1,
	1,
	1,
	1,
	'init'
	)
/*======================================Test==========================================*/

/*Удаление строки 
INSERT Purchases VALUES (2, '12-12-12' , 5, 1,1,'asd')
DELETE FROM Purchases Where (Cost = 5) AND (Cost = 5)*/

/*Проверка CHECK (Cost > 0)
INSERT Purchases VALUES (2, '12-12-12' , -5, 1,1,'asd')*/

/*DROP =======================================================================================================================================*/

drop table Purchases_Products 
drop table Purchases
drop table Shops
drop table Cards
drop table Type_of_cards
drop table Products
drop table Type_of_product
drop table Clients