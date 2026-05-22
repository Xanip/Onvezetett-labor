-----------------
--DELETE TABLES--
-----------------
DROP TABLE IF EXISTS [dbo].[RAWcurrencies];
DROP TABLE IF EXISTS [dbo].[RAWexchange];
DROP TABLE IF EXISTS [dbo].[RAWnews];
DROP TABLE IF EXISTS [dbo].[DimDate];
DROP TABLE IF EXISTS [dbo].[DimCurrency];
DROP TABLE IF EXISTS [dbo].[DimSource];
DROP TABLE IF EXISTS [dbo].[DimAuthor];
DROP TABLE IF EXISTS [dbo].[DimCategory];
DROP TABLE IF EXISTS [dbo].[FactExchange];
DROP TABLE IF EXISTS [dbo].[FactNews];

--------------
--RAW TABLES--
--------------
CREATE TABLE RAWcurrencies (
    CurrencyID INT IDENTITY(1,1) PRIMARY KEY,
    APIfetchedAt DATE NOT NULL,
    ProcessedFlag bit NOT NULL DEFAULT 0,
    Iso_code CHAR(3) NOT NULL UNIQUE,
    Iso_numeric CHAR(3) NULL,
    [Name] NVARCHAR(100) NOT NULL,
    Symbol NVARCHAR(10),
    [Start_date] DATE,
    [End_date] DATE
);

CREATE TABLE RAWexchange (
    ExchangeID INT IDENTITY(1,1) PRIMARY KEY,
    APIfetchedAt DATE NOT NULL,
    ProcessedFlag bit NOT NULL DEFAULT 0,
    BaseCurrency CHAR(3) NOT NULL,
    Currency CHAR(3) NOT NULL,
    Rate DECIMAL(18,6) NOT NULL,
    [Date] DATE NOT NULL,

    CONSTRAINT UQ_RAWexchange_Date_BaseCurrency_Currency
        UNIQUE ([Date], BaseCurrency, Currency)
);

CREATE TABLE RAWnews (
    ArticleID INT IDENTITY(1,1) PRIMARY KEY,
    APIfetchedAt DATE NOT NULL,
    ProcessedFlag bit NOT NULL DEFAULT 0,
    Source_id NVARCHAR(1000),
    Source_name NVARCHAR(1000),
    Author NVARCHAR(1000),
    Title NVARCHAR(1000),
    [Description] NVARCHAR(1000),
    [Url] NVARCHAR(2000),
    [UrlToImage] NVARCHAR(2000),
    [PublishedAt] DATETIME NOT NULL,
    [Content] NVARCHAR(1000)
);

------------------
-- Staging TABLE--
------------------

CREATE TABLE STGnewsCategory (
    RAWArticleID INT PRIMARY KEY,
    GeneratedCategory NVARCHAR(300),

    CONSTRAINT FK_STGnewsCategory_RAWnews
        FOREIGN KEY (RAWArticleID)
        REFERENCES RAWnews(ArticleID)
);

-----------------------
-- DIMENSIONAL TABLES--
-----------------------
CREATE TABLE DimDate (
    DateID INT IDENTITY(1,1) PRIMARY KEY,
    [Date] DATE NOT NULL,  
    [Year] INT NOT NULL,
    [Month] INT NOT NULL,
    [Day] INT NOT NULL
);
GO

CREATE TABLE DimCurrency (
    CurrencyID INT IDENTITY(1,1) PRIMARY KEY,
    CurrencyCode CHAR(3) NOT NULL UNIQUE,
    CurrencyName NVARCHAR(100) NULL,
    CurrencySymbol NVARCHAR(10) NULL
);
GO

CREATE TABLE DimSource (
    SourceID INT IDENTITY(1,1) PRIMARY KEY,
    SourceName NVARCHAR(1000) NOT NULL UNIQUE
);
GO

CREATE TABLE DimAuthor (
    AuthorID INT IDENTITY(1,1) PRIMARY KEY,
    AuthorName NVARCHAR(1000) NOT NULL
);
GO

CREATE TABLE DimCategory (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(300) NOT NULL UNIQUE
);
GO

---------------
--FACT TABLES--
---------------
CREATE TABLE FactExchange (
    ExchangeID INT IDENTITY(1,1) PRIMARY KEY,

    DateID INT NOT NULL,
    BaseCurrencyID INT NOT NULL,
    CurrencyID INT NOT NULL,

    Rate DECIMAL(18,6) NOT NULL,

    CONSTRAINT FK_FactExchange_Date
        FOREIGN KEY (DateID) REFERENCES DimDate(DateID),

    CONSTRAINT FK_FactExchange_BaseCurrency
        FOREIGN KEY (BaseCurrencyID) REFERENCES DimCurrency(CurrencyID),

    CONSTRAINT FK_FactExchange_Currency
        FOREIGN KEY (CurrencyID) REFERENCES DimCurrency(CurrencyID),

    CONSTRAINT UQ_FactExchange_Date_BaseCurrency_Currency
        UNIQUE ([DateID], BaseCurrencyID, CurrencyID)
);
GO

CREATE TABLE FactNews (
    NewsID INT IDENTITY(1,1) PRIMARY KEY,

    DateID INT NOT NULL,
    SourceID INT NOT NULL,
    AuthorID INT NOT NULL,
    CategoryID INT NOT NULL,

    Title NVARCHAR(1000) NOT NULL,
    [Url] NVARCHAR(2000) NOT NULL UNIQUE,

    CONSTRAINT FK_FactNews_Date
        FOREIGN KEY (DateID) REFERENCES DimDate(DateID),

    CONSTRAINT FK_FactNews_Source
        FOREIGN KEY (SourceID) REFERENCES DimSource(SourceID),

    CONSTRAINT FK_FactNews_Author
        FOREIGN KEY (AuthorID) REFERENCES DimAuthor(AuthorID),

    CONSTRAINT FK_FactNews_Category
        FOREIGN KEY (CategoryID) REFERENCES DimCategory(CategoryID)
);
GO