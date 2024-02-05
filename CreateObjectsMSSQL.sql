--Views
--1.1) ����� ���� �������� ������������, ���� � �������;
create or alter view VW_Places
as
select [Square], Price, DateOfDefinition, DateOfApplication,Adress, Postindex, t.Title,FormatTitle
from EstateObject e
join Postindex p on e.IDPostIndex=p.IDPostindex
join TypeOfActivity t on t.IDTypeOfActivity=e.IDTypeOfActivity
join [Format] f on e.IDFormat = f.IDFormat
where e.IDTypeOfActivity=1
go
select * from VW_Places
go

--2.2) ����� ���� �������� ������������, ���� � ���, � ��������� �������;

create or alter view VW_Build
as
select [Square], Price, DateOfDefinition, DateOfApplication,Adress, Postindex, t.Title,FormatTitle
from EstateObject e
join Postindex p on e.IDPostIndex=p.IDPostindex
join TypeOfActivity t on t.IDTypeOfActivity=e.IDTypeOfActivity
join [Format] f on e.IDFormat = f.IDFormat
where e.IDTypeOfActivity=2
go
select * from VW_Build
go

--2.3) ����� ���� �������� ������������, ���� � ��������, � ��������� ����;

create or alter view VW_Flat
as
select [Square], Price, DateOfDefinition, DateOfApplication,Adress, Postindex, t.Title,FormatTitle
from EstateObject e
join Postindex p on e.IDPostIndex=p.IDPostindex
join TypeOfActivity t on t.IDTypeOfActivity=e.IDTypeOfActivity
join [Format] f on e.IDFormat = f.IDFormat
where e.IDTypeOfActivity=3
go
select * from VW_Flat
go

--Procedure

--2.1) ���������/��������� ���� �����, ����������� �� 1� ����� �������;
create or alter proc PR_AddCommonCost
@IDPlace int,
@Cost decimal(14,2)
as
begin
declare @i int
set @i = 0
	if((select IDTypeOfActivity from EstateObject where IDEstateObject=@IDPlace )=1)
		begin
			declare @IDPlaceEstate int
			declare @IDBuildEstate int
			declare ObjectCurs cursor for
			select er.IDPlaceEstate, er.IDBuildingEstate
			from EstateObject eo
			join EstateRelation er on eo.IDEstateObject = er.IDPlaceEstate
			where eo.IDTypeOfActivity=1 and er.IDPlaceEstate=@IDPlace
			order by er.IDPlaceEstate

			open ObjectCurs

			FETCH NEXT FROM ObjectCurs INTO @IDPlaceEstate, @IDBuildEstate

			WHILE @@FETCH_STATUS = 0
				Begin
					update EstateObject
					set Price = Price+@Cost
					where IDEstateObject=@IDBuildEstate
					FETCH NEXT FROM ObjectCurs INTO @IDPlaceEstate, @IDBuildEstate
				end
			close ObjectCurs
			DEALLOCATE ObjectCurs 
		end
	else
		begin
			print('������ ������ ������������ �� �������� ��������')
		end
end
go

exec PR_AddCommonCost 1,-100
go


--2.2) ���������/��������� ���� �������, ����������� � 1� ����� ����;
create or alter proc PR_AddCommonFlatCost
@IDBuild int,
@Cost decimal(14,2)
as
begin
declare @i int
set @i = 0
	if((select IDTypeOfActivity from EstateObject where IDEstateObject=@IDBuild )=2)
		begin
			declare @IDFlatEstate int
			declare @IDBuildEstate int
			declare ObjectCurs cursor for
			select f.IDBuildEstate, f.IDFlatEstate
			from EstateObject eo
			join FlatRelation f on eo.IDEstateObject = f.IDBuildEstate
			where eo.IDTypeOfActivity=2 --and f.IDBuildEstate=@IDBuild
			order by f.IDBuildEstate

			open ObjectCurs

			FETCH NEXT FROM ObjectCurs INTO @IDBuildEstate, @IDFlatEstate

			WHILE @@FETCH_STATUS = 0
				Begin
					update EstateObject
					set Price = Price+@Cost
					where IDEstateObject=@IDFlatEstate
					FETCH NEXT FROM ObjectCurs INTO @IDBuildEstate, @IDFlatEstate
				end
			close ObjectCurs
			DEALLOCATE ObjectCurs 
		end
	else
		begin
			print('������ ������ ������������ �� �������� ���������')
		end
end
go

exec PR_AddCommonFlatCost 4,100
go
--Functions

--3.1) ��������� ������ ���� ������� � ������������ �������� ����/�������;
create or alter function FN_AllFlats(@IDEstate int)
returns table
as
return(
	select * from EstateObject
	join -----------------------------------��������
	where IDTypeOfActivity=3
	)