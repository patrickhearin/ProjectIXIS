-- 1. What are the comparative sales for each product in category transportation
--(on rows) by months of year during 2019 (on columns) (replace with zeros
-- where nulls, format for money type)?

WITH MEMBER Sales AS
COALESCEEMPTY(Measures.[Sales Value], 0),
FORMAT_STRING = '$###,###,##0.00'
SELECT [Tb Product].[Product Category].Transportation ON COLUMNS,
 ([Tb Date].[Date Month Of Year].[Date Month Of Year],
 [Tb Date].[Date Month Name].[Date Month Name]) ON ROWS
FROM TS
WHERE [Tb Date].[Date Year].[2019]



-- 2. Total sales during each quarter (on rows) of 2019 vs quarters of 2018 and
-- net one year growth (on columns) (use PARALLELPERIOD())?

WITH MEMBER [Previous Year] AS
 COALESCEEMPTY((Measures.[Sales Value],
 PARALLELPERIOD([Tb Date].[HMQY].[Date Quarter], 4)), 0)
MEMBER [Yearly Growth] AS
 COALESCEEMPTY(Measures.[Sales Value],0)-[Previous Year]
MEMBER Sales AS COALESCEEMPTY(Measures.[Sales Value],0)
SELECT {Sales, [Previous Year], [Net Growth]} ON COLUMNS,
([Tb Date].[Date Quarter].[Date Quarter],
[Tb Date].[Date Quarter Of Year].[Date Quarter Of Year]) ON ROWS
FROM TS
WHERE [Tb Date].[Date Year].[2019]



-- 3. Quantity of milk sold in each consumer city (on rows) during first quarter
-- of 2019 vs first quarter of 2018 (on columns) (use PARALLELPERIOD())?

WITH MEMBER [Previous Year] AS
 COALESCEEMPTY((Measures.[QuantitySold],
 PARALLELPERIOD([Tb Date].[HMQY].[Date Quarter], 4)), 0)
MEMBER Sales AS COALESCEEMPTY(Measures.[Sales Value],0)
SELECT {Measures.[QuantitySold], [Previous Year] } ON COLUMNS,
([Tb Date].[Date Quarter].[Date Quarter],
[Tb Date].[Date Quarter Of Year].[Date Quarter Of Year]) ON ROWS
FROM TS
WHERE ([Tb Date].[Date Year].[2019], [Tb Product].[Name].[Milk])


-- 4. Monthly YTD quantities (on rows) sold of each product line (on columns)
-- in transportation during 2019 (use PERIODSTODATE())?


WITH MEMBER [YTD Quantities] AS COALESCEEMPTY(SUM(
PERIODSTODATE([Tb Date].[HMQY].[Date Year],
[Tb Date].[HMQY].CURRENTMEMBER),
Measures.[QuantitySold]), 0)
SELECT {[Tb Product].[Product Category].Transportation} ON COLUMNS,
([YTD Quantities]) ON ROWS
FROM TS
WHERE ([Tb Date].[Date Year].[2019])



-- 5. Monthly YTD quantities (on rows) sold of each product line (on columns)
-- in transportation during 2019 (use YTD())?


WITH MEMBER [YTD Sales] AS COALESCEEMPTY(SUM(
YTD([Tb Date].[HMQY].CURRENTMEMBER),
Measures.[QuantitySold]), 0)
SELECT {[Tb Product].[Product Category].Transportation} ON COLUMNS,
([YTD Sales]) ON ROWS
FROM TS
WHERE ([Tb Date].[Date Year].[2019])



-- 6. Quantity of milk consumed in Chicago during each of the first 7 month of
-- 2018 (use PERIODSTODATE())?

WITH MEMBER [Milk Sold] AS COALESCEEMPTY(SUM(
PERIODSTODATE([Tb Date].[HMQY].[Date Year],
[Tb Date].[HMQY].CURRENTMEMBER),
Measures.[QuantitySold]), 0)
SELECT {[Milk Sold]} ON COLUMNS,
([Tb Date].[Date Month].[Date Month].[1]: [Tb Date].[Date Month].[Date Month].[7],[Tb Date].[Date Month Name].[Date Month Name]) ON ROWS
FROM TS
WHERE([Tb Date].[Date Year].[2018], [Tb Product].[Name].[Milk], [Tb Consumer].[City].[Chicago])



-- 7. Daily quantity of milk sold during January 2019, as well as MTD and last
-- 10 days total quantities?

WITH MEMBER [Milk Sold] AS COALESCEEMPTY(SUM(
MTD([Tb Date].[HMQY].CURRENTMEMBER), Measures.[QuantitySold]), 0)
MEMBER [Daily Quantity of Milk] AS COALESCEEMPTY(
Measures.[QuantitySold], 0)
MEMBER [Last 10 Days Total Quantities] AS COALESCEEMPTY(SUM(
[Tb Date].[HMQY].CURRENTMEMBER.LAG(-10):
[Tb Date].[HMQY].CURRENTMEMBER,
Measures.[QuantitySold]), 0)
SELECT {[Milk Sold], [Daily Quantity of Milk], [Last 10 Days Total Quantities] } ON COLUMNS,
([Tb Date].[Date Day Of Month].[Date Day Of Month]) ON ROWS
FROM TS
WHERE([Tb Date].[Date Year].[2019], [Tb Date].[Date Month Name].[January], [Tb Product].[Name].[Milk])



-- 8. Quantity of milk sold in each consumer city (on rows) during first 5
-- months of 2019 vs first 5 months of 2018 (on columns) (use
-- PARALLELPERIOD() and/or PERIODSTODATE())?

WITH MEMBER [Previous Year] AS
 COALESCEEMPTY((Measures.[QuantitySold],
 PARALLELPERIOD([Tb Date].[HMQY].[Date Month], 12)), 0)
MEMBER Sales AS COALESCEEMPTY(Measures.[Sales Value],0)
SELECT {Measures.[QuantitySold], [Previous Year] } ON COLUMNS,
([Tb Date].[Date Month].[Date Month].[13]: [Tb Date].[Date Month].[Date Month].[17],
[Tb Date].[Date Month Name].[Date Month Name]) ON ROWS
FROM TS
WHERE ([Tb Date].[Date Year].[2019], [Tb Product].[Name].[Milk])

