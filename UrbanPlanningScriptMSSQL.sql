USE [UrbanPlanning]
GO
/****** Object:  Table [dbo].[Check]    Script Date: 30.01.2024 14:31:52 ******/
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
/****** Object:  Table [dbo].[CheckEstate]    Script Date: 30.01.2024 14:31:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckEstate](
	[IDCheckEstate] [int] IDENTITY(1,1) NOT NULL,
	[IDEstateObject] [int] NOT NULL,
	[IDCheck] [int] NOT NULL,
 CONSTRAINT [PK_CheckEstate] PRIMARY KEY CLUSTERED 
(
	[IDCheckEstate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 30.01.2024 14:31:52 ******/
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
/****** Object:  Table [dbo].[Employee]    Script Date: 30.01.2024 14:31:52 ******/
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
/****** Object:  Table [dbo].[EstateObject]    Script Date: 30.01.2024 14:31:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstateObject](
	[IDEstateObject] [int] IDENTITY(1,1) NOT NULL,
	[Square] [decimal](14, 4) NOT NULL,
	[Price] [decimal](12, 2) NOT NULL,
	[DateOfDefinition] [datetime] NOT NULL,
	[DateOfApplication] [datetime] NOT NULL,
	[Adress] [nvarchar](50) NOT NULL,
	[IDLayoutEstate] [int] NOT NULL,
	[IDPostIndex] [int] NOT NULL,
	[IDTypeOfActivity] [int] NOT NULL,
	[IDFormat] [int] NOT NULL,
 CONSTRAINT [PK_EstateObject] PRIMARY KEY CLUSTERED 
(
	[IDEstateObject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstatePhoto]    Script Date: 30.01.2024 14:31:52 ******/
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
/****** Object:  Table [dbo].[EstateRelation]    Script Date: 30.01.2024 14:31:52 ******/
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
/****** Object:  Table [dbo].[FlatRelation]    Script Date: 30.01.2024 14:31:52 ******/
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
/****** Object:  Table [dbo].[Format]    Script Date: 30.01.2024 14:31:52 ******/
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
/****** Object:  Table [dbo].[Gender]    Script Date: 30.01.2024 14:31:52 ******/
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
/****** Object:  Table [dbo].[Post]    Script Date: 30.01.2024 14:31:52 ******/
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
/****** Object:  Table [dbo].[Postindex]    Script Date: 30.01.2024 14:31:52 ******/
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
/****** Object:  Table [dbo].[TypeOfActivity]    Script Date: 30.01.2024 14:31:52 ******/
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
