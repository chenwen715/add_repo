USE [master]
GO
/****** Object:  Database [ACSNEW]    Script Date: 2018/12/21 17:19:51 ******/
CREATE DATABASE [ACSNEW]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ACSNEW', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ACSNEW.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ACSNEW_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ACSNEW_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ACSNEW].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ACSNEW] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ACSNEW] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ACSNEW] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ACSNEW] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ACSNEW] SET ARITHABORT OFF 
GO
ALTER DATABASE [ACSNEW] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ACSNEW] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ACSNEW] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ACSNEW] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ACSNEW] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ACSNEW] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ACSNEW] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ACSNEW] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ACSNEW] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ACSNEW] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ACSNEW] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ACSNEW] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ACSNEW] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ACSNEW] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ACSNEW] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ACSNEW] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ACSNEW] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ACSNEW] SET RECOVERY FULL 
GO
ALTER DATABASE [ACSNEW] SET  MULTI_USER 
GO
ALTER DATABASE [ACSNEW] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ACSNEW] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ACSNEW] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ACSNEW] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ACSNEW', N'ON'
GO
USE [ACSNEW]
GO
/****** Object:  Table [dbo].[T_Base_AGV]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Base_AGV](
	[AgvNo] [nvarchar](50) NOT NULL,
	[AreaNo] [nvarchar](50) NULL,
	[Barcode] [nvarchar](50) NULL,
	[IsEnable] [bit] NULL,
	[State] [int] NULL,
	[CurrentCharge] [numeric](10, 2) NULL CONSTRAINT [DF_T_Base_AGV_CurrentCharge]  DEFAULT ((0)),
	[Height] [nvarchar](50) NULL,
	[Direction] [int] NULL,
	[ErrorMsg] [int] NULL,
	[UpdateTime] [datetime] NULL,
	[Ct] [int] NULL CONSTRAINT [DF_T_Base_AGV_Count]  DEFAULT ((0)),
	[ErrNum] [int] NULL,
	[ErrTime] [int] NULL,
 CONSTRAINT [PK_ExecUnit] PRIMARY KEY CLUSTERED 
(
	[AgvNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Base_Area]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Base_Area](
	[AreaNo] [nvarchar](50) NOT NULL,
	[AreaName] [nvarchar](50) NULL,
 CONSTRAINT [PK_T_Base_Area] PRIMARY KEY CLUSTERED 
(
	[AreaNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Base_KeyPoint]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Base_KeyPoint](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[KeyBarCode] [nvarchar](50) NULL,
	[KeyArea] [int] NULL,
 CONSTRAINT [PK_KeyPoint] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Base_PathList]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Base_PathList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SID] [int] NOT NULL,
	[SerialNo] [int] NOT NULL,
	[BarCode] [nvarchar](50) NOT NULL,
	[Direction] [int] NOT NULL CONSTRAINT [DF_T_Base_PathList_Direction]  DEFAULT ((0)),
 CONSTRAINT [PK_T_Base_PathList] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Base_Point]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Base_Point](
	[PointNo] [nvarchar](50) NOT NULL,
	[AreaNo] [nvarchar](50) NULL,
	[BarCode] [nvarchar](50) NOT NULL,
	[X] [int] NULL,
	[Y] [int] NULL,
	[IsXPos] [bit] NULL CONSTRAINT [DF_T_Base_Point_IsEast]  DEFAULT ((0)),
	[IsXNeg] [bit] NULL CONSTRAINT [DF_T_Base_Point_IsNorth]  DEFAULT ((0)),
	[IsYPos] [bit] NULL CONSTRAINT [DF_T_Base_Point_IsWest]  DEFAULT ((0)),
	[IsYNeg] [bit] NULL CONSTRAINT [DF_T_Base_Point_IsSouth]  DEFAULT ((0)),
	[IsEnable] [bit] NULL,
	[RotateAgvNo] [nvarchar](50) NULL,
	[IsOccupy] [bit] NULL,
	[OccupyAgvNo] [nvarchar](50) NULL,
	[PointType] [nvarchar](50) NULL,
	[XLength] [int] NULL CONSTRAINT [DF_T_Base_Point_XLength]  DEFAULT ((0)),
	[YLength] [int] NULL CONSTRAINT [DF_T_Base_Point_YLength]  DEFAULT ((0)),
	[AntiCollision] [int] NULL CONSTRAINT [DF_T_Base_Point_AntiCollision]  DEFAULT ((0)),
	[OriAgv] [int] NULL CONSTRAINT [DF_T_Base_Point_OriAgv]  DEFAULT ((0)),
	[OriDial] [int] NULL CONSTRAINT [DF_T_Base_Point_OriDial]  DEFAULT ((0)),
	[PathNum] [int] NULL CONSTRAINT [DF_T_Base_Point_PathNum]  DEFAULT ((0)),
	[G] [int] NULL,
	[H] [int] NULL,
 CONSTRAINT [PK_Points] PRIMARY KEY CLUSTERED 
(
	[PointNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Base_RotatePoint]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Base_RotatePoint](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AroundBarcode] [nvarchar](50) NULL,
	[RotateBarcode] [nvarchar](50) NULL,
 CONSTRAINT [PK_T_Base_PointDtl] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Base_Shelf]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Base_Shelf](
	[ShelfNo] [nvarchar](50) NOT NULL,
	[AreaNo] [nvarchar](50) NULL,
	[Barcode] [nvarchar](50) NOT NULL,
	[CurrentBarcode] [nvarchar](50) NOT NULL,
	[ShelfDirection] [nvarchar](50) NULL,
	[IsEnable] [bit] NOT NULL CONSTRAINT [DF_T_Base_Shelf_IsEnable]  DEFAULT ((1)),
	[IsLocked] [bit] NOT NULL CONSTRAINT [DF_T_Base_Shelf_IsLocked]  DEFAULT ((0)),
 CONSTRAINT [PK_Shelf] PRIMARY KEY CLUSTERED 
(
	[ShelfNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Base_Station]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Base_Station](
	[StationNo] [nvarchar](50) NOT NULL,
	[AreaNo] [nvarchar](50) NULL,
	[Barcode] [nvarchar](50) NULL,
	[StationType] [nvarchar](50) NULL,
	[IsEnable] [bit] NULL,
	[Direction] [int] NULL,
	[MaxTaskNum] [int] NULL,
	[Pre_Barcode] [nvarchar](50) NULL,
	[AgvDirection] [int] NULL,
 CONSTRAINT [PK_WorkStation] PRIMARY KEY CLUSTERED 
(
	[StationNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Config_Record]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Config_Record](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[agvNo] [nvarchar](50) NULL,
	[dealTime] [int] NULL,
	[expDealTimeUpdate] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_KeyValue_Config]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_KeyValue_Config](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[KeyVariable] [nvarchar](53) NOT NULL,
	[Value] [float] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_PathPoint]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_PathPoint](
	[PointNo] [nvarchar](50) NOT NULL,
	[PointX] [int] NOT NULL,
	[PointY] [int] NOT NULL,
	[x] [int] NOT NULL,
	[y] [int] NOT NULL,
	[pointType] [int] NULL,
	[intStationCode] [int] NULL,
	[wsType] [int] NULL,
	[beforex] [int] NULL,
	[beforey] [int] NULL,
	[afterx] [int] NULL,
	[aftery] [int] NULL,
	[isOccupy] [bit] NULL,
	[occupyAgv] [nvarchar](50) NULL,
	[area] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Task]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Task](
	[TaskNo] [nvarchar](20) NOT NULL,
	[TaskType] [nvarchar](50) NULL,
	[ShelfNo] [nvarchar](50) NULL,
	[PalletNo] [nchar](50) NULL,
	[TaskState] [int] NOT NULL CONSTRAINT [DF_T_Task_State]  DEFAULT ((0)),
	[TaskLevel] [int] NOT NULL CONSTRAINT [DF_T_Task_TaskLevel]  DEFAULT ((0)),
	[AgvNo] [nvarchar](50) NULL,
	[Direction] [nvarchar](50) NULL,
	[StationNo] [nvarchar](50) NULL,
	[Barcode] [nvarchar](50) NULL,
	[ErrorMsg] [nvarchar](50) NULL,
	[ErrorTime] [datetime] NULL,
	[CreateTime] [datetime] NULL,
	[SubmitTime] [datetime] NULL,
	[BeginTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[FromStationNo] [nvarchar](50) NULL,
	[FromStep] [int] NULL,
	[AreaNo] [nvarchar](50) NULL,
	[RotateDir] [int] NULL CONSTRAINT [DF_T_Task_RotateDir]  DEFAULT ((0)),
	[RotateBarcode] [nvarchar](50) NULL,
 CONSTRAINT [PK_FTasks] PRIMARY KEY CLUSTERED 
(
	[TaskNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Task_Delete]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_Task_Delete](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TaskNo] [varchar](20) NOT NULL,
	[AgvNo] [nvarchar](50) NULL,
	[State] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_Task_Old]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Task_Old](
	[TaskNo] [nvarchar](20) NOT NULL,
	[TaskType] [nvarchar](50) NULL,
	[ShelfNo] [nvarchar](50) NULL,
	[PalletNo] [nchar](50) NULL,
	[TaskState] [int] NOT NULL,
	[TaskLevel] [int] NOT NULL,
	[AgvNo] [nvarchar](50) NULL,
	[Direction] [nvarchar](50) NULL,
	[StationNo] [nvarchar](50) NULL,
	[Barcode] [nvarchar](50) NULL,
	[ErrorMsg] [nvarchar](50) NULL,
	[ErrorTime] [datetime] NULL,
	[CreateTime] [datetime] NULL,
	[SubmitTime] [datetime] NULL,
	[BeginTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[FromStationNo] [nvarchar](50) NULL,
	[FromStep] [int] NULL,
	[AreaNo] [nvarchar](50) NULL,
	[RotateDir] [int] NULL,
	[RotateBarcode] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Task_Son]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Task_Son](
	[SID] [int] IDENTITY(1,1) NOT NULL,
	[TaskNo] [nvarchar](20) NOT NULL,
	[STaskType] [nvarchar](50) NULL,
	[SerialNo] [int] NULL,
	[AgvNo] [nvarchar](50) NULL,
	[BeginPoint] [nvarchar](50) NULL,
	[EndPoint] [nvarchar](50) NULL,
	[DialDirection] [int] NULL,
	[AgvDirection] [int] NULL,
	[State] [int] NULL,
	[CBeginTime] [datetime] NULL,
	[CEndTime] [datetime] NULL,
	[ConStation] [nvarchar](50) NULL,
	[C_IsSendOk] [bit] NULL,
	[C_IsAsk] [bit] NULL,
	[HaveShelf] [bit] NULL,
 CONSTRAINT [PK_CTasks] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Type_Config]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Type_Config](
	[ItemNo] [nvarchar](50) NOT NULL,
	[ItemName] [nvarchar](50) NOT NULL,
	[FItemNo] [nvarchar](50) NULL,
	[FItemName] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_T_Type_Config_1]    Script Date: 2018/12/21 17:19:51 ******/
CREATE CLUSTERED INDEX [IX_T_Type_Config_1] ON [dbo].[T_Type_Config]
(
	[FItemNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[T_Type_Point]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Type_Point](
	[PointType] [nvarchar](50) NOT NULL,
	[PointTypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_T_Base_PointType] PRIMARY KEY CLUSTERED 
(
	[PointType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_Type_Split]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_Type_Split](
	[TaskType] [nvarchar](50) NOT NULL,
	[SerialNo] [int] NOT NULL,
	[DType] [nvarchar](50) NULL,
	[FromPoint] [nvarchar](50) NULL,
	[ToPoint] [nvarchar](50) NULL,
	[IsAsk] [bit] NULL,
	[IsSendOk] [bit] NULL,
	[HaveShelf] [bit] NULL,
 CONSTRAINT [PK_T_Type_Split] PRIMARY KEY CLUSTERED 
(
	[TaskType] ASC,
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[T_Base_AGV] ([AgvNo], [AreaNo], [Barcode], [IsEnable], [State], [CurrentCharge], [Height], [Direction], [ErrorMsg], [UpdateTime], [Ct], [ErrNum], [ErrTime]) VALUES (N'A02_001', N'1', N'202', 1, 11, CAST(79.00 AS Numeric(10, 2)), N'1', 2, 0, CAST(N'2018-12-21 17:17:00.337' AS DateTime), 0, 0, 0)
INSERT [dbo].[T_Base_AGV] ([AgvNo], [AreaNo], [Barcode], [IsEnable], [State], [CurrentCharge], [Height], [Direction], [ErrorMsg], [UpdateTime], [Ct], [ErrNum], [ErrTime]) VALUES (N'A02_003', N'1', N'201', 1, 11, CAST(74.00 AS Numeric(10, 2)), N'1', 1, 0, CAST(N'2018-12-21 17:18:06.563' AS DateTime), 0, 0, 0)
INSERT [dbo].[T_Base_Area] ([AreaNo], [AreaName]) VALUES (N'1', N'TEST')
SET IDENTITY_INSERT [dbo].[T_Base_PathList] ON 

INSERT [dbo].[T_Base_PathList] ([ID], [SID], [SerialNo], [BarCode], [Direction]) VALUES (250, 101, 1, N'202', 0)
SET IDENTITY_INSERT [dbo].[T_Base_PathList] OFF
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0001', N'1', N'101', 1, 1, 1, 0, 1, 0, 1, NULL, 0, N'', N'1', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0002', N'1', N'102', 1, 2, 1, 0, 1, 1, 1, NULL, 0, NULL, N'1', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0003', N'1', N'103', 1, 3, 1, 0, 1, 1, 1, NULL, 0, NULL, N'1', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0004', N'1', N'104', 1, 4, 1, 0, 0, 1, 1, NULL, 0, N'', N'3', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0005', N'1', N'201', 2, 1, 1, 1, 1, 0, 1, NULL, 1, N'A02_003', N'6', 0, 0, 0, 1, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0006', N'1', N'202', 2, 2, 1, 1, 1, 1, 1, NULL, 1, N'A02_001', N'6', 0, 0, 0, 2, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0007', N'1', N'203', 2, 3, 1, 1, 1, 1, 1, NULL, 0, N'', N'1', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0008', N'1', N'204', 2, 4, 1, 1, 0, 1, 1, NULL, 0, NULL, N'1', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0009', N'1', N'301', 3, 1, 1, 1, 1, 0, 1, NULL, 0, NULL, N'1', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0010', N'1', N'302', 3, 2, 1, 1, 1, 1, 1, NULL, 0, NULL, N'1', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0011', N'1', N'303', 3, 3, 1, 1, 1, 1, 1, NULL, 0, NULL, N'1', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0012', N'1', N'304', 3, 4, 1, 1, 0, 1, 1, NULL, 0, NULL, N'1', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0013', N'1', N'401', 4, 1, 1, 1, 1, 0, 1, NULL, 0, NULL, N'1', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0014', N'1', N'402', 4, 2, 1, 1, 1, 1, 1, NULL, 0, NULL, N'5', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0015', N'1', N'403', 4, 3, 1, 1, 1, 1, 1, NULL, 0, NULL, N'5', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0016', N'1', N'404', 4, 4, 1, 1, 0, 1, 1, NULL, 0, N'', N'3', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0017', N'1', N'501', 5, 1, 0, 1, 1, 0, 1, NULL, 0, NULL, N'1', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0018', N'1', N'502', 5, 2, 0, 1, 1, 1, 1, NULL, 0, N'', N'4', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0019', N'1', N'503', 5, 3, 0, 1, 1, 1, 1, NULL, 0, N'', N'4', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Point] ([PointNo], [AreaNo], [BarCode], [X], [Y], [IsXPos], [IsXNeg], [IsYPos], [IsYNeg], [IsEnable], [RotateAgvNo], [IsOccupy], [OccupyAgvNo], [PointType], [XLength], [YLength], [AntiCollision], [OriAgv], [OriDial], [PathNum], [G], [H]) VALUES (N'P0020', N'1', N'504', 5, 4, 0, 1, 0, 1, 1, NULL, 0, NULL, N'1', 0, 0, 0, 0, 0, 0, NULL, NULL)
INSERT [dbo].[T_Base_Shelf] ([ShelfNo], [AreaNo], [Barcode], [CurrentBarcode], [ShelfDirection], [IsEnable], [IsLocked]) VALUES (N'H0001', N'1', N'202', N'202', N'1', 1, 0)
INSERT [dbo].[T_Base_Shelf] ([ShelfNo], [AreaNo], [Barcode], [CurrentBarcode], [ShelfDirection], [IsEnable], [IsLocked]) VALUES (N'H0002', N'1', N'201', N'201', N'1', 1, 0)
INSERT [dbo].[T_Base_Station] ([StationNo], [AreaNo], [Barcode], [StationType], [IsEnable], [Direction], [MaxTaskNum], [Pre_Barcode], [AgvDirection]) VALUES (N'WSI', N'1', N'502', N'InStore', 1, 2, 2, N'402', 1)
INSERT [dbo].[T_Base_Station] ([StationNo], [AreaNo], [Barcode], [StationType], [IsEnable], [Direction], [MaxTaskNum], [Pre_Barcode], [AgvDirection]) VALUES (N'WSO', N'1', N'503', N'OutStore', 1, 2, 2, N'403', 1)
SET IDENTITY_INSERT [dbo].[T_KeyValue_Config] ON 

INSERT [dbo].[T_KeyValue_Config] ([ID], [KeyVariable], [Value]) VALUES (1, N'Danger', 60)
INSERT [dbo].[T_KeyValue_Config] ([ID], [KeyVariable], [Value]) VALUES (2, N'Savety', 75)
INSERT [dbo].[T_KeyValue_Config] ([ID], [KeyVariable], [Value]) VALUES (3, N'Cfull', 99)
SET IDENTITY_INSERT [dbo].[T_KeyValue_Config] OFF
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0101', 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0102', 1, 2, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0103', 1, 3, 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0201', 2, 1, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0202', 2, 2, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0203', 2, 3, 2, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0301', 3, 1, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0302', 3, 2, 3, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0303', 3, 3, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0104', 1, 4, 1, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0204', 2, 4, 2, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0304', 3, 4, 3, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0404', 4, 4, 4, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0401', 4, 1, 4, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0402', 4, 2, 4, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_PathPoint] ([PointNo], [PointX], [PointY], [x], [y], [pointType], [intStationCode], [wsType], [beforex], [beforey], [afterx], [aftery], [isOccupy], [occupyAgv], [area]) VALUES (N'0403', 4, 3, 4, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812120001', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_003', N'1', N'WSO', N'0503', N'', CAST(N'2018-12-13 11:11:50.890' AS DateTime), CAST(N'2018-12-12 11:58:45.960' AS DateTime), CAST(N'2018-12-13 11:12:13.907' AS DateTime), NULL, CAST(N'2018-12-13 11:12:39.747' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812120002', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'1', N'', N'0404', N'', NULL, CAST(N'2018-12-12 11:59:08.887' AS DateTime), CAST(N'2018-12-13 11:03:12.910' AS DateTime), NULL, CAST(N'2018-12-13 11:11:15.613' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130001', N'Task_ShelfIn', N'H0001', N'                                                  ', 99, 1, N'A02_003', N'1', N'', N'203', N'', NULL, CAST(N'2018-12-13 11:30:39.883' AS DateTime), CAST(N'2018-12-13 11:30:41.743' AS DateTime), NULL, CAST(N'2018-12-13 11:31:00.907' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130002', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'404', N'', NULL, CAST(N'2018-12-13 14:22:53.650' AS DateTime), CAST(N'2018-12-13 14:22:54.377' AS DateTime), NULL, CAST(N'2018-12-13 14:23:05.060' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130003', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'202', N'', CAST(N'2018-12-13 14:24:39.460' AS DateTime), CAST(N'2018-12-13 14:23:36.760' AS DateTime), CAST(N'2018-12-13 14:32:08.140' AS DateTime), NULL, CAST(N'2018-12-13 14:32:31.850' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130004', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'404', N'', NULL, CAST(N'2018-12-13 14:37:03.577' AS DateTime), CAST(N'2018-12-13 14:37:04.010' AS DateTime), NULL, CAST(N'2018-12-13 14:37:17.840' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130005', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-13 14:37:36.840' AS DateTime), CAST(N'2018-12-13 14:37:36.977' AS DateTime), NULL, CAST(N'2018-12-13 14:37:49.953' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130006', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'404', N'', NULL, CAST(N'2018-12-13 14:39:21.320' AS DateTime), CAST(N'2018-12-13 14:39:22.537' AS DateTime), NULL, CAST(N'2018-12-13 14:39:35.803' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130007', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-13 14:42:50.223' AS DateTime), CAST(N'2018-12-13 14:42:50.403' AS DateTime), NULL, CAST(N'2018-12-13 14:43:04.233' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130008', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_003', N'1', N'WSO', N'503', N'', NULL, CAST(N'2018-12-13 14:43:16.983' AS DateTime), CAST(N'2018-12-13 14:43:17.320' AS DateTime), NULL, CAST(N'2018-12-13 14:43:36.397' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130009', N'Task_ShelfIn', N'H0001', N'                                                  ', 99, 1, N'A02_003', N'1', N'', N'202', N'', NULL, CAST(N'2018-12-13 15:01:32.427' AS DateTime), CAST(N'2018-12-13 15:01:34.053' AS DateTime), NULL, CAST(N'2018-12-13 15:02:44.690' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130010', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_003', N'1', N'WSI', N'502', N'', NULL, CAST(N'2018-12-13 15:02:57.620' AS DateTime), CAST(N'2018-12-13 15:02:57.693' AS DateTime), NULL, CAST(N'2018-12-13 15:03:14.837' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130011', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-13 15:21:52.220' AS DateTime), CAST(N'2018-12-13 15:21:54.003' AS DateTime), NULL, CAST(N'2018-12-13 15:22:06.060' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130012', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'404', N'', NULL, CAST(N'2018-12-13 15:41:34.133' AS DateTime), CAST(N'2018-12-13 15:41:35.360' AS DateTime), NULL, CAST(N'2018-12-13 15:41:49.070' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130013', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-13 15:42:06.453' AS DateTime), CAST(N'2018-12-13 15:42:08.417' AS DateTime), NULL, CAST(N'2018-12-13 15:42:21.200' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130014', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'404', N'', NULL, CAST(N'2018-12-13 15:46:05.757' AS DateTime), CAST(N'2018-12-13 15:46:05.767' AS DateTime), NULL, CAST(N'2018-12-13 15:47:51.137' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130015', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-13 15:47:54.127' AS DateTime), CAST(N'2018-12-13 15:47:55.900' AS DateTime), NULL, CAST(N'2018-12-13 15:48:09.220' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130016', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'404', N'', NULL, CAST(N'2018-12-13 15:48:15.647' AS DateTime), CAST(N'2018-12-13 15:48:15.947' AS DateTime), NULL, CAST(N'2018-12-13 15:48:29.300' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812130017', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-13 15:49:36.470' AS DateTime), CAST(N'2018-12-13 15:49:38.020' AS DateTime), NULL, CAST(N'2018-12-13 15:49:51.593' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812170001', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'404', N'', NULL, CAST(N'2018-12-17 15:35:05.177' AS DateTime), CAST(N'2018-12-17 15:35:05.583' AS DateTime), NULL, CAST(N'2018-12-17 15:35:18.313' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812170002', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-17 15:35:36.283' AS DateTime), CAST(N'2018-12-17 15:35:37.667' AS DateTime), NULL, CAST(N'2018-12-17 15:35:50.490' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812170003', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_003', N'1', N'WSO', N'503', N'', NULL, CAST(N'2018-12-17 17:08:56.223' AS DateTime), CAST(N'2018-12-17 17:08:56.447' AS DateTime), NULL, CAST(N'2018-12-17 17:09:14.670' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180001', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-18 10:21:59.960' AS DateTime), CAST(N'2018-12-18 10:22:00.350' AS DateTime), NULL, CAST(N'2018-12-18 10:22:12.847' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180002', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_003', N'1', N'WSO', N'503', N'', NULL, CAST(N'2018-12-18 10:50:36.700' AS DateTime), CAST(N'2018-12-18 10:50:38.173' AS DateTime), NULL, CAST(N'2018-12-18 10:50:57.807' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180003', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-18 10:52:18.840' AS DateTime), CAST(N'2018-12-18 10:52:20.277' AS DateTime), NULL, CAST(N'2018-12-18 10:52:27.853' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180004', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'404', N'', NULL, CAST(N'2018-12-18 10:52:35.690' AS DateTime), CAST(N'2018-12-18 10:52:36.373' AS DateTime), NULL, CAST(N'2018-12-18 10:52:43.963' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180005', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-18 10:54:49.000' AS DateTime), CAST(N'2018-12-18 10:54:50.857' AS DateTime), NULL, CAST(N'2018-12-18 10:54:58.413' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180006', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-18 11:28:11.110' AS DateTime), CAST(N'2018-12-18 11:28:11.910' AS DateTime), NULL, CAST(N'2018-12-18 11:31:16.703' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180007', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_003', N'1', N'WSO', N'503', N'', NULL, CAST(N'2018-12-18 11:52:32.143' AS DateTime), CAST(N'2018-12-18 11:52:33.753' AS DateTime), NULL, CAST(N'2018-12-18 11:53:01.897' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180008', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-18 15:43:52.367' AS DateTime), CAST(N'2018-12-18 15:43:53.910' AS DateTime), NULL, CAST(N'2018-12-18 16:20:22.410' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180009', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'404', N'', NULL, CAST(N'2018-12-18 16:20:42.970' AS DateTime), CAST(N'2018-12-18 16:20:43.337' AS DateTime), NULL, CAST(N'2018-12-18 16:20:56.693' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180010', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-18 16:21:49.380' AS DateTime), CAST(N'2018-12-18 16:21:49.673' AS DateTime), NULL, CAST(N'2018-12-18 16:22:03.230' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180011', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_003', N'1', N'WSO', N'503', N'', NULL, CAST(N'2018-12-18 16:23:12.190' AS DateTime), CAST(N'2018-12-18 16:23:12.647' AS DateTime), NULL, CAST(N'2018-12-18 16:23:32.687' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180012', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-18 16:23:42.983' AS DateTime), CAST(N'2018-12-18 16:23:44.830' AS DateTime), NULL, CAST(N'2018-12-18 16:23:58.893' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180013', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_003', N'1', N'WSO', N'503', N'', NULL, CAST(N'2018-12-18 16:24:16.153' AS DateTime), CAST(N'2018-12-18 16:24:16.993' AS DateTime), NULL, CAST(N'2018-12-18 16:24:35.173' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180014', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-18 16:24:48.280' AS DateTime), CAST(N'2018-12-18 16:24:49.160' AS DateTime), NULL, CAST(N'2018-12-18 16:25:01.393' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180015', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'404', N'', NULL, CAST(N'2018-12-18 16:27:06.153' AS DateTime), CAST(N'2018-12-18 16:27:07.050' AS DateTime), NULL, CAST(N'2018-12-18 16:27:20.313' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180016', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-18 16:27:27.570' AS DateTime), CAST(N'2018-12-18 16:27:29.130' AS DateTime), NULL, CAST(N'2018-12-18 16:27:42.467' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180017', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_003', N'1', N'WSO', N'503', N'', CAST(N'2018-12-18 16:56:49.823' AS DateTime), CAST(N'2018-12-18 16:56:22.980' AS DateTime), CAST(N'2018-12-18 16:59:31.407' AS DateTime), NULL, CAST(N'2018-12-18 16:59:56.010' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180018', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-18 16:59:59.843' AS DateTime), CAST(N'2018-12-18 17:00:01.490' AS DateTime), NULL, CAST(N'2018-12-18 17:00:14.110' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180019', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_003', N'1', N'WSI', N'502', N'', NULL, CAST(N'2018-12-18 17:06:32.360' AS DateTime), CAST(N'2018-12-18 17:06:32.910' AS DateTime), NULL, CAST(N'2018-12-18 17:06:50.987' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180020', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-18 17:07:01.310' AS DateTime), CAST(N'2018-12-18 17:07:02.960' AS DateTime), NULL, CAST(N'2018-12-18 17:07:13.083' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812180021', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_003', N'1', N'WSO', N'503', N'', NULL, CAST(N'2018-12-18 17:13:01.120' AS DateTime), CAST(N'2018-12-18 17:13:02.897' AS DateTime), NULL, CAST(N'2018-12-19 11:01:44.503' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190001', N'Task_ShelfOut', N'H0002', N'                                                  ', 99, 1, N'A02_003', N'1', N'WSI', N'502', N'', CAST(N'2018-12-19 11:06:07.010' AS DateTime), CAST(N'2018-12-19 11:02:20.490' AS DateTime), CAST(N'2018-12-19 11:06:09.373' AS DateTime), NULL, CAST(N'2018-12-19 11:06:32.917' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190002', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_001', N'', N'', N'404', N'', NULL, CAST(N'2018-12-19 11:05:00.777' AS DateTime), CAST(N'2018-12-19 11:05:00.903' AS DateTime), NULL, CAST(N'2018-12-19 11:05:17.280' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190003', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-19 11:05:48.780' AS DateTime), CAST(N'2018-12-19 11:05:50.503' AS DateTime), NULL, CAST(N'2018-12-19 11:06:06.917' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190004', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_001', N'', N'', N'202', N'', NULL, CAST(N'2018-12-19 11:23:39.693' AS DateTime), CAST(N'2018-12-19 11:23:39.767' AS DateTime), NULL, CAST(N'2018-12-19 11:23:52.523' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190005', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_003', N'', N'', N'201', N'', NULL, CAST(N'2018-12-19 11:27:55.010' AS DateTime), CAST(N'2018-12-19 11:27:56.920' AS DateTime), NULL, CAST(N'2018-12-19 11:28:10.973' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190006', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_001', N'1', N'WSO', N'503', N'', NULL, CAST(N'2018-12-19 11:28:26.540' AS DateTime), CAST(N'2018-12-19 11:28:27.107' AS DateTime), NULL, CAST(N'2018-12-19 11:28:47.210' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190007', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_001', N'', N'', N'202', N'', NULL, CAST(N'2018-12-19 11:32:56.187' AS DateTime), CAST(N'2018-12-19 11:32:57.677' AS DateTime), NULL, CAST(N'2018-12-19 11:33:11.233' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190008', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_001', N'1', N'WSO', N'503', N'', NULL, CAST(N'2018-12-19 11:43:59.970' AS DateTime), CAST(N'2018-12-19 11:44:00.380' AS DateTime), NULL, CAST(N'2018-12-19 11:44:18.057' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190009', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_001', N'', N'', N'202', N'', NULL, CAST(N'2018-12-19 11:49:44.820' AS DateTime), CAST(N'2018-12-19 11:49:45.160' AS DateTime), NULL, CAST(N'2018-12-19 11:52:58.310' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190010', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'404', N'', NULL, CAST(N'2018-12-19 13:04:58.877' AS DateTime), CAST(N'2018-12-19 13:05:00.750' AS DateTime), NULL, CAST(N'2018-12-19 13:05:16.217' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190011', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'201', N'', NULL, CAST(N'2018-12-19 13:09:00.170' AS DateTime), CAST(N'2018-12-19 13:09:00.947' AS DateTime), NULL, CAST(N'2018-12-19 13:09:16.980' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190012', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_001', N'', N'', N'404', N'', NULL, CAST(N'2018-12-19 13:09:32.817' AS DateTime), CAST(N'2018-12-19 13:09:32.950' AS DateTime), NULL, CAST(N'2018-12-19 13:09:46.990' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190013', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_001', N'1', N'WSO', N'503', N'', CAST(N'2018-12-19 14:26:10.637' AS DateTime), CAST(N'2018-12-19 13:37:08.803' AS DateTime), CAST(N'2018-12-19 14:26:12.660' AS DateTime), NULL, CAST(N'2018-12-19 14:26:32.217' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190014', N'Task_ShelfOut', N'H0002', N'                                                  ', 99, 1, N'A02_003', N'1', N'WSO', N'503', N'', NULL, CAST(N'2018-12-19 14:15:15.460' AS DateTime), CAST(N'2018-12-19 14:15:15.643' AS DateTime), NULL, CAST(N'2018-12-19 14:15:37.283' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190015', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_003', N'', N'', N'201', N'', NULL, CAST(N'2018-12-19 14:15:53.013' AS DateTime), CAST(N'2018-12-19 14:15:53.747' AS DateTime), NULL, CAST(N'2018-12-19 14:16:09.077' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190016', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_001', N'', N'', N'201', N'', CAST(N'2018-12-19 14:25:52.407' AS DateTime), CAST(N'2018-12-19 14:22:25.447' AS DateTime), CAST(N'2018-12-19 14:25:54.433' AS DateTime), NULL, CAST(N'2018-12-19 14:26:09.873' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190017', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'104', N'', CAST(N'2018-12-19 14:25:05.110' AS DateTime), CAST(N'2018-12-19 14:22:30.280' AS DateTime), CAST(N'2018-12-19 14:25:48.330' AS DateTime), NULL, CAST(N'2018-12-19 14:26:03.810' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190018', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_001', N'', N'', N'202', N'', NULL, CAST(N'2018-12-19 14:26:48.220' AS DateTime), CAST(N'2018-12-19 14:26:49.060' AS DateTime), NULL, CAST(N'2018-12-19 14:27:02.573' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190019', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_001', N'', N'', N'404', N'', NULL, CAST(N'2018-12-19 14:27:22.043' AS DateTime), CAST(N'2018-12-19 14:27:23.287' AS DateTime), NULL, CAST(N'2018-12-19 14:27:36.910' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190020', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'104', N'', NULL, CAST(N'2018-12-19 14:31:26.787' AS DateTime), CAST(N'2018-12-19 14:31:27.520' AS DateTime), NULL, CAST(N'2018-12-19 14:31:34.440' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190021', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'202', N'', NULL, CAST(N'2018-12-19 14:31:50.007' AS DateTime), CAST(N'2018-12-19 14:31:50.177' AS DateTime), NULL, CAST(N'2018-12-19 14:32:00.977' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190022', N'Task_Charge', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'104', N'', NULL, CAST(N'2018-12-19 14:32:07.803' AS DateTime), CAST(N'2018-12-19 14:32:09.093' AS DateTime), NULL, CAST(N'2018-12-19 14:32:19.950' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812190023', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_001', N'', N'', N'202', N'', NULL, CAST(N'2018-12-19 14:32:18.610' AS DateTime), CAST(N'2018-12-19 14:32:20.487' AS DateTime), NULL, CAST(N'2018-12-19 14:32:33.167' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812210001', N'Task_ChargeCancel', N'', N'                                                  ', 99, 1, N'A02_003', N'', N'', N'201', N'', NULL, CAST(N'2018-12-21 17:14:59.330' AS DateTime), CAST(N'2018-12-21 17:15:00.490' AS DateTime), NULL, CAST(N'2018-12-21 17:15:14.020' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812210002', N'Task_ShelfOut', N'H0001', N'                                                  ', 99, 1, N'A02_001', N'1', N'WSO', N'503', N'', NULL, CAST(N'2018-12-21 17:15:49.320' AS DateTime), CAST(N'2018-12-21 17:15:50.577' AS DateTime), NULL, CAST(N'2018-12-21 17:16:10.163' AS DateTime), N'', 0, N'1', 0, N'')
INSERT [dbo].[T_Task] ([TaskNo], [TaskType], [ShelfNo], [PalletNo], [TaskState], [TaskLevel], [AgvNo], [Direction], [StationNo], [Barcode], [ErrorMsg], [ErrorTime], [CreateTime], [SubmitTime], [BeginTime], [EndTime], [FromStationNo], [FromStep], [AreaNo], [RotateDir], [RotateBarcode]) VALUES (N'201812210003', N'Task_ShelfIn', N'', N'                                                  ', 99, 0, N'A02_001', N'', N'', N'202', N'', NULL, CAST(N'2018-12-21 17:16:43.347' AS DateTime), CAST(N'2018-12-21 17:16:44.623' AS DateTime), NULL, CAST(N'2018-12-21 17:16:58.327' AS DateTime), N'', 3, N'1', 0, N'')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'普通行走点', N'1', N'PointType', N'点状态')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'靠墙行走点', N'2', N'PointType', N'点状态')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'充电点', N'3', N'PointType', N'点状态')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'站台点', N'4', N'PointType', N'点状态')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'站台附属点', N'5', N'PointType', N'点状态')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'货架点', N'6', N'PointType', N'点状态')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'旋转点', N'8', N'PointType', N'点状态')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'死点', N'10', N'PointType', N'点状态')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'回家点', N'7', N'PointType', N'点状态')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'旋转附属点', N'9', N'PointType', N'点状态')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'行走', N'1', N'STaskType', N'子任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'顶升', N'2', N'STaskType', N'子任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'下降', N'3', N'STaskType', N'子任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'直接顶升
', N'4', N'STaskType', N'子任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'直接下降
', N'5', N'STaskType', N'子任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'充电', N'6', N'STaskType', N'子任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'取消充电', N'7', N'STaskType', N'子任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'原地旋转', N'8', N'STaskType', N'子任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'左弧
', N'9', N'STaskType', N'子任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'右弧', N'10', N'STaskType', N'子任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'旋转左弧出
', N'11', N'STaskType', N'子任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'旋转右弧出
', N'12', N'STaskType', N'子任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'站台区域行走', N'13', N'STaskType', N'子任务')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'Task_Charge', N'充电', N'TaskType', N'任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'Task_ChargeCancel', N'取消充电', N'TaskType', N'任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'Task_ShelfOut', N'货架出库', N'TaskType', N'任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'Task_ShelfIn', N'货架回库', N'TaskType', N'任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'Task_AgvHome', N'Agv回家', N'TaskType', N'任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'Task_AgvMove', N'Agv移动', N'TaskType', N'任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'Task_ShelfMove', N'货架移动', N'TaskType', N'任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'Task_Rotate', N'货架旋转', N'TaskType', N'任务类型')
INSERT [dbo].[T_Type_Config] ([ItemNo], [ItemName], [FItemNo], [FItemName]) VALUES (N'Task_TranSport', N'输送', N'TaskType', N'任务类型')
INSERT [dbo].[T_Type_Point] ([PointType], [PointTypeName]) VALUES (N'ChargeStation', N'充电桩')
INSERT [dbo].[T_Type_Point] ([PointType], [PointTypeName]) VALUES (N'HomePoint', N'回家点')
INSERT [dbo].[T_Type_Point] ([PointType], [PointTypeName]) VALUES (N'PathPoint', N'路径点')
INSERT [dbo].[T_Type_Point] ([PointType], [PointTypeName]) VALUES (N'RotatePoint', N'旋转点')
INSERT [dbo].[T_Type_Point] ([PointType], [PointTypeName]) VALUES (N'ShelfPoint', N'货架点')
INSERT [dbo].[T_Type_Point] ([PointType], [PointTypeName]) VALUES (N'WorkStation', N'工作台')
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_AgvHome', 1, N'行走', N'AGV', N'EndBarcode', NULL, NULL, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_AgvMove', 1, N'行走', N'AGV', N'EndBarcode', NULL, NULL, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_Charge', 1, N'行走', N'AGV', N'EndBarcode', NULL, NULL, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_Charge', 2, N'充电', N'EndBarcode', N'EndBarcode', NULL, NULL, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ChargeCancel', 1, N'取消充电', N'AGV', N'AGV', NULL, NULL, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ChargeCancel', 2, N'行走', N'AGV', N'EndBarcode', 0, 0, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_Rotate', 1, N'顶升', N'AGV', N'AGV', 0, 0, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_Rotate', 2, N'原地旋转', N'Shelf_Now', N'Shelf_Now', NULL, NULL, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfIn', 1, N'行走', N'AGV', N'Shelf_Now', NULL, NULL, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfIn', 2, N'顶升', N'Shelf_Now', N'Shelf_Now', NULL, NULL, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfIn', 3, N'行走', N'Shelf_Now', N'EndBarcode', NULL, NULL, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfIn', 4, N'下降', N'EndBarcode', N'EndBarcode', NULL, NULL, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfMove', 1, N'行走', N'AGV', N'Shelf_Now', NULL, NULL, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfMove', 2, N'顶升', N'Shelf_Now', N'Shelf_Now', NULL, NULL, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfMove', 3, N'行走', N'Shelf_Now', N'EndBarcode', NULL, NULL, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfMove', 4, N'下降', N'EndBarcode', N'EndBarcode', NULL, NULL, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfOut', 1, N'行走', N'AGV', N'Shelf_Now', NULL, NULL, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfOut', 2, N'顶升', N'Shelf_Now', N'Shelf_Now', NULL, NULL, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfOut', 3, N'行走', N'Shelf_Now', N'RotateBarcode', NULL, NULL, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfOut', 4, N'原地旋转', N'RotateBarcode', N'RotateBarcode', NULL, NULL, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfOut', 5, N'行走', N'Shelf_Now', N'Pre_EndStation', 0, 0, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_ShelfOut', 6, N'行走', N'Pre_EndStation', N'EndStation', 0, 0, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_TranSport', 1, N'行走', N'AGV', N'Pre_StartStation', 0, 0, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_TranSport', 2, N'行走', N'Pre_StartStation', N'StartStation', 1, 0, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_TranSport', 3, N'取料', N'StartStation', N'StartStation', 0, 0, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_TranSport', 4, N'行走', N'StartStation', N'Pre_StartStation', 0, 0, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_TranSport', 5, N'行走', N'Pre_StartStation', N'Pre_StartStation', 0, 1, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_TranSport', 6, N'行走', N'Pre_StartStation', N'Pre_EndStation', 0, 0, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_TranSport', 7, N'行走', N'Pre_EndStation', N'EndStation', 1, 0, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_TranSport', 8, N'放料', N'EndStation', N'EndStation', 0, 0, 1)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_TranSport', 9, N'行走', N'EndStation', N'Pre_EndStation', 0, 0, 0)
INSERT [dbo].[T_Type_Split] ([TaskType], [SerialNo], [DType], [FromPoint], [ToPoint], [IsAsk], [IsSendOk], [HaveShelf]) VALUES (N'Task_TranSport', 10, N'行走', N'Pre_EndStation', N'Pre_EndStation', 0, 1, 0)
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_T_Type_Split]    Script Date: 2018/12/21 17:19:51 ******/
CREATE NONCLUSTERED INDEX [IX_T_Type_Split] ON [dbo].[T_Type_Split]
(
	[TaskType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[T_Task_Son] ADD  CONSTRAINT [DF_T_Task_Son_DialDirection]  DEFAULT ((0)) FOR [DialDirection]
GO
ALTER TABLE [dbo].[T_Task_Son] ADD  CONSTRAINT [DF_T_Task_Son_AgvDirection]  DEFAULT ((0)) FOR [AgvDirection]
GO
/****** Object:  StoredProcedure [dbo].[P_Base_GetAgv]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  --名称:获取AGV
  --功能描述:任务
  --代码编写:王欢欢
  --Date:2017-9-8
  /*********************************************************************/
  /*  如果您修改了程序，请留下修改记录，以便对程序进行维护！！！       */
  /*********************************************************************/
  --  修改人    修改时间    修改原因
  --
  /*********************************************************************/
CREATE PROCEDURE [dbo].[P_Base_GetAgv]
	@StationNo NVARCHAR(50),
	@ShelfNo NVARCHAR(50),
	@AgvNo NVARCHAR(50) OUT
  AS
BEGIN
	DECLARE @TmpCount int,@ExecText nvarchar(1000),@TmpBarcode NVARCHAR(50),@TmpAgvNo NVARCHAR(50),@TmpAreaNo NVARCHAR(50),@TmpDanagerCurrent float
BEGIN TRY
	SELECT @TmpBarcode = CurrentBarcode FROM dbo.T_Base_Shelf WHERE ShelfNo=@ShelfNo
	IF ISNULL(@TmpBarcode,'')='' BEGIN 
		SELECT @TmpBarcode = Barcode FROM dbo.T_Base_Station WHERE StationNo=@StationNo
	END 

	SELECT @TmpAreaNo=AreaNo FROM dbo.T_Base_Point WHERE Barcode=@TmpBarcode

	--判断当前点是否有AGV
	SELECT @TmpAgvNo = AgvNo FROM dbo.T_Base_AGV WHERE Barcode = @TmpBarcode;
	SELECT @TmpDanagerCurrent=Value FROM dbo.T_KeyValue_Config WHERE KeyVariable='Danger'

	--查询dbo.T_Task中是否有该AGV的任务
	SELECT DISTINCT AgvNo INTO #TmpTable FROM dbo.T_Task WHERE TaskState < 99 AND ISNULL(AgvNo, '') <> ''
	SELECT @TmpCount = COUNT(1) FROM #TmpTable WHERE AgvNo = @TmpAgvNo
	
	IF ISNULL(@TmpCount,0) = 0 BEGIN
		SET @AgvNo = @TmpAgvNo
	END
  
  --货架所在点没有agv或者（有agv，但agv有任务），这两种情况均要选择其他合适的AGV  
	IF(ISNULL(@AgvNo,'') = '') BEGIN
		
	--该货架点没有作为其他小车的终点
	SELECT @TmpCount=COUNT(1) FROM dbo.T_Base_Point 
	WHERE barcode= @TmpBarcode 
	AND (IsOccupy=1 AND OccupyAgvNo<>@TmpAgvNo)
	IF ISNULL(@TmpCount,0) = 0 BEGIN
		--state=11的小车
		
		--电量大于危险电量值
		--AGV状态更新时间差小于5秒，以防网络异常后state状态没有更新过来,造成还在线的假象
		--以上均满足的小车中获取最近的可用

		SELECT TOP 1 @AgvNo = agv.AgvNo FROM dbo.T_Base_AGV agv
		LEFT JOIN dbo.T_Base_Point pAgv ON agv.Barcode = pAgv.BarCode
		LEFT JOIN dbo.T_Base_Point pBegin ON pBegin.BarCode = @TmpBarcode
		WHERE agv.IsEnable = 1 AND State=11  AND Height = '1' AND agv.AreaNo=@TmpAreaNo
		--AND DATEDIFF(SECOND,agv.updatetime,GETDATE())<5 
		AND agv.CurrentCharge>@TmpDanagerCurrent
		AND agv.AgvNo NOT IN (SELECT AgvNo FROM #TmpTable)
		
		GROUP BY agv.AgvNo ORDER BY  min(ABS(pBegin.X - pAgv.X) + ABS(pBegin.Y - pAgv.Y))
	END 
	END
	
	
	DROP TABLE #TmpTable
END TRY	
BEGIN CATCH
	SET @ExecText=ERROR_MESSAGE(); RAISERROR(@ExecText,16,1);
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[P_Base_GetPoint]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  --名称:获取终点,通常由回家\充电\退出充电调用
  --功能描述:任务
  --代码编写:王欢欢
  --Date:2017-9-8
  /*********************************************************************/
  /*  如果您修改了程序，请留下修改记录，以便对程序进行维护！！！       */
  /*********************************************************************/
  --  修改人    修改时间    修改原因
  --
  /*********************************************************************/
CREATE PROCEDURE [dbo].[P_Base_GetPoint]
	@AgvNo NVARCHAR(50),
	@PointType NVARCHAR(50),
	@Barcode NVARCHAR(50) OUT
  AS
BEGIN
	DECLARE @TmpCount int,@ExecText nvarchar(1000),@TmpBarcode NVARCHAR(50),@TmpArea NVARCHAR(50)
	SET XACT_ABORT ON 
BEGIN TRY
	
	SELECT @TmpBarcode = Barcode,@TmpArea=AreaNo FROM dbo.T_Base_AGV WHERE AgvNo = @AgvNo

	BEGIN TRAN
		--判断当前点有无此点
		SELECT @Barcode = BarCode FROM dbo.T_Base_Point 
		WHERE Barcode = @TmpBarcode AND PointType = @PointType AND (IsOccupy=0 OR IsOccupy=1 AND OccupyAgvNo=@AgvNo)
		IF(ISNULL(@Barcode,'') = '') BEGIN 
			--获取最近的可用点
			--如果出库货架完成任务后解锁
			--回家选点可选未占用、当前点所属货架未被锁定、当前点货架确实还在当前点、点可用
			SELECT TOP 1 @Barcode = point.BarCode FROM dbo.T_Base_Point point
				LEFT JOIN dbo.T_Base_Point pBegin ON pBegin.BarCode = @TmpBarcode
				LEFT JOIN dbo.T_Base_Shelf shelf ON shelf.Barcode=point.BarCode 
				WHERE (shelf.IsLocked=0 AND shelf.Barcode=shelf.CurrentBarcode OR ISNULL(shelf.ShelfNo,'')='') 
				and point.IsEnable = 1 AND point.IsOccupy = 0 AND point.PointType = @PointType AND point.AreaNo LIKE N'%'+@TmpArea+'%'
				GROUP BY point.BarCode ORDER BY  min(ABS(pBegin.X - point.X) + ABS(pBegin.Y - point.Y))
		END
		IF(ISNULL(@Barcode,'') <> '') BEGIN 
			--占用已区到的点
			UPDATE  dbo.T_Base_Point SET OccupyAgvNo=@AgvNo,IsOccupy=1 WHERE BarCode=@Barcode
		END 
	COMMIT TRAN
END TRY	
BEGIN CATCH
	IF XACT_STATE()=-1 ROLLBACK TRAN
	SET @ExecText=ERROR_MESSAGE(); RAISERROR(@ExecText,16,1);
END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[P_Base_GetRotatePoint]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  --名称:获取终点,通常由回家\充电\退出充电调用
  --功能描述:任务
  --代码编写:王欢欢
  --Date:2017-9-8
  /*********************************************************************/
  /*  如果您修改了程序，请留下修改记录，以便对程序进行维护！！！       */
  /*********************************************************************/
  --  修改人    修改时间    修改原因
  --
  /*********************************************************************/
CREATE PROCEDURE [dbo].[P_Base_GetRotatePoint]
	@ShelfNo NVARCHAR(50),
	@PointType NVARCHAR(50),
	@Barcode NVARCHAR(50) OUT
  AS
BEGIN
	DECLARE @TmpCount int,@ExecText nvarchar(1000),@TmpBarcode NVARCHAR(50),@TmpArea NVARCHAR(50)
	SET XACT_ABORT ON 
BEGIN TRY
	
	SELECT @TmpBarcode = CurrentBarcode,@TmpArea=AreaNo FROM dbo.T_Base_Shelf WHERE ShelfNo = @ShelfNo

	BEGIN TRAN
		--判断当前点有无此点
		SELECT @Barcode = BarCode FROM dbo.T_Base_Point WHERE Barcode = @TmpBarcode AND PointType = @PointType;
		IF(ISNULL(@Barcode,'') = '') BEGIN 
			--获取最近的可用点
			
			SELECT TOP 1 @Barcode = point.BarCode FROM dbo.T_Base_Point point
				LEFT JOIN dbo.T_Base_Point pBegin ON pBegin.BarCode = @TmpBarcode			
				WHERE  point.IsEnable = 1 AND point.IsOccupy = 0 AND point.PointType = @PointType AND point.AreaNo LIKE N'%'+@TmpArea+'%'
				GROUP BY point.BarCode ORDER BY  min(ABS(pBegin.X - point.X) + ABS(pBegin.Y - point.Y))
		END
		
	COMMIT TRAN
END TRY	
BEGIN CATCH
	IF XACT_STATE()=-1 ROLLBACK TRAN
	SET @ExecText=ERROR_MESSAGE(); RAISERROR(@ExecText,16,1);
END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[P_Base_GetStation]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  --名称:获取终点,通常由回家\充电\退出充电调用
  --功能描述:任务
  --代码编写:王欢欢
  --Date:2017-9-8
  /*********************************************************************/
  /*  如果您修改了程序，请留下修改记录，以便对程序进行维护！！！       */
  /*********************************************************************/
  --  修改人    修改时间    修改原因
  --
  /*********************************************************************/
CREATE PROCEDURE [dbo].[P_Base_GetStation]
	@StationNo NVARCHAR(50) OUT,
	@Barcode NVARCHAR(50) OUT
  AS
BEGIN
	DECLARE @TmpCount int,@ExecText nvarchar(1000)
BEGIN TRY	
		DECLARE @TmpTaskNo NVARCHAR(20),@TmpAreaNo NVARCHAR(50),@TmpMaxDif NVARCHAR(50)

		SELECT @TmpMaxDif=value FROM [T_KeyValue_Config] WHERE [KeyVariable]= 'MaxYDiff'
		--随机选取一个可以填充的站台	
		
			SELECT @StationNo= StationNo ,@Barcode=Barcode FROM 
				(SELECT  TOP 1 StationNo, 
					ISNULL((SELECT COUNT(1) FROM dbo.T_Task WHERE StationNo = bs.StationNo AND TaskState < 99),0) tasknum,MaxTaskNum,Barcode
					FROM dbo.T_Base_Station bs
					WHERE  bs.StationType='OutStore' AND bs.IsEnable=1 
					--GROUP BY NEWID()
					ORDER BY NEWID()) A WHERE ISNULL(A.tasknum,0) <A.MaxTaskNum 

			IF (isnull(@StationNo,'')<>'')BEGIN
				
			--根据站台选择一条任务，该任务的货架点距离站台的Y差值最小
				SELECT TOP 1 @TmpTaskNo=task.TaskNo FROM dbo.T_Task task
				LEFT JOIN dbo.T_Base_Shelf shelf ON task.ShelfNo = shelf.ShelfNo 
				LEFT JOIN dbo.T_Base_Station station ON station.AreaNo=shelf.AreaNo
				LEFT JOIN dbo.T_Base_Point pShelf ON pShelf.Barcode = shelf.BarCode
				LEFT JOIN dbo.T_Base_Point pStation ON pStation.BarCode = station.Barcode
				WHERE TaskState>=1 AND ISNULL(task.StationNo,'')=''AND station.StationNo=@StationNo 
				AND ISNULL(task.Barcode,'')=''
				AND ABS(pShelf.Y-pStation.Y)<=@TmpMaxDif
				GROUP BY task.TaskNo,ABS(pShelf.Y-pStation.Y)
				ORDER BY MIN(ABS(pShelf.Y-pStation.Y))
		
		
				IF(ISNULL(@TmpTaskNo,'') <> '') BEGIN 
					--填充该任务的终点
					UPDATE  dbo.T_Task SET StationNo=@StationNo,Barcode=@Barcode WHERE TaskNo=@TmpTaskNo
				END 
			END 
END TRY	
BEGIN CATCH
	SET @ExecText=ERROR_MESSAGE(); RAISERROR(@ExecText,16,1);
END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[P_GetNewID]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[P_GetNewID]

@NEW_ID VARCHAR(16) OUTPUT

AS

BEGIN

DECLARE @DATE DATETIME

DECLARE @YY VARCHAR(4)

DECLARE @MM VARCHAR(2)

DECLARE @DD VARCHAR(2)


--保存取得的当前时间

SET @DATE = GETDATE()

SET @YY = DATEPART(YYYY, @DATE)

SET @MM = DATEPART(mm, @DATE)

SET @DD = DATEPART(dd, @DATE)


--位数不够的前面补0

SET @YY = REPLICATE('0', 4 - LEN(@YY)) + @YY

SET @MM = REPLICATE('0', 2 - LEN(@MM)) + @MM

SET @DD = REPLICATE('0', 2 - LEN(@DD)) + @DD


--取出表中当前日期的已有的最大ID

SET @NEW_ID = NULL

SELECT TOP 1 @NEW_ID = TaskNo FROM T_Task WHERE TaskNo LIKE  @YY+@MM+@DD+'%' ORDER BY TaskNo DESC


--如果未取出来

IF @NEW_ID IS NULL

--说明还没有当前日期的编号，则直接从1开始编号

SET @NEW_ID = (@YY+@MM+@DD+'0001')

--如果取出来了

ELSE

BEGIN

DECLARE @NUM VARCHAR(8)

--取出最大的编号加上1

SET @NUM = CONVERT(VARCHAR, (CONVERT(INT, RIGHT(@NEW_ID,4)) + 1))

--因为经过类型转换，丢失了高位的0，需要补上

SET @NUM = REPLICATE('0', 4 - LEN(@NUM)) + @NUM

--最后返回日期加编号

SET @NEW_ID = @YY+@MM+@DD + @NUM

END

END
GO
/****** Object:  StoredProcedure [dbo].[P_Task]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery91.sql|7|0|C:\Users\0226\AppData\Local\Temp\~vs9E3C.sql
  --名称:任务处理总入口
  --功能描述:
  --代码编写:王欢欢
  --Date:2017-9-5
  /*********************************************************************/
  /*  如果您修改了程序，请留下修改记录，以便对程序进行维护！！！       */
  /*********************************************************************/
  --  修改人    修改时间    修改原因
  --
  /*********************************************************************/
CREATE PROCEDURE [dbo].[P_Task]
  AS
BEGIN
	DECLARE @TmpCount int,@ExecText nvarchar(1000)
BEGIN TRY

	DECLARE @TmpTaskNo NVARCHAR(20),@TmpCurrentCharge numeric(10, 2),@TmpBarcode NVARCHAR(50),@TmpAgvNo NVARCHAR(50)
	,@TmpComare NVARCHAR(50)
	SET @TmpTaskNo = '';
	--判断任务是否可以执行
	DECLARE cursor0 CURSOR FOR SELECT  TaskNo FROM dbo.T_Task WHERE TaskState = 0 ORDER BY TaskLevel;
	OPEN cursor0;
	FETCH NEXT FROM cursor0 into @TmpTaskNo;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--调用存储过程
		EXEC dbo.P_Task_Start @TaskNo = @TmpTaskNo

		FETCH NEXT FROM cursor0 into @TmpTaskNo
	END
	CLOSE cursor0; DEALLOCATE cursor0;

	SET @TmpTaskNo = '';
	--补全任务
	--TaskState=1表示已经可以开始补全，TaskState=2表示已经至少补全过一次，因为一些原因未能成功
	DECLARE cursor1 CURSOR FOR 
		SELECT  TaskNo FROM dbo.T_Task ta 
			LEFT JOIN dbo.T_Base_AGV agv ON ta.AgvNo = agv.AgvNo
			WHERE TaskState = 1 OR TaskState=2 ORDER BY ta.TaskLevel,agv.CurrentCharge;
	OPEN cursor1;
	FETCH NEXT FROM cursor1 into @TmpTaskNo
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--调用存储过程
		EXEC dbo.P_Task_Fill @TaskNo = @TmpTaskNo,@TmpArea_Comp=@TmpComare OUT
		FETCH NEXT FROM cursor1 into @TmpTaskNo
	END
	CLOSE cursor1; DEALLOCATE cursor1;



	SET @TmpTaskNo = '';
	--分解任务
	DECLARE cursor2 CURSOR FOR 
		SELECT  TaskNo FROM dbo.T_Task ta 
			LEFT JOIN dbo.T_Base_AGV agv ON ta.AgvNo = agv.AgvNo
			WHERE TaskState = 3 ORDER BY ta.TaskLevel,agv.CurrentCharge;
	OPEN cursor2;
	FETCH NEXT FROM cursor2 into @TmpTaskNo
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--调用存储过程
		EXEC dbo.P_Task_Split @TaskNo = @TmpTaskNo
		FETCH NEXT FROM cursor2 into @TmpTaskNo
	END
	CLOSE cursor2; DEALLOCATE cursor2;
END TRY	
BEGIN CATCH
	SET @ExecText=ERROR_MESSAGE(); RAISERROR(@ExecText,16,1);
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[P_Task_Create]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--名称:创建任务
  --功能描述:判断传入参数是否合格，如果合格，则任务创建成功
  --代码编写:王欢欢
  --Date:2017-9-5
  /*********************************************************************/
  /*  如果您修改了程序，请留下修改记录，以便对程序进行维护！！！       */
  /*********************************************************************/
  --  修改人    修改时间    修改原因
  --
  /*********************************************************************/
CREATE PROCEDURE [dbo].[P_Task_Create]
	@TaskType NVARCHAR(50),
	@ShelfNo NVARCHAR(50),
	@PalletNo NVARCHAR(50),
	@TaskLevel INT,
	@AgvNo NVARCHAR(50),
	@Direction NVARCHAR(50),
	@StationNo NVARCHAR(50),
	@Barcode NVARCHAR(50),
	@FromStationNo NVARCHAR(50),
	@TaskState INT = 0,
	@FromStep INT =0,
	@AreaNo NVARCHAR(50)
  AS

BEGIN
	DECLARE @TmpCount int,@ExecText nvarchar(1000)
BEGIN TRY
	
	SELECT @TmpCount = COUNT(1) FROM dbo.T_Type_Config WHERE FITEMNO = 'TaskType' AND ItemNo = @TaskType
	IF(ISNULL(@TmpCount,0) = 0) BEGIN
		SET @ExecText = '无此任务类型：' + ISNULL(@TaskType,'')	RAISERROR(@ExecText,16,1);
	END

	IF(ISNULL(@ShelfNo,'') <> '') BEGIN
		SELECT @TmpCount = COUNT(1) FROM dbo.T_Base_Shelf WHERE ShelfNo = @ShelfNo
		IF(ISNULL(@TmpCount,0) = 0) BEGIN
			SET @ExecText = '无此货架号：' + ISNULL(@ShelfNo,'')	RAISERROR(@ExecText,16,1);
		END
	END 

	IF(ISNULL(@AgvNo,'') <> '') BEGIN
		SELECT @TmpCount = COUNT(1) FROM T_Task WHERE AgvNo=@AgvNo AND TaskState<99
		IF(ISNULL(@TmpCount,0) >1) BEGIN
			SET @ExecText = '此AGV正在执行任务：' + ISNULL(@AgvNo,'')	RAISERROR(@ExecText,16,1);
		END
	END 

	IF(ISNULL(@StationNo,'') <> '') BEGIN
		SELECT @TmpCount = COUNT(1) FROM dbo.T_Base_Station WHERE StationNo = @StationNo
		IF(ISNULL(@TmpCount,0) = 0) BEGIN
			SET @ExecText = '无此Station：' + ISNULL(@StationNo,'')	RAISERROR(@ExecText,16,1);
		END
	END 

	IF(ISNULL(@FromStationNo,'') <> '') BEGIN
		SELECT @TmpCount = COUNT(1) FROM dbo.T_Base_Station WHERE StationNo = @FromStationNo
		IF(ISNULL(@TmpCount,0) = 0) BEGIN
			SET @ExecText = '无此Station：' + ISNULL(@FromStationNo,'')	RAISERROR(@ExecText,16,1);
		END
	END 

	IF(ISNULL(@Barcode,'') <> '') BEGIN
		SELECT @TmpCount = COUNT(1) FROM dbo.T_Base_Point WHERE BarCode = @Barcode
		IF(ISNULL(@TmpCount,0) = 0) BEGIN
			SET @ExecText = '无此Point：' + ISNULL(@Barcode,'')	RAISERROR(@ExecText,16,1);
		END
	END 

	--回家任务、充电任务、退出充电任务等在创建时只会传入任务类型和小车号
	--故而只需保证小车没有重复任务即可
	IF ISNULL(@TaskType ,'') NOT IN ('Task_Charge','Task_ChargeCancel','Task_AgvHome') BEGIN 
		SELECT @TmpCount = COUNT(1) FROM T_Task WHERE TaskType = @TaskType 
			AND ShelfNo = ISNULL(@ShelfNo,'') AND StationNo = ISNULL(@StationNo,'')
			 AND Barcode = ISNULL(@Barcode,'')
			 AND FromStationNo=ISNULL(@FromStationNo,'') AND TaskState < 99
			 AND PalletNo=ISNULL(@PalletNo,'')
		IF(ISNULL(@TmpCount,0) <> 0) BEGIN
			SET @ExecText = '已有重复的任务！';	RAISERROR(@ExecText,16,1);
		END
  END   
  IF (ISNULL(@AgvNo,'')<>'') BEGIN 
	SELECT @TmpCount=COUNT(1) FROM dbo.T_Task WHERE AgvNo=@AgvNo AND TaskState<99  
	IF(ISNULL(@TmpCount,0) <> 0) BEGIN
			SET @ExecText = '建立重复小车任务！';	RAISERROR(@ExecText,16,1);
	END 
 END 

	
	DECLARE @NEW_ID NVARCHAR(50)
	EXEC dbo.P_GetNewID	@NEW_ID = @NEW_ID OUTPUT

	INSERT INTO dbo.T_Task
	        ( TaskNo ,
	          TaskType ,
	          ShelfNo ,
			  PalletNo,
	          TaskState ,
	          TaskLevel ,
	          AgvNo ,
	          Direction ,
	          StationNo ,
	          Barcode ,
	          ErrorMsg ,
	          CreateTime ,
	          SubmitTime ,
	          BeginTime ,
	          EndTime,
			  FromStationNo,
			  FromStep,
			  AreaNo,
			  RotateDir,
			  RotateBarcode
	        )
	VALUES  ( @NEW_ID , -- TaskNo - nvarchar(50)		 此处调用存储过程，获取任务号
	          @TaskType , -- TaskType - nvarchar(50)
	          ISNULL(@ShelfNo,'') , -- ShelfNo - nvarchar(50)
			  ISNULL(@PalletNo,''),
	          @TaskState , -- TaskState - int
	          ISNULL(@TaskLevel,0) , -- TaskLevel - int
	          ISNULL(@AgvNo,'') , -- AgvNo - nvarchar(50)
	          ISNULL(@Direction,'') , -- ShelfDirection - nvarchar(50)
	          ISNULL(@StationNo,'') , -- StationNo - nvarchar(50)
	          ISNULL(@Barcode,'') , -- EndBarcode - nvarchar(50)
	          N'' , -- ErrorMsg - nvarchar(50)
	          GETDATE() , -- AcceptTime - datetime
	          NULL , -- SubmitTime - datetime
	          NULL , -- BeginTime - datetime
	          NULL , -- EndTime - datetime
			  ISNULL(@FromStationNo,''),
			  @FromStep,
			  @AreaNo,
			  0,
			  N''
	        )
			IF(@@ROWCOUNT <> 1) BEGIN
				SET @ExecText = '插入到任务表中失败！';	RAISERROR(@ExecText,16,1);
			END


END TRY	
BEGIN CATCH
	SET @ExecText=ERROR_MESSAGE(); RAISERROR(@ExecText,16,1);
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[P_Task_Delete]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[P_Task_Delete]
	-- Add the parameters for the stored procedure here
	@TmpTaskNo NVARCHAR(20),
	@TmpAgvNo NVARCHAR(50)
AS
BEGIN
	DECLARE @TmpCount int,@ExecText nvarchar(1000)
BEGIN TRY
	DELETE dbo.T_Task_Son WHERE TaskNo=@TmpTaskNo

	INSERT INTO [dbo].[T_Task_Delete]
					([TaskNo]
					,[AgvNo]
					,[State]
					,[CreateTime])
				VALUES
					(@TmpTaskNo
					,@TmpAgvNo
					,0
					,GETDATE())

END TRY	
BEGIN CATCH
	SET @ExecText=ERROR_MESSAGE(); RAISERROR(@ExecText,16,1);
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[P_Task_Fill]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  --名称:任务填充AGV/充电桩
  --功能描述:补全主任务信息
  --代码编写:王欢欢
  --Date:2017-9-8
  /*********************************************************************/
  /*  如果您修改了程序，请留下修改记录，以便对程序进行维护！！！       */
  /*********************************************************************/
  --  修改人    修改时间    修改原因
  --
  /*********************************************************************/
CREATE PROCEDURE [dbo].[P_Task_Fill]
	@TaskNo NVARCHAR(20)
	,@TmpArea_Comp NVARCHAR(50) OUT
  AS
BEGIN
	DECLARE @TmpCount int,@ExecText nvarchar(1000)

BEGIN TRY
	
	DECLARE @TmpTaskType NVARCHAR(50),@TmpAgvNo NVARCHAR(50),@TmpShelfNo NVARCHAR(50),@TmpStationNo NVARCHAR(50),
	@TmpEndBarcode NVARCHAR(50),@TmpFromStation NVARCHAR(50),
	@TmpAreaNo NVARCHAR(50),@TmpDirection NVARCHAR(50),@TmpRotateBarcode NVARCHAR(50)
	SELECT TOP 1 @TmpTaskType = TaskType,@TmpAgvNo = AgvNo,@TmpShelfNo = ShelfNo,
		@TmpStationNo = StationNo,@TmpEndBarcode = Barcode,@TmpFromStation=FromStationNo,
		@TmpDirection=Direction,@TmpRotateBarcode=RotateBarcode,
		@TmpAreaNo=AreaNo
		FROM dbo.T_Task WHERE TaskNo = @TaskNo;

    --第一次区域填补：货架区任务    
	IF(ISNULL(@TmpAreaNo,'')='')BEGIN
		SELECT @TmpAreaNo=AreaNo FROM dbo.T_Base_Shelf WHERE ShelfNo=@TmpShelfNo
	END
	

	IF(ISNULL(@TmpTaskType,'') IN ('Task_Charge')) BEGIN										--充电 补充终点
		--获取充电桩,更新到主任务
		SELECT @TmpAreaNo=AreaNo FROM dbo.T_Base_AGV WHERE AgvNo = @TmpAgvNo
		IF (@TmpArea_Comp LIKE N'%'+@TmpAreaNo +'%')  BEGIN
			SET @ExecText='有电量更低的小车未获取到充电位？';GOTO NotOk;
        END 
		IF(ISNULL(@TmpEndBarcode,'') = '') BEGIN
			EXEC P_Base_GetPoint @AgvNo = @TmpAgvNo,@PointType = '3',@Barcode = @TmpEndBarcode OUT 
			IF(ISNULL(@TmpEndBarcode,'') = '') BEGIN 

				SET @TmpArea_Comp= ISNULL(@TmpArea_Comp,'') +@TmpAreaNo;
				SET @ExecText= '无可用的充电桩？'; GOTO NotOK;
			END
		END 
	END
	ELSE IF(ISNULL(@TmpTaskType,'') IN ('Task_ChargeCancel','Task_AgvHome')) BEGIN									--AGV回家 补充终点
		IF(ISNULL(@TmpEndBarcode,'') = '') BEGIN 
			EXEC P_Base_GetPoint @AgvNo = @TmpAgvNo,@PointType = '6',@Barcode = @TmpEndBarcode OUT 
			IF(ISNULL(@TmpEndBarcode,'') = '') BEGIN 
				SET @ExecText= '无可用的回家点？'; GOTO NotOK;
			END
		END
	END

	IF(ISNULL(@TmpEndBarcode,'') = '') BEGIN 
		IF ISNULL(@TmpTaskType,'') = 'Task_ShelfIn' BEGIN 
			SELECT @TmpEndBarcode = Barcode FROM dbo.T_Base_Shelf WHERE ShelfNo = @TmpShelfNo
		END 
		ELSE IF ISNULL(@TmpTaskType,'')  ='Task_ShelfOut' BEGIN
			IF ISNULL(@TmpStationNo,'')='' BEGIN 
				EXEC P_Base_GetStation @StationNo=@TmpStationNo,@Barcode=@TmpEndBarcode 
			END 
			ELSE BEGIN        
				SELECT @TmpEndBarcode = Barcode FROM dbo.T_Base_Station WHERE StationNo = @TmpStationNo
			END 
			IF ISNULL(@TmpStationNo,'')='' BEGIN
  				SET @ExecText= '无合适的站台可以填充到任务'; GOTO NotOK;          
			END           
		END 
		ELSE IF ISNULL(@TmpTaskType,'') = 'Task_Rotate' BEGIN
			SELECT @TmpEndBarcode = CurrentBarcode FROM dbo.T_Base_Shelf WHERE ShelfNo = @TmpShelfNo
		END 
	END 

	
	IF(ISNULL(@TmpAgvNo,'') = '') BEGIN
		--查找AGV
		EXEC [dbo].[P_Base_GetAgv] @TmpFromStation,@TmpShelfNo,@AgvNo = @TmpAgvNo OUTPUT
		IF(ISNULL(@TmpAgvNo,'') = '') BEGIN 
			SET @ExecText= '无可用的AGV'; GOTO NotOK;
		END
	END

	--第二次区域填补：回家或是充电任务    
	IF(ISNULL(@TmpAreaNo,'')='')BEGIN
		SELECT @TmpAreaNo=AreaNo FROM dbo.T_Base_AGV WHERE AgvNo = @TmpAgvNo
	END
	
	DECLARE @TmpShelfDirection NVARCHAR(50),@TmpStationDirection NVARCHAR(50),@DialDirection INT ------------补全旋转方向
	SELECT @TmpShelfDirection = ShelfDirection FROM dbo.T_Base_Shelf WHERE ShelfNo = @TmpShelfNo
	SELECT @TmpStationDirection = Direction FROM dbo.T_Base_Station WHERE StationNo = @TmpStationNo
	IF @TmpTaskType IN ('Task_ShelfOut') BEGIN
		IF ISNULL(@TmpDirection,'')=''  BEGIN  
			SET @DialDirection = 5
		END 		   
		ELSE IF ( CAST(@TmpStationDirection AS int) -CAST(@TmpShelfDirection AS INT )+CAST(@TmpDirection AS INT )-1<>0)BEGIN
			SET @DialDirection=CAST(@TmpStationDirection AS int) -CAST(@TmpShelfDirection AS INT )+CAST(@TmpDirection AS INT )-1
			IF @DialDirection<0 BEGIN
				SET @DialDirection= @DialDirection+4+5
				
			END
			ELSE IF @DialDirection>3 BEGIN
				SET @DialDirection= @DialDirection-4+5
			END 
			ELSE BEGIN 
				SET @DialDirection= @DialDirection+5
			END 
			------  ceshi 
			SET @DialDirection = 0

		END
		IF ISNULL(@DialDirection,0)>5 BEGIN
			EXEC [dbo].[P_Base_GetRotatePoint] @ShelfNo=@TmpShelfNo,@PointType='8',@BarCode=@TmpRotateBarcode OUTPUT      
		
			IF(ISNULL(@TmpRotateBarcode,'') = '') BEGIN 
				SET @ExecText= '无可用的旋转点'; GOTO NotOK;
			END 
		END      
    END
	ELSE BEGIN
  	SET @DialDirection=0;  
	END      
    
	UPDATE dbo.T_Task SET AgvNo = @TmpAgvNo,Barcode = @TmpEndBarcode,
						  StationNo=@TmpStationNo, TaskState = 3,ErrorMsg = '',
						  SubmitTime = GETDATE(),RotateDir=ISNULL(@DialDirection,0),
						  RotateBarcode=@TmpRotateBarcode,AreaNo=ISNULL(@TmpAreaNo,'')
		WHERE TaskNo = @TaskNo
	GOTO NN;

	NotOK:BEGIN
		UPDATE dbo.T_Task SET TaskState = 2, ErrorMsg = @ExecText,ErrorTime = GETDATE() WHERE TaskNo = @TaskNo
	END 

	NN:BEGIN
		SELECT 1
END 
END TRY	
BEGIN CATCH
	SET @ExecText=ERROR_MESSAGE(); RAISERROR(@ExecText,16,1);
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[P_Task_Finish]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  --名称:完成任务
  --功能描述:判断传入参数是否合格，如果合格，则任务创建成功
  --代码编写:
  --Date:
  /*********************************************************************/
  /*  如果您修改了程序，请留下修改记录，以便对程序进行维护！！！       */
  /*********************************************************************/
  --  修改人    修改时间    修改原因
  --
  /*********************************************************************/
CREATE PROCEDURE [dbo].[P_Task_Finish]
	@SID INT
  AS

BEGIN
	DECLARE @TmpCount int,@ExecText nvarchar(1000)
BEGIN TRY

	DECLARE @TmpTaskNo NVARCHAR(50),@TmpShelfNo nvarchar(50),@TmpTaskType nvarchar(50)
	SELECT @TmpTaskNo = TaskNo FROM dbo.T_Task_Son WHERE SID = @SID
	SELECT @TmpShelfNo= ShelfNo,@TmpTaskType=TaskType  from dbo.T_Task WHERE TaskNo = @TmpTaskNo
	IF ISNULL(@TmpTaskNo,'') = '' BEGIN RAISERROR('无法查找到此任务',16,1); END
	--删除子任务
	--删除子任务路径
	DELETE dbo.T_Task_Son WHERE SID = @SID
	DELETE dbo.T_Base_PathList WHERE SID=@SID
	SELECT @TmpCount = COUNT(1) FROM dbo.T_Task_Son WHERE TaskNo = @TmpTaskNo 
	IF ISNULL(@TmpCount,0) = 0 BEGIN
  --一条主任务执行完毕，更新主任务状态，更新货架锁  
		UPDATE dbo.T_Task SET TaskState = 99, EndTime = GETDATE() WHERE TaskNo = @TmpTaskNo
		IF  @TmpShelfNo<>''  BEGIN 
			UPDATE dbo.T_Base_Shelf SET IsLocked = 0 WHERE IsEnable = 1 AND IsLocked = 1 AND ShelfNo = @TmpShelfNo
			--不用检查是否更新成功
			--因为托盘和货架共用一个变量
			--但是托盘好并没有存入dbo.T_Base_Shelf，所以一定会更新失败
		END 
	END 
END TRY	
BEGIN CATCH
	SET @ExecText=ERROR_MESSAGE(); RAISERROR(@ExecText,16,1);
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[P_Task_Split]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery83.sql|7|0|C:\Users\0226\AppData\Local\Temp\~vs8B16.sql
-- Batch submitted through debugger: SQLQuery72.sql|7|0|C:\Users\0226\AppData\Local\Temp\~vsFB78.sql
  --名称:分解任务
  --功能描述:
  --代码编写:王欢欢
  --Date:2017-9-8
  /*********************************************************************/
  /*  如果您修改了程序，请留下修改记录，以便对程序进行维护！！！       */
  /*********************************************************************/
  --  修改人    修改时间    修改原因
  --
  /*********************************************************************/
CREATE PROCEDURE [dbo].[P_Task_Split]
	@TaskNo NVARCHAR(50)

  AS
BEGIN
	DECLARE @TmpCount int,@ExecText nvarchar(1000)

BEGIN TRY
	DECLARE @DialDirection INT ,@TmpStationDirection NVARCHAR(50) ,@TmpShelfDirection NVARCHAR(50),@TmpAgvDirection INT

	DECLARE @TmpTaskType NVARCHAR(50),@TmpAgvNo NVARCHAR(50),@TmpShelfNo NVARCHAR(50),
	@TmpStationNo NVARCHAR(50),@TmpEndBarcode NVARCHAR(50),@TmpDirection INT ,
	@TmpFromStation NVARCHAR(50),@TmpConStation NVARCHAR(50),
	@TmpFromStep INT ,@TmpRotateBarcode NVARCHAR(50),@TmpDialDirection INT 
	SELECT TOP 1 @TmpTaskType = TaskType,@TmpAgvNo = AgvNo,@TmpShelfNo = ShelfNo,
		@TmpStationNo = StationNo,@TmpEndBarcode = Barcode,@TmpDirection = Direction ,
		@TmpFromStation=FromStationNo,@TmpFromStep=FromStep,
		@DialDirection=RotateDir,@TmpRotateBarcode=RotateBarcode 
		FROM dbo.T_Task WHERE TaskNo = @TaskNo;

	DECLARE @TmpSerialNo INT,@TmpDType NVARCHAR(50),@TmpFromPoint NVARCHAR(50),
	@TmpToPoint NVARCHAR(50),@TmpIsAsk BIT,@TmpIsSendOk BIT,@TmpHaveShelf BIT
	DECLARE cursor_My CURSOR FOR SELECT SerialNo,DType,FromPoint,ToPoint,IsAsk,IsSendOk,HaveShelf FROM T_Type_Split  WHERE TaskType = @TmpTaskType AND SerialNo>=@TmpFromStep  ORDER BY SerialNo
	OPEN cursor_My;
	FETCH NEXT FROM cursor_My into @TmpSerialNo,@TmpDType,@TmpFromPoint,@TmpToPoint,@TmpIsAsk,@TmpIsSendOk,@TmpHaveShelf;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		DECLARE @TmpBPoint NVARCHAR(50),@TmpEPoint NVARCHAR(50)

		--任务起点和终点的选取
		--任务分解是怎么存入子任务列表

		--获取起点终点
		SET @TmpBPoint=''
		SET @TmpEPoint=''
		SET @TmpDialDirection=''
		IF(@TmpFromPoint = 'AGV') BEGIN 
			SELECT @TmpBPoint = Barcode FROM dbo.T_Base_AGV WHERE AgvNo = @TmpAgvNo
		END 
		ELSE IF(@TmpFromPoint = 'EndBarcode') BEGIN
			SELECT @TmpBPoint = @TmpEndBarcode
		END 
		ELSE IF(@TmpFromPoint = 'Shelf_Now') BEGIN
			SELECT @TmpBPoint = CurrentBarcode FROM dbo.T_Base_Shelf WHERE ShelfNo = @TmpShelfNo
		END
		 
		ELSE IF(@TmpFromPoint='Pre_StartStation')BEGIN
			SELECT @TmpBPoint=Pre_Barcode FROM dbo.T_Base_Station WHERE StationNo=@TmpFromStation
		END

		ELSE IF(@TmpFromPoint='StartStation')BEGIN
			SELECT @TmpBPoint=Barcode FROM dbo.T_Base_Station WHERE StationNo=@TmpFromStation
		END

		ELSE IF(@TmpFromPoint='Pre_EndStation')BEGIN
			SELECT @TmpBPoint=Pre_Barcode FROM dbo.T_Base_Station WHERE StationNo=@TmpStationNo
		END

		ELSE IF(@TmpFromPoint='EndStation')BEGIN
			SELECT @TmpBPoint=Barcode FROM dbo.T_Base_Station WHERE StationNo=@TmpStationNo
		END
		ELSE IF(@TmpFromPoint='RotateBarcode')BEGIN
			IF(ISNULL(@TmpRotateBarcode,'')<>'')BEGIN
				SET @TmpBPoint=@TmpRotateBarcode          
			END
			ELSE BEGIN
				GOTO BEE;       
			END     
		END      

		IF(@TmpToPoint = 'AGV') BEGIN 
			SELECT @TmpEPoint = Barcode FROM dbo.T_Base_AGV WHERE AgvNo = @TmpAgvNo
		END 
		ELSE IF(@TmpToPoint = 'RotateBarcode') BEGIN
			IF(ISNULL(@TmpRotateBarcode,'')<>'')BEGIN
				SET @TmpEPoint=@TmpRotateBarcode          
			END
			ELSE BEGIN
				GOTO BEE;       
			END            
		END 
		ELSE IF(@TmpToPoint = 'EndBarcode') BEGIN
			SELECT @TmpEPoint = @TmpEndBarcode
			SELECT @TmpAgvDirection=OriAgv FROM dbo.T_Base_Point WHERE Barcode=@TmpEPoint 
		END 
		ELSE IF(@TmpToPoint = 'Shelf_Now') BEGIN
			SELECT @TmpEPoint = CurrentBarcode FROM dbo.T_Base_Shelf WHERE ShelfNo = @TmpShelfNo
		END 

		ELSE  IF(@TmpToPoint='Pre_StartStation')BEGIN
			SELECT @TmpEPoint=Pre_Barcode FROM dbo.T_Base_Station WHERE StationNo=@TmpFromStation
		END

		ELSE  IF(@TmpToPoint='StartStation')BEGIN
			SELECT @TmpEPoint=Barcode FROM dbo.T_Base_Station WHERE StationNo=@TmpFromStation
		END

		ELSE  IF(@TmpToPoint='Pre_EndStation')BEGIN
			SELECT @TmpEPoint=Pre_Barcode FROM dbo.T_Base_Station WHERE StationNo=@TmpStationNo
		END

		ELSE  IF(@TmpToPoint='EndStation')BEGIN
			SELECT @TmpEPoint=Barcode, @TmpAgvDirection=AgvDirection 
			FROM dbo.T_Base_Station WHERE StationNo=@TmpStationNo
		END     

		SELECT @TmpShelfDirection = ShelfDirection FROM dbo.T_Base_Shelf WHERE ShelfNo = @TmpShelfNo
		SELECT @TmpStationDirection = Direction FROM dbo.T_Base_Station WHERE StationNo = @TmpStationNo
		IF (@TmpDType='原地旋转')BEGIN
			   
			SET @TmpDialDirection=@DialDirection
		END
	
		
		--需要询问或是发送完成信号的时候要给站台号
		IF(@TmpIsAsk=1) OR (@TmpIsSendOk=1) BEGIN
			IF(ISNULL(@TmpSerialNo,0)>5) BEGIN
				SET @TmpConStation=ISNULL(@TmpStationNo,'')
			END
			ELSE BEGIN
			    SET @TmpConStation=ISNULL(@TmpFromStation,'')
			END
		END

		INSERT INTO dbo.T_Task_Son
		        ( TaskNo ,
		          STaskType ,
				  SerialNo,
				  AgvNo,
		          BeginPoint ,
		          EndPoint ,
		          DialDirection ,
		          AgvDirection ,
		          State ,
		          CBeginTime ,
		          CEndTime,
				  ConStation,
				  C_IsAsk,
				  C_IsSendOk,
				  HaveShelf
		        )
		VALUES  ( @TaskNo , -- TaskNo - nvarchar(50)
		          @TmpDType , -- STaskType - nvarchar(50)
				  @TmpSerialNo,
				  @TmpAgvNo,
		          @TmpBPoint , -- BeginPoint - nvarchar(50)
		          @TmpEPoint , -- EndPoint - nvarchar(50)
		          ISNULL(@TmpDialDirection,0) , -- IsCircle - bit
		          ISNULL(@TmpAgvDirection,0) , -- Direction - nvarchar(50)
		          0 , -- State - nvarchar(50)
		          GETDATE() , -- CBeginTime - datetime
		          null,  -- CEndTime - datetime
				  @TmpConStation,--contact station
				  @TmpIsAsk,--ask or not
				  @TmpIsSendOk,--send ok or not
				  @TmpHaveShelf
		        )

		--占用子任务终点
		BEE:BEGIN
			SELECT 1      
		END      
		FETCH NEXT FROM cursor_My into @TmpSerialNo,@TmpDType,@TmpFromPoint,@TmpToPoint,@TmpIsAsk,@TmpIsSendOk,@TmpHaveShelf;
	END
	CLOSE cursor_My; DEALLOCATE cursor_My;
	UPDATE dbo.T_Task SET TaskState = 4 WHERE TaskNo = @TaskNo


END TRY	
BEGIN CATCH
	SET @ExecText=ERROR_MESSAGE(); RAISERROR(@ExecText,16,1);
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[P_Task_Start]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  --名称:判断任务是否可以开始
  --功能描述:检查任务是否可以开始执行
  --代码编写:王欢欢
  --Date:2017-9-5
  /*********************************************************************/
  /*  如果您修改了程序，请留下修改记录，以便对程序进行维护！！！       */
  /*********************************************************************/
  --  修改人    修改时间    修改原因
  --
  /*********************************************************************/
CREATE PROCEDURE [dbo].[P_Task_Start]
	@TaskNo NVARCHAR(50)

  AS
BEGIN
	DECLARE @TmpCount int,@ExecText nvarchar(1000)
BEGIN TRY
	DECLARE @TmpTaskType NVARCHAR(50),@TmpAgvNo NVARCHAR(50),@TmpShelfNo NVARCHAR(50),@TmpStationNo NVARCHAR(50),@TmpEndBarcode NVARCHAR(50),@TmpFromStationNo  NVARCHAR(50)
	SELECT TOP 1 @TmpTaskType = TaskType,@TmpAgvNo = AgvNo,@TmpShelfNo = ShelfNo,@TmpStationNo = StationNo,@TmpEndBarcode = Barcode,@TmpFromStationNo=FromStationNo FROM dbo.T_Task WHERE TaskNo = @TaskNo;

	IF(ISNULL(@TmpStationNo,'')<>'') BEGIN					--目标站台不空时，判断能否执行目标站台任务（充电桩、货架回家点、工作台、输送台、目标点等）
		DECLARE @TmpStationType NVARCHAR(50), @TmpMaxTaskNum INT 

		SELECT @TmpStationType = StationType,@TmpMaxTaskNum = MaxTaskNum FROM dbo.T_Base_Station WHERE StationNo = @TmpStationNo

		IF(ISNULL(@TmpStationType,'') IN ('WorkStation','InStore','OutStore','MidStation')) BEGIN		--如果是工作台
			SELECT @TmpCount = COUNT(1) FROM dbo.T_Task WHERE StationNo = @TmpStationNo and  TaskState > 0 AND TaskState < 99;

			IF(ISNULL(@TmpCount,0) >= @TmpMaxTaskNum) BEGIN 
				SET @ExecText=ISNULL(@TmpStationNo,'') + '站台：任务数量已达到限制' ; GOTO NextTask;
			END 
		END
	END

	IF ISNULL(@TmpAgvNo,'')<>'' BEGIN					--如果AGV不为空，则检查AGV的状态，以及AGV是否有正在执行的任务
		SELECT @TmpCount = COUNT(1) FROM dbo.T_Base_AGV WHERE AgvNo = @TmpAgvNo AND IsEnable = 1
		IF ISNULL(@TmpCount,0) = 0 BEGIN 
			SET @ExecText=ISNULL(@TmpAgvNo,'') + 'Agv不可用' ; GOTO NextTask;
		END 

		SET @TmpCount = 0;
		SELECT @TmpCount = COUNT(1) FROM dbo.T_Task WHERE AgvNo = @TmpAgvNo AND TaskState > 0 AND TaskState < 99
		IF ISNULL(@TmpCount,0) > 0 BEGIN 
			SET @ExecText=ISNULL(@TmpAgvNo,'') + '任务中有此Agv未执行完毕的任务' ; GOTO NextTask;
		END 
	END

	IF(ISNULL(@TmpShelfNo,'') <> '') BEGIN					--货架不为空时，更新货架为锁定状态
		UPDATE dbo.T_Base_Shelf SET IsLocked = 1 WHERE IsEnable = 1 AND IsLocked = 0 AND ShelfNo = @TmpShelfNo
		IF @@ROWCOUNT = 0 BEGIN
			SET @ExecText=ISNULL(@TmpShelfNo,'') + '货架：更新为已锁定失败，请检查是否未启用/已被锁定？'; GOTO NextTask;
		END
	END

	--提交任务
	UPDATE dbo.T_Task SET TaskState = 1 WHERE TaskNo = @TaskNo;
	GOTO NN

	NextTask:BEGIN
		UPDATE dbo.T_Task SET ErrorMsg = @ExecText,ErrorTime = GETDATE() WHERE TaskNo = @TaskNo
	END 

	NN:BEGIN
		SELECT 1
	END 
END TRY	
BEGIN CATCH
	SET @ExecText=ERROR_MESSAGE(); RAISERROR(@ExecText,16,1);
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[P_Tmp_InTask]    Script Date: 2018/12/21 17:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[P_Tmp_InTask]
	-- Add the parameters for the stored procedure here
@shelfNo nvarchar(50)	
AS
BEGIN
	DECLARE @TmpCount int,@ExecText nvarchar(1000)
BEGIN TRY
	DECLARE @TmpTaskType NVARCHAR(50),@TmpAgvNo NVARCHAR(50),@TmpShelfNo nvarchar(50),@TmpCurrentBarcode NVARCHAR(50),@TmpBarcode NVARCHAR(50) ,@TmpArea NVARCHAR(50) 
	
	SELECT @TmpCurrentBarcode=CurrentBarcode,@TmpBarcode=Barcode ,@TmpArea=AreaNo FROM dbo.T_Base_Shelf WHERE ShelfNo=@shelfNo
		
	SELECT @TmpAgvNo= AgvNo FROM  dbo.T_Base_AGV WHERE  Barcode=@TmpCurrentBarcode  
	EXEC dbo.P_Task_Create @TaskType = 'Task_ShelfIn', -- nvarchar(50)
		@ShelfNo = @TmpShelfNo, -- nvarchar(50)
		@TaskLevel = 0, -- int
		@AgvNo =@TmpAgvNo, -- nvarchar(50)
		@PalletNo=N'',
		@Direction = N'', -- nvarchar(50)
		@StationNo = N'', -- nvarchar(50)
		@Barcode = @TmpBarcode, -- nvarchar(50)
		@FromStationNo = N'', -- nvarchar(50)
		@TaskState = 0, -- int
		@FromStep = 3, -- int
		@AreaNo = @TmpArea -- nvarchar(50)	    
		--UPDATE dbo.T_Base_Shelf SET IsLocked=1 WHERE ShelfNo=@TmpShelfNo
END TRY	
BEGIN CATCH
	SET @ExecText=ERROR_MESSAGE(); RAISERROR(@ExecText,16,1);
END CATCH
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1：朝东；2：朝南；3：朝西；4：朝西' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_Base_AGV', @level2type=N'COLUMN',@level2name=N'Direction'
GO
USE [master]
GO
ALTER DATABASE [ACSNEW] SET  READ_WRITE 
GO
