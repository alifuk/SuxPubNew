USE [master]
GO
/****** Object:  Database [suxpub]    Script Date: 8. 9. 2014 0:31:10 ******/
CREATE DATABASE [suxpub]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'suxpub', FILENAME = N'C:\Users\amdal_000\suxpub.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'suxpub_log', FILENAME = N'C:\Users\amdal_000\suxpub_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
ALTER DATABASE [suxpub] SET AUTO_CREATE_STATISTICS ON 
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
USE [suxpub]
GO
/****** Object:  Table [dbo].[Atrakce]    Script Date: 8. 9. 2014 0:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Atrakce](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nazev] [nvarchar](50) NULL,
 CONSTRAINT [PK_Atrakce] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AtrakceCon]    Script Date: 8. 9. 2014 0:31:10 ******/
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
/****** Object:  Table [dbo].[Lokace]    Script Date: 8. 9. 2014 0:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lokace](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nazev] [nvarchar](50) NULL,
 CONSTRAINT [PK_Lokace] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Piva]    Script Date: 8. 9. 2014 0:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Piva](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nazev] [nvarchar](50) NULL,
 CONSTRAINT [PK_Piva] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PivaCon]    Script Date: 8. 9. 2014 0:31:10 ******/
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
/****** Object:  Table [dbo].[Pub]    Script Date: 8. 9. 2014 0:31:10 ******/
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
	[datumPridani] [datetime] NULL,
	[smazano] [int] NULL,
 CONSTRAINT [PK_Pub] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Atrakce] ON 

INSERT [dbo].[Atrakce] ([Id], [nazev]) VALUES (1, N'Kulečník')
INSERT [dbo].[Atrakce] ([Id], [nazev]) VALUES (2, N'Šipky')
INSERT [dbo].[Atrakce] ([Id], [nazev]) VALUES (3, N'Automaty')
INSERT [dbo].[Atrakce] ([Id], [nazev]) VALUES (5, N'Fotbálek')
INSERT [dbo].[Atrakce] ([Id], [nazev]) VALUES (6, N'Bowling')
INSERT [dbo].[Atrakce] ([Id], [nazev]) VALUES (7, N'Dobré parkování')
INSERT [dbo].[Atrakce] ([Id], [nazev]) VALUES (8, N'Zahrádka')
INSERT [dbo].[Atrakce] ([Id], [nazev]) VALUES (9, N'televize')
INSERT [dbo].[Atrakce] ([Id], [nazev]) VALUES (10, N'pokerovy stul')
INSERT [dbo].[Atrakce] ([Id], [nazev]) VALUES (11, N'platno')
INSERT [dbo].[Atrakce] ([Id], [nazev]) VALUES (12, N'billiard')
INSERT [dbo].[Atrakce] ([Id], [nazev]) VALUES (13, N'wifi')
INSERT [dbo].[Atrakce] ([Id], [nazev]) VALUES (14, N'jukebox')
SET IDENTITY_INSERT [dbo].[Atrakce] OFF
SET IDENTITY_INSERT [dbo].[AtrakceCon] ON 

INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (3, 2, 9, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (4, 2, 10, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (5, 3, 9, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (268, 2, 18, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (269, 5, 18, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (270, 9, 18, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (271, 13, 18, N'heslo: jardajagr   v zadni casti slaba wifi')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (272, 14, 18, N'')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (6, 3, 10, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (42, 1, 11, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (43, 2, 11, N'ROZBITÝ')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (44, 7, 11, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (52, 3, 13, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (59, 2, 8, N'supeer')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (60, 3, 8, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (61, 7, 8, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (102, 3, 14, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (103, 5, 14, N'zapraseny ale zdarma')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (104, 7, 14, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (105, 8, 14, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (106, 9, 14, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (107, 10, 14, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (131, 3, 15, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (132, 7, 15, N'placené')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (133, 8, 15, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (134, 9, 15, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (135, 11, 15, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (170, 1, 16, N'cerne tago, nejlepsi tago v lipe')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (171, 2, 16, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (172, 3, 16, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (173, 5, 16, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (174, 6, 16, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (175, 7, 16, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (176, 9, 16, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (177, 11, 16, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (178, 12, 16, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (199, 2, 17, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (200, 5, 17, N'desetikoruna jedenact micku')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (201, 13, 17, N'heslo: chlastej123')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (202, 14, 17, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (243, 1, 19, N'trosicku krivej')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (244, 2, 19, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (245, 3, 19, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (246, 5, 19, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (247, 7, 19, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (248, 8, 19, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (249, 9, 19, NULL)
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (250, 10, 19, N'cashovka, turnaje. tady ti jede')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (251, 13, 19, N'heslo: poker903')
INSERT [dbo].[AtrakceCon] ([Id], [atrakceId], [pubId], [poznamka]) VALUES (252, 14, 19, NULL)
SET IDENTITY_INSERT [dbo].[AtrakceCon] OFF
SET IDENTITY_INSERT [dbo].[Lokace] ON 

INSERT [dbo].[Lokace] ([Id], [nazev]) VALUES (1, N'Centrum')
INSERT [dbo].[Lokace] ([Id], [nazev]) VALUES (2, N'Svárov')
INSERT [dbo].[Lokace] ([Id], [nazev]) VALUES (1003, N'Sever')
INSERT [dbo].[Lokace] ([Id], [nazev]) VALUES (1004, N'Špičák')
SET IDENTITY_INSERT [dbo].[Lokace] OFF
SET IDENTITY_INSERT [dbo].[Piva] ON 

INSERT [dbo].[Piva] ([Id], [nazev]) VALUES (1, N'Svijany')
INSERT [dbo].[Piva] ([Id], [nazev]) VALUES (2, N'Plzeň')
INSERT [dbo].[Piva] ([Id], [nazev]) VALUES (3, N'Podkováň')
INSERT [dbo].[Piva] ([Id], [nazev]) VALUES (6, N'Březňák')
INSERT [dbo].[Piva] ([Id], [nazev]) VALUES (7, N'Gambrinus')
INSERT [dbo].[Piva] ([Id], [nazev]) VALUES (11, N'Kozel 0,5')
INSERT [dbo].[Piva] ([Id], [nazev]) VALUES (12, N'Kofola 0,5')
INSERT [dbo].[Piva] ([Id], [nazev]) VALUES (14, N'Kofola 0,3')
INSERT [dbo].[Piva] ([Id], [nazev]) VALUES (15, N'Prazdroj')
INSERT [dbo].[Piva] ([Id], [nazev]) VALUES (16, N'Březňák tankový')
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
SET IDENTITY_INSERT [dbo].[PivaCon] OFF
SET IDENTITY_INSERT [dbo].[Pub] ON 

INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano]) VALUES (8, N'U dědka', N'Roháče z Dubé', N'Prostorné', 1, 3, N'4', N'Místo kam jít na kulečník', N'Ranní nasávači, automatovci', 2, CAST(50.6884867 AS Decimal(10, 7)), CAST(14.5361225 AS Decimal(10, 7)), NULL, NULL)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano]) VALUES (11, N'Little Saigon', N'U Synagogy 3001 47001 Česká Lípa', N'Normální', 1, 3, N'4', N'Super na jídlo', N'Střední třída', NULL, CAST(50.6849406 AS Decimal(10, 7)), CAST(14.5410411 AS Decimal(10, 7)), NULL, NULL)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano]) VALUES (12, N'Hospudka u vitulina', NULL, N'Normální', 2, 3, N'4', NULL, N'Cykliste a ranni nasavaci', 2, NULL, NULL, NULL, NULL)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano]) VALUES (13, N'Lekarna', N'affsafsdfasdfsaf', N'Prostorné', 2, 4, N'ahoj', N'Fajn zahrádka', N'Nasávači', 2, NULL, NULL, NULL, NULL)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano]) VALUES (15, N'Bohemia', NULL, N'Stísněné', 1, 4, N'4', NULL, N'Střední vyšší třída', 4, NULL, NULL, NULL, NULL)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano]) VALUES (16, N'hon', NULL, N'Normální', 1, 3, N'2', N'Vyborny ovocny birrel', N'tradicni kurak', 2, NULL, NULL, NULL, NULL)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano]) VALUES (17, N'u prasíka', NULL, N'Stísněné', 1, 3, N'5', N'Rodinna hospudka mensi kapacity, s chapavou rychlou a starostlivou obsluhou, ktera vas obsluhuje srdcem a s laskou. Nikdo se tu nehada a je zde citit poklidna privetiva atmosfera.Vymalovano, tak se tu clovek neciti jako v komunismu. Tady se mi libi.', N'vysokoskolsti filozofove, programatori', 3, NULL, NULL, NULL, NULL)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano]) VALUES (18, N'Dno Pytle', N'Zámecká 74', N'Stísněné', 1, 4, N'4', N'Velký výber rumů, výtečně natočené svijany.', N'stredni trida, ', 3, NULL, NULL, NULL, NULL)
INSERT [dbo].[Pub] ([Id], [nazev], [adresa], [prostornost], [lokace], [hodnoceni], [obsluha], [poznamka], [navstevnici], [prostredi], [gpsN], [gpsE], [datumPridani], [smazano]) VALUES (19, N'central', NULL, N'Prostorné', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Pub] OFF
ALTER TABLE [dbo].[Pub] ADD  CONSTRAINT [DF_Pub_datumPridani]  DEFAULT (getdate()) FOR [datumPridani]
GO
ALTER TABLE [dbo].[Pub] ADD  CONSTRAINT [DF_Pub_smazano]  DEFAULT ((0)) FOR [smazano]
GO
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
