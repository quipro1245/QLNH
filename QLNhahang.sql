USE [master]
GO
/****** Object:  Database [QUANLYNHAHANG]    Script Date: 12/21/2020 8:12:06 AM ******/
CREATE DATABASE [QUANLYNHAHANG]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QUANLYNHAHANG', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QUANLYNHAHANG.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QUANLYNHAHANG_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QUANLYNHAHANG_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QUANLYNHAHANG] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QUANLYNHAHANG].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QUANLYNHAHANG] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET ARITHABORT OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QUANLYNHAHANG] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QUANLYNHAHANG] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QUANLYNHAHANG] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QUANLYNHAHANG] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QUANLYNHAHANG] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QUANLYNHAHANG] SET  MULTI_USER 
GO
ALTER DATABASE [QUANLYNHAHANG] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QUANLYNHAHANG] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QUANLYNHAHANG] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QUANLYNHAHANG] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QUANLYNHAHANG] SET DELAYED_DURABILITY = DISABLED 
GO
USE [QUANLYNHAHANG]
GO
/****** Object:  Table [dbo].[ACCOUNT]    Script Date: 12/21/2020 8:12:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT](
	[USERNAME] [nvarchar](100) NOT NULL,
	[DISPLAYNAME] [nvarchar](100) NOT NULL DEFAULT (N'Qui'),
	[PASSWORD] [nvarchar](100) NOT NULL DEFAULT ((0)),
	[TYPE] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[USERNAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BILL]    Script Date: 12/21/2020 8:12:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BILL](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DATECHECKIN] [date] NOT NULL DEFAULT (getdate()),
	[DATECHECKOUT] [date] NULL,
	[IDTABLE] [int] NOT NULL,
	[status] [int] NOT NULL DEFAULT ((0)),
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BILLINFO]    Script Date: 12/21/2020 8:12:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BILLINFO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDBILL] [int] NOT NULL,
	[IDFOOD] [int] NOT NULL,
	[COUNT] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FOOD]    Script Date: 12/21/2020 8:12:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FOOD](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](100) NOT NULL DEFAULT (N'Chưa đặt tên'),
	[IDCATEGORY] [int] NOT NULL,
	[PRICE] [float] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FOODCATEGORY]    Script Date: 12/21/2020 8:12:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FOODCATEGORY](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](100) NOT NULL DEFAULT (N'Chưa đặt tên'),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TABLEFOOD]    Script Date: 12/21/2020 8:12:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLEFOOD](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](100) NOT NULL DEFAULT (N'Bàn chưa có tên'),
	[status] [nvarchar](100) NOT NULL DEFAULT (N'Trống'),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[ACCOUNT] ([USERNAME], [DISPLAYNAME], [PASSWORD], [TYPE]) VALUES (N'quipro', N'phuqui', N'quipro1245', 1)
INSERT [dbo].[ACCOUNT] ([USERNAME], [DISPLAYNAME], [PASSWORD], [TYPE]) VALUES (N'tricui', N'tricui', N'tricui', 0)
SET IDENTITY_INSERT [dbo].[BILL] ON 

INSERT [dbo].[BILL] ([ID], [DATECHECKIN], [DATECHECKOUT], [IDTABLE], [status], [discount], [totalPrice]) VALUES (114, CAST(N'2020-12-19' AS Date), CAST(N'2020-12-19' AS Date), 2, 1, 1, 14850)
INSERT [dbo].[BILL] ([ID], [DATECHECKIN], [DATECHECKOUT], [IDTABLE], [status], [discount], [totalPrice]) VALUES (115, CAST(N'2020-12-19' AS Date), CAST(N'2020-12-19' AS Date), 1, 1, 1, 14850)
INSERT [dbo].[BILL] ([ID], [DATECHECKIN], [DATECHECKOUT], [IDTABLE], [status], [discount], [totalPrice]) VALUES (116, CAST(N'2020-12-19' AS Date), CAST(N'2020-12-19' AS Date), 5, 1, 1, 747450)
INSERT [dbo].[BILL] ([ID], [DATECHECKIN], [DATECHECKOUT], [IDTABLE], [status], [discount], [totalPrice]) VALUES (117, CAST(N'2020-12-19' AS Date), CAST(N'2020-12-19' AS Date), 4, 1, 1, 178200)
INSERT [dbo].[BILL] ([ID], [DATECHECKIN], [DATECHECKOUT], [IDTABLE], [status], [discount], [totalPrice]) VALUES (118, CAST(N'2020-12-20' AS Date), NULL, 10, 0, 0, NULL)
SET IDENTITY_INSERT [dbo].[BILL] OFF
SET IDENTITY_INSERT [dbo].[BILLINFO] ON 

INSERT [dbo].[BILLINFO] ([ID], [IDBILL], [IDFOOD], [COUNT]) VALUES (116, 114, 29, 3)
INSERT [dbo].[BILLINFO] ([ID], [IDBILL], [IDFOOD], [COUNT]) VALUES (117, 115, 29, 3)
INSERT [dbo].[BILLINFO] ([ID], [IDBILL], [IDFOOD], [COUNT]) VALUES (118, 116, 29, 3)
INSERT [dbo].[BILLINFO] ([ID], [IDBILL], [IDFOOD], [COUNT]) VALUES (119, 116, 35, 1)
INSERT [dbo].[BILLINFO] ([ID], [IDBILL], [IDFOOD], [COUNT]) VALUES (120, 116, 37, 1)
INSERT [dbo].[BILLINFO] ([ID], [IDBILL], [IDFOOD], [COUNT]) VALUES (121, 117, 52, 1)
INSERT [dbo].[BILLINFO] ([ID], [IDBILL], [IDFOOD], [COUNT]) VALUES (122, 118, 29, 3)
INSERT [dbo].[BILLINFO] ([ID], [IDBILL], [IDFOOD], [COUNT]) VALUES (123, 118, 30, 1)
SET IDENTITY_INSERT [dbo].[BILLINFO] OFF
SET IDENTITY_INSERT [dbo].[FOOD] ON 

INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (29, N'Súp cá hồi', 6, 15000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (30, N'Gỏi cá hồi', 6, 250000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (31, N'Cháo cá hồi', 6, 50000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (32, N'Cá hồi nướng', 6, 320000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (33, N'Cá hồi rang muối', 6, 320000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (34, N'Cá hồi sốt chanh leo', 6, 400000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (35, N'Cá quả nướng muối ớt', 7, 25000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (36, N'Cá quả chiên xù', 7, 20000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (37, N'Lẩu gà đen', 8, 700000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (38, N'Lẩu vịt', 8, 400000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (39, N'Lẩu riêu cua bắp bò', 8, 550000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (40, N'Lẩu bò nhúng dấm', 8, 350000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (41, N'Lẩu thập cẩm', 8, 600000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (42, N'Lẩu ếch măng cay', 8, 400000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (43, N'Lẩu cá quả', 8, 350000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (44, N'Lẩu cá chép nấu riêu', 8, 380000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (45, N'Lẩu gà nấm tươi', 8, 550000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (46, N'Lẩu cháo chim câu', 8, 600000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (47, N'Lẩu chim rừng', 8, 700000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (48, N'Lẩu lợn rừng tía tô', 8, 700000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (49, N'Lẩu gà rượu vang', 8, 600000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (50, N'Lẩu sườn', 8, 500000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (51, N'Lẩu cá lăng', 8, 500000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (52, N'Dê nướng tảng', 9, 180000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (53, N'Dê tái chanh', 9, 150000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (54, N'Dê hấp hải sâm', 9, 300000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (55, N'Chân dê rang muối', 9, 160000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (56, N'Lẩu dê', 9, 700000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (97, N'Súp cá ', 6, 15000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (98, N'Súp cá hồi 1', 6, 15000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (99, N'Coca Cola', 29, 15000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (100, N'Ếch nướng muối ớt', 10, 60000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (101, N'Súp gà măng chua', 33, 20000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (102, N'Súp gà kem ngô', 33, 30000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (103, N'Súp hải sản chua cay', 33, 15000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (104, N'Súp cá hồi', 33, 15000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (105, N'Ngô non chiên bơ', 33, 15000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (106, N'Cải ngọt xào nấm', 34, 15000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (107, N'Bí xào tỏi', 34, 30000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (108, N'Rau lang xào tỏi', 34, 30000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (109, N'Mồng tơ xào', 34, 30000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (110, N'Su su luộc chấm muối vừng', 34, 30000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (111, N'Nộm sứa phòng tôm', 35, 60000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (112, N'Salad rau mầm', 35, 50000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (113, N'Salad dầm dấm', 35, 40000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (114, N'Mướp đắng đá ruốc', 35, 50000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (115, N'Nộp hoa chuối', 35, 40000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (116, N'Nộm rau má', 35, 40000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (117, N'Nộp dưa góp', 35, 40000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (118, N'Gỏi sứa', 36, 60000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (119, N'Mực xào thập cẩm', 37, 180000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (120, N'Mực chiên bơ', 37, 180000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (121, N'Mực trứng hấp', 37, 200000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (122, N'Mực trứng nướng muối ớt', 37, 200000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (123, N'Mực trứng chiên', 37, 180000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (124, N'Dê xào lăn', 9, 180000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (125, N'Chân dê hầm thuốc bắc', 9, 180000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (126, N'Ếch chiên bơ', 10, 120000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (127, N'Ếch xào lá lốt', 10, 120000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (128, N'Tốm sông chao', 11, 100000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (129, N'Tôm chiên giòn', 11, 150000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (130, N'Tôm kho tàu', 11, 150000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (131, N'Tôm hấp nước dừa', 11, 150000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (132, N'Chả tôm', 11, 150000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (133, N'Ghẹ hấp bia', 12, 250000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (134, N'Ghẹ rang muối', 12, 250000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (135, N'Ghẹ rang me', 12, 250000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (136, N'Ghẹ nướng ', 12, 250000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (137, N'Sườn nướng', 13, 150000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (138, N'Sườn xào chua ngọt', 13, 150000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (139, N'Sụn rang muối', 13, 150000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (140, N'Nem cua', 14, 150000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (141, N'Nem tôm', 14, 120000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (142, N'Nem hải sản', 14, 150000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (143, N'Canh cua mồng tơi', 31, 50000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (144, N'Canh cá nấu riêu', 31, 90000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (145, N'Canh đầu cá', 31, 40000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (146, N'Canh cải thịt', 31, 50000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (147, N'Canh dưa chua bắp bò', 31, 120000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (148, N'Canh thịt chua', 31, 40000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (149, N'Vịt Minh Hương luộc', 30, 300000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (150, N'Vịt chiên cay', 30, 300000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (151, N'Vịt rang muối', 30, 300000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (152, N'Vịt quay', 30, 300000)
INSERT [dbo].[FOOD] ([ID], [NAME], [IDCATEGORY], [PRICE]) VALUES (153, N'Vịt om sấu', 30, 300000)
SET IDENTITY_INSERT [dbo].[FOOD] OFF
SET IDENTITY_INSERT [dbo].[FOODCATEGORY] ON 

INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (6, N'Cá hồi')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (7, N'Cá quả')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (8, N'Lẩu các loại')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (9, N'Dê')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (10, N'Ếch')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (11, N'Tôm')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (12, N'Ghẹ')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (13, N'Sườn Lợn')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (14, N'Nem')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (29, N'Thức uống')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (30, N'Vịt')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (31, N'Canh các món')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (33, N'Súp')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (34, N'Rau')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (35, N'Nộm và Salad')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (36, N'Gỏi sứa')
INSERT [dbo].[FOODCATEGORY] ([ID], [NAME]) VALUES (37, N'Mực')
SET IDENTITY_INSERT [dbo].[FOODCATEGORY] OFF
SET IDENTITY_INSERT [dbo].[TABLEFOOD] ON 

INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (1, N'Bàn 1', N'Đã đặt')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (2, N'Bàn 2', N'Đã đặt')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (3, N'Bàn 3', N'Đã đặt')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (4, N'Ban 4', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (5, N'Bàn 5', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (6, N'Bàn 6', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (7, N'Bàn 7', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (8, N'Bàn 8', N'Đã đặt')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (9, N'Bàn 9', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (10, N'Bàn 10', N'Có người')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (11, N'Bàn 11', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (12, N'Bàn 12', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (13, N'Bàn 13', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (14, N'Bàn 14', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (15, N'Bàn 15', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (16, N'Bàn 16', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (17, N'Bàn 17', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (18, N'Bàn 18', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (19, N'Bàn 19', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (20, N'Bàn 20', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (21, N'Bàn 21', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (27, N'Bàn 22', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (33, N'Bàn 23', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (37, N'Bàn 0', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (38, N'Bàn 1', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (39, N'Bàn 2', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (40, N'Bàn 3', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (41, N'Bàn 4', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (42, N'Bàn 5', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (43, N'Bàn 6', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (44, N'Bàn 7', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (45, N'Bàn 8', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (46, N'Bàn 9', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (47, N'Bàn 10', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (48, N'Bàn 11', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (49, N'Bàn 12', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (50, N'Bàn 13', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (51, N'Bàn 14', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (52, N'Bàn 15', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (53, N'Bàn 16', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (54, N'Bàn 17', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (55, N'Bàn 18', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (56, N'Bàn 19', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (57, N'Bàn 20', N'Trống')
INSERT [dbo].[TABLEFOOD] ([ID], [NAME], [status]) VALUES (58, N'Bàn 21', N'Trống')
SET IDENTITY_INSERT [dbo].[TABLEFOOD] OFF
ALTER TABLE [dbo].[BILL]  WITH CHECK ADD FOREIGN KEY([IDTABLE])
REFERENCES [dbo].[TABLEFOOD] ([ID])
GO
ALTER TABLE [dbo].[BILLINFO]  WITH CHECK ADD FOREIGN KEY([IDBILL])
REFERENCES [dbo].[BILL] ([ID])
GO
ALTER TABLE [dbo].[BILLINFO]  WITH CHECK ADD FOREIGN KEY([IDFOOD])
REFERENCES [dbo].[FOOD] ([ID])
GO
ALTER TABLE [dbo].[FOOD]  WITH CHECK ADD FOREIGN KEY([IDCATEGORY])
REFERENCES [dbo].[FOODCATEGORY] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAcountByUserName]    Script Date: 12/21/2020 8:12:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROC [dbo].[USP_GetAcountByUserName]
 @userName nvarchar(100)
 as
 begin
	SELECT * FROM dbo.ACCOUNT WHERE USERNAME = @userName
end

GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 12/21/2020 8:12:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetTableList]
	AS SELECT*FROM dbo.TABLEFOOD

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 12/21/2020 8:12:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertBill]
@idTable INT
AS
BEGIN
	INSERT dbo.BILL(DATECHECKIN,DATECHECKOUT,IDTABLE,status,discount)
	VALUES (GETDATE(),null,@idTable,0,0)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 12/21/2020 8:12:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertBillInfo]
@idBill INT,@idFood int, @count int
AS
BEGIN
	DECLARE @isExitsBillInfo int
	DECLARE @foodCount int =1
	SELECT @isExitsBillInfo = id,@foodCount=b.COUNT FROM dbo.BILLINFO as b Where IDBILL =@idBill AND IDFOOD =@idFood 
	IF(@isExitsBillInfo>0)
	BEGIN
		DECLARE @newCount int = @foodCount + @count
		IF(@newCount>0)
			UPDATE dbo.BILLINFO SET count=@foodCount+@count Where IDFOOD = @idFood
		ELSE
			DELETE dbo.BILLINFO WHERE idBill = @idBill And IDFOOD = @idFood
	END
	ELSE
	BEGIN
		INSERT dbo.BILLINFO(IDBILL,IDFOOD,COUNT)
		VALUES(@idBill,@idFood,@count)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 12/21/2020 8:12:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_Login]
 @userName nvarchar(100),@passWord nvarchar(100)
 as
 begin	
		SELECT*FROM dbo.ACCOUNT WHERE USERNAME = @userName AND PASSWORD = @passWord
end

GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTable]    Script Date: 12/21/2020 8:12:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_SwitchTable]
@idTable1 INT, @idTable2 INT
AS BEGIN
	DECLARE @idFirstBill INT
	DECLARE @idSecondBill INT

	DECLARE @idFirstTableEmty int =1
	DECLARE @idSecondTableEmty int =1
	
	SELECT @idSecondBill FROM dbo.BILL WHERE IDTABLE= @idTable2 AND status =0
	SELECT @idFirstBill FROM dbo.BILL WHERE IDTABLE= @idTable1 AND status =0
	PRINT @idFirstBill
	PRINT @idSecondBill
	PRINT '--------------'
	IF(@idFirstBill IS null)
	BEGIN
	PRINT '--------------1'
		INSERT dbo.BILL(DATECHECKIN,DATECHECKOUT,IDTABLE,status)
VALUES(GETDATE(),null,@idTable1,0)
		SELECT @idFirstBill = MAX(id) FROM dbo.BILL WHERE IDTABLE= @idTable1 AND status =0
		
	END
	SELECT  @idFirstTableEmty = COUNT(*) FROM dbo.BILLINFO WHERE idBill = @idFirstBill
	IF(@idSecondBill IS null)
	BEGIN
	PRINT '--------------2'
		INSERT dbo.BILL(DATECHECKIN,DATECHECKOUT,IDTABLE,status)
VALUES(GETDATE(),null,@idTable2,0)
		SELECT @idSecondBill = MAX(id) FROM dbo.BILL WHERE IDTABLE= @idTable2 AND status =0
		
	END
	SELECT  @idSecondBill = COUNT(*) FROM dbo.BILLINFO WHERE idBill = @idSecondBill
	
	SELECT id INTO IDBillInfoTable FROM dbo.BILLINFO WHERE IDBILL = @idSecondBill
	UPDATE dbo.BILLINFO SET IDBILL = @idSecondBill WHERE idBill = @idFirstBill
	UPDATE dbo.BILLINFO SET idBill = @idFirstBill WHERE id IN (SELECT * FROM IDBillInfoTable)

	DROP TABLE IDBillInfoTable 
	IF(@idFirstTableEmty =0)
		UPDATE dbo.TABLEFOOD SET status = N'Trống' WHERE id = @idTable2
	IF(@idSecondTableEmty=0)
		UPDATE dbo.TABLEFOOD SET status = N'Trống' WHERE id = @idTable1
END

GO
USE [master]
GO
ALTER DATABASE [QUANLYNHAHANG] SET  READ_WRITE 
GO
