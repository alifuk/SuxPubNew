USE [master]
GO
/****** Object:  Database [suxpub]    Script Date: 16. 9. 2014 15:05:56 ******/
CREATE DATABASE [suxpub]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'suxpub', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\suxpub.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'suxpub_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\suxpub_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [suxpub] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [suxpub].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [suxpub] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [suxpub] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [suxpub] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [suxpub] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [suxpub] SET ARITHABORT OFF 
GO
ALTER DATABASE [suxpub] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [suxpub] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [suxpub] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [suxpub] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [suxpub] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [suxpub] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [suxpub] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [suxpub] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [suxpub] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [suxpub] SET  DISABLE_BROKER 
GO
ALTER DATABASE [suxpub] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [suxpub] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [suxpub] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [suxpub] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [suxpub] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [suxpub] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [suxpub] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [suxpub] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [suxpub] SET  MULTI_USER 
GO
ALTER DATABASE [suxpub] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [suxpub] SET DB_CHAINING OFF 
GO
ALTER DATABASE [suxpub] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [suxpub] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [suxpub] SET DELAYED_DURABILITY = DISABLED 
GO
USE [suxpub]
GO
/****** Object:  Table [dbo].[Atrakce]    Script Date: 16. 9. 2014 15:05:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Atrakce](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nazev] [nvarchar](50) NULL,
	[smazano] [int] NOT NULL CONSTRAINT [DF_Atrakce_smazano]  DEFAULT ((0)),
 CONSTRAINT [PK_Atrakce] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AtrakceCon]    Script Date: 16. 9. 2014 15:05:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AtrakceCon](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[atrakceId] [int] NOT NULL,
	[pubId] [int] NOT NULL,
	[poznamka] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Lokace]    Script Date: 16. 9. 2014 15:05:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lokace](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nazev] [nvarchar](50) NULL,
	[smazano] [int] NOT NULL CONSTRAINT [DF_Lokace_smazano]  DEFAULT ((0)),
 CONSTRAINT [PK_Lokace] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Piva]    Script Date: 16. 9. 2014 15:05:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Piva](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nazev] [nvarchar](50) NULL,
	[smazano] [int] NOT NULL CONSTRAINT [DF_Piva_smazano]  DEFAULT ((0)),
 CONSTRAINT [PK_Piva] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PivaCon]    Script Date: 16. 9. 2014 15:05:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PivaCon](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[pubId] [int] NOT NULL,
	[pivoId] [int] NOT NULL,
	[cena] [decimal](6, 2) NULL,
 CONSTRAINT [PK_PivaCon] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pub]    Script Date: 16. 9. 2014 15:05:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pub](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nazev] [nvarchar](50) NULL,
	[adresa] [nvarchar](50) NULL,
	[prostornost] [nvarchar](50) NULL,
	[lokace] [int] NULL,
	[hodnoceni] [int] NULL,
	[obsluha] [nvarchar](50) NULL,
	[poznamka] [nvarchar](max) NULL,
	[navstevnici] [nvarchar](max) NULL,
	[prostredi] [int] NULL,
	[gpsN] [decimal](10, 7) NULL,
	[gpsE] [decimal](10, 7) NULL,
	[datumPridani] [datetime] NULL CONSTRAINT [DF_Pub_datumPridani]  DEFAULT (getdate()),
	[smazano] [int] NULL CONSTRAINT [DF_Pub_smazano]  DEFAULT ((0)),
	[odUzivatele] [int] NULL,
 CONSTRAINT [PK_Pub] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Atrakce] ON 

INSERT [dbo].[Atrakce] ([Id], [nazev], [smazano]) VALUES (1, N'Billiárd (díry)', 0)
INSERT [dbo].[Atrakce] ([Id], [nazev], [smazano]) VALUES (2, N'Šipky', 0)
INSERT [dbo].[Atrakce] ([Id], [nazev], [smazano]) VALUES (3, N'Automaty', 0)
INSERT [dbo].[Atrakce] ([Id], [nazev], [smazano]) VALUES (5, N'Fotbálek', 0)
INSERT [dbo].[Atrakce] ([Id], [nazev], [smazano]) VALUES (6, N'Bowling', 0)
INSERT [dbo].[Atrakce] ([Id], [nazev], [smazano]) VALUES (7, N'Dobré parkování', 0)
INSERT [dbo].[Atrakce] ([Id], [nazev], [smazano]) VALUES (8, N'Zahrádka', 0)
INSERT [dbo].[Atrakce] ([Id], [nazev], [smazano]) VALUES (9, N'Televize', 0)
INSERT [dbo].[Atrakce] ([Id], [nazev], [smazano]) VALUES (10, N'Stůl na poker', 0)
INSERT [dbo].[Atrakce] ([Id], [nazev], [smazano]) VALUES (11, N'Plátno', 0)
INSERT [dbo].[Atrakce] ([Id], [nazev], [smazano]) VALUES (12, N'Kulečník(bez děr)', 0)
INSERT [dbo].[Atrakce] ([Id], [nazev], [smazano]) VALUES (13, N'Wi-fi', 0)
INSERT [dbo].[Atrakce] ([Id], [nazev], [smazano]) VALUES (14, N'Jukebox', 0)
SET IDENTITY_INSERT [dbo].[Atrakce] OFF
SET IDENTITY_INSERT [dbo].[AtrakceCon] ON 

INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (3, 2, 9, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (4, 2, 10, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (5, 3, 9, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (319, 2, 18, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (320, 5, 18, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (321, 9, 18, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (322, 13, 18, N'heslo: jardajagr   v zadni casti slaba wifi')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (323, 14, 18, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (6, 3, 10, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (42, 1, 11, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (43, 2, 11, N'ROZBITÝ')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (44, 7, 11, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (52, 3, 13, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (353, 2, 8, N'supeeer')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (354, 3, 8, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (355, 7, 8, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (102, 3, 14, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (103, 5, 14, N'zapraseny ale zdarma')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (104, 7, 14, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (105, 8, 14, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (106, 9, 14, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (107, 10, 14, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (385, 1, 16, N'cerne tago, nejlepsi tago v lipe')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (386, 2, 16, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (387, 3, 16, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (388, 5, 16, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (389, 6, 16, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (390, 7, 16, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (391, 9, 16, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (392, 11, 16, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (393, 12, 16, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (340, 2, 17, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (341, 5, 17, N'desetikoruna jedenact micku')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (342, 13, 17, N'heslo: chlastej123')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (343, 14, 17, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (424, 1, 19, N'trosicku krivej')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (425, 2, 19, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (426, 3, 19, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (427, 5, 19, N'napiču')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (428, 7, 19, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (429, 8, 19, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (430, 9, 19, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (431, 10, 19, N'cashovka, turnaje. tady ti jede')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (432, 13, 19, N'heslo: poker903')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (433, 14, 19, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (276, 8, 12, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (277, 9, 12, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (278, 14, 12, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (371, 1, 29, N'chybí koule ')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (372, 6, 29, N'chybí kužekly')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (373, 7, 29, N'5kč za 2 hodiny')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (374, 13, 29, N'nepřipojí se s windows XP / WPA')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (375, 14, 29, N'nemaj tam kabáty')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (440, 3, 15, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (441, 7, 15, N'přes den placené')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (442, 8, 15, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (443, 9, 15, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (444, 11, 15, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (445, 13, 15, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (452, 3, 31, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (453, 5, 31, N'zaprasený, ale zdarma!!')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (454, 7, 31, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (455, 8, 31, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (456, 9, 31, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (457, 10, 31, N'')
SET IDENTITY_INSERT [dbo].[AtrakceCon] OFF
SET IDENTITY_INSERT [dbo].[Lokace] ON 

INSERT [dbo].[Lokace] ([Id], [nazev], [smazano]) VALUES (1, N'Centrum', 0)
INSERT [dbo].[Lokace] ([Id], [nazev], [smazano]) VALUES (2, N'Svárov', 0)
INSERT [dbo].[Lokace] ([Id], [nazev], [smazano]) VALUES (1003, N'Sever', 0)
INSERT [dbo].[Lokace] ([Id], [nazev], [smazano]) VALUES (1004, N'Špičák', 0)
INSERT [dbo].[Lokace] ([Id], [nazev], [smazano]) VALUES (1005, N'Jiná lokace', 0)
SET IDENTITY_INSERT [dbo].[Lokace] OFF
SET IDENTITY_INSERT [dbo].[Piva] ON 

INSERT [dbo].[Piva] ([Id], [nazev], [smazano]) VALUES (1, N'Svijany', 0)
INSERT [dbo].[Piva] ([Id], [nazev], [smazano]) VALUES (2, N'Plzeň', 0)
INSERT [dbo].[Piva] ([Id], [nazev], [smazano]) VALUES (3, N'Podkováň', 0)
INSERT [dbo].[Piva] ([Id], [nazev], [smazano]) VALUES (6, N'Březňák', 0)
INSERT [dbo].[Piva] ([Id], [nazev], [smazano]) VALUES (7, N'Gambrinus', 0)
INSERT [dbo].[Piva] ([Id], [nazev], [smazano]) VALUES (11, N'Kozel', 0)
INSERT [dbo].[Piva] ([Id], [nazev], [smazano]) VALUES (12, N'Kofola', 0)
INSERT [dbo].[Piva] ([Id], [nazev], [smazano]) VALUES (15, N'Prazdroj', 0)
INSERT [dbo].[Piva] ([Id], [nazev], [smazano]) VALUES (16, N'Březňák tankový', 0)
INSERT [dbo].[Piva] ([Id], [nazev], [smazano]) VALUES (17, N'Postřižiny', 0)
SET IDENTITY_INSERT [dbo].[Piva] OFF
SET IDENTITY_INSERT [dbo].[PivaCon] ON 

INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (11, 8, 7, CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (15, 11, 11, CAST(25.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (16, 8, 6, CAST(22.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (17, 14, 11, CAST(22.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (18, 14, 7, CAST(22.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (19, 15, 2, CAST(37.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (20, 15, 7, CAST(29.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (21, 16, 6, CAST(25.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (22, 16, 7, CAST(25.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (23, 16, 15, CAST(35.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (24, 17, 11, CAST(22.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (25, 18, 2, CAST(32.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (26, 18, 1, CAST(23.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (27, 19, 6, CAST(21.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (28, 19, 16, CAST(23.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (29, 12, 17, CAST(0.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (30, 29, 3, CAST(15.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (31, 29, 12, CAST(18.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (32, 29, 1, CAST(10.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (33, 31, 11, CAST(22.00 AS Decimal(6, 2)))
INSERT [dbo].[PivaCon] ([Id], [pubId], [pivoId], [cena]) VALUES (34, 31, 7, CAST(22.00 AS Decimal(6, 2)))
SET IDENTITY_INSERT [dbo].[PivaCon] OFF
SET IDENTITY_INSERT [dbo].[Pub] ON 

INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (8, N'U dědka', N'Roháče z Dubé', N'Prostorné', 1, 3, N'4', N'Místo kam jít na kulečník', N'Ranní nasávači, automatovci', 2, CAST(50.6884867 AS Decimal(10, 7)), CAST(14.5361225 AS Decimal(10, 7)), NULL, 0, 0)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (11, N'Little Saigon', N'U Synagogy 3001 47001 Česká Lípa', N'Normální', 1, 3, N'4', N'Super na jídlo', N'Střední třída', 3, CAST(50.6849406 AS Decimal(10, 7)), CAST(14.5410411 AS Decimal(10, 7)), NULL, 0, 0)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (12, N'Hospůdka u Viťulína (Lékárna)', N'U Rybníčku 1130/5', N'Normální', 2, 3, N'4', NULL, N'Cykliste a ranni nasavaci', 2, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (15, N'Bohemia', NULL, N'Stísněné', 1, 5, N'4', NULL, N'Střední vyšší třída', 4, NULL, NULL, CAST(N'2014-09-11 10:39:07.227' AS DateTime), 0, 0)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (16, N'Honda', N'Hrnčířská', N'Normální', 1, 3, N'2', N'Vyborny ovocny birrel', N'tradicni kurak', 2, NULL, NULL, CAST(N'2014-09-10 12:44:54.460' AS DateTime), 0, 0)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (17, N'U Prasíka', NULL, N'Stísněné', 1, 4, N'5', N'Rodinna hospudka mensi kapacity, s chapavou rychlou a starostlivou obsluhou, ktera vas obsluhuje srdcem a s laskou. Nikdo se tu nehada a je zde citit poklidna privetiva atmosfera.Vymalovano, tak se tu clovek neciti jako v komunismu. Tady se mi libi.', N'vysokoskolsti filozofove, programatori', 3, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (18, N'Dno Pytle', N'Zámecká 74', N'Stísněné', 1, 4, N'4', N'Velký výber rumů, výtečně natočené svijany.', N'stredni trida, ', 3, CAST(50.6853903 AS Decimal(10, 7)), CAST(14.5388003 AS Decimal(10, 7)), NULL, 0, 0)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (19, N'Centrál', NULL, N'Prostorné', 1, 2, N'3', NULL, NULL, 2, NULL, NULL, CAST(N'2014-09-10 12:48:22.133' AS DateTime), 0, 0)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (29, N'U Mourovatého Evžena', NULL, N'Stísněné', 1003, 2, N'3', N'Nepříjemná servírka', N'Lidi kteří maji rádi kočky.', 4, NULL, NULL, CAST(N'2014-09-08 13:52:36.540' AS DateTime), 0, 0)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (30, NULL, NULL, N'Normální', 1, 1, N'1', NULL, NULL, 1, NULL, NULL, CAST(N'2014-09-11 13:47:11.277' AS DateTime), 0, 1)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (31, N'Herna bar Hong Kong 3', NULL, N'Normální', 1003, 3, N'3', NULL, NULL, 1, NULL, NULL, CAST(N'2014-09-11 15:20:37.530' AS DateTime), 0, 0)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (32, NULL, NULL, N'Normální', 1, 1, N'1', NULL, NULL, 1, NULL, NULL, CAST(N'2014-09-16 09:48:42.367' AS DateTime), 0, 1)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (33, NULL, NULL, N'Normální', 1, 1, N'1', NULL, NULL, 1, NULL, NULL, CAST(N'2014-09-16 09:52:44.713' AS DateTime), 0, 1)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano], [odUzivatele]) VALUES (34, NULL, NULL, N'Normální', 1, 1, N'1', NULL, NULL, 1, NULL, NULL, CAST(N'2014-09-16 12:15:03.540' AS DateTime), 0, 1)
SET IDENTITY_INSERT [dbo].[Pub] OFF
ALTER TABLE [dbo].[Pub]  WITH CHECK ADD  CONSTRAINT [FK_Pub_Lokace] FOREIGN KEY([lokace])
REFERENCES [dbo].[Lokace] ([Id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Pub] CHECK CONSTRAINT [FK_Pub_Lokace]
GO
USE [master]
GO
ALTER DATABASE [suxpub] SET  READ_WRITE 
GO
