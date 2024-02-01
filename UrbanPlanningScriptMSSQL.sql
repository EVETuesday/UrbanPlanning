USE [UrbanPlanning]
GO
/****** Object:  Table [dbo].[Check]    Script Date: 01.02.2024 15:30:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Check](
	[IDCheck] [int] IDENTITY(1,1) NOT NULL,
	[DateOfTheSale] [datetime] NOT NULL,
	[IDEmployee] [int] NOT NULL,
	[IDClient] [int] NOT NULL,
	[IDEstateObject] [int] NOT NULL,
 CONSTRAINT [PK_Check] PRIMARY KEY CLUSTERED 
(
	[IDCheck] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 01.02.2024 15:30:55 ******/
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
/****** Object:  Table [dbo].[Employee]    Script Date: 01.02.2024 15:30:55 ******/
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
/****** Object:  Table [dbo].[EstateObject]    Script Date: 01.02.2024 15:30:55 ******/
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
	[Adress] [nvarchar](50) NOT NULL,
	[IDPostIndex] [int] NOT NULL,
	[IDTypeOfActivity] [int] NOT NULL,
	[IDFormat] [int] NOT NULL,
 CONSTRAINT [PK_EstateObject] PRIMARY KEY CLUSTERED 
(
	[IDEstateObject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstatePhoto]    Script Date: 01.02.2024 15:30:55 ******/
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
/****** Object:  Table [dbo].[EstateRelation]    Script Date: 01.02.2024 15:30:55 ******/
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
/****** Object:  Table [dbo].[FlatRelation]    Script Date: 01.02.2024 15:30:55 ******/
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
/****** Object:  Table [dbo].[Format]    Script Date: 01.02.2024 15:30:55 ******/
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
/****** Object:  Table [dbo].[Gender]    Script Date: 01.02.2024 15:30:55 ******/
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
/****** Object:  Table [dbo].[Post]    Script Date: 01.02.2024 15:30:55 ******/
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
/****** Object:  Table [dbo].[Postindex]    Script Date: 01.02.2024 15:30:55 ******/
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
/****** Object:  Table [dbo].[TypeOfActivity]    Script Date: 01.02.2024 15:30:55 ******/
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
SET IDENTITY_INSERT [dbo].[Check] ON 

INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (1, CAST(N'1993-06-24T10:13:00.000' AS DateTime), 4, 4, 27)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (2, CAST(N'2012-05-29T13:36:00.000' AS DateTime), 5, 32, 24)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (3, CAST(N'1997-04-03T14:24:00.000' AS DateTime), 8, 13, 13)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (4, CAST(N'2018-05-16T17:47:00.000' AS DateTime), 11, 20, 14)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (5, CAST(N'2025-02-09T07:20:00.000' AS DateTime), 13, 36, 24)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (6, CAST(N'2001-09-21T07:12:00.000' AS DateTime), 15, 16, 41)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (7, CAST(N'2010-06-10T02:18:00.000' AS DateTime), 17, 7, 9)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (8, CAST(N'2010-10-09T07:29:00.000' AS DateTime), 18, 23, 30)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (9, CAST(N'2001-12-22T05:11:00.000' AS DateTime), 19, 18, 28)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (10, CAST(N'2018-05-24T07:55:00.000' AS DateTime), 22, 44, 16)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (11, CAST(N'1996-02-11T04:23:00.000' AS DateTime), 23, 10, 17)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (12, CAST(N'2015-11-18T14:02:00.000' AS DateTime), 26, 36, 22)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (13, CAST(N'2008-01-10T14:02:00.000' AS DateTime), 28, 23, 49)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (14, CAST(N'2012-12-02T03:57:00.000' AS DateTime), 29, 5, 26)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (15, CAST(N'2019-04-16T06:15:00.000' AS DateTime), 37, 20, 47)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (16, CAST(N'2005-12-26T01:04:00.000' AS DateTime), 38, 12, 21)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (17, CAST(N'2026-09-17T06:59:00.000' AS DateTime), 39, 22, 27)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (18, CAST(N'2005-05-16T12:23:00.000' AS DateTime), 40, 25, 29)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (19, CAST(N'2017-03-31T02:39:00.000' AS DateTime), 42, 33, 2)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (20, CAST(N'2001-09-26T08:42:00.000' AS DateTime), 43, 38, 28)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (21, CAST(N'2028-10-31T17:25:00.000' AS DateTime), 44, 49, 36)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (22, CAST(N'2022-01-21T18:56:00.000' AS DateTime), 47, 2, 27)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (23, CAST(N'2000-07-07T13:14:00.000' AS DateTime), 49, 42, 6)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (24, CAST(N'2019-10-30T16:20:00.000' AS DateTime), 4, 40, 12)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (25, CAST(N'2001-06-11T01:26:00.000' AS DateTime), 5, 13, 8)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (26, CAST(N'1999-05-02T02:57:00.000' AS DateTime), 8, 15, 29)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (27, CAST(N'1995-10-18T09:08:00.000' AS DateTime), 11, 14, 16)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (28, CAST(N'2001-03-18T16:20:00.000' AS DateTime), 13, 37, 12)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (29, CAST(N'2001-07-04T12:23:00.000' AS DateTime), 15, 50, 23)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (30, CAST(N'2025-09-24T13:36:00.000' AS DateTime), 17, 23, 23)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (31, CAST(N'2008-07-27T15:50:00.000' AS DateTime), 18, 26, 30)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (32, CAST(N'2008-06-21T03:23:00.000' AS DateTime), 19, 41, 13)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (33, CAST(N'2019-10-20T06:50:00.000' AS DateTime), 22, 12, 19)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (34, CAST(N'2027-10-15T15:41:00.000' AS DateTime), 23, 22, 42)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (35, CAST(N'2011-07-25T05:24:00.000' AS DateTime), 26, 10, 14)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (36, CAST(N'1999-12-19T00:00:00.000' AS DateTime), 28, 42, 8)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (37, CAST(N'2010-05-06T03:31:00.000' AS DateTime), 29, 16, 41)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (38, CAST(N'2009-10-27T13:45:00.000' AS DateTime), 37, 9, 41)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (39, CAST(N'2017-05-06T09:04:00.000' AS DateTime), 38, 15, 25)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (40, CAST(N'2008-12-26T16:55:00.000' AS DateTime), 39, 43, 40)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (41, CAST(N'2022-09-15T05:06:00.000' AS DateTime), 40, 23, 14)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (42, CAST(N'2014-07-18T07:29:00.000' AS DateTime), 42, 20, 7)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (43, CAST(N'1995-10-23T08:42:00.000' AS DateTime), 43, 20, 41)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (44, CAST(N'2006-11-20T05:36:00.000' AS DateTime), 44, 1, 47)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (45, CAST(N'1995-12-02T05:54:00.000' AS DateTime), 47, 48, 24)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (46, CAST(N'2017-07-12T18:25:00.000' AS DateTime), 49, 29, 50)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (47, CAST(N'2024-10-18T10:52:00.000' AS DateTime), 4, 16, 43)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (48, CAST(N'2008-12-25T12:57:00.000' AS DateTime), 5, 8, 20)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (49, CAST(N'1997-06-23T17:08:00.000' AS DateTime), 8, 7, 30)
INSERT [dbo].[Check] ([IDCheck], [DateOfTheSale], [IDEmployee], [IDClient], [IDEstateObject]) VALUES (50, CAST(N'2007-02-19T06:59:00.000' AS DateTime), 11, 32, 7)
SET IDENTITY_INSERT [dbo].[Check] OFF
GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (1, N'Константинов', N'Матвей', N'Александрович', CAST(N'1982-09-21' AS Date), N'85153127367  ', 1, NULL, NULL, N'SarahAndMorenoCompany', NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (2, N'Коновалов', N'Артур', N'Кириллович', CAST(N'1971-09-12' AS Date), N'86107857394  ', 1, NULL, NULL, N'RogerAndLynchCompany', NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (3, N'Худяков', N'Иван', N'Артёмович', CAST(N'1983-08-18' AS Date), N'83653814430  ', 0, N'1935', N'721143', NULL, N'6478674426', N'664471571', N'2435062066100', N'39323689936478674426', N'5846725664664471571 ', N'388278126', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (4, N'Владимирова', N'Полина', N'Павловна', CAST(N'1988-02-24' AS Date), N'81397898941  ', 1, NULL, NULL, N'JenniferAndHernandezCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (5, N'Полякова', N'Алина', N'Романовна', CAST(N'1989-05-10' AS Date), N'83665536821  ', 0, N'5807', N'314725', NULL, N'8285279298', N'287863619', N'5681507983523', N'17010158818285279298', N'4683684551287863619 ', N'434559752', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (6, N'Яковлева', N'Альбина', N'Данииловна', CAST(N'2005-07-17' AS Date), N'86994952037  ', 0, N'3552', N'106406', NULL, N'1686730131', N'480899551', N'9578486051843', N'38127070651686730131', N'4020262340480899551 ', N'560115986', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (7, N'Ершова', N'София', N'Владимировна', CAST(N'1998-07-09' AS Date), N'84828257844  ', 1, NULL, NULL, N'OlgaAndWhiteCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (8, N'Иванов', N'Арсений', N'Михайлович', CAST(N'1984-09-17' AS Date), N'85017190458  ', 0, N'9706', N'367502', NULL, N'5102995196', N'924374341', N'4459148616857', N'36233565865102995196', N'2161397447924374341 ', N'744304264', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (9, N'Третьякова', N'Таисия', N'Константиновна', CAST(N'2003-05-16' AS Date), N'80215750595  ', 0, N'5048', N'813430', NULL, N'1786036477', N'114032943', N'3999894443947', N'22309758361786036477', N'1727685998114032943 ', N'508816948', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (10, N'Фомина', N'Вера', N'Макаровна', CAST(N'1984-07-10' AS Date), N'85884431802  ', 1, NULL, NULL, N'LindaAndTaylorCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (11, N'Розанов', N'Марк', N'Артёмович', CAST(N'1977-04-27' AS Date), N'83937020301  ', 0, N'3190', N'897014', NULL, N'3925966737', N'492357529', N'1077844660131', N'48280573053925966737', N'2050381825492357529 ', N'169390483', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (12, N'Смирнов', N'Андрей', N'Миронович', CAST(N'2002-10-20' AS Date), N'80789165310  ', 1, NULL, NULL, N'TerryAndSullivanCompany', NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (13, N'Злобина', N'Есения', N'Данииловна', CAST(N'1976-01-10' AS Date), N'84190720145  ', 1, NULL, NULL, N'KellyAndSparksCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (14, N'Миронова', N'София', N'Ярославовна', CAST(N'1995-11-11' AS Date), N'80692066300  ', 1, NULL, NULL, N'CarolAndUnderwoodCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (15, N'Терентьев', N'Виктор', N'Захарович', CAST(N'1998-03-01' AS Date), N'89855696994  ', 1, NULL, NULL, N'JosephineAndMartinCompany', NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (16, N'Белов', N'Владислав', N'Максимович', CAST(N'1975-05-20' AS Date), N'85560446537  ', 0, N'3923', N'362312', NULL, N'3521672515', N'969520958', N'3626161181476', N'29725663633521672515', N'3728212071969520958 ', N'865822037', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (17, N'Михеева', N'Полина', N'Алексеевна', CAST(N'1998-03-06' AS Date), N'87688275471  ', 0, N'2760', N'705788', NULL, N'5386257200', N'798903604', N'3776692534641', N'37312936545386257200', N'7101070959798903604 ', N'318120722', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (18, N'Жилина', N'Милана', N'Константиновна', CAST(N'2003-07-26' AS Date), N'82674380394  ', 1, NULL, NULL, N'HarveyAndRamseyCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (19, N'Яковлев', N'Роман', N'Александрович', CAST(N'2001-06-15' AS Date), N'82028433737  ', 0, N'8167', N'959168', NULL, N'4501398853', N'816032679', N'8214377858781', N'16258455634501398853', N'5011193604816032679 ', N'147859002', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (20, N'Кузнецова', N'Анастасия', N'Львовна', CAST(N'1977-11-26' AS Date), N'89164626489  ', 1, NULL, NULL, N'DorothyAndWardCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (21, N'Филиппова', N'Арина', N'Фёдоровна', CAST(N'2002-09-02' AS Date), N'80007548019  ', 0, N'5493', N'242017', NULL, N'9525179777', N'844588769', N'6444073976561', N'70887044429525179777', N'2396319535844588769 ', N'944839141', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (22, N'Титова', N'Полина', N'Александровна', CAST(N'1977-03-12' AS Date), N'82339974415  ', 1, NULL, NULL, N'ThomasAndFoxCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (23, N'Сергеева', N'Эмилия', N'Арсентьевна', CAST(N'1993-11-15' AS Date), N'82505918426  ', 1, NULL, NULL, N'CynthiaAndMorrisCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (24, N'Александров', N'Михаил', N'Максимович', CAST(N'2002-07-11' AS Date), N'82839736464  ', 0, N'8824', N'990622', NULL, N'1634554035', N'509282841', N'5775659790744', N'76223234561634554035', N'5047012802509282841 ', N'411428249', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (25, N'Смирнова', N'Софья', N'Фёдоровна', CAST(N'1983-07-06' AS Date), N'84016902737  ', 1, NULL, NULL, N'ChristopherAndFlemingCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (26, N'Усов', N'Ярослав', N'Богданович', CAST(N'2000-02-18' AS Date), N'89048237941  ', 1, NULL, NULL, N'SusanAndSnyderCompany', NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (27, N'Зубова', N'Александра', N'Артуровна', CAST(N'1998-01-19' AS Date), N'82978074577  ', 1, NULL, NULL, N'HenryAndBrownCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (28, N'Новиков', N'Лев', N'Артёмович', CAST(N'2003-06-22' AS Date), N'80980581637  ', 1, NULL, NULL, N'MarcusAndBoydCompany', NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (29, N'Кузнецов', N'Егор', N'Максимович', CAST(N'1970-12-25' AS Date), N'85690048843  ', 0, N'2966', N'216607', NULL, N'9710671136', N'149976609', N'8916910960245', N'13425253329710671136', N'4366763579149976609 ', N'924965183', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (30, N'Бородин', N'Эмир', N'Дмитриевич', CAST(N'1999-11-06' AS Date), N'80692713287  ', 0, N'2485', N'273411', NULL, N'5005511522', N'334210667', N'7398720131956', N'49030270765005511522', N'2162052077334210667 ', N'351885932', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (31, N'Князев', N'Михаил', N'Тимурович', CAST(N'1991-04-12' AS Date), N'89581500287  ', 1, NULL, NULL, N'DavidAndStephensCompany', NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (32, N'Кузнецова', N'Софья', N'Максимовна', CAST(N'2004-11-16' AS Date), N'85126968539  ', 1, NULL, NULL, N'AshleyAndWilliamsCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (33, N'Малышева', N'Ясмина', N'Данииловна', CAST(N'1984-08-07' AS Date), N'83295308173  ', 1, NULL, NULL, N'JuliaAndClarkCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (34, N'Смирнова', N'Елизавета', N'Савельевна', CAST(N'1990-07-13' AS Date), N'87397133330  ', 1, NULL, NULL, N'HeidiAndJohnsonCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (35, N'Акимова', N'Таисия', N'Михайловна', CAST(N'1981-06-01' AS Date), N'83604373807  ', 1, NULL, NULL, N'JeffreyAndBrownCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (36, N'Дорофеева', N'Александра', N'Ярославовна', CAST(N'1991-08-03' AS Date), N'88577392780  ', 0, N'8828', N'250131', NULL, N'7190599460', N'852818940', N'5268525964308', N'52367012067190599460', N'5475964205852818940 ', N'733330032', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (37, N'Колосова', N'Василиса', N'Сергеевна', CAST(N'1978-09-25' AS Date), N'85665620817  ', 1, NULL, NULL, N'JudithAndPerryCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (38, N'Захаров', N'Александр', N'Юрьевич', CAST(N'1995-06-26' AS Date), N'89312386662  ', 0, N'4210', N'632674', NULL, N'2877546756', N'396596258', N'2828013836979', N'36848472982877546756', N'2046461447396596258 ', N'472993018', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (39, N'Фадеева', N'Полина', N'Владимировна', CAST(N'2001-07-21' AS Date), N'87002894089  ', 1, NULL, NULL, N'RuthAndChandlerCompany', NULL, NULL, NULL, NULL, NULL, NULL, 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (40, N'Борисов', N'Максим', N'Фёдорович', CAST(N'1995-02-05' AS Date), N'80699613981  ', 0, N'9792', N'409977', NULL, N'8692203940', N'901857214', N'5636654201838', N'96323706578692203940', N'5049268414901857214 ', N'660470074', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (41, N'Воронова', N'Елена', N'Константиновна', CAST(N'1976-07-24' AS Date), N'87218917452  ', 0, N'6473', N'543730', NULL, N'3157789548', N'928609545', N'6092246086407', N'27731011983157789548', N'2819091327928609545 ', N'712754485', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (42, N'Рожкова', N'Камилла', N'Кирилловна', CAST(N'1996-11-20' AS Date), N'83164632689  ', 0, N'9521', N'299545', NULL, N'8181157619', N'489352900', N'7276095493069', N'53758797528181157619', N'2106834640489352900 ', N'550471714', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (43, N'Ситников', N'Тимур', N'Юрьевич', CAST(N'1997-03-22' AS Date), N'88225404705  ', 1, NULL, NULL, N'RuthAndJohnsonCompany', NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (44, N'Ширяев', N'Тимур', N'Матвеевич', CAST(N'1972-01-22' AS Date), N'87070645425  ', 1, NULL, NULL, N'LucilleAndCarlsonCompany', NULL, NULL, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (45, N'Дьякова', N'Евангелина', N'Арсентьевна', CAST(N'1990-08-16' AS Date), N'83183555680  ', 0, N'9085', N'152043', NULL, N'4706332083', N'965369786', N'8489763572283', N'36249109324706332083', N'7777108654965369786 ', N'849408588', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (46, N'Романов', N'Павел', N'Юрьевич', CAST(N'1998-08-02' AS Date), N'85693528915  ', 0, N'7661', N'961998', NULL, N'1227531219', N'348281114', N'4568320417176', N'13560001781227531219', N'2213147715348281114 ', N'436426124', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (47, N'Чернышева', N'Вероника', N'Александровна', CAST(N'1986-09-22' AS Date), N'87838303096  ', 0, N'9679', N'148625', NULL, N'9817945753', N'122111643', N'9621206992796', N'52334713949817945753', N'3118175366122111643 ', N'701173717', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (48, N'Лапшин', N'Алексей', N'Егорович', CAST(N'1991-05-06' AS Date), N'89991052089  ', 0, N'8708', N'181152', NULL, N'3881400198', N'135898209', N'9302128238245', N'48983314933881400198', N'1988112550135898209 ', N'344037505', 1)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (49, N'Чернышева', N'Ангелина', N'Максимовна', CAST(N'1991-06-12' AS Date), N'84523771780  ', 0, N'7177', N'988954', NULL, N'1604008743', N'338077225', N'4904598754516', N'25725479371604008743', N'6606774359338077225 ', N'450859907', 2)
INSERT [dbo].[Client] ([IDClient], [LastName], [FirstName], [Patronymic], [Birthday], [Phone], [IsLegalEntity], [PasportSeries], [PasportNumber], [CompanyTitle], [INN], [KPP], [OGRN], [PaymentAccount], [CorrespondentAccount], [BIK], [IDGender]) VALUES (50, N'Баженов', N'Александр', N'Маркович', CAST(N'1991-01-04' AS Date), N'81065599198  ', 0, N'2875', N'911781', NULL, N'9454397870', N'409381065', N'6982170085258', N'11885573959454397870', N'7243729849409381065 ', N'873315723', 1)
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

INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (1, CAST(561.0000 AS Decimal(14, 4)), CAST(22440000.00 AS Decimal(12, 2)), CAST(N'1991-02-24' AS Date), CAST(N'1993-01-07' AS Date), N'г. Красноярск, ул. Лермонтова, 13, оф. 17', 43, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (2, CAST(9166.0000 AS Decimal(14, 4)), CAST(366640000.00 AS Decimal(12, 2)), CAST(N'2010-04-15' AS Date), CAST(N'2011-08-16' AS Date), N'г. Тольятти, ул. Свердлова, 14, оф. 37', 20, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (3, CAST(236.0000 AS Decimal(14, 4)), CAST(9440000.00 AS Decimal(12, 2)), CAST(N'1993-08-13' AS Date), CAST(N'1996-03-30' AS Date), N'г. Краснодар, ул. Гоголя, 28, оф. 65', 23, 3, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (4, CAST(3124.0000 AS Decimal(14, 4)), CAST(124960000.00 AS Decimal(12, 2)), CAST(N'2013-08-24' AS Date), CAST(N'2016-04-18' AS Date), N'г. Тольятти, ул. Степная, 41, оф. 54', 26, 2, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (5, CAST(3343.0000 AS Decimal(14, 4)), CAST(133720000.00 AS Decimal(12, 2)), CAST(N'2021-11-25' AS Date), CAST(N'2024-03-26' AS Date), N'г. Екатеринбург, ул. Энергетиков, 33, оф. 85', 5, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (6, CAST(9637.0000 AS Decimal(14, 4)), CAST(385480000.00 AS Decimal(12, 2)), CAST(N'1998-07-01' AS Date), CAST(N'1999-12-04' AS Date), N'г. Саратов, ул. Фрунзе, 11, оф. 74', 49, 1, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (7, CAST(9614.0000 AS Decimal(14, 4)), CAST(384560000.00 AS Decimal(12, 2)), CAST(N'2007-05-21' AS Date), CAST(N'2009-02-04' AS Date), N'г. Ростов-на-Дону, ул. Южная, 30, оф. 5', 44, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (8, CAST(3121.0000 AS Decimal(14, 4)), CAST(124840000.00 AS Decimal(12, 2)), CAST(N'2008-06-12' AS Date), CAST(N'2009-08-07' AS Date), N'г. Уфа, ул. Пролетарская, 29, оф. 88', 8, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (9, CAST(5705.0000 AS Decimal(14, 4)), CAST(228200000.00 AS Decimal(12, 2)), CAST(N'1997-10-26' AS Date), CAST(N'1999-09-05' AS Date), N'г. Нижний Новгород, ул. Молодежная, 12, оф. 44', 13, 1, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (10, CAST(4399.0000 AS Decimal(14, 4)), CAST(175960000.00 AS Decimal(12, 2)), CAST(N'2015-05-09' AS Date), CAST(N'2017-04-15' AS Date), N'г. Уфа, ул. Дорожная, 41, оф. 18', 46, 1, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (11, CAST(3260.0000 AS Decimal(14, 4)), CAST(130400000.00 AS Decimal(12, 2)), CAST(N'1992-04-24' AS Date), CAST(N'1993-06-04' AS Date), N'г. Санкт-Петербург, ул. Садовая, 37, оф. 43', 43, 2, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (12, CAST(1793.0000 AS Decimal(14, 4)), CAST(71720000.00 AS Decimal(12, 2)), CAST(N'2012-09-13' AS Date), CAST(N'2015-01-25' AS Date), N'г. Красноярск, ул. Молодежная, 6, оф. 70', 2, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (13, CAST(717.0000 AS Decimal(14, 4)), CAST(28680000.00 AS Decimal(12, 2)), CAST(N'2003-10-23' AS Date), CAST(N'2005-09-08' AS Date), N'г. Уфа, ул. Школьная, 39, оф. 100', 27, 3, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (14, CAST(6807.0000 AS Decimal(14, 4)), CAST(272280000.00 AS Decimal(12, 2)), CAST(N'2008-03-18' AS Date), CAST(N'2010-06-08' AS Date), N'г. Омск, ул. Зеленая, 38, оф. 91', 33, 3, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (15, CAST(4684.0000 AS Decimal(14, 4)), CAST(187360000.00 AS Decimal(12, 2)), CAST(N'2015-12-17' AS Date), CAST(N'2018-04-08' AS Date), N'г. Саратов, ул. Строительная, 37, оф. 23', 23, 2, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (16, CAST(7784.0000 AS Decimal(14, 4)), CAST(311360000.00 AS Decimal(12, 2)), CAST(N'2003-01-23' AS Date), CAST(N'2004-12-30' AS Date), N'г. Тюмень, ул. Матросова, 37, оф. 43', 28, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (17, CAST(1540.0000 AS Decimal(14, 4)), CAST(61600000.00 AS Decimal(12, 2)), CAST(N'2023-09-15' AS Date), CAST(N'2025-05-18' AS Date), N'г. Тольятти, ул. Парковая, 37, оф. 4', 6, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (18, CAST(4717.0000 AS Decimal(14, 4)), CAST(188680000.00 AS Decimal(12, 2)), CAST(N'2003-09-04' AS Date), CAST(N'2004-12-01' AS Date), N'г. Уфа, ул. Фрунзе, 24, оф. 77', 13, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (19, CAST(555.0000 AS Decimal(14, 4)), CAST(22200000.00 AS Decimal(12, 2)), CAST(N'2015-01-20' AS Date), CAST(N'2016-09-13' AS Date), N'г. Пермь, ул. Дорожная, 7, оф. 78', 37, 3, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (20, CAST(3220.0000 AS Decimal(14, 4)), CAST(128800000.00 AS Decimal(12, 2)), CAST(N'1998-02-05' AS Date), CAST(N'1999-09-27' AS Date), N'г. Казань, ул. Родниковая, 35, оф. 26', 49, 3, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (21, CAST(7328.0000 AS Decimal(14, 4)), CAST(293120000.00 AS Decimal(12, 2)), CAST(N'2024-06-06' AS Date), CAST(N'2026-07-28' AS Date), N'г. Екатеринбург, ул. Заводская, 27, оф. 86', 38, 2, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (22, CAST(5828.0000 AS Decimal(14, 4)), CAST(233120000.00 AS Decimal(12, 2)), CAST(N'2019-05-19' AS Date), CAST(N'2021-09-10' AS Date), N'г. Нижний Новгород, ул. Красная, 17, оф. 29', 12, 2, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (23, CAST(2561.0000 AS Decimal(14, 4)), CAST(102440000.00 AS Decimal(12, 2)), CAST(N'1998-02-19' AS Date), CAST(N'1999-08-16' AS Date), N'г. Ростов-на-Дону, ул. Верхняя, 14, оф. 47', 15, 3, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (24, CAST(9838.0000 AS Decimal(14, 4)), CAST(393520000.00 AS Decimal(12, 2)), CAST(N'2017-07-02' AS Date), CAST(N'2018-09-11' AS Date), N'г. Краснодар, ул. Железнодорожная, 32, оф. 97', 50, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (25, CAST(8313.0000 AS Decimal(14, 4)), CAST(332520000.00 AS Decimal(12, 2)), CAST(N'1996-07-07' AS Date), CAST(N'1999-03-06' AS Date), N'г. Тюмень, ул. 1 Мая, 45, оф. 60', 38, 3, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (26, CAST(4595.0000 AS Decimal(14, 4)), CAST(183800000.00 AS Decimal(12, 2)), CAST(N'1996-07-27' AS Date), CAST(N'1998-09-13' AS Date), N'г. Волгоград, ул. Вишневая, 32, оф. 66', 16, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (27, CAST(7541.0000 AS Decimal(14, 4)), CAST(301640000.00 AS Decimal(12, 2)), CAST(N'1993-01-24' AS Date), CAST(N'1994-04-02' AS Date), N'г. Пермь, ул. Труда, 1, оф. 25', 34, 3, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (28, CAST(2642.0000 AS Decimal(14, 4)), CAST(105680000.00 AS Decimal(12, 2)), CAST(N'1996-12-20' AS Date), CAST(N'1998-06-26' AS Date), N'г. Москва, ул. Сосновая, 34, оф. 61', 11, 3, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (29, CAST(4419.0000 AS Decimal(14, 4)), CAST(176760000.00 AS Decimal(12, 2)), CAST(N'1998-05-15' AS Date), CAST(N'2000-10-20' AS Date), N'г. Краснодар, ул. Свободы, 17, оф. 33', 22, 1, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (30, CAST(1561.0000 AS Decimal(14, 4)), CAST(62440000.00 AS Decimal(12, 2)), CAST(N'2021-08-06' AS Date), CAST(N'2023-07-27' AS Date), N'г. Ижевск, ул. Нагорная, 33, оф. 38', 47, 3, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (31, CAST(4405.0000 AS Decimal(14, 4)), CAST(176200000.00 AS Decimal(12, 2)), CAST(N'2006-01-21' AS Date), CAST(N'2008-01-07' AS Date), N'г. Челябинск, ул. Светлая, 8, оф. 10', 41, 3, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (32, CAST(5136.0000 AS Decimal(14, 4)), CAST(205440000.00 AS Decimal(12, 2)), CAST(N'2005-09-09' AS Date), CAST(N'2008-01-12' AS Date), N'г. Москва, ул. Овражная, 13, оф. 8', 4, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (33, CAST(6377.0000 AS Decimal(14, 4)), CAST(255080000.00 AS Decimal(12, 2)), CAST(N'2015-08-27' AS Date), CAST(N'2017-10-29' AS Date), N'г. Красноярск, ул. Цветочная, 34, оф. 26', 28, 3, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (34, CAST(6162.0000 AS Decimal(14, 4)), CAST(246480000.00 AS Decimal(12, 2)), CAST(N'2024-09-06' AS Date), CAST(N'2025-12-09' AS Date), N'г. Тольятти, ул. Нагорная, 48, оф. 78', 30, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (35, CAST(3846.0000 AS Decimal(14, 4)), CAST(153840000.00 AS Decimal(12, 2)), CAST(N'2009-04-16' AS Date), CAST(N'2010-06-30' AS Date), N'г. Москва, ул. Клубная, 49, оф. 50', 10, 1, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (36, CAST(8654.0000 AS Decimal(14, 4)), CAST(346160000.00 AS Decimal(12, 2)), CAST(N'1997-09-28' AS Date), CAST(N'1999-01-13' AS Date), N'г. Омск, ул. Лесная, 29, оф. 65', 15, 3, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (37, CAST(3095.0000 AS Decimal(14, 4)), CAST(123800000.00 AS Decimal(12, 2)), CAST(N'2007-07-26' AS Date), CAST(N'2009-07-04' AS Date), N'г. Ижевск, ул. Московская, 39, оф. 100', 25, 3, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (38, CAST(1787.0000 AS Decimal(14, 4)), CAST(71480000.00 AS Decimal(12, 2)), CAST(N'2005-08-13' AS Date), CAST(N'2007-11-29' AS Date), N'г. Санкт-Петербург, ул. Строительная, 18, оф. 5', 3, 3, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (39, CAST(5438.0000 AS Decimal(14, 4)), CAST(217520000.00 AS Decimal(12, 2)), CAST(N'2012-11-04' AS Date), CAST(N'2015-06-19' AS Date), N'г. Самара, ул. Зеленая, 43, оф. 25', 7, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (40, CAST(6914.0000 AS Decimal(14, 4)), CAST(276560000.00 AS Decimal(12, 2)), CAST(N'2005-04-07' AS Date), CAST(N'2007-04-24' AS Date), N'г. Москва, ул. Дорожная, 46, оф. 48', 50, 1, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (41, CAST(3425.0000 AS Decimal(14, 4)), CAST(137000000.00 AS Decimal(12, 2)), CAST(N'2020-11-19' AS Date), CAST(N'2021-12-10' AS Date), N'г. Екатеринбург, ул. Строителей, 48, оф. 27', 46, 2, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (42, CAST(5614.0000 AS Decimal(14, 4)), CAST(224560000.00 AS Decimal(12, 2)), CAST(N'2011-09-08' AS Date), CAST(N'2012-11-11' AS Date), N'г. Екатеринбург, ул. Родниковая, 22, оф. 30', 45, 3, 1)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (43, CAST(5406.0000 AS Decimal(14, 4)), CAST(216240000.00 AS Decimal(12, 2)), CAST(N'1992-06-23' AS Date), CAST(N'1993-11-21' AS Date), N'г. Екатеринбург, ул. Речная, 10, оф. 94', 39, 3, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (44, CAST(395.0000 AS Decimal(14, 4)), CAST(15800000.00 AS Decimal(12, 2)), CAST(N'2004-07-02' AS Date), CAST(N'2005-10-10' AS Date), N'г. Казань, ул. Коммунистическая, 31, оф. 69', 12, 2, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (45, CAST(4443.0000 AS Decimal(14, 4)), CAST(177720000.00 AS Decimal(12, 2)), CAST(N'1991-01-14' AS Date), CAST(N'1993-06-06' AS Date), N'г. Краснодар, ул. Чкалова, 39, оф. 87', 26, 3, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (46, CAST(5090.0000 AS Decimal(14, 4)), CAST(203600000.00 AS Decimal(12, 2)), CAST(N'2014-01-10' AS Date), CAST(N'2016-06-29' AS Date), N'г. Новосибирск, ул. Комарова, 8, оф. 44', 5, 2, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (47, CAST(947.0000 AS Decimal(14, 4)), CAST(37880000.00 AS Decimal(12, 2)), CAST(N'2021-04-19' AS Date), CAST(N'2022-09-01' AS Date), N'г. Москва, ул. Комарова, 32, оф. 7', 14, 2, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (48, CAST(381.0000 AS Decimal(14, 4)), CAST(15240000.00 AS Decimal(12, 2)), CAST(N'2004-03-21' AS Date), CAST(N'2006-11-20' AS Date), N'г. Ижевск, ул. Трактовая, 28, оф. 42', 38, 1, 3)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (49, CAST(981.0000 AS Decimal(14, 4)), CAST(39240000.00 AS Decimal(12, 2)), CAST(N'1993-09-08' AS Date), CAST(N'1996-04-22' AS Date), N'г. Самара, ул. Совхозная, 29, оф. 47', 45, 2, 2)
INSERT [dbo].[EstateObject] ([IDEstateObject], [Square], [Price], [DateOfDefinition], [DateOfApplication], [Adress], [IDPostIndex], [IDTypeOfActivity], [IDFormat]) VALUES (50, CAST(2049.0000 AS Decimal(14, 4)), CAST(81960000.00 AS Decimal(12, 2)), CAST(N'2004-05-19' AS Date), CAST(N'2006-07-11' AS Date), N'г. Самара, ул. Молодежная, 26, оф. 24', 13, 2, 1)
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
INSERT [dbo].[EstateRelation] ([IDEstateRelation], [IDPlaceEstate], [IDBuildingEstate]) VALUES (11, 17, 50)
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
ALTER TABLE [dbo].[EstateObject]  WITH CHECK ADD  CONSTRAINT [FK_EstateObject_Postindex] FOREIGN KEY([IDPostIndex])
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
