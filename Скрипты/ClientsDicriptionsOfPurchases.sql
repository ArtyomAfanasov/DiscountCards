-- View для описания покупок конкретного клиента.
Execute AddPurchase @DataOfPurchase='2019-06-01',@FK_ID_Card=9,@FK_ID_Shop=1,@NumberOfCashbox='First', @ForDescription=null
Execute AddPurchase @DataOfPurchase='2019-06-01',@FK_ID_Card=9,@FK_ID_Shop=1,@NumberOfCashbox='First', @ForDescription='Она уже второй раз покупает!'

create view ClientsDicriptionsOfPurchases (FirstName, LastName, DataOfPurchase, Cost, FK_ID_Shop, ForDescription)
	as select FirstName, LastName, DataOfPurchase, Cost, FK_ID_Shop, Purchases.ForDescription
		from Purchases 
			left outer join Cards on Cards.FK_ID_Client = Purchases.FK_ID_Card
			join Clients on Cards.FK_ID_Client = Clients.ID_Client			
				where FirstName = 'Женя'

select * from ClientsDicriptionsOfPurchases

drop view ClientsDicriptionsOfPurchases