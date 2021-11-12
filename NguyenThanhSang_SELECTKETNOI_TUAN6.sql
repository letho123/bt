--NGUYỄN THANH SANG
--C3(10-12)
--SELECT KẾT NỐI 
--CÂU 15
USE Northwind
SELECT [OrderID],[CustomerID],[EmployeeID],[OrderDate],WEEKDAYOFORDATE = DATEPART(DW,ORDERDATE)
FROM Orders
WHERE (DATEPART(DW,ORDERDATE)IN (7,1)) AND MONTH(OrderDate)=12 AND YEAR(OrderDate)=1997


BÀI TẬP 2: LỆNH SELECT – TRUY VẤN CÓ KẾT NỐI
1. Liệt kê các customer lập hóa đơn trong tháng 7/1997. Thông tin gồm 
CustomerID, CompanyName, Address, OrderID, Orderdate. Được sắp xếp theo 
Customerid, cùng CustomerID thì sắp xếp theo OrderDate giảm dần.
	SELECT C.[CustomerID],[CompanyName],[Address],[OrderID],[OrderDate]
	FROM [dbo].[Customers] C JOIN [dbo].[Orders] O ON C.CustomerID = O.CustomerID
	WHERE YEAR(OrderDate)=1997 AND MONTH(OrderDate)=7
	ORDER BY C.CustomerID, O.OrderDate

2. Liệt kê các customer có lập hóa đơn trong 15 ngày đầu tiên của 1/1997
CUSTOMER - ORDERS
--CÁCH 1 : DÙNG JOIN ĐỂ KẾT NỐI CÁC BẢNG
	SELECT CUSTOMERS.[CustomerID],[CompanyName],[Address],[Phone],[OrderID],[EmployeeID]
	FROM Customers JOIN ORDERS ON Customers.CustomerID = ORDERS.CustomerID
	WHERE DAY(OrderDate)<=15 AND MONTH(OrderDate)=1 AND YEAR(OrderDate)=1997
--CÁCH 2 : ĐẶT BÍ DANH VÀ DÙNG JOIN
	SELECT C.[CustomerID],[CompanyName],[Address],[Phone],[OrderID],[EmployeeID]
	FROM Customers C JOIN ORDERS O ON C.CustomerID = O.CustomerID
	WHERE DAY(OrderDate)<=15 AND MONTH(OrderDate)=1 AND YEAR(OrderDate)=1997
	ORDER BY CompanyName, ORDERDATE DESC -- SẮP XẾP
--CÁCH 3 : KEETTS BẰNG MỆNH ĐỀ WHERE
	SELECT C.[CustomerID],[CompanyName],[Address],[Phone],[OrderID],[EmployeeID], OrderDate
	FROM Customers C , ORDERS O 
	WHERE C.CUSTOMERID = O.CUSTOMERID AND 
		DAY(OrderDate)<=15 AND MONTH(OrderDate)=1 AND YEAR(OrderDate)=1997
		ORDER BY CompanyName, ORDERDATE DESC
		
	
3. Liệt kê danh sách các sản phẩm được giao vào ngày 16/7/1996
	SET DATEFORMAT DMY
	SELECT P.[ProductID],[ProductName],[ShippedDate]
	FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD
	ON P.ProductID = OD.ProductID
	JOIN [dbo].[Orders] O ON O.OrderID=OD.OrderID
	WHERE ShippedDate='16/7/1996'
4. Liệt kê danh sách các hóa đơn của các Customers mua hàng trong tháng 4, 9 
của năm 1997. Thông tin gồm Orderid, CompanyName, OrderDate, 
RequiredDate, được sắp xếp theo CompanyName, cùng Companyname thì theo 
OrderDate giảm dần.
	SELECT [OrderID],[OrderDate],[CompanyName],[RequiredDate]
	FROM [dbo].[Orders] O JOIN [dbo].[Customers] C ON O.CustomerID=C.CustomerID
	WHERE MONTH(OrderDate) IN (4,9) AND YEAR(OrderDate)=1997
	ORDER BY CompanyName,OrderDate DESC
5. Liệt kê danh sách các hóa đơn do nhân viên có Lastname là Fuller lập.
	SELECT [OrderID],[OrderDate],E.[EmployeeID],FULLNAME = [LastName]+' '+[FirstName],[CustomerID]
	FROM [dbo].[Employees] E JOIN [dbo].[Orders] O ON  E.EmployeeID=O.EmployeeID
	WHERE LastName='FULLER'
6. Liệt kê danh sách các Products do nhà cung cấp (supplier) có mã 1,3,6 bán 
được trong tháng quý 2 của năm 1997, được sắp xếp theo mã nhà cung cấp
--BẢNG LẤY : PRODUCTS, SUPPLIERS, ORDERS
	SELECT P.[ProductID],[ProductName],P.[SupplierID],
			[CategoryID],[QuantityPerUnit],DONGIAMUA = P.[UnitPrice],
			[UnitsInStock],[CompanyName],
			QUY = DATEPART(QQ,ORDERDATE),[OrderDate],
			DONGIABAN = OD.UNITPRICE
	FROM [dbo].[Suppliers] S JOIN [dbo].[Products] P ON S.SupplierID=P.SupplierID
		JOIN [dbo].[Order Details] OD ON OD.ProductID=P.ProductID
		JOIN[dbo].[Orders] O ON O.OrderID=OD.OrderID
	WHERE P.SupplierID IN (1,3,6) AND DATEPART(QQ,OrderDate)=2
	AND YEAR(ORDERDATE)=1997
	ORDER BY P.SupplierID,P.ProductID
(SupplierID), cùng mã nhà cung cấp thì sắp xếp theo ProductID.
7. Liệt kê danh sách các Products có đơn giá bán bằng đơn giá mua.
	SELECT P.[ProductID],[ProductName],P.[UnitPrice]
	FROM [dbo].[Products] P JOIN  [dbo].[Order Details] OD ON P.UnitPrice=OD.UnitPrice
8. Liệt kê danh sách các Products mà hóa đơn có OrderID là 10248 đã mua.
	SELECT P.[ProductID],[ProductName],O.[OrderID]
	FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID=OD.ProductID
	JOIN [dbo].[Orders] O ON OD.OrderID=O.OrderID
	WHERE O.OrderID=10248
9. Liệt kê danh sách các Employers đã lập các hóa đơn trong tháng 7 của năm 1996.
	SELECT E.[EmployeeID], FULLNAME = [LastName]+' '+[FirstName], [OrderDate]
	FROM [dbo].[Orders] O JOIN [dbo].[Employees] E ON O.EmployeeID=E.EmployeeID
	WHERE MONTH(OrderDate)=7 AND YEAR(OrderDate)=1996
10.Danh sách các sản phẩm bán trong ngày thứ 7 và chủ nhật của tháng 12 năm 
1996, thông tin gồm [ProductID], [ProductName], OrderID, OrderDate, 
CustomerID, Unitprice, Quantity, ToTal= Quantity*UnitPrice. Được sắp xếp 
theo ProductID, cùng ProductID thì sắp xếp theo Quantity giảm dần.
	SELECT P.[ProductID],[ProductName],O.[OrderID],[OrderDate],C.[CustomerID],OD.[UnitPrice],[Quantity],TOTAL = [Quantity]*OD.[UnitPrice],
	WEEKDAYOFORDATE = DATEPART(DW,OrderDate)
	FROM Products P JOIN [Order Details] OD ON P.ProductID=OD.ProductID
	JOIN Orders O ON O.OrderID=OD.OrderID
	JOIN Customers C ON O.CustomerID=C.CustomerID
	WHERE  MONTH(OrderDate)=12 AND YEAR(OrderDate)=1996 AND (DATEPART(DW,OrderDate) IN (1,7))
	ORDER BY P.ProductID, OD.Quantity
11.Liệt kê bảng doanh thu của mỗi nhân viên theo từng hóa đơn trong năm 1996 
gồm EmployeeID, EmployName, OrderID, Orderdate, Productid, quantity, 
unitprice, ToTal=quantity*unitprice. 
	SELECT E.[EmployeeID],EMPLOYNAME = [LastName]+' '+[FirstName],O.[OrderID],[OrderDate],[ProductID],[UnitPrice],TOTAL = [Quantity]*[UnitPrice]
	FROM Employees E JOIN Orders O ON E.EmployeeID=O.EmployeeID
	JOIN [Order Details] OD ON O.OrderID=OD.OrderID
	WHERE YEAR(OrderDate)=1996
12.Danh sách các đơn hàng sẽ được giao trong các thứ 7 của tháng 12 năm 1996. 
    SELECT O.[OrderID],P.[ProductID],[EmployeeID],[ProductName],[OrderDate],[ShipName],[ShipAddress],[ShipCity],[ShipPostalCode],[ShipCountry]
	FROM [dbo].[Orders] O JOIN [dbo].[Order Details] OD ON O.OrderID=OD.OrderID
	JOIN [dbo].[Products] P ON P.ProductID=OD.ProductID
	WHERE DATEPART(DW,OrderDate)=7 AND MONTH(OrderDate)=12 AND YEAR(OrderDate)=1996 
13.Liệt kê danh sách các nhân viên chưa lập hóa đơn (dùng LEFT JOIN/RIGHT 
JOIN).
	SELECT E.[EmployeeID],FULLNAME = [LastName]+' '+[FirstName],
	ORDERID, ORDERDATE, O.[EmployeeID]
	FROM Employees E LEFT JOIN ORDERS O ON E.EmployeeID=O.EmployeeID
	WHERE O.EmployeeID IS NULL
14.Liệt kê danh sách các sản phẩm chưa bán được (dùng LEFT JOIN/RIGHT 
JOIN).
	SELECT P.[ProductID],[ProductName],OD.[ProductID]
	FROM [dbo].[Products] P LEFT JOIN [dbo].[Order Details] OD ON 
	P.ProductID=OD.ProductID
	WHERE OD.ProductID IS NULL
15.Liệt kê danh sách các khách hàng chưa mua hàng lần nào (dùng LEFT 
JOIN/RIGHT JOIN).
	SELECT C.[CustomerID],[ContactName],OD.[CustomerID]
	FROM [dbo].[Customers] C LEFT JOIN [dbo].[Orders] OD ON
	C.CustomerID=OD.CustomerID
	WHERE OD.CustomerID IS NULL