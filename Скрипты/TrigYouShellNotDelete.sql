create trigger YouShellNotDeleteMyShops on Shops for delete
as
	rollback;

--drop trigger YouShellNotDeleteMyShop

delete from Shops 
	where ID_Shop = 7