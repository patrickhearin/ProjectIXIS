-- Category I – 50 points – upload .sql file with solutions to D2L dropbox

-- Option Problem #1

--a) (25 points) Based on the tables in the database given by the description below:


SELECT DISTINCT S.Name "Supplier Name",
S.City "Supplier City",
S.State "Supplier State",
P.Name "Product Name",
P.Product_Category "Product Category",
P.Product_Packaging "Product Packaging",
P.Product_Line "Product Line",
SUM(Quantity) "Total Offers Quantity",
SUM(Quantity*Price) "Value",
MAX(Price) "Maximum Price",
MIN(Price) "Minimum Price"
INTO Tb_Final_Exam_Cube
FROM Tb_Supplier S, Tb_Product P, Tb_Offers O
WHERE S.Supp_ID=O.Supp_ID AND
P.Prod_ID=O.Prod_ID
 GROUP BY CUBE((S.State, S.City, S.Name),
(P.Product_Category, P.Product_Line, P.Product_Packaging, P.Name)),
ROLLUP(S.State, S.City, S.Name),
ROLLUP(P.Product_Packaging, P.Name),
ROLLUP(P.Product_Category, P.Product_Line, P.Name)
 
 
 
 -- b) (25 points) Given the cube created at point a) solve the following queries using SQL:
 
 
-- 1. Value of products offered by supplier and by product packaging? (2 points)


SELECT [Supplier Name], [Product Packaging], [Value]
FROM Tb_Final_Exam_Cube
WHERE "Supplier Name" IS NOT NULL
AND "Supplier City" IS NOT NULL
AND "Supplier State" IS NOT NULL
AND "Product Category" IS NULL
AND "Product Line" IS NULL
AND "Product Packaging" IS NOT NULL
AND "Product Name" IS NULL



-- 2. Volume of milk offered by each supplier in Wisconsin? (2 points)



SELECT [Supplier Name], [Total Offers Quantity]
FROM Tb_Final_Exam_Cube
WHERE "Supplier Name" IS NOT NULL
AND "Supplier City" IS NOT NULL
AND "Supplier State" = 'Wisconsin'
AND "Product Category" IS NOT NULL
AND "Product Line" IS NOT NULL
AND "Product Packaging" IS NOT NULL
AND "Product Name" = 'Milk'


-- 3. Find the maximum price for each product offered in Madison? (5 points)


SELECT [Product Name], [Maximum Price]
FROM Tb_Final_Exam_Cube
WHERE "Supplier Name" IS NULL
AND "Supplier City" = 'Madison'
AND "Supplier State" IS NOT NULL
AND "Product Category" IS NOT NULL
AND "Product Line" IS NULL
AND "Product Packaging" IS NOT NULL
AND "Product Name" IS NOT NULL



-- 4. For each supplier city find the product offered in largest quantity? (8 points)


SELECT [Supplier City], [Total Offers Quantity], [Product Name]
 FROM Tb_Final_Exam_Cube, (SELECT [Supplier City] AS [Max City]
    , max(DISTINCT [Total Offers Quantity]) AS [Max Quantity]
FROM Tb_Final_Exam_Cube
WHERE [Supplier Name] is NULL
AND [Supplier State] is NOT NULL
AND [Supplier City] is NOT NULL
AND [Product Name] is NOT NULL
AND [Product Packaging] is NOT NULL
AND [Product Category] is  NULL
AND [Product Line] is NULL
GROUP BY [Supplier City]) AS max_quantity
WHERE [Supplier Name] is NULL
AND [Supplier State] is NOT NULL
AND [Supplier City] is NOT NULL
AND [Product Name] is NOT NULL
AND [Product Packaging] is NOT NULL
AND [Product Category] is  NULL
AND [Product Line] is NULL
AND max_quantity.[Max City] = [Supplier City]
AND max_quantity.[Max Quantity] = [Total Offers Quantity]
ORDER BY [Supplier City]



-- 5. For each product find the city where it is offered at the lowest price? (8 points)

SELECT [Product Name], [Supplier City], [Minimum Price]
FROM Tb_Final_Exam_Cube, (SELECT [Product Name] AS [Min Product]
    , min(DISTINCT [Minimum Price]) AS [Min Price]
FROM Tb_Final_Exam_Cube
WHERE [Supplier Name] is NULL
AND [Supplier State] is NOT NULL
AND [Supplier City] is NOT NULL
AND [Product Name] is NOT NULL
AND [Product Packaging] is NOT NULL
AND [Product Category] is NULL
AND [Product Line] is NULL
GROUP BY [Product Name]) as min_price
WHERE [Supplier Name] is NULL
AND [Supplier State] is NOT NULL
AND [Supplier City] is NOT NULL
AND [Product Name] is NOT NULL
AND [Product Packaging] is NOT NULL
AND [Product Category] is NULL
AND [Product Line] is NULL
AND min_price.[Min Product] = [Product Name]
AND min_price.[Min Price] = [Minimum Price]
ORDER BY [Product Name]




 

 
 
 
 
 
 
 
 
 