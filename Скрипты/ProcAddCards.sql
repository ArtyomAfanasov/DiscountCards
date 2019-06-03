/*-----------------------------------------------------------------------------------------------------------------------------------------------------
-- ���������� ������ �������
-----------------------------------------------------------------------------------------------------------------------------------------------------*/

CREATE PROCEDURE AddNewCard
@DataOfReceiving AS date,
@CardNumber AS integer,
@ForDescription varchar(150),

@FirstName varchar(50),
@LastName varchar (50),	
@Phone varchar(20),
@Email varchar(50)

AS

BEGIN

DECLARE @ID_Card INTEGER
declare @ID_Client integer

SELECT @ID_Card = MAX(ID_Card) + 1 FROM Cards
SELECT @ID_Client = MAX(ID_Client) + 1 FROM Clients

INSERt into Clients (ID_Client, FirstName, LastName, Phone, Email)
	values (@ID_Client, @FirstName, @LastName, @Phone, @Email)
INSERT INTO Cards (ID_Card, CardNumber, AccumulatedPoints, DateOfReceiving, FK_ID_Client, FK_ID_TypeOfCard, ForDescription)
	VALUES(@ID_Card, @CardNumber, 0, @DataOfReceiving, @ID_Client, 1, @ForDescription);

END;
	
-- drop
--DELETE FROM Cards Where (ID_Card = 2)
--DELETE FROM Clients Where (ID_Client = 6)

-- ������ ������ ���������: -- 
EXECUTE AddNewCard @DataOfReceiving='2019-05-02',@CardNumber='2314', @ForDescription='����������', @FirstName='������', @LastName='�����',@Phone='88005553535',@Email='some'
EXECUTE AddNewCard @DataOfReceiving='2019-05-02',@CardNumber='151', @ForDescription='����������', @FirstName='����', @LastName='������',@Phone='88128301238',@Email='newsome'
EXECUTE AddNewCard @DataOfReceiving='2019-05-03',@CardNumber='124', @ForDescription='����������', @FirstName='����', @LastName='�������',@Phone='8800533535',@Email='some@mail.ru'
EXECUTE AddNewCard @DataOfReceiving='2019-05-04',@CardNumber='111', @ForDescription='����������', @FirstName='����', @LastName='�����',@Phone='8812325238',@Email='newsome@mail.ru'
EXECUTE AddNewCard @DataOfReceiving='2019-05-05',@CardNumber='1544', @ForDescription='����������', @FirstName='����', @LastName='���������',@Phone='896153535',@Email='someae@mail.ru'
EXECUTE AddNewCard @DataOfReceiving='2019-05-06',@CardNumber='1241', @ForDescription='����������', @FirstName='��������', @LastName='����������',@Phone='881345301238',@Email='newsoame@mail.ru'
EXECUTE AddNewCard @DataOfReceiving='2019-05-07',@CardNumber='22454', @ForDescription='����������', @FirstName='�����', @LastName='����',@Phone='8800536535',@Email='someas@mail.ru'
EXECUTE AddNewCard @DataOfReceiving='2019-05-08',@CardNumber='162', @ForDescription='����������', @FirstName='����', @LastName='������',@Phone='8812834638',@Email='newsogme@mail.ru'
EXECUTE AddNewCard @DataOfReceiving='2019-05-08',@CardNumber='11252', @ForDescription=null,@FirstName='����', @LastName='���Description',@Phone='881212834638',@Email='newsogm2e@mail.ru'
-- �������
DROP PROCEDURE AddNewCard