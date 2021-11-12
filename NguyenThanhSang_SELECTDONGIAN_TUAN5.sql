--NGUYỄN THANH SANG
--C3(10-12)
--1. XEM THÔNG TIN TẤT CẢ CÁC CỘT CÓ TRONG 1 TABLE
	USE Northwind 
	SELECT * FROM Products -- XEM THÔNG TIN BẢNG SẢN PHẨM
	SELECT * FROM Employees -- XEM THÔNG TIN BẢNG NHÂN VIÊN
	SELECT * FROM Customers -- XEM THÔNG TIN BẢNG KHÁC HÀNG
	SELECT * FROM [dbo].[Orders] -- XEM THÔNG TIN BẢNG HÓA ĐƠN
	SELECT * FROM [dbo].[Order Details] -- XEM THÔNG TIN BẢNG CHI TIẾT HÓA ĐƠN
--2. XEM THÔNG TIN MỘT VÀI THUỘC TÍNH
-- DANH SÁCH KHÁCH HÀNG GỒM MAKH, TENKH,DIACHI,THANHPHO
	SELECT [CustomerID],[CompanyName],[Address],[City] FROM Customers
	--XEM BẢNG NHÂN VIÊN
	--DANH SÁCH NHÂN VIÊN GỒM MANV,HOTEN,NGAYSINH,DIACHI
	SELECT [EmployeeID],[LastName],[FirstName],[BirthDate],[Address]
	FROM [dbo].[Employees]
--3. GHÉP CÁC CỘT LẠI VỚI NHAU
	SELECT [EmployeeID],[LastName]+' '+[FirstName],[BirthDate],[Address]
	FROM Employees
	--ĐẶT TIÊN ĐỀ CHO CỘT
	SELECT [EmployeeID],FULLNAME=[LastName]+' '+[FirstName],[BirthDate],[Address]
	FROM Employees
	--C2
	SELECT [EmployeeID],[LastName]+' '+[FirstName] AS FULLNAME,[BirthDate],[Address]
	FROM Employees
--4. TRUY VẤN TẠO CỘT TÍNH TOÁN
	SELECT * FROM [dbo].[Order Details]
	SELECT *, TOTAL = QUANTITY * UNITPRICE
	FROM[dbo].[Order Details]

	SELECT [OrderID],[ProductID],[UnitPrice],[Quantity], TOTAL = QUANTITY * UNITPRICE
	FROM[dbo].[Order Details]
--5. LOẠI BỎ CÁC DÒNG TRÙNG NHAU DÙNG TỪ KHÓA DISTINCT
	SELECT DISTINCT CustomerID, SHIPNAME,SHIPCITY
	FROM Orders
--6. LẤY RA N DÒNG ĐẦU TIÊN
	-- LẤY RA 5 KHÁCH HÀNG ĐẦU TIÊN
	SELECT TOP 5 * FROM Customers
	--LẤY RA 4 NHÂN VIÊN ĐẦU TIÊN
	SELECT TOP 4 * FROM Employees
	--DS 4 NHÂN VIÊN ĐẦU TIÊN GỒM MANV, TENNV, DIA CHI
	SELECT TOP 4 EMPLOYEEID,FULLNAME = [LASTNAME]+' '+[FIRSTNAME],ADDRESS FROM Employees
	--LẤY RA 5% CỦA KHÁCH HÀNG ĐẦU TIÊN
	SELECT * FROM Customers
	SELECT TOP 5 PERCENT * FROM Customers
	SELECT TOP 20 PERCENT * FROM [dbo].[Employees]
	--LIỆT KÊ DANH SÁCH GỒM MANV, HOTEN, NGAYSINH, TUOI
	SELECT GETDATE() -- NGÀY GIỜ HIỆN HÀNH
	SELECT YEAR(GETDATE())--LẤY NĂM HIỆN HÀNH
	SELECT [EmployeeID], FULLNAME = [LASTNAME]+' '+[FIRSTNAME],[BirthDate], TUOI = YEAR(GETDATE()) - YEAR([BirthDate])
	FROM Employees
	--LIỆT KÊ 3 NHÂN VIÊN CÓ TUỔI NHỎ NHẤT GỒM MANV, HOTEN, NGAYSINH, TUỔI
	--SẮP XẾP
	SELECT [EmployeeID], FULLNAME = [LASTNAME]+' '+[FIRSTNAME],[BirthDate], TUOI = YEAR(GETDATE()) - YEAR([BirthDate])
	FROM Employees
	ORDER BY TUOI

	SELECT TOP 3 WITH TIES [EmployeeID], FULLNAME = [LASTNAME]+' '+[FIRSTNAME],[BirthDate], TUOI = YEAR(GETDATE()) - YEAR([BirthDate])
	FROM Employees
	ORDER BY TUOI
	--3 NGƯỜI CÓ TUỔI LỚN NHẤT
	SELECT TOP 3 WITH TIES [EmployeeID], FULLNAME = [LASTNAME]+' '+[FIRSTNAME],[BirthDate], TUOI = YEAR(GETDATE()) - YEAR([BirthDate])
	FROM Employees
	ORDER BY TUOI DESC
--6. TRUY VẤN CÓ ĐIỀU KIỆN
	SELECT * FROM Customers
--6.1 LIỆT KÊ CÁC KHÁCH HÀNG Ở TP LONDON
	SELECT * FROM Customers
		WHERE CITY = 'LONDON'
--6.2 LIỆT KÊ CÁC KHÁCH HÀNG Ở THÀNH PHỐ LONDON, MADRID, BERLIN
	SELECT * FROM Customers
		WHERE CITY = 'LONDON' OR CITY ='BERLIN' OR CITY ='MADRID'
	--CÁCH 2 
	SELECT * FROM Customers
		WHERE CITY IN('LONDON','BERLIN','MADRID')
--6.2 LIỆT KÊ CÁC KHÁCH HÀNG KHÔNG Ở THÀNH PHỐ LONDON, MADRID, BERLIN
	SELECT * FROM Customers
		WHERE CITY NOT IN('LONDON','BERLIN','MADRID')
--6.3 LIỆT KÊ CÁC SẢN PHẨM CÓ SỐ LƯỢNG TỒN TỪ 50 ĐẾN 100
	SELECT * FROM Products
		WHERE UnitsInStock>=50 AND UnitsInStock<=100
	--CÁCH 2
	SELECT * FROM PRODUCTS
		WHERE UnitsInStock BETWEEN 50 AND 100
--6.4 LIỆT KÊ DANH SÁCH CÁC NHÂN VIÊN
	SELECT * FROM Employees
	SELECT * FROM Employees WHERE FirstName='NANCY' -- CÓ TÊN BẰNG NANCY
--6.5 LIỆT KÊ DANH SÁCH CÁC NHÂN VIÊN CÓ TÊN BẮT ĐẦU BẰNG CHỮ N
	SELECT * FROM Employees
		WHERE FirstName LIKE 'N%'--%ĐẠI DIỆN CHO NHIỀU KÝ TỰ BẤT KỲ 
--6.6 LIỆT KÊ CÁC NHÂN VIÊN CÓ KỸ TỰ CUỐI CÙNG CỦA TÊN LÀ CHỮ T
	SELECT * FROM Employees
		WHERE FirstName LIKE '%T'

--6.7 LIỆT KÊ CÁC NHÂN VIÊN CÓ TÊN CHỨA CHỮ A
	SELECT * FROM Employees
		WHERE FirstName LIKE '%A%'
--6.8 LIỆT KÊ NHỮNG NHÂN VIÊN CÓ KỸ TỰ THỨ 2 CỦA TÊN LÀ CHỮ A
	SELECT * FROM Employees
		WHERE FirstName LIKE '_A%'--DẤU _ ĐẠI DIỆN CHO 1 KÝ TỰ BẤT KỲ TẠI VỊ TRÍ NÓ ĐỨNG
--6.9 LIỆT KÊ NHỮNG NHÂN VIÊN CÓ KỸ TỰ THỨ 3 CỦA TÊN LÀ CHỮ N
	SELECT * FROM Employees
		WHERE FirstName LIKE '__N%'
--6.10 LIỆT KÊ CÁC KHÁCH HÀNG KHÔNG CÓ SỐ FAX
	SELECT * FROM Customers
		WHERE FAX IS NULL
--6.11 LIỆT KÊ CÁC KHÁCH HÀNG CÓ SỐ FAX
	SELECT * FROM Customers
		WHERE FAX IS NOT NULL
--6.12 LIỆT KÊ DANH SÁCH CÁC HÓA ĐƠN CÓ NGÀY LẬP LÀ NGÀY 11
	SELECT * FROM Orders
		WHERE DAY(OrderDate)=11
--6.13 LIỆT KÊ DANH SÁCH CÁC HÓA ĐƠN ĐƯỢC LẬP TRONG THÁNG 10
	SELECT * FROM Orders
		WHERE MONTH(OrderDate)=10
--6.14 LIỆT KÊ DANH SÁCH CÁC HÓA ĐƠN ĐC LẬP VÀO NĂM 1997
	SELECT * FROM Orders
		WHERE YEAR(OrderDate)=1997
--6.15 LIỆT KÊ CÁC HÓA ĐƠN ĐƯỢC LẬP VÀO NGÀY HÔM NAY
	SELECT * FROM ORDERS	
		WHERE OrderDate=GETDATE()
--HÀM DATEPART
--LẤY PHẦN NGÀY
SELECT DATEPART(DD,GETDATE())
--LẤY PHẦN THÁNG
SELECT DATEPART(MM,GETDATE())
--LẤY PHẦN NĂM
SELECT DATEPART(YY,GETDATE())
--LẤY PHẦN QUÝ
SELECT DATEPART(QQ,GETDATE())
--LẤY NGÀY THỨ MẤY TRONG TUẦN
SELECT DATEPART(DW,GETDATE())
SET DATEFORMAT DMY
SELECT DATEPART(DW,'10/10/2002')
--1. Liệt kê thông tin của tất cả các sản phẩm (Products)
	SELECT * FROM Products
--2. Liệt kê danh sách các khách hàng (Customers). Thông tin bao gồm CustomerID, CompanyName, City, Phone.
	SELECT [CustomerID],[CompanyName],[City],[Phone] FROM [dbo].[Customers]
--3. Liệt kê danh sách các sản phẩm (Products). Thông tin bao gồm ProductId, ProductName, UnitPrice.
	SELECT [ProductID],[ProductName],[UnitPrice] FROM [dbo].[Products]
--4. Liệt kê danh sách các nhân viên (Employees). Thông tin bao gồm EmployeeId, EmployeeName, Phone, Age. Trong đó EmployeeName được ghép từ 
--LastName và FirstName; Age là tuổi được tính từ năm hiện hành (GetDate()) và năm của Birthdate.
	SELECT [EmployeeID],EMPLOYYEENAME = [LastName]+' '+[FirstName],[HomePhone],AGE = YEAR(GETDATE()) - YEAR([BirthDate])
	FROM [dbo].[Employees]
--5. Liệt kê danh sách các khách hàng (Customers) có ContactTitle bắt đầu bằng chữ O
	SELECT * FROM[dbo].[Customers]
		WHERE [ContactTitle] LIKE 'O%'
--6. Liệt kê danh sách khách hàng (Customers) ở thành phố LonDon, Boise và Paris
	SELECT * FROM Customers
		WHERE CITY IN('LONDON','BOISE','PARIS')
--7. Liệt kê danh sách khách hàng (Customers) có tên bắt đầu bằng chữ V mà ở thành phố Lyon
	SELECT * FROM[dbo].[Customers]
		WHERE [ContactName] LIKE 'V%' AND City = 'LYON'
--8. Liệt kê danh sách các khách hàng (Customers) không có số fax
	SELECT * FROM Customers
		WHERE FAX IS NULL
--9. Liệt kê danh sách các khách hàng (Customers) có số Fax
	SELECT * FROM Customers
		WHERE FAX IS NOT NULL
--10.Liệt kê danh sách nhân viên (Employees) có năm sinh <=1960.
	SELECT * FROM [dbo].[Employees]
		WHERE YEAR(BirthDate)<=1960
--11.Liệt kê danh sách các sản phẩm (Products) có từ ‘Boxes’ trong cột QuantityPerUnit. 
	SELECT * FROM [dbo].[Products]
		WHERE QuantityPerUnit='BOXES'
--12.Liệt kê danh sách các sản phẩm (Products) có Unitprice lớn hớn 10 và nhỏ hơn 15. 
	SELECT * FROM [dbo].[Products]
		WHERE UnitPrice BETWEEN 10 AND 15
--13.Liệt kê danh sách các hóa đơn (orders) có OrderDate được lập trong tháng 9 năm 1996. Được sắp xếp theo mã khách hàng, cùng mã khách hàng sắp xếp 
--theo ngày lập hóa đơn giảm dần.
	SELECT * FROM [dbo].[Orders]
		WHERE MONTH(OrderDate)=9 AND YEAR(OrderDate)=1996
	ORDER BY[CustomerID],OrderDate desc --(desc sắp xếp giảm dần)
--14.Liệt kê danh sách các hóa đơn (Orders) được lập trong quý 4 năm 1997. Thông tin gồm OrderID, OrderDate, Customerid, EmployeeID. Được sắp xếp theo 
--tháng của ngày lập hóa đơn.
	SELECT[OrderID], [OrderDate],[CustomerID],[EmployeeID] FROM[dbo].[Orders]
		WHERE DATEPART(QQ,OrderDate)=4
	ORDER BY MONTH(OrderDate)

--15.Liệt kê danh sách các hóa đơn (Orders) được lập trong trong ngày thứ 7 và chủ nhật của tháng 12 năm 1997. Thông tin gồm OrderID, OrderDate, Customerid, 
--EmployeeID, WeekDayOfOrdate (Ngày thứ mấy trong tuần). 
	SELECT[OrderID], [OrderDate],[CustomerID],[EmployeeID], WeekDayOfOrdate =DATEPART(DW,OrderDate) FROM[dbo].[Orders]
		WHERE MONTH(OrderDate)=12 AND year(OrderDate)=1997 AND (DATEPART(DW,OrderDate)=1 OR DATEPART(DW,OrderDate)=7)
--16.Liệt kê danh sách các sản phẩm (Products) ứng với tiền tồn vốn. Thông tin bao gồm ProductId, ProductName, Unitprice, UnitsInStock, TotalAccount. Trong 
--đó TotalAccount= UnitsInStock * Unitprice. Được sắp xếp theo TotalAcount giảm dần.
	SELECT [ProductID],[ProductName],[UnitPrice],[UnitsInStock],TotalAccount=[UnitPrice]*[UnitsInStock] FROM[dbo].[Products]
		ORDER BY TotalAccount DESC
--17.Liệt kê danh sách 5 customers có city bắt đầu ‘M’.
	SELECT TOP 5 * FROM [dbo].[Customers]
		WHERE City LIKE 'M%'
--18.Liệt kê danh sách 2 employees có tuổi lớn nhất. Thông tin bao gồm EmployeeID, EmployeeName, Age. Trong đó, EmployeeName được ghép từ 
--LastName và FirstName; Age là năm hiện hành trừ năm sinh.
	SELECT TOP 2 [EmployeeID],EmployeeName=[LastName]+' '+[FirstName],AGE = YEAR(GETDATE())-YEAR([BirthDate]) FROM [dbo].[Employees]
		ORDER BY AGE DESC
--19.Liệt kê danh sách các Products có số lượng tồn nhỏ hơn 5.
	SELECT *FROM [dbo].[Products]
		WHERE UnitsInStock<5
--20.Liệt kê danh sách các Orders gồm OrderId, Productid, Quantity, Unitprice, Discount, ToTal = Quantity * unitPrice – 20%*Discount.
	SELECT [OrderID],[ProductID],[UnitPrice],[Quantity],[Discount],TOTAL = [Quantity]*[UnitPrice]-20/100*[Discount] FROM[dbo].[Order Details]


	






	