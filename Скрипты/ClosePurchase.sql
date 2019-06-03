-- Чтобы иметь возможность достать только готовые покупки.
create procedure ClosePurchase
	@ID_Purchase as int,
	@ForDescription as varchar(200)

	as
	begin
		update Purchases set isDone = 1 
			where ID_Purchase = @ID_Purchase

		update Purchases set ForDescription = @ForDescription
			where ID_Purchase = @ID_Purchase
	end;

drop procedure ClosePurchase;	

--=========================================================================================================================
execute ClosePurchase @ID_Purchase = 1, @ForDescription = 'Первое закрытие покупки в этой БД.'