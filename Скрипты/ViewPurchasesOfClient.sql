-- ��� ������� �������------------------------------------------------------------------------------------------------------------------------
create view PurchasesOfClient (FirstName, LastName, DataOfPurchase, Cost, FK_ID_Shop)
	as select FirstName, LastName, DataOfPurchase, Cost, FK_ID_Shop
		from Clients 
			join Cards on Cards.FK_ID_Client = Clients.ID_Client
			join Purchases on Purchases.FK_ID_Card = Cards.ID_Card
				where FirstName = '�����' and LastName = '��������'

select * from PurchasesOfClient

drop view PurchasesOfClient
------------------------------------------------------------------------------------------------------------------------