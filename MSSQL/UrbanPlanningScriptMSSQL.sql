USE [master]
GO
/****** Object:  Database [UrbanPlanning]    Script Date: 19.02.2024 23:48:15 ******/
CREATE DATABASE [UrbanPlanning]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UrbanPlanning', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\UrbanPlanning.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'UrbanPlanning_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\UrbanPlanning_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [UrbanPlanning] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UrbanPlanning].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UrbanPlanning] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UrbanPlanning] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UrbanPlanning] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UrbanPlanning] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UrbanPlanning] SET ARITHABORT OFF 
GO
ALTER DATABASE [UrbanPlanning] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UrbanPlanning] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UrbanPlanning] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UrbanPlanning] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UrbanPlanning] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UrbanPlanning] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UrbanPlanning] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UrbanPlanning] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UrbanPlanning] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UrbanPlanning] SET  DISABLE_BROKER 
GO
ALTER DATABASE [UrbanPlanning] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UrbanPlanning] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UrbanPlanning] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UrbanPlanning] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UrbanPlanning] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UrbanPlanning] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UrbanPlanning] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UrbanPlanning] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [UrbanPlanning] SET  MULTI_USER 
GO
ALTER DATABASE [UrbanPlanning] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UrbanPlanning] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UrbanPlanning] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UrbanPlanning] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [UrbanPlanning] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [UrbanPlanning] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [UrbanPlanning] SET QUERY_STORE = ON
GO
ALTER DATABASE [UrbanPlanning] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [UrbanPlanning]
GO
/****** Object:  Table [dbo].[EstateObject]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstateObject](
	[IDEstateObject] [int] IDENTITY(1,1) NOT NULL,
	[Square] [decimal](14, 4) NOT NULL,
	[Price] [decimal](12, 2) NOT NULL,
	[DateOfDefinition] [date] NOT NULL,
	[DateOfApplication] [date] NOT NULL,
	[Number] [int] NOT NULL,
	[Adress] [nvarchar](100) NOT NULL,
	[IDPostIndex] [int] NOT NULL,
	[IDTypeOfActivity] [int] NOT NULL,
	[IDFormat] [int] NOT NULL,
 CONSTRAINT [PK_EstateObject] PRIMARY KEY CLUSTERED 
(
	[IDEstateObject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstateRelation]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstateRelation](
	[IDEstateRelation] [int] IDENTITY(1,1) NOT NULL,
	[IDPlaceEstate] [int] NOT NULL,
	[IDBuildingEstate] [int] NOT NULL,
 CONSTRAINT [PK_EstateRelation] PRIMARY KEY CLUSTERED 
(
	[IDEstateRelation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_AllBuilds]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--3.2) Получение списка всех домов с возможностью указания участка;
create   function [dbo].[FN_AllBuilds](@IDEstateObject int)
returns table
as
		return(
		select eo.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress,IDTypeOfActivity
		from EstateObject eo
		join EstateRelation er on eo.IDEstateObject=er.IDBuildingEstate
		where er.IDPlaceEstate=@IDEstateObject
		group by eo.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress,IDTypeOfActivity
	)
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[IDEmployee] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[Patronymic] [nvarchar](50) NOT NULL,
	[Birthday] [date] NOT NULL,
	[Phone] [char](13) NOT NULL,
	[PasportSeries] [char](4) NOT NULL,
	[PasportNumber] [char](6) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[IDPost] [int] NOT NULL,
	[IDGender] [int] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[IDEmployee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[IDClient] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[Patronymic] [nvarchar](50) NOT NULL,
	[Birthday] [date] NOT NULL,
	[Phone] [char](13) NOT NULL,
	[IsLegalEntity] [bit] NOT NULL,
	[PasportSeries] [char](4) NULL,
	[PasportNumber] [char](6) NULL,
	[CompanyTitle] [nvarchar](50) NULL,
	[INN] [char](10) NULL,
	[KPP] [char](9) NULL,
	[OGRN] [char](13) NULL,
	[PaymentAccount] [char](20) NULL,
	[CorrespondentAccount] [char](20) NULL,
	[BIK] [char](9) NULL,
	[IDGender] [int] NOT NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Check]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Check](
	[IDCheck] [int] IDENTITY(1,1) NOT NULL,
	[DateOfTheSale] [datetime] NOT NULL,
	[FullCost] [decimal](14, 2) NOT NULL,
	[IDEmployee] [int] NOT NULL,
	[IDClient] [int] NOT NULL,
	[IDEstateObject] [int] NOT NULL,
 CONSTRAINT [PK_Check] PRIMARY KEY CLUSTERED 
(
	[IDCheck] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_HistoryCheck]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function [dbo].[FN_HistoryCheck](@IDEstateObject int)
returns table
as
	return(
		(select ch.IDCheck,ch.DateOfTheSale,ch.FullCost,Concat(e.LastName,' ',e.FirstName,' ', e.Patronymic) as 'Employee',Concat(cl.LastName,' ',cl.FirstName,' ', cl.Patronymic) as 'Client',ch.IDEstateObject,(select top 1 FullCost from [Check] where IDEstateObject=@IDEstateObject order by DateOfTheSale) as 'ActualCost',(select top 1 Concat(cl.LastName,' ',cl.FirstName,' ', cl.Patronymic) from [Check] ch join Client cl on ch.IDClient=cl.IDClient where IDEstateObject=@IDEstateObject order by DateOfTheSale) as 'ActualClient'
		from [Check] ch
		join Client cl on ch.IDClient=cl.IDClient
		join Employee e on ch.IDEmployee=e.IDEmployee
		where IDEstateObject=@IDEstateObject)
	)
GO
/****** Object:  Table [dbo].[Format]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Format](
	[IDFormat] [int] IDENTITY(1,1) NOT NULL,
	[FormatTitle] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Format] PRIMARY KEY CLUSTERED 
(
	[IDFormat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeOfActivity]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeOfActivity](
	[IDTypeOfActivity] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TypeOfActivity] PRIMARY KEY CLUSTERED 
(
	[IDTypeOfActivity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Postindex]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Postindex](
	[IDPostindex] [int] IDENTITY(1,1) NOT NULL,
	[Postindex] [char](6) NOT NULL,
 CONSTRAINT [PK_Postindex] PRIMARY KEY CLUSTERED 
(
	[IDPostindex] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_Places]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Views
--1.1) Вывод всех объектов недвижимости, типа – участок со всеми домами на нём;
create   view [dbo].[VW_Places]
as
select e.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress, Postindex, t.Title,FormatTitle, STRING_AGG(er.IDBuildingEstate,', ') as 'Builds'
from EstateObject e
join Postindex p on e.IDPostIndex=p.IDPostindex
join TypeOfActivity t on t.IDTypeOfActivity=e.IDTypeOfActivity
join [Format] f on e.IDFormat = f.IDFormat
join EstateRelation er on e.IDEstateObject=er.IDPlaceEstate
where e.IDTypeOfActivity=1
group by e.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress, Postindex, t.Title,FormatTitle
GO
/****** Object:  Table [dbo].[FlatRelation]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FlatRelation](
	[IDFlatRelation] [int] IDENTITY(1,1) NOT NULL,
	[IDBuildEstate] [int] NOT NULL,
	[IDFlatEstate] [int] NOT NULL,
 CONSTRAINT [PK_FlatRelation] PRIMARY KEY CLUSTERED 
(
	[IDFlatRelation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_Build]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--2.2) Вывод всех объектов недвижимости, типа – дом, с указанием участка;

create   view [dbo].[VW_Build]
as
select [Square], Price, DateOfDefinition, DateOfApplication, Number,Adress, Postindex, t.Title,FormatTitle, STRING_AGG(fr.IDFlatEstate,', ') as 'Flats'
from EstateObject e
join Postindex p on e.IDPostIndex=p.IDPostindex
join TypeOfActivity t on t.IDTypeOfActivity=e.IDTypeOfActivity
join [Format] f on e.IDFormat = f.IDFormat
join FlatRelation fr on e.IDEstateObject=fr.IDBuildEstate
where e.IDTypeOfActivity=2
group by e.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress, Postindex, t.Title,FormatTitle
GO
/****** Object:  View [dbo].[VW_Flat]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--2.3) Вывод всех объектов недвижимости, типа – квартира, с указанием дома;

create   view [dbo].[VW_Flat]
as
select [Square], Price, DateOfDefinition, DateOfApplication,Adress, Postindex, t.Title,FormatTitle
from EstateObject e
join Postindex p on e.IDPostIndex=p.IDPostindex
join TypeOfActivity t on t.IDTypeOfActivity=e.IDTypeOfActivity
join [Format] f on e.IDFormat = f.IDFormat
where e.IDTypeOfActivity=3
GO
/****** Object:  UserDefinedFunction [dbo].[FN_AllFlats]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Functions

--3.1) Получение списка всех квартир с возможностью указания дома;
create   function [dbo].[FN_AllFlats](@IDEstateObject int)
returns table
as
		return(
		select eo.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress,IDTypeOfActivity
		from EstateObject eo
		join FlatRelation fr on eo.IDEstateObject=fr.IDFlatEstate
		where fr.IDBuildEstate=@IDEstateObject
		group by eo.IDEstateObject,[Square], Price, DateOfDefinition, DateOfApplication, Number, Adress,IDTypeOfActivity
	)
GO
/****** Object:  Table [dbo].[EstatePhoto]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstatePhoto](
	[IDEstatePhoto] [int] IDENTITY(1,1) NOT NULL,
	[PhotoPath] [nvarchar](500) NOT NULL,
	[IDEstateObject] [int] NOT NULL,
	[IDEmployee] [int] NOT NULL,
 CONSTRAINT [PK_EstatePhoto] PRIMARY KEY CLUSTERED 
(
	[IDEstatePhoto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[IDGender] [int] IDENTITY(1,1) NOT NULL,
	[GenderTitle] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[IDGender] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Post]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[IDPost] [int] IDENTITY(1,1) NOT NULL,
	[PostTitle] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Post] PRIMARY KEY CLUSTERED 
(
	[IDPost] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temp]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp](
	[id] [int] NULL,
	[inttemp] [int] NULL,
	[chartemp] [varchar](50) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Check] ON 

INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (1, CAST(N'1993-06-24T10:13:00.000' AS DateTime), CAST(301640000.00 AS Decimal(14, 2)), 4, 4, 27)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (2, CAST(N'2012-05-29T13:36:00.000' AS DateTime), CAST(393520000.00 AS Decimal(14, 2)), 5, 32, 24)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (3, CAST(N'1997-04-03T14:24:00.000' AS DateTime), CAST(28680000.00 AS Decimal(14, 2)), 8, 13, 13)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (4, CAST(N'2018-05-16T17:47:00.000' AS DateTime), CAST(272280000.00 AS Decimal(14, 2)), 11, 20, 14)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (5, CAST(N'2025-02-09T07:20:00.000' AS DateTime), CAST(393520000.00 AS Decimal(14, 2)), 13, 36, 24)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (6, CAST(N'2001-09-21T07:12:00.000' AS DateTime), CAST(137000000.00 AS Decimal(14, 2)), 15, 16, 41)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (7, CAST(N'2010-06-10T02:18:00.000' AS DateTime), CAST(228200000.00 AS Decimal(14, 2)), 17, 7, 9)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (8, CAST(N'2010-10-09T07:29:00.000' AS DateTime), CAST(62440000.00 AS Decimal(14, 2)), 18, 23, 30)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (9, CAST(N'2001-12-22T05:11:00.000' AS DateTime), CAST(105680000.00 AS Decimal(14, 2)), 19, 18, 28)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (10, CAST(N'2018-05-24T07:55:00.000' AS DateTime), CAST(311360000.00 AS Decimal(14, 2)), 22, 44, 16)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (11, CAST(N'1996-02-11T04:23:00.000' AS DateTime), CAST(61600000.00 AS Decimal(14, 2)), 23, 10, 17)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (12, CAST(N'2015-11-18T14:02:00.000' AS DateTime), CAST(233120000.00 AS Decimal(14, 2)), 26, 36, 22)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (13, CAST(N'2008-01-10T14:02:00.000' AS DateTime), CAST(39240000.00 AS Decimal(14, 2)), 28, 23, 49)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (14, CAST(N'2012-12-02T03:57:00.000' AS DateTime), CAST(183800000.00 AS Decimal(14, 2)), 29, 5, 26)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (15, CAST(N'2019-04-16T06:15:00.000' AS DateTime), CAST(37880000.00 AS Decimal(14, 2)), 37, 20, 47)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (16, CAST(N'2005-12-26T01:04:00.000' AS DateTime), CAST(293120000.00 AS Decimal(14, 2)), 38, 12, 21)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (17, CAST(N'2026-09-17T06:59:00.000' AS DateTime), CAST(301640000.00 AS Decimal(14, 2)), 39, 22, 27)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (18, CAST(N'2005-05-16T12:23:00.000' AS DateTime), CAST(176760000.00 AS Decimal(14, 2)), 40, 25, 29)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (19, CAST(N'2017-03-31T02:39:00.000' AS DateTime), CAST(366640000.00 AS Decimal(14, 2)), 42, 33, 2)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (20, CAST(N'2001-09-26T08:42:00.000' AS DateTime), CAST(105680000.00 AS Decimal(14, 2)), 43, 38, 28)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (21, CAST(N'2028-10-31T17:25:00.000' AS DateTime), CAST(346160000.00 AS Decimal(14, 2)), 44, 49, 36)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (22, CAST(N'2022-01-21T18:56:00.000' AS DateTime), CAST(301640000.00 AS Decimal(14, 2)), 47, 2, 27)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (23, CAST(N'2000-07-07T13:14:00.000' AS DateTime), CAST(385480000.00 AS Decimal(14, 2)), 49, 42, 6)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (24, CAST(N'2019-10-30T16:20:00.000' AS DateTime), CAST(71720000.00 AS Decimal(14, 2)), 4, 40, 12)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (25, CAST(N'2001-06-11T01:26:00.000' AS DateTime), CAST(124840000.00 AS Decimal(14, 2)), 5, 13, 8)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (26, CAST(N'1999-05-02T02:57:00.000' AS DateTime), CAST(176760000.00 AS Decimal(14, 2)), 8, 15, 29)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (27, CAST(N'1995-10-18T09:08:00.000' AS DateTime), CAST(311360000.00 AS Decimal(14, 2)), 11, 14, 16)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (28, CAST(N'2001-03-18T16:20:00.000' AS DateTime), CAST(71720000.00 AS Decimal(14, 2)), 13, 37, 12)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (29, CAST(N'2001-07-04T12:23:00.000' AS DateTime), CAST(102440000.00 AS Decimal(14, 2)), 15, 50, 23)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (30, CAST(N'2025-09-24T13:36:00.000' AS DateTime), CAST(102440000.00 AS Decimal(14, 2)), 17, 23, 23)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (31, CAST(N'2008-07-27T15:50:00.000' AS DateTime), CAST(62440000.00 AS Decimal(14, 2)), 18, 26, 30)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (32, CAST(N'2008-06-21T03:23:00.000' AS DateTime), CAST(28680000.00 AS Decimal(14, 2)), 19, 41, 13)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (33, CAST(N'2019-10-20T06:50:00.000' AS DateTime), CAST(22200000.00 AS Decimal(14, 2)), 22, 12, 19)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (34, CAST(N'2027-10-15T15:41:00.000' AS DateTime), CAST(224560100.00 AS Decimal(14, 2)), 23, 22, 42)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (35, CAST(N'2011-07-25T05:24:00.000' AS DateTime), CAST(272280000.00 AS Decimal(14, 2)), 26, 10, 14)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (36, CAST(N'1999-12-19T00:00:00.000' AS DateTime), CAST(124830000.00 AS Decimal(14, 2)), 28, 42, 8)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (37, CAST(N'2010-05-06T03:31:00.000' AS DateTime), CAST(137000000.00 AS Decimal(14, 2)), 29, 16, 41)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (38, CAST(N'2009-10-27T13:45:00.000' AS DateTime), CAST(137000000.00 AS Decimal(14, 2)), 37, 9, 41)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (39, CAST(N'2017-05-06T09:04:00.000' AS DateTime), CAST(332520000.00 AS Decimal(14, 2)), 38, 15, 25)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (40, CAST(N'2008-12-26T16:55:00.000' AS DateTime), CAST(276560000.00 AS Decimal(14, 2)), 39, 43, 40)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (41, CAST(N'2022-09-15T05:06:00.000' AS DateTime), CAST(272280000.00 AS Decimal(14, 2)), 40, 23, 14)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (42, CAST(N'2014-07-18T07:29:00.000' AS DateTime), CAST(384560000.00 AS Decimal(14, 2)), 42, 20, 7)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (43, CAST(N'1995-10-23T08:42:00.000' AS DateTime), CAST(137000000.00 AS Decimal(14, 2)), 43, 20, 41)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (44, CAST(N'2006-11-20T05:36:00.000' AS DateTime), CAST(37880000.00 AS Decimal(14, 2)), 44, 1, 47)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (45, CAST(N'1995-12-02T05:54:00.000' AS DateTime), CAST(393520000.00 AS Decimal(14, 2)), 47, 48, 24)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (46, CAST(N'2017-07-12T18:25:00.000' AS DateTime), CAST(81960100.00 AS Decimal(14, 2)), 49, 29, 50)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (47, CAST(N'2024-10-18T10:52:00.000' AS DateTime), CAST(216240000.00 AS Decimal(14, 2)), 4, 16, 43)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (48, CAST(N'2008-12-25T12:57:00.000' AS DateTime), CAST(128800000.00 AS Decimal(14, 2)), 5, 8, 20)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (49, CAST(N'1997-06-23T17:08:00.000' AS DateTime), CAST(62440000.00 AS Decimal(14, 2)), 8, 7, 30)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [FullCost], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (50, CAST(N'2007-02-19T06:59:00.000' AS DateTime), CAST(384560000.00 AS Decimal(14, 2)), 11, 32, 7)
SET IDENTITY_INSERT [dbo].[Check] OFF
GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (1, N'Константинов', N'Матвей', N'Александрович', CAST(N'1982-09-21' AS Date), N'85153127367  ', 1, NULL, NULL, N'RachelAndMillerCompany', N'6978006786', N'620679453', N'9133312695650', N'95164386888201266234', N'65286211061516513654', N'809287306', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (2, N'Коновалов', N'Артур', N'Кириллович', CAST(N'1971-09-12' AS Date), N'86107857394  ', 1, NULL, NULL, N'JesusAndWaltonCompany', N'4651440006', N'277099949', N'7081755478805', N'84455339221165207716', N'10718292016957962043', N'347003036', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (3, N'Худяков', N'Иван', N'Артёмович', CAST(N'1983-08-18' AS Date), N'83653814430  ', 0, N'5177', N'209495', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (4, N'Владимирова', N'Полина', N'Павловна', CAST(N'1988-02-24' AS Date), N'81397898941  ', 1, NULL, NULL, N'RichardAndPriceCompany', N'2351462371', N'713960699', N'8183787100473', N'31205407808751196675', N'57178014595511591754', N'736760351', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (5, N'Полякова', N'Алина', N'Романовна', CAST(N'1989-05-10' AS Date), N'83665536821  ', 0, N'6508', N'304796', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (6, N'Яковлева', N'Альбина', N'Данииловна', CAST(N'2005-07-17' AS Date), N'86994952037  ', 0, N'5689', N'949910', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (7, N'Ершова', N'София', N'Владимировна', CAST(N'1998-07-09' AS Date), N'84828257844  ', 1, NULL, NULL, N'MichaelAndHollowayCompany', N'6079033909', N'994727367', N'8771356148707', N'78658313757047521306', N'63441238117843865337', N'896890906', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (8, N'Иванов', N'Арсений', N'Михайлович', CAST(N'1984-09-17' AS Date), N'85017190458  ', 0, N'8542', N'513781', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (9, N'Третьякова', N'Таисия', N'Константиновна', CAST(N'2003-05-16' AS Date), N'80215750595  ', 0, N'3438', N'742921', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (10, N'Фомина', N'Вера', N'Макаровна', CAST(N'1984-07-10' AS Date), N'85884431802  ', 1, NULL, NULL, N'JanetAndStewartCompany', N'6090387243', N'961183330', N'9287080707710', N'13185688528930962551', N'23120199793324883735', N'618409774', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (11, N'Розанов', N'Марк', N'Артёмович', CAST(N'1977-04-27' AS Date), N'83937020301  ', 0, N'9043', N'231513', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (12, N'Смирнов', N'Андрей', N'Миронович', CAST(N'2002-10-20' AS Date), N'80789165310  ', 1, NULL, NULL, N'AnnAndBurnsCompany', N'1263644027', N'189383685', N'8380096233104', N'40208929989408248274', N'77993945926660269643', N'996454009', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (13, N'Злобина', N'Есения', N'Данииловна', CAST(N'1976-01-10' AS Date), N'84190720145  ', 1, NULL, NULL, N'CarolynAndCainCompany', N'5708800973', N'789451735', N'9457093993768', N'41988316348770966849', N'22721571055825521238', N'461634186', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (14, N'Миронова', N'София', N'Ярославовна', CAST(N'1995-11-11' AS Date), N'80692066300  ', 1, NULL, NULL, N'CarlAndSuttonCompany', N'1979441510', N'912782320', N'6349798816714', N'99142098468069375160', N'43783626432765638500', N'464363278', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (15, N'Терентьев', N'Виктор', N'Захарович', CAST(N'1998-03-01' AS Date), N'89855696994  ', 1, NULL, NULL, N'CarolAndPatrickCompany', N'7692148593', N'590498578', N'3831340401446', N'82109475838937504532', N'55482944731266250649', N'462385689', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (16, N'Белов', N'Владислав', N'Максимович', CAST(N'1975-05-20' AS Date), N'85560446537  ', 0, N'7488', N'473457', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (17, N'Михеева', N'Полина', N'Алексеевна', CAST(N'1998-03-06' AS Date), N'87688275471  ', 0, N'6266', N'777977', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (18, N'Жилина', N'Милана', N'Константиновна', CAST(N'2003-07-26' AS Date), N'82674380394  ', 1, NULL, NULL, N'MelissaAndParkCompany', N'5889020669', N'849487878', N'2933915207104', N'76991184146466355945', N'48372432354957817248', N'671730501', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (19, N'Яковлев', N'Роман', N'Александрович', CAST(N'2001-06-15' AS Date), N'82028433737  ', 0, N'6281', N'680569', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (20, N'Кузнецова', N'Анастасия', N'Львовна', CAST(N'1977-11-26' AS Date), N'89164626489  ', 1, NULL, NULL, N'LeslieAndJohnsonCompany', N'7033435301', N'439125867', N'3568552171444', N'80607670873651797945', N'61551276205664230506', N'650442240', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (21, N'Филиппова', N'Арина', N'Фёдоровна', CAST(N'2002-09-02' AS Date), N'80007548019  ', 0, N'9164', N'808028', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (22, N'Титова', N'Полина', N'Александровна', CAST(N'1977-03-12' AS Date), N'82339974415  ', 1, NULL, NULL, N'DonnaAndNelsonCompany', N'1119203486', N'508734550', N'8841543887438', N'22510244548241853808', N'86544920072443225041', N'638619709', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (23, N'Сергеева', N'Эмилия', N'Арсентьевна', CAST(N'1993-11-15' AS Date), N'82505918426  ', 1, NULL, NULL, N'ColleenAndReevesCompany', N'7964168868', N'847430855', N'1414975914383', N'50067482284130104542', N'63321494106711776511', N'420733566', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (24, N'Александров', N'Михаил', N'Максимович', CAST(N'2002-07-11' AS Date), N'82839736464  ', 0, N'9320', N'466428', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (25, N'Смирнова', N'Софья', N'Фёдоровна', CAST(N'1983-07-06' AS Date), N'84016902737  ', 1, NULL, NULL, N'AndreaAndDavisCompany', N'1387860518', N'620778644', N'2857186382755', N'48446382598366741847', N'87514247144503428614', N'375715790', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (26, N'Усов', N'Ярослав', N'Богданович', CAST(N'2000-02-18' AS Date), N'89048237941  ', 1, NULL, NULL, N'AngelAndMillerCompany', N'9005451015', N'491057504', N'4967745420693', N'82588169233634196638', N'46731489136350050671', N'770565236', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (27, N'Зубова', N'Александра', N'Артуровна', CAST(N'1998-01-19' AS Date), N'82978074577  ', 1, NULL, NULL, N'CodyAndSmithCompany', N'4115834234', N'814188088', N'6971050445510', N'78043795419298005747', N'34674020659547792338', N'493847823', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (28, N'Новиков', N'Лев', N'Артёмович', CAST(N'2003-06-22' AS Date), N'80980581637  ', 1, NULL, NULL, N'KennethAndEdwardsCompany', N'5383898875', N'685670952', N'3772292466032', N'69372958547983662801', N'19388117348853823898', N'301588083', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (29, N'Кузнецов', N'Егор', N'Максимович', CAST(N'1970-12-25' AS Date), N'85690048843  ', 0, N'6188', N'911171', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (30, N'Бородин', N'Эмир', N'Дмитриевич', CAST(N'1999-11-06' AS Date), N'80692713287  ', 0, N'3799', N'718491', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (31, N'Князев', N'Михаил', N'Тимурович', CAST(N'1991-04-12' AS Date), N'89581500287  ', 1, NULL, NULL, N'RichardAndCunninghamCompany', N'7444064475', N'654244250', N'4864603124950', N'52754174561363920731', N'80699150188985771441', N'817327894', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (32, N'Кузнецова', N'Софья', N'Максимовна', CAST(N'2004-11-16' AS Date), N'85126968539  ', 1, NULL, NULL, N'EmilyAndRayCompany', N'3530064452', N'662547685', N'8468345314698', N'51239893833254958910', N'41615687801067948411', N'301065576', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (33, N'Малышева', N'Ясмина', N'Данииловна', CAST(N'1984-08-07' AS Date), N'83295308173  ', 1, NULL, NULL, N'EvaAndBrownCompany', N'2636626042', N'612941131', N'9755192696665', N'74180478687004587160', N'98107638839142511250', N'474301547', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (34, N'Смирнова', N'Елизавета', N'Савельевна', CAST(N'1990-07-13' AS Date), N'87397133330  ', 1, NULL, NULL, N'ClaraAndHolmesCompany', N'6440694197', N'636519169', N'5222355190173', N'26775272102322284903', N'84156542761946537468', N'809574948', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (35, N'Акимова', N'Таисия', N'Михайловна', CAST(N'1981-06-01' AS Date), N'83604373807  ', 1, NULL, NULL, N'PeterAndPowellCompany', N'2568163895', N'835435141', N'1225617274392', N'39033528376584437000', N'28064695169998079471', N'364368939', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (36, N'Дорофеева', N'Александра', N'Ярославовна', CAST(N'1991-08-03' AS Date), N'88577392780  ', 0, N'7154', N'476074', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (37, N'Колосова', N'Василиса', N'Сергеевна', CAST(N'1978-09-25' AS Date), N'85665620817  ', 1, NULL, NULL, N'EvelynAndMurphyCompany', N'7500095546', N'111172127', N'6120502907986', N'85658189656311591426', N'95247515954667069054', N'425194878', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (38, N'Захаров', N'Александр', N'Юрьевич', CAST(N'1995-06-26' AS Date), N'89312386662  ', 0, N'9139', N'896920', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (39, N'Фадеева', N'Полина', N'Владимировна', CAST(N'2001-07-21' AS Date), N'87002894089  ', 1, NULL, NULL, N'YolandaAndOwensCompany', N'5059812065', N'730695704', N'8697187080375', N'22786775433131535738', N'78864501829580460611', N'163557003', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (40, N'Борисов', N'Максим', N'Фёдорович', CAST(N'1995-02-05' AS Date), N'80699613981  ', 0, N'3262', N'656194', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (41, N'Воронова', N'Елена', N'Константиновна', CAST(N'1976-07-24' AS Date), N'87218917452  ', 0, N'2191', N'305959', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (42, N'Рожкова', N'Камилла', N'Кирилловна', CAST(N'1996-11-20' AS Date), N'83164632689  ', 0, N'8519', N'481856', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (43, N'Ситников', N'Тимур', N'Юрьевич', CAST(N'1997-03-22' AS Date), N'88225404705  ', 1, NULL, NULL, N'JohnAndBurgessCompany', N'5457739811', N'818911266', N'4473619902071', N'93347519502125660570', N'51354761755880959192', N'503486621', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (44, N'Ширяев', N'Тимур', N'Матвеевич', CAST(N'1972-01-22' AS Date), N'87070645425  ', 1, NULL, NULL, N'KimAndWardCompany', N'1921864483', N'412437835', N'8192289021107', N'24528096154120463005', N'55296235405904344400', N'595824388', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (45, N'Дьякова', N'Евангелина', N'Арсентьевна', CAST(N'1990-08-16' AS Date), N'83183555680  ', 0, N'5006', N'326464', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (46, N'Романов', N'Павел', N'Юрьевич', CAST(N'1998-08-02' AS Date), N'85693528915  ', 0, N'1302', N'867377', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (47, N'Чернышева', N'Вероника', N'Александровна', CAST(N'1986-09-22' AS Date), N'87838303096  ', 0, N'5036', N'681609', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (48, N'Лапшин', N'Алексей', N'Егорович', CAST(N'1991-05-06' AS Date), N'89991052089  ', 0, N'3619', N'818538', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (49, N'Чернышева', N'Ангелина', N'Максимовна', CAST(N'1991-06-12' AS Date), N'84523771780  ', 0, N'2388', N'879000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (50, N'Баженов', N'Александр', N'Маркович', CAST(N'1991-01-04' AS Date), N'81065599198  ', 0, N'8955', N'300514', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Client] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (1, N'Козлов', N'Владимир', N'Вадимович', CAST(N'1995-06-10' AS Date), N'89782904561  ', N'9209', N'734916', N'123LE59Evfk', N'LE59Evfk', 3, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (2, N'Кириллова', N'Виктория', N'Давидовна', CAST(N'1984-05-16' AS Date), N'81200222412  ', N'6671', N'526895', N'456kp1WNnK2', N'kp1WNnK2', 2, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (3, N'Попова', N'Анна', N'Артёмовна', CAST(N'2003-05-19' AS Date), N'86358379282  ', N'7211', N'809976', N'789478Zwdlu', N'478Zwdlu', 2, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (4, N'Ильин', N'Лука', N'Александрович', CAST(N'1999-07-09' AS Date), N'81604920953  ', N'2595', N'714066', N'11228uyhBjpn', N'8uyhBjpn', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (5, N'Петухова', N'Виктория', N'Егоровна', CAST(N'1971-04-15' AS Date), N'83731866731  ', N'1430', N'789839', N'1455OPSz7P6Z', N'OPSz7P6Z', 1, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (6, N'Попова', N'Полина', N'Максимовна', CAST(N'1982-02-15' AS Date), N'80064733460  ', N'6424', N'235418', N'1788PrqOC8zZ', N'PrqOC8zZ', 3, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (7, N'Самсонова', N'Кира', N'Николаевна', CAST(N'1979-12-09' AS Date), N'87195926986  ', N'9942', N'277036', N'2121KsH3SbHB', N'KsH3SbHB', 2, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (8, N'Иванов', N'Игорь', N'Андреевич', CAST(N'1977-08-04' AS Date), N'85283589961  ', N'3524', N'534345', N'2454E938XjF4', N'E938XjF4', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (9, N'Евдокимов', N'Илья', N'Максимович', CAST(N'1987-02-06' AS Date), N'81246141594  ', N'3408', N'528908', N'2787Gd94iXtW', N'Gd94iXtW', 3, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (10, N'Петрова', N'Дарья', N'Платоновна', CAST(N'1989-11-25' AS Date), N'80680727309  ', N'2914', N'768826', N'31202ClI8lGQ', N'2ClI8lGQ', 2, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (11, N'Казаков', N'Никита', N'Михайлович', CAST(N'1973-09-25' AS Date), N'88901449446  ', N'2450', N'412722', N'3453V8JOsVhz', N'V8JOsVhz', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (12, N'Синицын', N'Александр', N'Даниилович', CAST(N'1970-05-20' AS Date), N'84218656326  ', N'5598', N'387929', N'3786bHWbf7Pz', N'bHWbf7Pz', 3, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (13, N'Козлов', N'Иван', N'Даниилович', CAST(N'2002-06-06' AS Date), N'86940951118  ', N'4089', N'496330', N'4119F6o9icG7', N'F6o9icG7', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (14, N'Владимиров', N'Максим', N'Александрович', CAST(N'1993-11-09' AS Date), N'89070431018  ', N'2665', N'593820', N'4452m7qldF5V', N'm7qldF5V', 3, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (15, N'Русакова', N'Ульяна', N'Тимуровна', CAST(N'1989-11-19' AS Date), N'81432581560  ', N'4085', N'428185', N'4785MZhxpCC4', N'MZhxpCC4', 1, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (16, N'Евдокимова', N'Софья', N'Данииловна', CAST(N'1991-09-13' AS Date), N'87695776225  ', N'2704', N'155133', N'5118FASZgk7P', N'FASZgk7P', 3, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (17, N'Зверев', N'Дмитрий', N'Ярославович', CAST(N'1970-08-26' AS Date), N'87266353847  ', N'3100', N'807366', N'5451SBiDs1AV', N'SBiDs1AV', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (18, N'Сизов', N'Леонид', N'Львович', CAST(N'2003-09-02' AS Date), N'83394808883  ', N'2882', N'828585', N'57848HZANvPn', N'8HZANvPn', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (19, N'Колосов', N'Даниил', N'Артёмович', CAST(N'1977-02-09' AS Date), N'87578466255  ', N'7001', N'246928', N'6117kJClV6Ug', N'kJClV6Ug', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (20, N'Денисов', N'Марк', N'Романович', CAST(N'1971-02-21' AS Date), N'87474363608  ', N'1489', N'874770', N'645000Cv5IEt', N'00Cv5IEt', 3, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (21, N'Кузнецов', N'Глеб', N'Даниилович', CAST(N'1985-11-06' AS Date), N'86685573758  ', N'6259', N'104793', N'6783WKeKQbQ0', N'WKeKQbQ0', 2, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (22, N'Морозов', N'Семён', N'Артёмович', CAST(N'1973-08-24' AS Date), N'84269610601  ', N'6005', N'647699', N'7116MdcEC8Iv', N'MdcEC8Iv', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (23, N'Денисов', N'Константин', N'Иванович', CAST(N'1977-05-14' AS Date), N'88640221450  ', N'7528', N'460218', N'7449MF45U0By', N'MF45U0By', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (24, N'Токарева', N'Кристина', N'Кирилловна', CAST(N'1993-08-19' AS Date), N'89640854331  ', N'6945', N'387984', N'7782wGQhrEC8', N'wGQhrEC8', 3, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (25, N'Кудряшов', N'Артём', N'Ильич', CAST(N'1984-11-07' AS Date), N'81891145385  ', N'4941', N'380269', N'81157puysBxP', N'7puysBxP', 3, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (26, N'Жукова', N'Ксения', N'Никитична', CAST(N'1974-07-28' AS Date), N'84739275572  ', N'9055', N'856975', N'8448NzfW7tBX', N'NzfW7tBX', 1, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (27, N'Черняев', N'Андрей', N'Егорович', CAST(N'1994-04-08' AS Date), N'85412023052  ', N'4033', N'177406', N'87814ZUgQHzX', N'4ZUgQHzX', 3, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (28, N'Павлов', N'Кирилл', N'Захарович', CAST(N'1992-01-17' AS Date), N'87652326535  ', N'6014', N'656174', N'9114Efl1HnFm', N'Efl1HnFm', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (29, N'Данилова', N'Анна', N'Владимировна', CAST(N'1988-10-20' AS Date), N'80712994518  ', N'5555', N'123819', N'9447hp2TGirQ', N'hp2TGirQ', 1, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (30, N'Краснова', N'Кира', N'Егоровна', CAST(N'1986-10-16' AS Date), N'85848597688  ', N'6431', N'317403', N'9780RtC3n8OS', N'RtC3n8OS', 3, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (31, N'Савицкий', N'Михаил', N'Максимович', CAST(N'1998-12-18' AS Date), N'87282889570  ', N'5388', N'445107', N'10113qugNes86', N'qugNes86', 2, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (32, N'Кузнецов', N'Артём', N'Даниилович', CAST(N'1975-05-22' AS Date), N'82530718803  ', N'6773', N'517386', N'10446Vpp8H9Ej', N'Vpp8H9Ej', 3, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (33, N'Смирнова', N'Анастасия', N'Дмитриевна', CAST(N'1970-09-19' AS Date), N'88840706548  ', N'9621', N'435541', N'10779P9R7M7Mq', N'P9R7M7Mq', 3, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (34, N'Кузина', N'Кристина', N'Петровна', CAST(N'1990-08-14' AS Date), N'88265718247  ', N'4958', N'489215', N'11112FR4XZx87', N'FR4XZx87', 3, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (35, N'Кузнецов', N'Тимофей', N'Маркович', CAST(N'1970-09-27' AS Date), N'80128825193  ', N'7905', N'119684', N'11445OKXUeDH7', N'OKXUeDH7', 2, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (36, N'Лукьянова', N'Елена', N'Максимовна', CAST(N'1986-12-12' AS Date), N'89950665742  ', N'2894', N'392830', N'117782AfYKO4Z', N'2AfYKO4Z', 2, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (37, N'Коровина', N'Алиса', N'Ивановна', CAST(N'1975-11-24' AS Date), N'82688977059  ', N'5647', N'942564', N'12111o0ZTLN7r', N'o0ZTLN7r', 1, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (38, N'Воронцова', N'Агния', N'Григорьевна', CAST(N'2003-01-03' AS Date), N'84537810722  ', N'6797', N'935260', N'12444lSq4eI1u', N'lSq4eI1u', 1, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (39, N'Галкин', N'Лев', N'Германович', CAST(N'1997-09-06' AS Date), N'84255997454  ', N'2818', N'204150', N'12777fea6r9Fe', N'fea6r9Fe', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (40, N'Васильев', N'Константин', N'Родионович', CAST(N'1988-04-01' AS Date), N'86280519294  ', N'9363', N'856562', N'13110kkg6QNMR', N'kkg6QNMR', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (41, N'Дубровина', N'София', N'Данииловна', CAST(N'2002-08-04' AS Date), N'86952566335  ', N'1628', N'561906', N'134434L8ttOHB', N'4L8ttOHB', 2, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (42, N'Борисова', N'Злата', N'Вадимовна', CAST(N'1979-12-15' AS Date), N'89829329108  ', N'7998', N'948146', N'13776Iym4gNiw', N'Iym4gNiw', 1, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (43, N'Молчанова', N'Екатерина', N'Ивановна', CAST(N'1979-03-22' AS Date), N'81904314051  ', N'1922', N'142584', N'14109Q8ubzXeL', N'Q8ubzXeL', 1, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (44, N'Бочаров', N'Матвей', N'Алексеевич', CAST(N'1993-10-21' AS Date), N'82369375340  ', N'7765', N'613698', N'14442fdhl0OiW', N'fdhl0OiW', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (45, N'Григорьева', N'Ирина', N'Кирилловна', CAST(N'1994-10-08' AS Date), N'85200881502  ', N'2295', N'786749', N'147755doBwZUj', N'5doBwZUj', 2, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (46, N'Одинцова', N'Алиса', N'Львовна', CAST(N'1973-11-18' AS Date), N'83018121548  ', N'2187', N'611605', N'15108VPOU2WcX', N'VPOU2WcX', 2, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (47, N'Юдин', N'Тимофей', N'Романович', CAST(N'1988-06-22' AS Date), N'89854695131  ', N'9317', N'222681', N'15441GeO5mcOu', N'GeO5mcOu', 1, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (48, N'Романов', N'Данил', N'Михайлович', CAST(N'2000-11-23' AS Date), N'88565932222  ', N'7027', N'846918', N'15774RutED5qG', N'RutED5qG', 3, 1)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (49, N'Савина', N'Арина', N'Ярославовна', CAST(N'1980-05-21' AS Date), N'83745929786  ', N'6492', N'876148', N'16107Ymk6imJv', N'Ymk6imJv', 1, 2)
INSERT [dbo].[Employee] ([IDEmployee], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [PasportSeries], [PasportNumber], [Login], [Password], [IDPost], [IDGender]) VALUES (50, N'Ушаков', N'Матвей', N'Фёдорович', CAST(N'2002-11-28' AS Date), N'84996057163  ', N'3456', N'945955', N'16440sat3BfzO', N'sat3BfzO', 3, 1)
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[EstateObject] ON 

INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (1, CAST(561.0000 AS Decimal(14, 4)), CAST(22440000.00 AS Decimal(12, 2)), CAST(N'1991-02-24' AS Date), CAST(N'1993-01-07' AS Date), 8, N'г. Красноярск,  ул. Лермонтова, уч 8', 43, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (2, CAST(9166.0000 AS Decimal(14, 4)), CAST(366640000.00 AS Decimal(12, 2)), CAST(N'2010-04-15' AS Date), CAST(N'2011-08-16' AS Date), 198, N'г. Тольятти,  ул. Свердлова, уч 198', 20, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (3, CAST(236.0000 AS Decimal(14, 4)), CAST(9440400.00 AS Decimal(12, 2)), CAST(N'1993-08-13' AS Date), CAST(N'1996-03-30' AS Date), 81, N'г. Красноярск,  ул. Лермонтова, уч 8, д. 4, кв. 3', 23, 3, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (4, CAST(3124.0000 AS Decimal(14, 4)), CAST(132418600.00 AS Decimal(12, 2)), CAST(N'2013-08-24' AS Date), CAST(N'2016-04-18' AS Date), 63, N'г. Красноярск,  ул. Лермонтова, уч 8, д. 4', 26, 2, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (5, CAST(3343.0000 AS Decimal(14, 4)), CAST(133720000.00 AS Decimal(12, 2)), CAST(N'2021-11-25' AS Date), CAST(N'2024-03-26' AS Date), 62, N'г. Екатеринбург,  ул. Энергетиков, уч 62', 5, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (6, CAST(9637.0000 AS Decimal(14, 4)), CAST(385480000.00 AS Decimal(12, 2)), CAST(N'1998-07-01' AS Date), CAST(N'1999-12-04' AS Date), 14, N'г. Саратов,  ул. Фрунзе, уч 14', 49, 1, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (7, CAST(9614.0000 AS Decimal(14, 4)), CAST(384560000.00 AS Decimal(12, 2)), CAST(N'2007-05-21' AS Date), CAST(N'2009-02-04' AS Date), 23, N'г. Ростов-на-Дону,  ул. Южная, уч 23', 44, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (8, CAST(3121.0000 AS Decimal(14, 4)), CAST(124840000.00 AS Decimal(12, 2)), CAST(N'2008-06-12' AS Date), CAST(N'2009-08-07' AS Date), 155, N'г. Уфа,  ул. Пролетарская, уч 155', 8, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (9, CAST(5705.0000 AS Decimal(14, 4)), CAST(228200000.00 AS Decimal(12, 2)), CAST(N'1997-10-26' AS Date), CAST(N'1999-09-05' AS Date), 45, N'г. Нижний Новгород,  ул. Молодежная, уч 45', 13, 1, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (10, CAST(4399.0000 AS Decimal(14, 4)), CAST(175960000.00 AS Decimal(12, 2)), CAST(N'2015-05-09' AS Date), CAST(N'2017-04-15' AS Date), 28, N'г. Уфа,  ул. Дорожная, уч 28', 46, 1, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (11, CAST(3260.0000 AS Decimal(14, 4)), CAST(130400000.00 AS Decimal(12, 2)), CAST(N'1992-04-24' AS Date), CAST(N'1993-06-04' AS Date), 134, N'г. Тольятти,  ул. Свердлова, уч 198, д. 11', 43, 2, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (12, CAST(1793.0000 AS Decimal(14, 4)), CAST(71720000.00 AS Decimal(12, 2)), CAST(N'2012-09-13' AS Date), CAST(N'2015-01-25' AS Date), 60, N'г. Красноярск,  ул. Молодежная, уч 60', 2, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (13, CAST(717.0000 AS Decimal(14, 4)), CAST(28680300.00 AS Decimal(12, 2)), CAST(N'2003-10-23' AS Date), CAST(N'2005-09-08' AS Date), 47, N'г. Тольятти,  ул. Свердлова, уч 198, д. 11, кв. 13', 27, 3, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (14, CAST(6807.0000 AS Decimal(14, 4)), CAST(272280300.00 AS Decimal(12, 2)), CAST(N'2008-03-18' AS Date), CAST(N'2010-06-08' AS Date), 92, N'г. Екатеринбург,  ул. Энергетиков, уч 62, д. 15, кв. 14', 33, 3, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (15, CAST(4684.0000 AS Decimal(14, 4)), CAST(187360000.00 AS Decimal(12, 2)), CAST(N'2015-12-17' AS Date), CAST(N'2018-04-08' AS Date), 163, N'г. Екатеринбург,  ул. Энергетиков, уч 62, д. 15', 23, 2, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (16, CAST(7784.0000 AS Decimal(14, 4)), CAST(311360000.00 AS Decimal(12, 2)), CAST(N'2003-01-23' AS Date), CAST(N'2004-12-30' AS Date), 64, N'г. Тюмень,  ул. Матросова, уч 64', 28, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (17, CAST(1540.0000 AS Decimal(14, 4)), CAST(61600000.00 AS Decimal(12, 2)), CAST(N'2023-09-15' AS Date), CAST(N'2025-05-18' AS Date), 188, N'г. Тольятти,  ул. Парковая, уч 188', 6, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (18, CAST(4717.0000 AS Decimal(14, 4)), CAST(188680000.00 AS Decimal(12, 2)), CAST(N'2003-09-04' AS Date), CAST(N'2004-12-01' AS Date), 94, N'г. Уфа,  ул. Фрунзе, уч 94', 13, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (19, CAST(555.0000 AS Decimal(14, 4)), CAST(22200300.00 AS Decimal(12, 2)), CAST(N'2015-01-20' AS Date), CAST(N'2016-09-13' AS Date), 177, N'г. Саратов,  ул. Фрунзе, уч 14, д. 21, кв. 19', 37, 3, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (20, CAST(3220.0000 AS Decimal(14, 4)), CAST(128800300.00 AS Decimal(12, 2)), CAST(N'1998-02-05' AS Date), CAST(N'1999-09-27' AS Date), 93, N'г. Ростов-на-Дону,  ул. Южная, уч 23, д. 22, кв. 20', 49, 3, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (21, CAST(7328.0000 AS Decimal(14, 4)), CAST(293120000.00 AS Decimal(12, 2)), CAST(N'2024-06-06' AS Date), CAST(N'2026-07-28' AS Date), 144, N'г. Саратов,  ул. Фрунзе, уч 14, д. 21', 38, 2, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (22, CAST(5828.0000 AS Decimal(14, 4)), CAST(233120000.00 AS Decimal(12, 2)), CAST(N'2019-05-19' AS Date), CAST(N'2021-09-10' AS Date), 93, N'г. Ростов-на-Дону,  ул. Южная, уч 23, д. 22', 12, 2, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (23, CAST(2561.0000 AS Decimal(14, 4)), CAST(102440300.00 AS Decimal(12, 2)), CAST(N'1998-02-19' AS Date), CAST(N'1999-08-16' AS Date), 2, N'г. Уфа,  ул. Пролетарская, уч 155, д. 41, кв. 23', 15, 3, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (24, CAST(9838.0000 AS Decimal(14, 4)), CAST(393520000.00 AS Decimal(12, 2)), CAST(N'2017-07-02' AS Date), CAST(N'2018-09-11' AS Date), 130, N'г. Краснодар,  ул. Железнодорожная, уч 130', 50, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (25, CAST(8313.0000 AS Decimal(14, 4)), CAST(332520300.00 AS Decimal(12, 2)), CAST(N'1996-07-07' AS Date), CAST(N'1999-03-06' AS Date), 132, N'г. Нижний Новгород,  ул. Молодежная, уч 45, д. 44, кв. 25', 38, 3, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (26, CAST(4595.0000 AS Decimal(14, 4)), CAST(183800000.00 AS Decimal(12, 2)), CAST(N'1996-07-27' AS Date), CAST(N'1998-09-13' AS Date), 63, N'г. Волгоград,  ул. Вишневая, уч 63', 16, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (27, CAST(7541.0000 AS Decimal(14, 4)), CAST(301640300.00 AS Decimal(12, 2)), CAST(N'1993-01-24' AS Date), CAST(N'1994-04-02' AS Date), 89, N'г. Уфа,  ул. Дорожная, уч 28, д. 46, кв. 27', 34, 3, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (28, CAST(2642.0000 AS Decimal(14, 4)), CAST(105680300.00 AS Decimal(12, 2)), CAST(N'1996-12-20' AS Date), CAST(N'1998-06-26' AS Date), 134, N'г. Красноярск,  ул. Молодежная, уч 60, д. 47, кв. 28', 11, 3, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (29, CAST(4419.0000 AS Decimal(14, 4)), CAST(176760000.00 AS Decimal(12, 2)), CAST(N'1998-05-15' AS Date), CAST(N'2000-10-20' AS Date), 104, N'г. Краснодар,  ул. Свободы, уч 104', 22, 1, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (30, CAST(1561.0000 AS Decimal(14, 4)), CAST(62440300.00 AS Decimal(12, 2)), CAST(N'2021-08-06' AS Date), CAST(N'2023-07-27' AS Date), 110, N'г. Тюмень,  ул. Матросова, уч 64, д. 49, кв. 30', 47, 3, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (31, CAST(4405.0000 AS Decimal(14, 4)), CAST(176200300.00 AS Decimal(12, 2)), CAST(N'2006-01-21' AS Date), CAST(N'2008-01-07' AS Date), 99, N'г. Красноярск,  ул. Лермонтова, уч 8, д. 50, кв. 31', 41, 3, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (32, CAST(5136.0000 AS Decimal(14, 4)), CAST(205440000.00 AS Decimal(12, 2)), CAST(N'2005-09-09' AS Date), CAST(N'2008-01-12' AS Date), 95, N'г. Москва,  ул. Овражная, уч 95', 4, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (33, CAST(6377.0000 AS Decimal(14, 4)), CAST(255080400.00 AS Decimal(12, 2)), CAST(N'2015-08-27' AS Date), CAST(N'2017-10-29' AS Date), 16, N'г. Красноярск,  ул. Лермонтова, уч 8, д. 4, кв. 33', 28, 3, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (34, CAST(6162.0000 AS Decimal(14, 4)), CAST(246480000.00 AS Decimal(12, 2)), CAST(N'2024-09-06' AS Date), CAST(N'2025-12-09' AS Date), 160, N'г. Тольятти,  ул. Нагорная, уч 160', 30, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (35, CAST(3846.0000 AS Decimal(14, 4)), CAST(153840000.00 AS Decimal(12, 2)), CAST(N'2009-04-16' AS Date), CAST(N'2010-06-30' AS Date), 117, N'г. Москва,  ул. Клубная, уч 117', 10, 1, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (36, CAST(8654.0000 AS Decimal(14, 4)), CAST(346160300.00 AS Decimal(12, 2)), CAST(N'1997-09-28' AS Date), CAST(N'1999-01-13' AS Date), 37, N'г. Тольятти,  ул. Свердлова, уч 198, д. 11, кв. 36', 15, 3, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (37, CAST(3095.0000 AS Decimal(14, 4)), CAST(123800300.00 AS Decimal(12, 2)), CAST(N'2007-07-26' AS Date), CAST(N'2009-07-04' AS Date), 173, N'г. Екатеринбург,  ул. Энергетиков, уч 62, д. 15, кв. 37', 25, 3, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (38, CAST(1787.0000 AS Decimal(14, 4)), CAST(71480300.00 AS Decimal(12, 2)), CAST(N'2005-08-13' AS Date), CAST(N'2007-11-29' AS Date), 45, N'г. Саратов,  ул. Фрунзе, уч 14, д. 21, кв. 38', 3, 3, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (39, CAST(5438.0000 AS Decimal(14, 4)), CAST(217520000.00 AS Decimal(12, 2)), CAST(N'2012-11-04' AS Date), CAST(N'2015-06-19' AS Date), 103, N'г. Самара,  ул. Зеленая, уч 103', 7, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (40, CAST(6914.0000 AS Decimal(14, 4)), CAST(276560000.00 AS Decimal(12, 2)), CAST(N'2005-04-07' AS Date), CAST(N'2007-04-24' AS Date), 5, N'г. Москва,  ул. Дорожная, уч 5', 50, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (41, CAST(3425.0000 AS Decimal(14, 4)), CAST(137000000.00 AS Decimal(12, 2)), CAST(N'2020-11-19' AS Date), CAST(N'2021-12-10' AS Date), 107, N'г. Уфа,  ул. Пролетарская, уч 155, д. 41', 46, 2, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (42, CAST(5614.0000 AS Decimal(14, 4)), CAST(224560400.00 AS Decimal(12, 2)), CAST(N'2011-09-08' AS Date), CAST(N'2012-11-11' AS Date), 12, N'г. Красноярск,  ул. Лермонтова, уч 8, д. 4, кв. 42', 45, 3, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (43, CAST(5406.0000 AS Decimal(14, 4)), CAST(216240300.00 AS Decimal(12, 2)), CAST(N'1992-06-23' AS Date), CAST(N'1993-11-21' AS Date), 52, N'г. Тольятти,  ул. Свердлова, уч 198, д. 11, кв. 43', 39, 3, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (44, CAST(395.0000 AS Decimal(14, 4)), CAST(15800000.00 AS Decimal(12, 2)), CAST(N'2004-07-02' AS Date), CAST(N'2005-10-10' AS Date), 110, N'г. Нижний Новгород,  ул. Молодежная, уч 45, д. 44', 12, 2, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (45, CAST(4443.0000 AS Decimal(14, 4)), CAST(177720300.00 AS Decimal(12, 2)), CAST(N'1991-01-14' AS Date), CAST(N'1993-06-06' AS Date), 52, N'г. Екатеринбург,  ул. Энергетиков, уч 62, д. 15, кв. 45', 26, 3, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (46, CAST(5090.0000 AS Decimal(14, 4)), CAST(203600000.00 AS Decimal(12, 2)), CAST(N'2014-01-10' AS Date), CAST(N'2016-06-29' AS Date), 118, N'г. Уфа,  ул. Дорожная, уч 28, д. 46', 5, 2, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (47, CAST(947.0000 AS Decimal(14, 4)), CAST(37880000.00 AS Decimal(12, 2)), CAST(N'2021-04-19' AS Date), CAST(N'2022-09-01' AS Date), 94, N'г. Красноярск,  ул. Молодежная, уч 60, д. 47', 14, 2, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (48, CAST(381.0000 AS Decimal(14, 4)), CAST(15240000.00 AS Decimal(12, 2)), CAST(N'2004-03-21' AS Date), CAST(N'2006-11-20' AS Date), 134, N'г. Ижевск,  ул. Трактовая, уч 134', 38, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (49, CAST(981.0000 AS Decimal(14, 4)), CAST(39240000.00 AS Decimal(12, 2)), CAST(N'1993-09-08' AS Date), CAST(N'1996-04-22' AS Date), 86, N'г. Тюмень,  ул. Матросова, уч 64, д. 49', 45, 2, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Number], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (50, CAST(2049.0000 AS Decimal(14, 4)), CAST(81959800.00 AS Decimal(12, 2)), CAST(N'2004-05-19' AS Date), CAST(N'2006-07-11' AS Date), 97, N'г. Красноярск,  ул. Лермонтова, уч 8, д. 50', 13, 2, 1)
SET IDENTITY_INSERT [dbo].[EstateObject] OFF
GO
SET IDENTITY_INSERT [dbo].[EstatePhoto] ON 

INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (1, N'https://avatars.dzeninfra.ru/get-zen_doc/271828/pub_65a94dff5fa2ee4ed86a10ab_65a94e0a95fa5f044c31c010/scale_1200', 3, 1)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (2, N'https://avatars.dzeninfra.ru/get-zen_doc/271828/pub_65a8f6154aebb8193f135bbc_65a8fd4d335af54b4b39ae87/scale_1200', 13, 6)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (3, N'https://forum.ivd.ru/uploads/monthly_2018_05/plan.jpeg.eefd27876f9d9cd190e9b68ce91a3cb1.jpeg', 14, 9)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (4, N'https://obstanovka.club/uploads/posts/2023-03/1678198235_obstanovka-club-p-planirovka-dvukhkomnatnikh-kvartir-dizain-68.png', 19, 12)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (5, N'https://otoplenie-vdome.ru/wp-content/uploads/1/2/2/12264ef9f2f811bc84b3f20f33dc48e4.jpeg', 20, 14)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (6, N'https://fonovik.com/uploads/posts/2023-02/1677560468_fonovik-com-p-neobichnie-planirovki-kvartir-31.jpg', 23, 16)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (7, N'https://www.archrevue.ru/images/tb/2/7/0/27087/15029715277327_w1500h1500.jpg', 25, 20)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (8, N'http://solncevopark.ru/forum/upload/foto/c/c/0/f_ff165c260acf6ae035ce79b6d90cc.jpg', 27, 24)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (9, N'https://addawards.ru/upload/iblock/aa3/plan.jpg', 28, 25)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (10, N'https://www.mebel-go.ru/mebelgoer/2772000074.jpg', 30, 27)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (11, N'http://molniam.ru/upload_files/image/yal10/plan/13.jpg', 31, 30)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (12, N'https://zelgorod.ru/uploads/all/40/70/73/4070732e1aed19b1d90df1d01c8cbf4d.jpg', 33, 32)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (13, N'https://static.diary.ru/userdir/3/2/2/8/3228530/80791828.jpg', 36, 33)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (14, N'https://i.pinimg.com/736x/30/85/48/308548de6d268fb89dc3be7c67a77f88.jpg', 37, 34)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (15, N'https://sk-amigo.ru/800/600/http/xn--h1agnge8d.xn--p1ai/filestore/uploaded/plan_1et_d3_678_normal.png', 38, 48)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (16, N'https://design-homes.ru/images/galery/1947/dizajn-kukhni-gostinoj-20-kv-m_5dbaeb27acdef.jpg', 42, 50)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (17, N'https://timeszp.com/wp-content/uploads/2022/12/1_dizajn-kvartiry-studii-ploshchadyu-30-kv-m-10.jpg', 43, 1)
INSERT [dbo].[EstatePhoto] ([IDEstatePhoto], [PhotoPath], [IDEstateObject], [IDEmployee]) VALUES (18, N'https://ecpu.ru/new-buildings/kazan/972/plans/doma-po-ul-pavlyuhina-kazan-plan-9.jpg', 45, 6)
SET IDENTITY_INSERT [dbo].[EstatePhoto] OFF
GO
SET IDENTITY_INSERT [dbo].[EstateRelation] ON 

INSERT [dbo].[EstateRelation] ([IDEstateRelation], [IDPlaceEstate], [IDBuildingEstate]) VALUES (1, 1, 4)
INSERT [dbo].[EstateRelation] ([IDEstateRelation], [IDPlaceEstate], [IDBuildingEstate]) VALUES (2, 2, 11)
INSERT [dbo].[EstateRelation] ([IDEstateRelation], [IDPlaceEstate], [IDBuildingEstate]) VALUES (3, 5, 15)
INSERT [dbo].[EstateRelation] ([IDEstateRelation], [IDPlaceEstate], [IDBuildingEstate]) VALUES (4, 6, 21)
INSERT [dbo].[EstateRelation] ([IDEstateRelation], [IDPlaceEstate], [IDBuildingEstate]) VALUES (5, 7, 22)
INSERT [dbo].[EstateRelation] ([IDEstateRelation], [IDPlaceEstate], [IDBuildingEstate]) VALUES (6, 8, 41)
INSERT [dbo].[EstateRelation] ([IDEstateRelation], [IDPlaceEstate], [IDBuildingEstate]) VALUES (7, 9, 44)
INSERT [dbo].[EstateRelation] ([IDEstateRelation], [IDPlaceEstate], [IDBuildingEstate]) VALUES (8, 10, 46)
INSERT [dbo].[EstateRelation] ([IDEstateRelation], [IDPlaceEstate], [IDBuildingEstate]) VALUES (9, 12, 47)
INSERT [dbo].[EstateRelation] ([IDEstateRelation], [IDPlaceEstate], [IDBuildingEstate]) VALUES (10, 16, 49)
INSERT [dbo].[EstateRelation] ([IDEstateRelation], [IDPlaceEstate], [IDBuildingEstate]) VALUES (11, 1, 50)
SET IDENTITY_INSERT [dbo].[EstateRelation] OFF
GO
SET IDENTITY_INSERT [dbo].[FlatRelation] ON 

INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (1, 4, 3)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (2, 11, 13)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (3, 15, 14)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (4, 21, 19)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (5, 22, 20)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (6, 41, 23)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (7, 44, 25)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (8, 46, 27)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (9, 47, 28)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (10, 49, 30)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (11, 50, 31)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (12, 4, 33)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (13, 11, 36)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (14, 15, 37)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (15, 21, 38)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (16, 4, 42)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (17, 11, 43)
INSERT [dbo].[FlatRelation] ([IDFlatRelation], [IDBuildEstate], [IDFlatEstate]) VALUES (18, 15, 45)
SET IDENTITY_INSERT [dbo].[FlatRelation] OFF
GO
SET IDENTITY_INSERT [dbo].[Format] ON 

INSERT [dbo].[Format] ([IDFormat], [FormatTitle]) VALUES (1, N'Частная')
INSERT [dbo].[Format] ([IDFormat], [FormatTitle]) VALUES (2, N'Государственная')
INSERT [dbo].[Format] ([IDFormat], [FormatTitle]) VALUES (3, N'Муниципальная')
SET IDENTITY_INSERT [dbo].[Format] OFF
GO
SET IDENTITY_INSERT [dbo].[Gender] ON 

INSERT [dbo].[Gender] ([IDGender], [GenderTitle]) VALUES (1, N'Мужчина')
INSERT [dbo].[Gender] ([IDGender], [GenderTitle]) VALUES (2, N'Женщина')
SET IDENTITY_INSERT [dbo].[Gender] OFF
GO
SET IDENTITY_INSERT [dbo].[Post] ON 

INSERT [dbo].[Post] ([IDPost], [PostTitle]) VALUES (1, N'Менеджер')
INSERT [dbo].[Post] ([IDPost], [PostTitle]) VALUES (2, N'Кадастровый инженер')
INSERT [dbo].[Post] ([IDPost], [PostTitle]) VALUES (3, N'Архитектор')
SET IDENTITY_INSERT [dbo].[Post] OFF
GO
SET IDENTITY_INSERT [dbo].[Postindex] ON 

INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (1, N'130558')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (2, N'931953')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (3, N'971003')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (4, N'996253')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (5, N'986345')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (6, N'496041')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (7, N'270586')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (8, N'816238')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (9, N'669871')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (10, N'409499')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (11, N'300183')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (12, N'839456')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (13, N'918396')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (14, N'985785')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (15, N'131916')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (16, N'552075')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (17, N'615283')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (18, N'299405')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (19, N'596754')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (20, N'755424')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (21, N'727123')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (22, N'118487')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (23, N'214375')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (24, N'366661')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (25, N'258071')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (26, N'874345')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (27, N'598861')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (28, N'954504')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (29, N'843672')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (30, N'883053')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (31, N'701507')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (32, N'897087')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (33, N'458943')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (34, N'609283')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (35, N'835241')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (36, N'965265')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (37, N'202945')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (38, N'642910')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (39, N'315619')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (40, N'670509')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (41, N'750899')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (42, N'834178')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (43, N'862699')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (44, N'212105')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (45, N'942453')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (46, N'308833')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (47, N'441457')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (48, N'618410')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (49, N'440394')
INSERT [dbo].[Postindex] ([IDPostindex], [Postindex]) VALUES (50, N'494023')
SET IDENTITY_INSERT [dbo].[Postindex] OFF
GO
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (1, 301640000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (2, 393520000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (3, 28680000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (4, 272280000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (5, 393520000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (6, 137000000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (7, 228200000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (8, 62440000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (9, 105680000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (10, 311360000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (11, 61600000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (12, 233120000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (13, 39240000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (14, 183800000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (15, 37880000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (16, 293120000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (17, 301640000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (18, 176760000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (19, 366640000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (20, 105680000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (21, 346160000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (22, 301640000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (23, 385480000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (24, 71720000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (25, 124840000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (26, 176760000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (27, 311360000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (28, 71720000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (29, 102440000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (30, 102440000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (31, 62440000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (32, 28680000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (33, 22200000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (34, 224560100, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (35, 272280000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (36, 124840000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (37, 137000000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (38, 137000000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (39, 332520000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (40, 276560000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (41, 272280000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (42, 384560000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (43, 137000000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (44, 37880000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (45, 393520000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (46, 81960100, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (47, 216240000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (48, 128800000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (49, 62440000, NULL)
INSERT [dbo].[temp] ([id], [inttemp], [chartemp]) VALUES (50, 384560000, NULL)
GO
SET IDENTITY_INSERT [dbo].[TypeOfActivity] ON 

INSERT [dbo].[TypeOfActivity] ([IDTypeOfActivity], [Title]) VALUES (1, N'Участок')
INSERT [dbo].[TypeOfActivity] ([IDTypeOfActivity], [Title]) VALUES (2, N'Дом')
INSERT [dbo].[TypeOfActivity] ([IDTypeOfActivity], [Title]) VALUES (3, N'Квартира')
SET IDENTITY_INSERT [dbo].[TypeOfActivity] OFF
GO
ALTER TABLE [dbo].[Check]  WITH CHECK ADD  CONSTRAINT [FK_Check_Client] FOREIGN KEY([IDClient])
REFERENCES [dbo].[Client] ([IDClient])
GO
ALTER TABLE [dbo].[Check] CHECK CONSTRAINT [FK_Check_Client]
GO
ALTER TABLE [dbo].[Check]  WITH CHECK ADD  CONSTRAINT [FK_Check_Employee] FOREIGN KEY([IDEmployee])
REFERENCES [dbo].[Employee] ([IDEmployee])
GO
ALTER TABLE [dbo].[Check] CHECK CONSTRAINT [FK_Check_Employee]
GO
ALTER TABLE [dbo].[Check]  WITH CHECK ADD  CONSTRAINT [FK_Check_EstateObject] FOREIGN KEY([IDEstateObject])
REFERENCES [dbo].[EstateObject] ([IDEstateObject])
GO
ALTER TABLE [dbo].[Check] CHECK CONSTRAINT [FK_Check_EstateObject]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [FK_Client_Gender] FOREIGN KEY([IDGender])
REFERENCES [dbo].[Gender] ([IDGender])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [FK_Client_Gender]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Gender] FOREIGN KEY([IDGender])
REFERENCES [dbo].[Gender] ([IDGender])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Gender]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Post] FOREIGN KEY([IDPost])
REFERENCES [dbo].[Post] ([IDPost])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Post]
GO
ALTER TABLE [dbo].[EstateObject]  WITH CHECK ADD  CONSTRAINT [FK_EstateObject_Format] FOREIGN KEY([IDFormat])
REFERENCES [dbo].[Format] ([IDFormat])
GO
ALTER TABLE [dbo].[EstateObject] CHECK CONSTRAINT [FK_EstateObject_Format]
GO
ALTER TABLE [dbo].[EstateObject]  WITH CHECK ADD  CONSTRAINT [FK_EstateObject_Postindex] FOREIGN KEY([IDFormat])
REFERENCES [dbo].[Postindex] ([IDPostindex])
GO
ALTER TABLE [dbo].[EstateObject] CHECK CONSTRAINT [FK_EstateObject_Postindex]
GO
ALTER TABLE [dbo].[EstateObject]  WITH CHECK ADD  CONSTRAINT [FK_EstateObject_TypeOfActivity] FOREIGN KEY([IDTypeOfActivity])
REFERENCES [dbo].[TypeOfActivity] ([IDTypeOfActivity])
GO
ALTER TABLE [dbo].[EstateObject] CHECK CONSTRAINT [FK_EstateObject_TypeOfActivity]
GO
ALTER TABLE [dbo].[EstatePhoto]  WITH CHECK ADD  CONSTRAINT [FK_EstatePhoto_Employee] FOREIGN KEY([IDEmployee])
REFERENCES [dbo].[Employee] ([IDEmployee])
GO
ALTER TABLE [dbo].[EstatePhoto] CHECK CONSTRAINT [FK_EstatePhoto_Employee]
GO
ALTER TABLE [dbo].[EstatePhoto]  WITH CHECK ADD  CONSTRAINT [FK_EstatePhoto_EstateObject] FOREIGN KEY([IDEstateObject])
REFERENCES [dbo].[EstateObject] ([IDEstateObject])
GO
ALTER TABLE [dbo].[EstatePhoto] CHECK CONSTRAINT [FK_EstatePhoto_EstateObject]
GO
ALTER TABLE [dbo].[EstateRelation]  WITH CHECK ADD  CONSTRAINT [FK_EstateRelation_EstateObject] FOREIGN KEY([IDPlaceEstate])
REFERENCES [dbo].[EstateObject] ([IDEstateObject])
GO
ALTER TABLE [dbo].[EstateRelation] CHECK CONSTRAINT [FK_EstateRelation_EstateObject]
GO
ALTER TABLE [dbo].[EstateRelation]  WITH CHECK ADD  CONSTRAINT [FK_EstateRelation_EstateObject1] FOREIGN KEY([IDBuildingEstate])
REFERENCES [dbo].[EstateObject] ([IDEstateObject])
GO
ALTER TABLE [dbo].[EstateRelation] CHECK CONSTRAINT [FK_EstateRelation_EstateObject1]
GO
ALTER TABLE [dbo].[FlatRelation]  WITH CHECK ADD  CONSTRAINT [FK_FlatRelation_EstateObject] FOREIGN KEY([IDBuildEstate])
REFERENCES [dbo].[EstateObject] ([IDEstateObject])
GO
ALTER TABLE [dbo].[FlatRelation] CHECK CONSTRAINT [FK_FlatRelation_EstateObject]
GO
ALTER TABLE [dbo].[FlatRelation]  WITH CHECK ADD  CONSTRAINT [FK_FlatRelation_EstateObject1] FOREIGN KEY([IDFlatEstate])
REFERENCES [dbo].[EstateObject] ([IDEstateObject])
GO
ALTER TABLE [dbo].[FlatRelation] CHECK CONSTRAINT [FK_FlatRelation_EstateObject1]
GO
/****** Object:  StoredProcedure [dbo].[PR_AddCommonCost]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Procedure

--2.1) Повышение/Понижение цены домов, находящихся на 1м общем участке;
create   proc [dbo].[PR_AddCommonCost]
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
GO
/****** Object:  StoredProcedure [dbo].[PR_AddCommonFlatCost]    Script Date: 19.02.2024 23:48:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--2.2) Повышение/Понижение цены квартир, находящихся в 1м общем доме;
create   proc [dbo].[PR_AddCommonFlatCost]
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
GO
USE [master]
GO
ALTER DATABASE [UrbanPlanning] SET  READ_WRITE 
GO
