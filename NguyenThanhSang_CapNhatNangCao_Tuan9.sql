--Nguyen Thanh Sang
--C3 tiết 10 - 12
BÀI TẬP 1: LỆNH INSERT
Cách 1: Dùng chức năng Import/Export (kiểm tra kết quả sau mỗi lần thực hiện)
1) Tất cả các thông tin nhân viên có trong bảng Employees trong NorthWind ra
thành tập tin NhanVien.txt.
2) Dữ liệu của các bảng Products, Orders, Order Details trong bảng NorthWind vào
tập tin QLHH.MDB. Lưu ý: Tập tin QLHH.MDB phải tồn tại trên đĩa trước khi
thực hiện Export.
3) Dữ liệu các bảng Products, Suppliers trong NorthWind ra thành tập tin
SP_NCC.XLS
4) Các khách hàng có City là LonDon từ bảng Customers trong NorthWind ra
thành tập tin KH.xls.
5) Danh sách các sản phẩm ở Products trong NorthWind thành tập tin
SanPham.TXT, thông tin cần lấy bao gồm ProductID, ProductName,
QuantityPerUnit, Unitprice.
6) Các sản phẩm có SupplierID là 1 hoặc 2 hoặc 3 ở bảng Products trong
NorthWind vào bảng SanPham trong QLBH. Lưu ý chỉ chọn những cột mà trong
bảng sản phẩm cần.
7) Các nhà cung cấp có Country là USA ở bảng Suppliers trong NorthWin vào
bảng NhaCungCap trong QLBH. Lưu ý: chỉ chọn những cột mà trong bản
Nhacungcap cần.
8) Danh sách các nhân viên có trong tập tin Nhanvien.TXT vào bảng NhanVien
Cách 2: Dùng lệnh Insert…Select…
1) Xóa hết các dữ liệu đang có trong các Table của cơ sở dữ liệu QLBH bằng lệnh
Delete.
2) Trong trường hợp nào thì không xóa được dữ liệu bảng SanPham khi chưa xóa
dữ liệu bảng con của SanPham?
3) Nếu bạn muốn xóa bất kỳ Bảng cha thì xóa luôn các bảng quan hệ thì bạn phải
làm gì? Bạn thực hiện một ví dụ minh họa
4) Dùng lệnh Insert thêm vào mỗi bảng của CSDL QLBH 5 record với nội dung do
sinh viên tự nghĩ.
5) Dùng câu lệnh INSERT … SELECT với các cột chọn cần thiết để thêm dữ liệu
vào (nhớ kiểm tra kết quả sau mỗi lần thực hiện)
a. Các khách hàng có trong bảng Customers trong NorthWind vào bảng
KhachHang trong QLBH.
SELECT * FROM QLBH..KHACHHANG
INSERT QLBH..KHACHHANG
b. Các sản phẩm có SupplierID từ 4 đến 29 ở bảng Products trong CSDL
NorthWind vào bảng Sanpham trong QLBH.
--tHÊN VÀO NHÓM SẢN PHẨM
SELECT * FROM QLBH..NHOMSP
INSERT QLBH..NHOMSP SELECT CATEGORYID, CATEGORYNAME FROM CATEGORIES
-- THÊM VÀO BẢNG NHÀ CUNG CẤP
SELECT * FROM QLBH..NHACUNGCAP
INSERT QLBH..NHACUNGCAP
	SELECT [SupplierID],[CompanyName],[Address],[Phone],[Fax],[HomePage]
	FROM [dbo].[Suppliers]
--THÊM VÀO BẢNG SẢN PHẨM
SELECT * FROM QLBH..SANPHAM
INSERT QLBH..SANPHAM
	SELECT [ProductID],[ProductName],[SupplierID],[CategoryID],[QuantityPerUnit],
	[UnitPrice],[UnitsInStock] FROM [dbo].[Products] WHERE SUPPLIERID BETWEEN 4 AND 29
SELECT * FROM QLBH..SANPHAM
C. DANH SÁCH TẤT CẢ CACS HÓA ĐƠN CÓ ODID NẰM TRONG KHOẢNG 10248
ĐẾN 10350 TRONG BẢNG ORDERS TRONG NORTHWIND VÀO BẢNG HOADON, CÁC HÓA ĐƠN NÀY
ĐƯỢC XEM LÀ HÓA ĐƠN XUẤT - TỨC LOAIHD LÀ 'X'
SELECT * FROM QLBH..HOADON
ALTER TABLE QLBH..HOADON ADD LOAIHD CHAR(1)
INSERT QLBH..HOADON SELECT ORDERID, ORDERDATE, REQUIREDDATE, SHIPADDRESS, CUSTOMERID,'X'
	FROM ORDERS WHERE ORDERID BETWEEN 10248 AND 10350
d. Danh sách tất cả các hoá đơn có OrderID nằm trong khoảng 10351 đến
10446 trong bảng Orders trong Northwind vào bảng HoaDon, các hoá đơn
này được xem là hoá đơn nhập - tức LoaiHD là ‘N’
INSERT QLBH..HOADON SELECT ORDERID, ORDERDATE, REQUIREDDATE, SHIPADDRESS, CUSTOMERID,'N'
	FROM ORDERS WHERE ORDERID BETWEEN 10351 AND 10446
SELECT * FROM QLBH..HOADON
e. Danh sách tất cả các chi tiết hoá đơn có OderID nằm trong khoảng 10248
đến 10270 trong bảng Order Detail trong NorthWind vào bảng CT_HoaDon.
Chú ý: các ràng buộc khóa chính, khóa ngoại và các ràng buộc khác. Chỉ lấy các cột
tương ứng với các bảng trong CSDL QLBH
SELECT * FROM QLBH..CTHD
INSERT QLBH..CTHD
	SELECT [ProductID],[OrderID],[Quantity],[UnitPrice],[Discount]
	FROM [dbo].[Order Details]
	WHERE [OrderID] BETWEEN 10248 AND 10270 -- bị LỖI DO KHÔNG CÓ MASP TRONG BẢN SP

--
	INSERT QLBH..CTHD
	SELECT [ProductID],[OrderID],[Quantity],[UnitPrice],[Discount]
	FROM [dbo].[Order Details]
	WHERE [OrderID] BETWEEN 10248 AND 10270 AND [ProductID] IN 
	(SELECT MASP FROM QLBH..SANPHAM)
SELECT * FROM QLBH..CTHD
BÀI TẬP 2: LỆNH UPDATE
1. Cập nhật đơn giá bán 100000 cho NHỮNG sản phẩm có tên bắt đầu bằng chữ T
SELECT * FROM CTHD
	UPDATE CTHD
	SET DONGIABAN = 100000
	WHERE MASP IN (SELECT MASP FROM SANPHAM WHERE TENSP LIKE'T%')
2. Cập nhật số lượng tồn = 50% số lượng tồn hiện có cho những sản phẩm có đơn
vị tính có chữ box
SELECT * FROM SANPHAM 
	UPDATE SANPHAM
	SET SOLUONGTON = SOLUONGTON*(1.0*50/100)
	WHERE DONVITINH LIKE '%BOX%'

SELECT * FROM SANPHAM 
3. Cập nhật mã nhà cung cấp là 1 trong bảng NHACUNGCAP thành 100? Bạn có
cập nhật được hay không?. Vì sao?.
--KHÔNG, VI PHẠM KHÓA NGOẠI
4. Tăng điểm tích lũy lên 100 cho những khách hàng mua hàng trong tháng 7 năm
1997
	SELECT * FROM KHACHHANG
	ALTER TABLE KHACHHANG ADD DIEMTL INT
	UPDATE KHACHHANG
	SET DIEMTL = 0
	--
	UPDATE KHACHHANG 
	SET DIEMTL = DIEMTL +100
		WHERE MAKH IN 
			(SELECT MAKH FROM HOADON WHERE MONTH(NGAYLAP)=8 AND YEAR(NGAYLAP)=1996)
	SELECT * FROM KHACHHANG
5. Giảm 10% đơn giá bán cho những sản phẩm có số lượng tồn <10.
6. Cập nhật giá bán trong bảng CT_HoaDon bằng với đơn giá mua trong bảng
SanPham của các sản phẩm do nhà cung cấp có mã là 4 hay 7.
BÀI TẬP 3: LỆNH DELETE
Lưu ý, việc xóa dữ liệu là công việc cần thận trọng, nên chúng ta ít thao tác trên
CSDL với lệnh DELETE, trừ khi loại bỏ dữ liệu tạm. Nên phần này yêu cầu chúng
ta phải sao chép dữ liệu trước khi thực hiện các công việc sau:
1. Xóa các hóa đơn được lập trong tháng 7 năm 1996. Bạn có thực hiện được
không? Vì sao?
2. Xóa các hóa đơn của các khách hàng có loại là VL mua hàng trong năm 1996.
3. Xóa các sản phẩm chưa bán được trong năm 1996.
	DELETE FROM SANPHAM 
		WHERE MASP NOT IN (SELECT MASP FROM CTHD)
4. Xóa các khách hàng vãng lai. Lưu ý khi xóa xong thì phải xóa luôn các hóa đơn
và các chi tiết của các hóa đơn này trong bảng HoaDon và bảng CTHoaDon
5. Tạo bảng HoaDon797 chứa các hóa đơn được lập trong tháng 7 năm 1997. Sau
đó xóa toàn bộ dữ liệu của bảng này bằng lệnh Truncate
SELECT C.MAKH, TENKH, DIACHI, TONGTIEN = SUM(SOLUONG*DONGIABAN)
INTO HDKH_71996
FROM KHACHHANG C JOIN HOADON O ON O.MAKH = C.MAKH
	JOIN CTHD OD ON OD.MAHD = O.MAHD
WHERE MONTH(NGAYLAP)=7 AND YEAR(NGAYLAP)=1996
GROUP BY C.MAKH,TENKH,DIACHI

SELECT * FROM HDKH_71996

TRUNCATE TABLE HDKH_71996



BÀI TẬP 5: LỆNH SELECT – CÁC LOẠI TRUY VẤN KHÁC
1. Kết danh sách các Customer và Employee lại với nhau. Thông tin gồm
CodeID, Name, Address, Phone. Trong đó CodeID là
CustomerID/EmployeeID, Name là Companyname/LastName + FirstName,
Phone là Homephone.
SELECT CODEID = CUSTOMERID, NAME = COMPANYNAME, ADDRESS, PHONE FROM Customers
UNION
SELECT CODEID = CONVERT(NCHAR(5),EMPLOYEEID),NAME =LASTNAME+' '+FIRSTNAME, ADDRESS, HOMEPHONE
FROM Employees
2. Dùng lệnh SELECT…INTO tạo bảng HDKH_71997 cho biết tổng tiền khách
hàng đã mua trong tháng 7 năm 1997 gổm CustomerID, CompanyName,
Address, ToTal =sum(quantity*Unitprice)
SELECT O.[CustomerID],[CompanyName],[Address],TOTAL = SUM(QUANTITY * UNITPRICE)
INTO HDKH_71997
FROM Customers C JOIN Orders O ON O.CustomerID=C.CustomerID
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
WHERE MONTH(ORDERDATE)=7 AND YEAR(ORDERDATE)=1997
GROUP BY O.[CustomerID],[CompanyName],[Address]
--
SELECT * FROM HDKH_71997
3. Dùng lệnh SELECT…INTO tạo bảng LuongNV cho biết tổng lương của nhân
viên trong tháng 12 năm 1996 gổm EmployeeID, Name là LastName +
FirstName, Address, ToTal =sum(quantity*Unitprice)
4. Liệt kê các khách hàng có đơn hàng chuyển đến các quốc gia ([ShipCountry])
là 'Germany' và 'USA' trong quý 1 năm 1998, do công ty vận chuyển
(CompanyName) Speedy Express thực hiện, thông tin gồm [CustomerID],
[CompanyName] (tên khách hàng), tổng tiền.
5. Pivot Query
Tạo bảng dbo.HoaDonBanHang có cấu trúc sau
CREATE TABLE dbo.HoaDonBanHang
(
orderid INT NOT NULL,
orderdate DATE NOT NULL,
empid INT NOT NULL,
custid VARCHAR(5) NOT NULL,
qty INT NOT NULL,
CONSTRAINT PK_Orders PRIMARY KEY(orderid)
)Trường ĐH Công Nghiệp TP.HCM Bài Tập Thực Hành Môn Hệ Cơ Sở Dữ Liệu
Khoa Công Nghệ Thông Tin 41/46
Chèn dữ liệu vào bảng
(30001, '20070802', 3, 'A', 10),
(10001, '20071224', 2, 'A', 12),
(10005, '20071224', 1, 'B', 20),
(40001, '20080109', 2, 'A', 40),
(10006, '20080118', 1, 'C', 14),
(20001, '20080212', 2, 'B', 12),
(40005, '20090212', 3, 'A', 10),
(20002, '20090216', 1, 'C', 20),
(30003, '20090418', 2, 'B', 15),
(30004, '20070418', 3, 'C', 22),
(30007, '20090907', 3, 'D', 30)
a) Tính tổng Qty cho mỗi nhân viên. Thông tin gồm empid, custid
b) Tạo bảng Pivot có dạng sau
Gợi ý:
SELECT empid, A, B, C, D
FROM (SELECT empid, custid, qty
FROM dbo.Orders) AS D
PIVOT(SUM(qty) FOR custid IN(A, B, C, D)) AS P;
c) Tạo 1 query lấy dữ liệu từ bảng dbo.HoaDonBanHang trả về số
hóa đơn đã lập của nhân viên employee trong mỗi năm.
d) Tạo bảng pivot hiển thị số đơn đặt hàng được thực hiện bởi nhân
viên có mã 164, 198, 223, 231, and 233.