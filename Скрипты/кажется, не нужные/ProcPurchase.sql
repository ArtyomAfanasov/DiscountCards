Create procedure AddKindOfProductTo_Purchases_Products
	@Cashbox as varchar(100),
	@FK_ID_Product as int,
	@AmountOfProduct as int,
	@ForDescription as varchar(200)		
	
	as

	begin		
		Declare @ID_Current int
		Declare @FK_ID_Purchase int 		
		
		select @ID_Current = MAX(ID_Current) + 1 from Purchases_Products
		select @FK_ID_Purchase = ID_purchase from Purchases where (ForDescription = @Cashbox)
		
		insert into Purchases_Products (ID_Current, FK_ID_Purchase, FK_ID_Product, AmountOfProduct, ForDescription) values
			(@ID_Current, @FK_ID_Purchase, @FK_ID_Product, @AmountOfProduct, @ForDescription)
	end	

drop procedure AddKindOfProductInPurchase