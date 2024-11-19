_________________________________________________________________________________________________________________________________________________________________________________________________________
# functions

Transact-SQL – exercises.

Procedures, Functions.


Task 1.

Create a procedure p_z1 (without parameters) that displays the product name (ProductName) and the unit price (UnitPrice) from the Products table. All records should be displayed. Execute the procedure.

CREATE PROCEDURE P_Z1
AS
SELECT ...

EXEC P_Z1


Task 2.

Create a function f_z2 (without parameters) that displays the product name (ProductName) and the unit price (UnitPrice) from the Products table. All records should be displayed. Verify the function.

CREATE FUNCTION F_Z2()
RETURNS TABLE
AS
RETURN ( ... )

SELECT * FROM F_Z2()


Task 3.

Create a p_z3 procedure that displays the product name (ProductName) and the unit price (UnitPrice) from the Products table. This time, however, the procedure should display data for only those products whose unit price is greater than the value of the procedure parameter. Execute the procedure.

CREATE PROCEDURE P_Z3
(@Price MONEY)
AS
SELECT ...

Execute the procedure:

ZEC P_Z3 50.0
ZEC P_Z3 90.0


Task 4.

Create a f_z4 function that displays the product name (ProductName) and the unit price (UnitPrice) from the Products table. This time, however, the function should display data for only those products whose unit price is greater than the value of the function parameter. Check the function.

Function call:

SELECT * FROM F_Z4(50)
SELECT * FROM F_Z4(90)


Task 5.

Create a procedure p_z5 that displays ProductName, UnitPrice, and CategoryID for all products that belong to the category with the name (CategoryName) given as the procedure parameter. Category names are unique and can be found in the Categories table (CategoryName column).
Execute the procedure.


Task 6.

Create a function f_z6 that displays ProductName, UnitPrice, and CategoryID for all products that belong to the category with the name (CategoryName) given as the procedure parameter. Category names are unique and can be found in the Categories table (CategoryName column).
Check the function.


Task 7.
Create a function f_z7 that will display the ProductID, ProductName, CategoryID, UnitPrice of all products with prices within the range specified by the function parameters.


Task 8.
Create a function f_z8. Copy the text of the function f_z7 and add one more parameter – @CategoryName. The function should display all product data with prices within the range specified by the first two parameters of the function. In addition, the result should be limited only to products from the category whose name is given as the third parameter of the function.


Task 9.
Create a function f_z9. Copy the text of the function f_z8. Change the function f_z9 so that it checks if the parameter @CategoryName is equal to NULL. If it is, the function should display product data for all categories.
Tip:

CREATE FUNCTION f_z11 (@Price1 MONEY, @Price2 MONEY, @CategoryID INT)
RETURNS @T TABLE (ProductID INT, ProductName NVARCHAR(40),
 CategoryID INT,
 UnitPrice MONEY)
AS
BEGIN
IF @CategoryID IS NULL
 INSERT INTO @T
 SELECT ProductID, ProductName, CategoryID
 FROM Products
 WHERE....
ELSE
 INSERT INTO @T
 SELECT ProductID, ProductName, CategoryID
 FROM Products
 WHERE....
RETURN
END

Task 10 – optional.
Create a function f_z10 that will display the Customer ID, Customer Name, Order Number and Order Date of all Orders of the top three customers (WITH TIES). The top customer is the one who spent the most money (across all orders). The formula for calculating the amount for one order line in the [Order Details] table is ROUND(Quantity*UnitPrice*CAST((1-Discount) AS MONEY),2).

Hint:

CREATE OR ALTER FUNCTION F10 ()
RETURNS @T TABLE(CustomerID NCHAR(5),
CompanyName NVARCHAR(40),
OrderID INT,
OrderDate DATE )
AS
BEGIN
--The following helper table will contain the identifiers
--and amounts for the top three customers
DECLARE @Tmp TABLE (CustomerID NCHAR(5),
Amount MONEY)
INSERT INTO @Tmp
SELECT TOP 3 WITH TIES O.CustomerID,
SUM(ROUND(Quantity*UnitPrice*CAST((1-Discount) AS MONEY),2)) Amount
FROM [Order Details] AS OD
JOIN Orders AS O ON OD.OrderID = O.OrderID
GROUP BY O.CustomerID
ORDER BY Amount DESC

INSERT INTO @T
SELECT C.CustomerID, C.CompanyName, O.OrderID, O.OrderDate
FROM @TMP AS T
JOIN ...
JOIN ...
ORDER BY C.CustomerID, OrderDate

RETURN
END
GO

SELECT * FROM F10()

Task 11. Example of using the CROSS APPLY operator (solved).
Create a function f_z11 that displays the Customer ID (CustomerID), Order Number and Order Date (OrderId, OrderDate) of the three most recent orders (Orders, WITH TIES) of the three best customers (WITH TIES). The best customer is the one who has spent the most money (on all orders).
The formula for calculating the amount for one order line in the [Order Details] table is ROUND(Quantity*UnitPrice*CAST((1-Discount) AS MONEY),2).
Note
