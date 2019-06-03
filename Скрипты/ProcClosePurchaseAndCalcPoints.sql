-- Чтобы иметь возможность достать только готовые покупки. Выставить флажок, что покупка завершена
create procedure ClosePurchaseAndCalcPoints
	@ID_Purchase as int,
	@ForDescription as varchar(200)

	as
	begin
		declare @ID_Card int;
		declare @TypeOfCard int;
		declare @points int;

		update Purchases set isDone = 1 
			where ID_Purchase = @ID_Purchase

		update Purchases set ForDescription = @ForDescription
			where ID_Purchase = @ID_Purchase


		select @ID_Card = FK_ID_Card from Purchases where ID_Purchase = @ID_Purchase

		select @TypeOfCard = FK_ID_TypeOfCard from Cards 
			where ID_Card = @ID_Card

		select @points = AccumulatedPoints from Cards
			where ID_Card = @ID_Card		

		if @TypeOfCard >= 5 return
		
		if (@points > 10000 and @TypeOfCard < 5)
			begin 
				update Cards set FK_ID_TypeOfCard = 5 where ID_Card = @ID_Card;
				return;
			end;
		if @points > 5000 -- Переход c 3 на 4ый уровень.
			begin
				update Cards set FK_ID_TypeOfCard = 4 where ID_Card = @ID_Card;
				return;
			end;
		if @points > 2500 -- Переход c 2 на 3 уровень.
			begin
				update Cards set FK_ID_TypeOfCard = 3 where ID_Card = @ID_Card;
				return;
			end;		
		if @points > 1000 -- Переход c 1 на 2 уровень.
			begin
				update Cards set FK_ID_TypeOfCard = 2 where ID_Card = @ID_Card;
				return;
			end;
	end;

drop procedure ClosePurchaseAndCalcPoints;	

--=========================================================================================================================
execute ClosePurchaseAndCalcPoints @ID_Purchase = 15, @ForDescription = 'Первое закрытие покупки в этой БД.'

--=========================================================================================================================
-- Можно открывать покупку. Закладывать в коризну. Закрывать покупку. Считать баллы. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Execute AddPurchase @DataOfPurchase='2019-06-01',@FK_ID_Card=3,@FK_ID_Shop=7,@NumberOfCashbox='second', @ForDescription=null

update Cards set AccumulatedPoints = 0 where ID_Card  = 3
update Cards set FK_ID_TypeOfCard = 1 where ID_Card  = 3

execute AddKindOfProductTo_Purchases_Products @ID_Shop=7, @Cashbox='second', @FK_ID_Product=1, @AmountOfProduct=20, @ForDescription=null
select AccumulatedPoints from Cards where
	Cards.ID_Card = (select FK_ID_Card from Purchases where NumberOfCashbox = 'second' and FK_ID_Shop = 7 and isDone = 0)
select FK_ID_TypeOfCard from Cards
	where ID_Card = 3

-- Проверить после закрытия:
select FK_ID_TypeOfCard from Cards
	where ID_Card = 3
select AccumulatedPoints from Cards where
	Cards.ID_Card = 3
