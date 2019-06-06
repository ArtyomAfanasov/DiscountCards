-- View для описания покупок конкретного клиента.
--Execute AddPurchase @DataOfPurchase='2019-06-01',@FK_ID_Card=9,@FK_ID_Shop=1,@NumberOfCashbox='First', @ForDescription=null
--Execute AddPurchase @DataOfPurchase='2019-06-01',@FK_ID_Card=9,@FK_ID_Shop=1,@NumberOfCashbox='First', @ForDescription='Она уже второй раз покупает!'

-- Все покупки всех клиентов.
create view AllClientsAllPurchases (FirstName, LastName, DataOfPurchase, Cost, FK_ID_Shop)
	as select FirstName, LastName, DataOfPurchase, Cost, FK_ID_Shop
		from Clients 
			join Cards on Clients.ID_Client = Cards.FK_ID_Client
			join Purchases on Cards.ID_Card = Purchases.FK_ID_Card
		
		/*from Purchases 
			left outer join Cards on Cards.ID_Card = Purchases.FK_ID_Card
			join Clients on Clients.ID_Client = Cards.FK_ID_Client 		
				where Purchases.ForDescription is null*/

select * from AllClientsAllPurchases

drop view AllClientsAllPurchases