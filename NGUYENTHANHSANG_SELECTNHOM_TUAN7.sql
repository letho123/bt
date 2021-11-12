--NGUYỄN THANH SANG
--C3(10-12)
--1 CHO BIẾT TỔNG TIỀN CỦA TỪNG HÓA ĐƠN
	SELECT [OrderID], TONGTIEN = SUM([UnitPrice]*[Quantity])
	FROM [dbo].[Order Details]
	GROUP BY [OrderID]
	-- LẤY DƯ CỘT SẼ SAI
--1B CHO BIẾT TỔNG TIỀN CỦA TỪNG HÓA ĐƠN, THÔNG TIN GỒM MAHD, NGAYLAP, NGAYGIAO, MAKH,....
	SELECT O.[OrderID],[OrderDate],[RequiredDate],[CustomerID], TONGTIEN = SUM([UnitPrice]*[Quantity])
	FROM [dbo].[Orders] O JOIN [dbo].[Order Details] OD ON OD.OrderID=O.OrderID
	GROUP BY O.[OrderID],[OrderDate],[RequiredDate],[CustomerID]
--2 CHO BIẾT MỖI KHÁCH HÀNG MUA BAO NHIÊU HÓA ĐƠN.
	SELECT O.[CustomerID],[CompanyName],[Address],[Phone], SOHDMUA=COUNT(O.CustomerID)
	FROM [dbo].[Customers] C JOIN [dbo].[Orders] O ON C.CustomerID=O.CustomerID
	GROUP BY O.[CustomerID],[CompanyName],[Address],[Phone]
--3 CHO BIẾT TỔNG SỐ LƯỢNG BÁN ĐƯỢC, SỐ LƯỢNG TB BÁN ĐƯỢC, SL LỚN NHẤT, SL NHỎ NHẤT, SỐ LẦN BÁN
-- ĐƯỢC CỦA MỖI SẢN PHẨM. ĐƯỢC SẮP XẾP THEO MASP
	SELECT OD.[ProductID],[ProductName], TONGSL=SUM([Quantity]), SLLN = MAX([Quantity]),
	SLNN = MIN([Quantity]), TRUNGBINH = AVG([Quantity]), SOLANBAN=COUNT(OD.[ProductID])
	FROM Products P JOIN [Order Details] OD ON P.ProductID=OD.ProductID
	GROUP BY OD.[ProductID],[ProductName]
	ORDER BY OD.ProductID
--4 CHO BIẾT SỐ LƯỢNG BÁN ĐƯỢC LỚN NHẤT CỦA TỪNG SẢN PHẨM
	SELECT OD.[ProductID],[ProductName], SLLN = MAX([Quantity])
	FROM Products P JOIN [Order Details] OD ON P.ProductID=OD.ProductID
	GROUP BY OD.[ProductID],[ProductName]
	ORDER BY OD.ProductID
--5 CHO BIẾT SẢN PHẨM NÀO CÓ SỐ LƯỢNG BÁN ĐƯỢC LỚN NHẤT
	SELECT TOP  1 WITH TIES OD.[ProductID],[ProductName], [Quantity]
	FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.[ProductID]=OD.[ProductID]
	ORDER BY [Quantity] DESC
--6 CHO BIẾT SẢN PHẨM NÀO CÓ TỔNG SỐ LƯỢNG BÁN ĐƯỢC LỚN NHẤT
	SELECT TOP  1 WITH TIES OD.[ProductID],[ProductName], TONGSL=SUM( [Quantity])
	FROM [dbo].[Products] P JOIN [dbo].[Order Details] OD ON P.[ProductID]=OD.[ProductID]
	GROUP BY OD.ProductID, ProductName
	ORDER BY TONGSL DESC
--7 CHO BIẾT TỔNG TIỀN CỦA MỖI HÓA ĐƠN BÁN ĐƯỢC TRONG THÁNG 10 NĂM 2021
	SELECT O.[OrderID],[OrderDate],[RequiredDate],[CustomerID], TONGTIEN = SUM([Quantity]*[UnitPrice])
	FROM [dbo].[Order Details] OD JOIN [dbo].[Orders] O ON OD.OrderID=O.OrderID
	WHERE MONTH([OrderDate])=10 AND YEAR([OrderDate])=1997
	GROUP BY O.[OrderID],[OrderDate],[RequiredDate],[CustomerID]
--8 CHO BIẾT TỔNG TIỀN PHẢI TRẢ CỦA KHÁCH HÀNG CÓ TÊN BẮT ĐẦU BẰNG CHỮ L,
-- ĐƯỢC SẮP XẾP THEO TỔNG TIỀN GIẢM DẦN
	SELECT O.[CustomerID],CompanyName,TONGTIEN = SUM([Quantity]*[UnitPrice])
	FROM [dbo].[Customers] C JOIN [dbo].[Orders] O ON C.CustomerID=O.CustomerID
	JOIN [dbo].[Order Details] OD ON OD.[OrderID] = O.[OrderID]
	WHERE [CompanyName] LIKE'L%'
	GROUP BY O.CustomerID, CompanyName
	ORDER BY TONGTIEN DESC
--9 CHO BIẾT TỔNG TIỀN THU ĐƯỢC CỦA MỖI NHÂN VIÊN TRONG NGÀY 17/10/1997
	SET DATEFORMAT DMY
	SELECT O.[EmployeeID], FULLNAME = [LastName]+' '+[FirstName],[Address],
[HomePhone],TONGTIEN =SUM([Quantity]*[UnitPrice])
	FROM Employees E JOIN Orders O ON O.EmployeeID=E.EmployeeID
	JOIN [Order Details] OD ON OD.OrderID=O.OrderID
	WHERE OrderDate='17/10/1997'
	GROUP BY O.[EmployeeID], [LastName]+' '+[FirstName],[Address],[HomePhone]
--10 CHO BIẾT SẢN PHẨM NÀO CÓ TỔNG SỐ LƯỢNG BÁN ĐƯỢC TRÊN 500
	SELECT OD.PRODUCTID, PRODUCTNAME, TONGSLBAN = SUM(QUANTITY)
	FROM PRODUCTS P JOIN [Order Details] OD ON P.ProductID=OD.ProductID
	GROUP BY OD.PRODUCTID, PRODUCTNAME
	HAVING SUM(Quantity)>500
	ORDER BY TONGSLBAN
--11 CHO BIẾT NHÂN VIÊN NÀO CÓ DOANH THU TRÊN 10000 TRONG THÁNG 10 ĐƯỢC SẮP XẾP THEO TÊN NHÂN VIÊN, CÙNG TÊN THEO TỔNG TIỀN GIẢM
	SELECT O.EMPLOYEEID, FULLNAME=[LastName]+' '+[FirstName], TONGTIEN = SUM(QUANTITY*UNITPRICE)
	FROM Employees E JOIN ORD