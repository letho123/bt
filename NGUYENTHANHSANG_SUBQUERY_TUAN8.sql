--NGUYỄN THANH SANG
-- 20118191
-- C3(10-12)
--BÀI TẬP 4: LỆNH SELECT – TRUY VẤN CON SUBQUERY
/*1. Các product có đơn giá bán lớn hơn đơn giá bán trung bình của các product.
Thông tin gồm ProductID, ProductName, Unitprice (Bên bảng Order Details).*/
SELECT 	P.ProductID, ProductName, OD.Unitprice 
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID
WHERE OD.UnitPrice>(SELECT AVG(UNITPRICE) FROM [dbo].[Order Details])
/*2. Các product có đơn giá bán lớn hơn đơn giá bán trung bình của các product có
ProductName bắt đầu là ‘N’*/
SELECT P.[ProductID],[ProductName],OD.[UnitPrice]
	FROM[dbo].[Order Details] OD JOIN [dbo].[Products] P ON OD.ProductID = P.ProductID
	WHERE OD.UnitPrice >
	(SELECT AVG(OD.[UnitPrice]) FROM [dbo].[Order Details] OD JOIN [dbo].[Products] P ON OD.ProductID = P.ProductID
		WHERE ProductName LIKE '%N')

/*3. Cho biết những sản phẩm có tên bắt đầu bằng chữ N và đơn giá bán > đơn giá
bán của sản phẩm khác*/
SELECT [ProductName], P.[ProductID], OD.[UnitPrice]
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID=OD.ProductID
WHERE ProductName LIKE 'N%' AND OD.UnitPrice >
	(SELECT AVG(OD.UnitPrice)
		FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID = OD.ProductID
			WHERE ProductName NOT LIKE 'N%')
	
/*4. Danh sách các products đã có khách hàng đặt hàng (tức là ProductId có trong
Order Details). Thông tin bao gồm ProductId, ProductName, Unitprice*/
	--CÁCH 1 : DÙNG JOIN
	--CÁCH 2 DÙNG SUBQUERY : 
	SELECT *FROM Products
	WHERE ProductID IN (SELECT ProductID FROM [Order Details])
	--
	SELECT *, DONGIABAN = OD.UNITPRICE
	FROM Products P JOIN [dbo].[Order Details] OD ON OD.ProductID=P.ProductID
	WHERE P.ProductID IN (SELECT ProductID FROM [Order Details])
/*5. Danh sách các products có đơn giá nhập lớn hơn đơn giá bán nhỏ nhất của tất
cả các Products*/
	SELECT [ProductID],[ProductName],DGN = [UnitPrice]
	FROM [dbo].[Products]
	WHERE UnitPrice > (SELECT MIN([UnitPrice]) FROM [dbo].[Order Details])
/*6. Danh sách các hóa đơn của những Customers mà Customers ở thành phố
LonDon và Madrid.*/
SELECT [OrderID],City,[CompanyName]
FROM [dbo].[Orders] O JOIN [dbo].[Customers] C ON O.CustomerID=C.CustomerID
WHERE C.CustomerID IN
	(SELECT [CustomerID]
		FROM[dbo].[Customers]
	WHERE [City] IN ('LONDON','MADRID'))
/*7. Danh sách các products có đơn vị tính có chữ Box và có đơn giá mua nhỏ hơn
đơn giá bán trung bình của tất cả các Products.*/
SELECT [ProductID],[ProductName],[QuantityPerUnit]
FROM [dbo].[Products] 
WHERE [QuantityPerUnit] LIKE '%BOX%' AND [UnitPrice] <(SELECT AVG([UnitPrice]) FROM [dbo].[Order Details])
/*8. Danh sách các Products có số lượng (Quantity) bán được lớn nhất.*/
	SELECT TOP 1 WITH TIES OD.[ProductID],[ProductName],[Quantity]
	FROM [dbo].[Order Details] OD JOIN [dbo].[Products]P ON OD.ProductID=P.ProductID
	ORDER BY Quantity DESC
	--CÁCH 2
	SELECT [OrderID],OD.[ProductID],[Quantity],[ProductName]
	FROM [dbo].[Order Details] OD JOIN [dbo].[Products] P ON OD.ProductID=P.ProductID
	WHERE [Quantity] =(SELECT MAX([Quantity]) FROM [dbo].[Order Details])
/*9. Danh sách các Customer chưa từng lập hóa đơn (viết bằng ba cách: dùng NOT
EXISTS, dùng LEFT JOIN, dùng NOT IN )*/
-- CÁCH 1 DÙNG LEFT JOIN 
	SELECT C.[CustomerID],[CompanyName],[Address]
	FROM Customers C LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
	WHERE O.CustomerID IS NULL
--CÁCH 2: DÙNG NOT IN 
	SELECT CUSTOMERID, COMPANYNAME, ADDRESS FROM Customers
	WHERE CustomerID NOT IN	(SELECT CUSTOMERID FROM ORDERS)
--CÁCH 3: DÙNG NOT EXIXST
	SELECT CUSTOMERID, COMPANYNAME, ADDRESS FROM Customers C
	WHERE NOT EXISTS (SELECT * FROM Orders O WHERE C.CustomerID=O.CustomerID)
10. Cho biết các sản phẩm có đơn vị tính có chứa chữ box và có đơn giá bán cao
nhất.
SELECT TOP 1 WITH TIES OD.[ProductID],[ProductName],[QuantityPerUnit],OD.[UnitPrice]
FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.ProductID=OD.ProductID
WHERE [QuantityPerUnit] LIKE '%BOX%'
ORDER BY OD.[UnitPrice] DESC
/*11. Danh sách các products có đơn giá bán lớn hơn đơn giá bán trung bình của các
Products có ProductId<=5.*/
SELECT OD.[ProductID],[ProductName],OD.[UnitPrice]
FROM [dbo].[Order Details] OD JOIN [dbo].[Products] P ON OD.ProductID=P.ProductID
WHERE OD.[UnitPrice] >
(SELECT AVG([UnitPrice]) FROM [dbo].[Order Details] WHERE [ProductID] <= 5)
/*12. Cho biết những sản phẩm nào có tổng số lượng bán được lớn hơn số lượng
trung bình bán ra.*/
SELECT OD.ProductID, ProductName, TONGSL = SUM(Quantity) FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID
GROUP BY OD.ProductID, ProductName
	HAVING SUM(OD.Quantity) >(SELECT AVG(QUANTITY) FROM [Order Details])
13. Liệt kê danh sách các khách hàng mua các hóa đơn mà các hóa đơn này chỉ
mua những sản phẩm có mã >=3
14. Liệt kê các sản phẩm có trên 20 đơn hàng trong quí 3 năm 1998, thông tin gồm
[ProductID], [ProductName]
15. Liệt kê danh sách các sản phẩm Producrs chưa bán được trong tháng 6 năm
1996
16. Liệt kê danh sách các Employes không lập hóa đơn vào ngày hôm nay
17. Liệt kê danh sách các Customers chưa mua hàng trong năm 1997
18. Tìm tất cả các Customers mua các sản phẩm có tên bắt đầu bằng chữ T trong
tháng 7.
19. Danh sách các City có nhiều hơn 3 customer.Trường ĐH Công Nghiệp TP.HCM Bài Tập Thực Hành Môn Hệ Cơ Sở Dữ Liệu
Khoa Công Nghệ Thông Tin 40/46
20. Bạn hãy đưa ra câu hỏi cho 3 câu truy vấn sau và cho biết sự khác nhau của 3
câu truy vấn này:
Select ProductId, ProductName, UnitPrice from [Products]
Where Unitprice>ALL (Select Unitprice from [Products] where
ProductName like ‘B%’)
Select ProductId, ProductName, UnitPrice from [Products]
Where Unitprice>ANY (Select Unitprice from [Products] where
ProductName like ‘B%’)
Select ProductId, ProductName, UnitPrice from [Products]
Where Unitprice=ANY (Select Unitprice from [Products] where
ProductName like ‘B%’)