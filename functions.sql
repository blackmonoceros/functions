--TASK 1:
CREATE PROCEDURE P_Z1 AS
BEGIN
SELECT ProductName, UnitPrice FROM Products
END GO
EXEC P_Z1


--TASK 2:

CREATE FUNCTION F_Z2() RETURNS TABLE
AS RETURN (
SELECT ProductName, UnitPrice FROM Products
) GO


--TASK 3:

CREATE PROCEDURE P_Z3
(@Price MONEY) AS
BEGIN
SELECT ProductName, UnitPrice FROM Products
WHERE UnitPrice > @Price END
GO
EXEC P_Z3 50.0
EXEC P_Z3 90.0


--TASK 4:

CREATE FUNCTION F_Z4(@Price MONEY) RETURNS TABLE
AS RETURN (
SELECT ProductName, UnitPrice FROM Products
WHERE UnitPrice > @Price
) GO
SELECT * FROM F_Z4(50) SELECT * FROM F_Z4(90)


--TASK 5:
CREATE PROCEDURE P_Z5
(@CategoryName NVARCHAR(255)) AS
BEGIN
SELECT p.ProductName, p.UnitPrice, p.CategoryID FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID WHERE c.CategoryName = @CategoryName
END GO
EXEC P_Z5 'cosmic'


--TASK 6:

CREATE FUNCTION F_Z6(@CategoryName NVARCHAR(255)) RETURNS TABLE
AS RETURN (
SELECT p.ProductName, p.UnitPrice, p.CategoryID FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID WHERE c.CategoryName = @CategoryName
) GO
SELECT * FROM F_Z6('Cosmic')


--TASK 7:

CREATE FUNCTION F_Z7(@Price1 MONEY, @Price2 MONEY) RETURNS TABLE
AS RETURN (
SELECT ProductID, ProductName, CategoryID, UnitPrice FROM Products
WHERE UnitPrice BETWEEN @Price1 AND @Price2
) GO
SELECT * FROM F_Z7(10, 50)


--TASK 8:

CREATE FUNCTION F_Z8(@Price1 MONEY, @Price2 MONEY, @CategoryName NVARCHAR(255)) RETURNS TABLE
AS RETURN (
SELECT p.ProductID, p.ProductName, p.CategoryID, p.UnitPrice FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE p.UnitPrice BETWEEN @Price1 AND @Price2 AND c.CategoryName = @CategoryName
) GO
SELECT * FROM F_Z8(10, 50, 'Cosmic')


--TASK 9:
CREATE FUNCTION F_Z9(@Price1 MONEY, @Price2 MONEY, @CategoryName NVARCHAR(255) = NULL)
RETURNS TABLE AS
BEGIN
RETURN (
SELECT p.ProductID, p.ProductName, p.CategoryID, p.UnitPrice FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID WHERE p.UnitPrice BETWEEN @Price1 AND @Price2
AND (@CategoryName IS NULL OR c.CategoryName = @CategoryName)
) END GO
SELECT * FROM F_Z9(10, 50, 'Cosmic') SELECT * FROM F_Z9(10, 50, NULL)


