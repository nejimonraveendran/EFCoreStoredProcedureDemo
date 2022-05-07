USE [ProductsDb]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertProduct]    Script Date: 2022-05-07 3:55:13 PM ******/
DROP PROCEDURE [dbo].[SP_InsertProduct]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllProducts]    Script Date: 2022-05-07 3:55:13 PM ******/
DROP PROCEDURE [dbo].[SP_GetAllProducts]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2022-05-07 3:55:13 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Products]') AND type in (N'U'))
DROP TABLE [dbo].[Products]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 2022-05-07 3:55:13 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Categories]') AND type in (N'U'))
DROP TABLE [dbo].[Categories]
GO
USE [master]
GO
/****** Object:  Database [ProductsDb]    Script Date: 2022-05-07 3:55:13 PM ******/
DROP DATABASE [ProductsDb]
GO
/****** Object:  Database [ProductsDb]    Script Date: 2022-05-07 3:55:13 PM ******/
CREATE DATABASE [ProductsDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProductsDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ProductsDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProductsDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ProductsDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ProductsDb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProductsDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProductsDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProductsDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProductsDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProductsDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProductsDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProductsDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProductsDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProductsDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProductsDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProductsDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProductsDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProductsDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProductsDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProductsDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProductsDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ProductsDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProductsDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProductsDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProductsDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProductsDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProductsDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProductsDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProductsDb] SET RECOVERY FULL 
GO
ALTER DATABASE [ProductsDb] SET  MULTI_USER 
GO
ALTER DATABASE [ProductsDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProductsDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProductsDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProductsDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ProductsDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ProductsDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ProductsDb', N'ON'
GO
ALTER DATABASE [ProductsDb] SET QUERY_STORE = OFF
GO
USE [ProductsDb]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 2022-05-07 3:55:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2022-05-07 3:55:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Categories] ([Id], [CategoryName]) VALUES (1, N'Books')
GO
INSERT [dbo].[Categories] ([Id], [CategoryName]) VALUES (2, N'Grocery')
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAllProducts]    Script Date: 2022-05-07 3:55:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetAllProducts]
AS    
   SET NOCOUNT ON;

	select p.Id ProductId, p.ProductName, c.Id CategoryId, c.CategoryName from products p inner join categories c on p.CategoryId=c.id
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertProduct]    Script Date: 2022-05-07 3:55:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_InsertProduct]
	@ProductName nvarchar(50),
	@CategoryId int,
	@ReturnedProductId int OUTPUT
AS    
   SET NOCOUNT ON;

	insert into Products (ProductName, CategoryId) values (@ProductName, @CategoryId)

	select @ReturnedProductId = SCOPE_IDENTITY()
GO
USE [master]
GO
ALTER DATABASE [ProductsDb] SET  READ_WRITE 
GO
