-- Все типы карт во всех магазинах
create view TypeOfCardsFromAllShops as
	select ID_Shop, ID_TypeOfCard from Shops
		join Purchases on Shops.ID_Shop = Purchases.FK_ID_Shop
		join Cards on Purchases.FK_ID_Card = Cards.ID_Card
		join Type_of_cards on Cards.FK_ID_TypeOfCard = Type_of_cards.ID_TypeOfCard			

-- Что есть View.
select * from TypeOfCardsFromAllShops	

-- Разные карт в каждом магазине. Having - фильтрация групп.
select * from TypeOfCardsFromAllShops
	group by ID_Shop, ID_TypeOfCard
		having ID_TypeOfCard >=3
	
drop view TypeOfCardsFromAllShops