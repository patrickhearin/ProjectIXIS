

--1) Aggregates by combinations of supplier name and product name?

SELECT {Measures.[Quantity - Tb Transactions],
Measures.[Price - Tb Transactions] } ON COLUMNS,
{[Tb Product].[Name].ALLMEMBERS * [Tb Supplier].[Name].ALLMEMBERS} ON ROWS
FROM DS715 


--2) Aggregates by supplier states?

SELECT {Measures.[Quantity - Tb Transactions],
Measures.[Price - Tb Transactions] } ON COLUMNS,
NON EMPTY [Tb Supplier].[state].ALLMEMBERS ON ROWS
FROM DS715 

--3) Number of transactions between supplier-city-consumer-city pairs?

SELECT Measures.[Quantity - Tb Transactions] ON COLUMNS,
{[Tb Supplier].[City].ALLMEMBERS * [Tb Consumer].[City].ALLMEMBERS} ON ROWS
FROM DS715 



--4) Name of each product and quantity Wisconsin suppliers sold of that product?

SELECT Measures.[Quantity - Tb Transactions] ON COLUMNS,
[Tb Product].[Name].ALLMEMBERS ON ROWS
FROM DS715
WHERE [Tb Supplier].[State].[Wisconsin]


--5) Quantity of sales aggregated by product and supplier state?

SELECT Measures.[Quantity - Tb Transactions] ON COLUMNS,
{[Tb Supplier].[State].ALLMEMBERS * [Tb Product].[Name].ALLMEMBERS} ON ROWS
FROM DS715

--6) Quantity of computer sales aggregated by suppliers in Wisconsin?
 
 SELECT Measures.[Quantity - Tb Transactions] ON COLUMNS,
[Tb Supplier].[Name].[Name].ALLMEMBERS ON ROWS
FROM DS715
WHERE ([Tb Supplier].[State].[Wisconsin], [Tb Product].[Name].[Computer])
 
 
--7) Quantity of auto sales by each supplier from Wisconsin to each auto consumer in Illinois?

SELECT Measures.[Quantity - Tb Transactions] ON COLUMNS,
[Tb Supplier].[Name].[Name].ALLMEMBERS ON ROWS
FROM DS715
WHERE ([Tb Supplier].[State].[Wisconsin], [Tb Product].[Name].[Name].[Auto], [Tb Consumer].[State].[Illinois])


-- 8) Quantity of each product sold by each supplier in Madison to each consumer in Illinois?

SELECT Measures.[Quantity - Tb Transactions] ON COLUMNS,
{ [Tb Product].[Name].ALLMEMBERS * [Tb Supplier].[Name].[Name].ALLMEMBERS} ON ROWS
FROM DS715
WHERE ([Tb Supplier].[City].[Madison], [Tb Consumer].[State].[Illinois])
	
	
-- 9) Quantity of each product sold by supplier Bernstein to consumers in Chicago?


SELECT Measures.[Quantity - Tb Transactions] ON COLUMNS,
[Tb Product].[Name].ALLMEMBERS ON ROWS
FROM DS715
WHERE ([Tb Supplier].[Name].[Name].[Bernstein], [Tb Consumer].[City].[Chicago])


-- 10) Quantity of milk sold by supplier Bernstein to each of his milk consumers in Chicago?


SELECT Measures.[Quantity - Tb Transactions] ON COLUMNS,
[Tb Consumer].[Name].[Name] ON ROWS
FROM DS715
WHERE ([Tb Supplier].[Name].[Name].[Bernstein], [Tb Product].[Name].[Milk], [Tb Consumer].[City].[Chicago])


-- 11) (Extra Credit 4%) For each product list quantity sold by suppliers in
-- Madison to consumers in Chicago versus quantity sold by suppliers in
-- Chicago to consumers in Madison (result columns will be: product name,
-- quantity Madison_Chicago, quantity Chicago_Madison)?


SELECT {(Measures.[Quantity - Tb Transactions], [Tb Supplier].[City].[Madison], [Tb Consumer].[City].[Chicago]), (Measures.[Quantity - Tb Transactions], [Tb Supplier].[City].[Chicago], [Tb Consumer].[City].[Madison])} ON COLUMNS,
[Tb Product].[Name].[Name] ON ROWS
FROM DS715





