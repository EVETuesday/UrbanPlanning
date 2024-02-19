use master
BACKUP DATABASE [UrbanPlanning] TO  DISK = N'C:\SQLBacks\UrbanPlanning.bak' WITH NOFORMAT, NOINIT,  NAME = N'UrbanPlanning-Полная База данных Резервное копирование', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
use UrbanPlanning
go

--Views
--1.1) Вывод всех объектов недвижимости, типа – участок со всеми домами на нём;
create or alter view VW_Places
as
select e.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress, Postindex, t.Title,FormatTitle, 
STRING_AGG(e.Number,', ') as 'Builds'
from EstateObject e
join Postindex p on e.IDPostIndex=p.IDPostindex
join TypeOfActivity t on t.IDTypeOfActivity=e.IDTypeOfActivity
join [Format] f on e.IDFormat = f.IDFormat
join EstateRelation er on e.IDEstateObject=er.IDPlaceEstate
where e.IDTypeOfActivity=1
group by e.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress, Postindex, t.Title,FormatTitle
go
select * from VW_Places
go

--2.2) Вывод всех объектов недвижимости, типа – дом, со всеми квартирами в нём

create or alter view VW_Build
as
select [Square], Price, DateOfDefinition, DateOfApplication, Number,Adress, Postindex, t.Title,FormatTitle, 
STRING_AGG(fr.IDFlatEstate,', ') as 'Flats'
from EstateObject e
join Postindex p on e.IDPostIndex=p.IDPostindex
join TypeOfActivity t on t.IDTypeOfActivity=e.IDTypeOfActivity
join [Format] f on e.IDFormat = f.IDFormat
join FlatRelation fr on e.IDEstateObject=fr.IDBuildEstate
where e.IDTypeOfActivity=2
group by e.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress, Postindex, t.Title,FormatTitle
go
select * from VW_Build
go

--2.3) Вывод всех объектов недвижимости, типа – квартира;

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

--2.1) Повышение/Понижение цены домов, находящихся на 1м общем участке;
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
			print('Данный объект недвижимости не является участком')
		end
end
go

exec PR_AddCommonCost 1,-100
go

select * from EstateObject eo join EstateRelation er on eo.IDEstateObject=er.IDBuildingEstate where er.IDPlaceEstate=1
go


--2.2) Повышение/Понижение цены квартир, находящихся в 1м общем доме;
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
			print('Данный объект недвижимости не является строением')
		end
end
go

exec PR_AddCommonFlatCost 4,100
go

select eo.* from EstateObject eo join FlatRelation fl on eo.IDEstateObject=fl.IDFlatEstate where fl.IDBuildEstate=4
go
--Functions

--3.1) Получение списка всех квартир с возможностью указания дома;
create or alter function FN_AllFlats(@IDEstateObject int)
returns table
as
		return(
		select eo.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress,IDTypeOfActivity
		from EstateObject eo
		join FlatRelation fr on eo.IDEstateObject=fr.IDFlatEstate
		where fr.IDBuildEstate=@IDEstateObject
		group by eo.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress,IDTypeOfActivity
	)
go

select * from FN_AllFlats(4)
go

--3.2) Получение списка всех домов с возможностью указания участка;
create or alter function FN_AllBuilds(@IDEstateObject int)
returns table
as
		return(
		select eo.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress,IDTypeOfActivity
		from EstateObject eo
		join EstateRelation er on eo.IDEstateObject=er.IDBuildingEstate
		where er.IDPlaceEstate=@IDEstateObject
		group by eo.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress,IDTypeOfActivity
	)
go

select * from FN_AllBuilds(1)

select * from FN_AllFlats((select top 1 IDEstateObject from FN_AllBuilds(1))) --Список всех квартир на участке(Узнать насчёт массивов)
go
--3.2) Получение списка истории продаж определённого объекта недвижимости;

create or alter function FN_HistoryCheck(@IDEstateObject int)
returns table
as
	return(
		(select ch.IDCheck,ch.DateOfTheSale,ch.FullCost,Concat(e.LastName,' ',e.FirstName,' ', e.Patronymic) as 'Employee',
		Concat(cl.LastName,' ',cl.FirstName,' ', cl.Patronymic) as 'Client',ch.IDEstateObject,
		(select top 1 FullCost from [Check] where IDEstateObject=@IDEstateObject order by DateOfTheSale) as 'ActualCost',
		(select top 1 Concat(cl.LastName,' ',cl.FirstName,' ', cl.Patronymic) from [Check] ch join Client cl on ch.IDClient=cl.IDClient 
		where IDEstateObject=@IDEstateObject order by DateOfTheSale) as 'ActualClient'
		from [Check] ch
		join Client cl on ch.IDClient=cl.IDClient
		join Employee e on ch.IDEmployee=e.IDEmployee
		where IDEstateObject=@IDEstateObject)
	)
go

select * from FN_HistoryCheck(7)
order by DateOfTheSale
go

--Triggers

--4.1) Проверка на запрет объявления квартиры на участке или в квартире;}
		--4.2) Проверка на запрет объявления дома в доме или квартире;}
		--4.3) Проверка на запрет участка в доме, участке или квартире;}


create or alter trigger TR_DifferencePlaceBlock
on EstateRelation
for insert,update
as
begin
	if exists((select * from EstateObject eo join inserted i on eo.IDEstateObject=i.IDBuildingEstate where IDTypeOfActivity<>2))
	begin
		print '[Запрет объявления участка в доме, участке или квартире]'
		rollback tran
	end
	else if exists((select * from EstateObject eo join inserted i on eo.IDEstateObject=i.IDPlaceEstate where IDTypeOfActivity<>1))
	begin
		print '[Запрет объявления участка в доме, участке или квартире]'
		rollback tran
	end
end
go

update EstateRelation
set IDBuildingEstate = 1
where IDEstateRelation = 1

----
disable trigger TR_DifferencePlaceBlock
on estaterelation
go
--
enable trigger TR_DifferencePlaceBlock
on estaterelation
go
----


create or alter trigger TR_DifferenceFlatBlock
on flatrelation
for insert,update
as
begin
	if exists((select * from EstateObject eo join inserted i on eo.IDEstateObject=i.IDFlatEstate where IDTypeOfActivity<>3))
	begin
		print '[Запрет объявления квартиры на участке или в квартире]'
		rollback tran
	end
	else if exists((select * from EstateObject eo join inserted i on eo.IDEstateObject=i.IDBuildEstate where IDTypeOfActivity<>2))
	begin
		print '[Запрет объявления квартиры на участке или в квартире]'
		rollback tran
	end
end
go

update FlatRelation
set IDFlatEstate = 4
where IDFlatRelation = 1


----
disable trigger TR_DifferenceFlatBlock
on flatrelation
go
--
enable trigger TR_DifferenceFlatBlock
on flatrelation
go
----


/*4.4) Проверка на запрет добавления данных для юр. лица в физ. Лицо
  4.5) Проверка на запрет добавления данных для физ. лица в юр. лицо*/

create or alter trigger TR_IsLegalEntity
on Client
for insert,update
as
begin
	if (exists(select * from inserted where IsLegalEntity=1 and ((PasportNumber is not NULL or PasportSeries is not NULL) 
	or (CompanyTitle is NULL or INN is NULL or KPP is NULL or OGRN is NULL or PaymentAccount is NULL or CorrespondentAccount is NULL 
	or BIK is NULL))))
	begin
		print '[Запрет добавления данных для юр. лица в физ. Лицо]'
		rollback tran
	end
	if (exists(select * from inserted where IsLegalEntity=0 and ((PasportNumber is NULL or PasportSeries is NULL)  
	or (CompanyTitle is not NULL or INN is not NULL or KPP is not NULL or OGRN is not NULL or PaymentAccount is not NULL 
	or CorrespondentAccount is not NULL or BIK is not NULL))))
	begin
		print '[Запрет добавления данных для физ. лица в юр. Лицо]'
		rollback tran
	end
end
go

update Client
set PasportNumber = 1111,
PasportSeries = 2222
where IDClient=1
go
select top 1 * from Client
go
