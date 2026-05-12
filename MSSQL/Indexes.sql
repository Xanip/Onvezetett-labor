-----------------------
-- RAW TABLE INDEXES --
-----------------------
-- RAWcurrencies
CREATE INDEX IX_RAWcurrencies_ProcessedFlag
ON RAWcurrencies (ProcessedFlag);

CREATE UNIQUE INDEX UX_RAWcurrencies_Iso
ON RAWcurrencies (Iso_code, Iso_numeric);


-- RAWexchange
CREATE INDEX IX_RAWexchange_ProcessedFlag
ON RAWexchange (ProcessedFlag);

CREATE INDEX IX_RAWexchange_BatchLookup
ON RAWexchange ([Date], BaseCurrency, Currency);


-- RAWnews
CREATE INDEX IX_RAWnews_ProcessedFlag
ON RAWnews (ProcessedFlag);

CREATE UNIQUE INDEX UX_RAWnews_Url
ON RAWnews ([Url]);

CREATE INDEX IX_RAWnews_Source
ON RAWnews (Source_id, Source_name);



-----------------------
-- DIM TABLE INDEXES --
-----------------------
-- DimDate
CREATE UNIQUE INDEX UX_DimDate_Date
ON DimDate ([Date]);

CREATE INDEX IX_DimDate_YearMonth
ON DimDate ([Year], [Month]);


-- DimCurrency
CREATE UNIQUE INDEX UX_DimCurrency_Code
ON DimCurrency (CurrencyCode);


-- DimSource
CREATE UNIQUE INDEX UX_DimSource_Name
ON DimSource (SourceName);


-- DimAuthor
CREATE INDEX IX_DimAuthor_Name
ON DimAuthor (AuthorName);


-- DimCategory
CREATE UNIQUE INDEX UX_DimCategory_Name
ON DimCategory (CategoryName);



------------------------
-- FACT TABLE INDEXES --
------------------------
-- FactExchange
CREATE INDEX IX_FactExchange_Date
ON FactExchange (DateID);

CREATE INDEX IX_FactExchange_CurrencyLookup
ON FactExchange (BaseCurrencyID, CurrencyID);

CREATE INDEX IX_FactExchange_FullFilter
ON FactExchange (DateID, BaseCurrencyID, CurrencyID);


-- FactNews
CREATE INDEX IX_FactNews_Date
ON FactNews (DateID);

CREATE INDEX IX_FactNews_Source
ON FactNews (SourceID);

CREATE INDEX IX_FactNews_Author
ON FactNews (AuthorID);

CREATE INDEX IX_FactNews_Category
ON FactNews (CategoryID);

CREATE INDEX IX_FactNews_DimCombo
ON FactNews (DateID, SourceID, CategoryID);