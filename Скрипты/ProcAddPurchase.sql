create procedure AddPurchase 	
	@DataOfPurchase as date,
	@FK_ID_Card as int,
	@FK_ID_Shop as int,
	@NumberOfCashbox as varchar(75),
	@ForDescription as varchar(100)
	
	as
	 
	begin
		Declare @ID_Purchase int
		select @ID_Purchase = MAX(ID_Purchase) + 1 from Purchases

		insert into Purchases (ID_Purchase, DataOfPurchase, Cost, FK_ID_Card, FK_ID_Shop, NumberOfCashbox, isDone, ForDescription) values
			(@ID_Purchase, @DataOfPurchase, 0, @FK_ID_Card, @FK_ID_Shop, @NumberOfCashbox, 0, @ForDescription)			
	end

--drop procedure AddPurchase

Execute AddPurchase @DataOfPurchase='2019-06-01',@FK_ID_Card=1,@FK_ID_Shop=1,@NumberOfCashbox='First', @ForDescription=null
Execute AddPurchase @DataOfPurchase='2019-06-01',@FK_ID_Card=5,@FK_ID_Shop=2,@NumberOfCashbox='First', @ForDescription=null
Execute AddPurchase @DataOfPurchase='2019-06-01',@FK_ID_Card=3,@FK_ID_Shop=2,@NumberOfCashbox='Second', @ForDescription=null
Execute AddPurchase @DataOfPurchase='2019-06-01',@FK_ID_Card=4,@FK_ID_Shop=2,@NumberOfCashbox='First', @ForDescription=null
Execute AddPurchase @DataOfPurchase='2019-06-01',@FK_ID_Card=2,@FK_ID_Shop=1,@NumberOfCashbox='Second', @ForDescription=null
--delete from Purchases where ID_Purchase >= 7