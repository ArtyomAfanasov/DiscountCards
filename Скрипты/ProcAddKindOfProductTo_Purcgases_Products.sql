-- Добавить продукт и количество в корзину.
Create procedure AddKindOfProductTo_Purchases_Products
	@ID_Shop as int,
	@Cashbox as varchar(100),
	@FK_ID_Product as int,
	@AmountOfProduct as int,
	@ForDescription as varchar(200)		
	
	as

	begin		
		Declare @ID_Current int
		Declare @FK_ID_Purchase int 		
		
		select @ID_Current = MAX(ID_Current) + 1 from Purchases_Products
		select @FK_ID_Purchase = ID_purchase from Purchases where (NumberOfCashbox = @Cashbox) and (isDone = 0) and (FK_ID_Shop = @ID_Shop)
		
		insert into Purchases_Products (ID_Current, FK_ID_Purchase, FK_ID_Product, AmountOfProduct, ForDescription) values
			(@ID_Current, @FK_ID_Purchase, @FK_ID_Product, @AmountOfProduct, @ForDescription)
	end	

--drop procedure AddKindOfProductTo_Purchases_Products

execute AddKindOfProductTo_Purchases_Products @ID_Shop=1, @Cashbox='First', @FK_ID_Product=1, @AmountOfProduct=5, @ForDescription=null
execute AddKindOfProductTo_Purchases_Products @ID_Shop=1, @Cashbox='First', @FK_ID_Product=2, @AmountOfProduct=5, @ForDescription=null
execute AddKindOfProductTo_Purchases_Products @ID_Shop=1, @Cashbox='First', @FK_ID_Product=3, @AmountOfProduct=5, @ForDescription=null
execute AddKindOfProductTo_Purchases_Products @ID_Shop=1, @Cashbox='First', @FK_ID_Product=4, @AmountOfProduct=5, @ForDescription=null
execute AddKindOfProductTo_Purchases_Products @ID_Shop=1, @Cashbox='First', @FK_ID_Product=1, @AmountOfProduct=5, @ForDescription=null