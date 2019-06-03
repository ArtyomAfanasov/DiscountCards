-- Триггер добавляет баллы на карту и стоимость в чек.
CREATE TRIGGER Tr_AddProductToPurchase ON Purchases_Products for INSERT

AS

BEGIN	
	declare @priceForProducts int; 
	declare @amountOfPoints int; 
	declare @currentPoints int; 
	declare @cost int; 
	declare @ID_CardFromPurchase int;
	
	declare @FK_ID_Product int; 
	declare @AmountOfProduct int; 
	declare @FK_ID_Purchase int
		
	select @FK_ID_Product = FK_ID_Product from inserted
	select @AmountOfProduct = AmountOfProduct from inserted
	select @FK_ID_Purchase = FK_ID_Purchase from inserted
			
	-- цена за товары одного типа.
	set @priceForProducts = (select CostForUnit from Products 
		where Products.ID_Product = @FK_ID_Product ) * @AmountOfProduct

	-- коэффициент, на который умножать
	set @amountOfPoints = (select CoefficientForAddingPoints from Products 
			join Type_of_product on Products.FK_ID_TypeOfProduct = Type_of_product.ID_TypeOfProduct
				where Products.ID_Product = @FK_ID_Product ) * @priceForProducts

	select @ID_CardFromPurchase = FK_ID_Card from Purchases 
		where Purchases.ID_Purchase = @FK_ID_Purchase		 

	--select @ID_CardFromPurchase = ID_Card from Purchases join Cards
	--	on Purchases.FK_ID_Card = Cards.ID_Card 
	--		where Purchases.ID_Purchase = @FK_ID_Purchase

	select @currentPoints = AccumulatedPoints from Cards  
		where ID_Card = @ID_CardFromPurchase		
		
	select @cost = Cost from Purchases 
		where Purchases.ID_Purchase = @FK_ID_Purchase

	update Purchases set Cost = @cost + @priceForProducts
		where Purchases.ID_Purchase = @FK_ID_Purchase

	update Cards set AccumulatedPoints = @currentPoints + @amountOfPoints 
		where Cards.ID_Card = @ID_CardFromPurchase
	
END;

--drop trigger Tr_AddProductToPurchase

-- Пример: Рабочий! :)-----------------------------------------------------------------------------------------------------------------
Execute AddPurchase @DataOfPurchase='2019-06-01',@FK_ID_Card=5,@FK_ID_Shop=5,@NumberOfCashbox='First', @ForDescription=null
execute AddKindOfProductTo_Purchases_Products @ID_Shop=5, @Cashbox='First', @FK_ID_Product=1, @AmountOfProduct=5, @ForDescription=null
select Cost from Purchases where NumberOfCashbox = 'First' and FK_ID_Shop = 5
select AccumulatedPoints from Cards where
	Cards.ID_Card = (select FK_ID_Card from Purchases where NumberOfCashbox = 'First' and FK_ID_Shop = 5)

execute AddKindOfProductTo_Purchases_Products @ID_Shop=1, @Cashbox='First', @FK_ID_Product=1, @AmountOfProduct=5, @ForDescription=null
select Cost from Purchases where NumberOfCashbox = 'First' and FK_ID_Shop = 1
select AccumulatedPoints from Cards where
	Cards.ID_Card = (select FK_ID_Card from Purchases where NumberOfCashbox = 'First' and FK_ID_Shop = 1)
-- Пример /\-----------------------------------------------------------------------------------------------------------------

---------------------------------Вложенный select----------------------------------------------------------------
select CoefficientForAddingPoints * ((select CostForUnit * 5 from Products 
	where Products.ID_Product = 1 )) as Coef from Products 
		join Type_of_product on Products.FK_ID_TypeOfProduct = Type_of_product.ID_TypeOfProduct
			where ID_Product = 1
-----------------------------------------------------------------------------------------------------------------

------------------------------------------------------Отладка:

-- test:
select FK_ID_Card from Purchases where NumberOfCashbox = 'First' and FK_ID_Shop = 1
select ID_CardFromPurchase = FK_ID_Card from Purchases 
	where Purchases.ID_Purchase = 2

select currentPoints = AccumulatedPoints from Cards 
	where ID_Card = 1



select amountOfPoints = CoefficientForAddingPoints from Products 
			join Type_of_product on Products.FK_ID_TypeOfProduct = Type_of_product.ID_TypeOfProduct
				where ID_Product = 1



select CostForUnit * 5 from Products 
	where Products.ID_Product = 1 

-- коэффициент, на который умножать
select CoefficientForAddingPoints from Products 
		join Type_of_product on Products.FK_ID_TypeOfProduct = Type_of_product.ID_TypeOfProduct
			where ID_Product = 1

update Cards set AccumulatedPoints = (select AccumulatedPoints from Cards where
	Cards.ID_Card = (select FK_ID_Card from Purchases where NumberOfCashbox = 'First' and FK_ID_Shop = 1)) + 
			(select CoefficientForAddingPoints * ((select CostForUnit * 5 from Products 
				where Products.ID_Product = 1 )) from Products 
					join Type_of_product on Products.FK_ID_TypeOfProduct = Type_of_product.ID_TypeOfProduct
						where ID_Product = 1)
	where Cards.ID_Card = 1

select AccumulatedPoints from Cards where
	Cards.ID_Card = (select FK_ID_Card from Purchases where NumberOfCashbox = 'First' and FK_ID_Shop = 1)

-----

select ID_CardFromPurchase = FK_ID_Card from Purchases 
		where Purchases.ID_Purchase = 1

select FK_ID_Card from Purchases 
	where Purchases.ID_Purchase = 2

	--- full test ---

--set @priceForProducts = (select CostForUnit from Products 
--	where Products.ID_Product = 1) * 5

-- коэффициент, на который умножать
--select CoefficientForAddingPoints from Products 
--		join Type_of_product on Products.FK_ID_TypeOfProduct = Type_of_product.ID_TypeOfProduct
--			where ID_Product = 1
--set @amountOfPoints = (select CoefficientForAddingPoints from Products 
--		join Type_of_product on Products.FK_ID_TypeOfProduct = Type_of_product.ID_TypeOfProduct
--			where ID_Product = 1) * (select CostForUnit from Products 
--	where Products.ID_Product = 1) * 5

--select FK_ID_Card from Purchases 
--	where Purchases.ID_Purchase = 2		 ---

--select @ID_CardFromPurchase = ID_Card from Purchases join Cards
--	on Purchases.FK_ID_Card = Cards.ID_Card 
--		where Purchases.ID_Purchase = @FK_ID_Purchase

--select AccumulatedPoints from Cards  --- 
--	where ID_Card = (select FK_ID_Card from Purchases 
--	where Purchases.ID_Purchase = 2)			  ---

select @cost = Cost from Purchases 
	where Purchases.ID_Purchase = @FK_ID_Purchase

update Cards set AccumulatedPoints = (select AccumulatedPoints from Cards
	where ID_Card = (select FK_ID_Card from Purchases 
	where Purchases.ID_Purchase = 2)) + (select CoefficientForAddingPoints from Products 
		join Type_of_product on Products.FK_ID_TypeOfProduct = Type_of_product.ID_TypeOfProduct
			where ID_Product = 1) * (select CostForUnit from Products 
	where Products.ID_Product = 1) * 5
	where Cards.ID_Card = (select FK_ID_Card from Purchases 
	where Purchases.ID_Purchase = 2)
	
select AccumulatedPoints from Cards where
	Cards.ID_Card = (select FK_ID_Card from Purchases where NumberOfCashbox = 'First' and FK_ID_Shop = 1)

update Purchases set Cost = @cost + (select CostForUnit from Products 
	where Products.ID_Product = 1) * 5
	where Purchases.ID_Purchase = @FK_ID_Purchase