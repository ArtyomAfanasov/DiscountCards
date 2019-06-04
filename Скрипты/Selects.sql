-- ���������� ������ II ������.
select Email from Clients, Cards 
	where Clients.ID_Client = Cards.FK_ID_Client 

-- �����, ������������ � �.
select FirstName from Clients 
	where SUBSTRING(FirstName, 1, 1) = '�' 

-- union. ������ ��������� ��, � ������� ����� �������� �����������.
select LastName, Phone from Clients, Cards 
	where Clients.ID_Client = Cards.FK_ID_Client  
union
select FirstName, ForDescription from Clients 
	where SUBSTRING(FirstName, 1, 1) = '�' or ForDescription = null

-- outer. ��� ������ ���� �� ���� �������� � ���������� �� ����, ��� �� ��� ����������� �������.
select CardNumber, ID_Purchase from Cards 
	left join Purchases on Purchases.FK_ID_Card = Cards.ID_Card	

-- ����� ����� ���� ������� �� ���� ������.
select Sum(Cost) from Purchases 
	join (select ID_Card from Cards where ID_Card = 1 or ID_Card = 2) as TwoCard 
		on TwoCard.ID_Card = Purchases.FK_ID_Card 
select Cost from Purchases  -- ��� ��������.
	join (select ID_Card from Cards where ID_Card = 1 or ID_Card = 2) as TwoCard 
		on TwoCard.ID_Card = Purchases.FK_ID_Card 

-- ���������� ������� � �������� 7 � �������� ������ 200 ������� ������.
select Count(ID_Purchase) from Purchases 
	where FK_ID_Shop = 7 And Cost > 200
select ID_Purchase from Purchases 
	where FK_ID_Shop = 7 And Cost > 200

-- ��� ��������, ���������� ������������ ����� � ��������. ������� :)
--================================================================================================================
create view ToMaxCost as
	select ID_Card, Sum(Cost) as MoneyForCard from Purchases 
			join Cards on Cards.ID_Card = Purchases.FK_ID_Card
				group by ID_Card
drop view ToMaxCost


select FirstName, LastName from Clients
	join Cards on Clients.ID_Client = Cards.FK_ID_Client 
		where Cards.ID_Card = (select ID_Card from ToMaxCost 
									where MoneyForCard = (select Max(MoneyForCard) from ToMaxCost))


		select ID_Card from ToMaxCost 
			where MoneyForCard = (select Max(MoneyForCard) from ToMaxCost)
	
		-- �������
		select ID_Card, Sum(Cost) as MoneyForCard from Purchases 
			join Cards on Cards.ID_Card = Purchases.FK_ID_Card
				group by ID_Card

		-- ���� ������
		Execute AddPurchase @DataOfPurchase='2019-06-04',@FK_ID_Card=9,@FK_ID_Shop=6,@NumberOfCashbox='First', @ForDescription=null
		execute AddKindOfProductTo_Purchases_Products @ID_Shop=6, @Cashbox='First', @FK_ID_Product=1, @AmountOfProduct=10000, @ForDescription=null
-- �������.
--================================================================================================================

-- Not in. ID_Card, ������� ������ � �������, � ������� ������ 10000 ������.
select ID_Card from Cards 
	where ID_Card in (select FK_ID_Card from Purchases 
							where Cost > 10000)
			
			-- �������
			select FK_ID_Card, Cost from Purchases 
							where Cost > 10000		

		-- select �� ���� ������ ����������� �������.
		select FK_ID_Card from Purchases
			group by FK_ID_Card

-- exist. ���������� �� ������� �� ����� ������� � ������� 14161. ������� ��� �������. + � ������� �����������! :)
			EXECUTE AddNewCard @DataOfReceiving='2019-06-04',@CardNumber='14161', @ForDescription=null,@FirstName='����', @LastName='����������',@Phone='881212878638',@Email='new9m2e@mail.ru'

			select ID_Card from Cards where CardNumber = 14161	

select FirstName, LastName from Clients
	join Cards on Clients.ID_Client = Cards.FK_ID_Client
	left join Purchases on Cards.ID_Card = Purchases.FK_ID_Card
		where Cards.CardNumber = 14161 and not exists (select FK_ID_Card from Purchases
							where Purchases.FK_ID_Card = (select ID_Card from Cards where CardNumber = 14161))
	
			select ID_Shop from Shops
				where not exists (select * from Shops where ID_Shop >7) and ID_Shop = 5

-- ����� ������ ���� ������������. ���������� �� ������� �������.			
select ForDescription, '� ��������' as ThisComment from Shops where (ForDescription is not null) and ForDescription <> ''
union
select ForDescription, '� Purchases' as ThisComment from Purchases where (ForDescription is not null) and ForDescription <> ''
union
select ForDescription, '� Purchases_Products' as ThisComment from Purchases_Products where (ForDescription is not null) and ForDescription <> ''
union
select ForDescription, '� Products' as ThisComment from Products where (ForDescription is not null) and ForDescription <> ''
union
select ForDescription, '� Type_of_product' as ThisComment from Type_of_product where (ForDescription is not null) and ForDescription <> ''
union
select ForDescription, '� Cards' as ThisComment from Cards where (ForDescription is not null) and ForDescription <> ''
union
select ForDescription, '� Type_of_cards' as ThisComment from Type_of_cards where (ForDescription is not null) and ForDescription <> ''
union
select ForDescription, '� Clients' from Clients where (ForDescription is not null) and ForDescription <> ''
order by 2

-- ����� ���� ��������� � ������� ��� ������� 2.
select ID_TypeOfProduct from Type_of_product 
	join Products on Type_of_product.ID_TypeOfProduct = Products.FK_ID_TypeOfProduct
	join Purchases_Products on Products.ID_Product = Purchases_Products.FK_ID_Product
		where Purchases_Products.FK_ID_Purchase = 2
			group by ID_TypeOfProduct
		
		-- ��������, ��� ��������.
		select ID_TypeOfProduct from Type_of_product 
			join Products on Type_of_product.ID_TypeOfProduct = Products.FK_ID_TypeOfProduct
			join Purchases_Products on Products.ID_Product = Purchases_Products.FK_ID_Product
				where Purchases_Products.FK_ID_Purchase = 10
					group by ID_TypeOfProduct

-- � ������ �������� �� ���������� ���-�� ���� � ������� ������ 2.
select Count(FK_ID_TypeOfCard) as '���������� ���� ���� ������ 2 � �������� �� ����������' from 	
	(select AddressShop, FK_ID_TypeOfCard from Shops
		join Purchases on Shops.ID_Shop = Purchases.FK_ID_Shop
		join Cards on Purchases.FK_ID_Card = Cards.ID_Card
			where Cards.FK_ID_TypeOfCard > 2 and Shops.AddressShop = '����������') as TypesCards	