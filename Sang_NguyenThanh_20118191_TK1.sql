-- NGUYỄN THANH SANG
-- LỚP DHKTPM16ATT
-- C3(10-12)
CÂU 1 : (1 điểm)
Sử dụng T_SQL để tạo Database QLCT có Data file là QLCT_data và File Log
QLCT_Log. Các thông số cho các file tùy sinh viên qui định
CREATE DATABASE QLCT
ON PRIMARY
	(NAME ='QLCT_DATA',
	FILENAME='D:\HECSDL\QLCT_DATA.MDF',
	SIZE=20,
	MAXSIZE=40,
	FILEGROWTH =1)
LOG ON
	(NAME ='QLCT_LOG',
	FILENAME='D:\HECSDL\QLCT_LOG.LDF',
	SIZE=6,
	MAXSIZE=8,
	FILEGROWTH =1)
CÂU 2 : Tạo các Table và các ràng buộc cho các bảng (3 điểm). Sinh viên có thể tạo cùng
với lệnh Create Table hay tạo các ràng buộc bằng lệnh Alter Table
Phongban(mapb char(5), tenpb nvarchar(50))Họ Tên Sinh Viên .............................................. MASV ...................... Lớp ..................................... Đề 2
Trang 2
Congtrinh(mact char(5), tenct nvarchar(40), diadiem nvarchar(50), ngaycapgp date, ngaykc
date, ngayht date)
Nhanvien(manv char(5), tennv nvarchar(30), phai char(5), ngsinh date, diachi nvarchar(50),
mapb char(5))
Phancong(mact char(5), manv char(5), slngaycong int)
USE QLCT
CREATE TABLE PHONGBAN(MAPB CHAR(5), TENPB NVARCHAR(50))
CREATE TABLE CONGTRINH(MACT CHAR(5), TENCT NVARCHAR(40), DIADIEM NVARCHAR(50), NGAYCAPGP DATE, NGAYKC DATE, NGAYHT DATE)
CREATE TABLE NHANVIEN(MANV CHAR(5), TENNV NVARCHAR(30), PHAI CHAR(5), NGAYSINH DATE, DIACHI NVARCHAR(50), MAPB CHAR(5))
CREATE TABLE PHANCONG(MACT CHAR(5), MANV CHAR(5), SLNGAYCONG INT)
1. Các ràng buộc khóa chính và khóa ngoại
-- RÀNG BUỘC KHÓA CHÍNH
ALTER TABLE PHONGBAN
	ADD CONSTRAINT PK_MAPB PRIMARY KEY(MAPB)
ALTER TABLE PHONGBAN
	ALTER COLUMN MAPB CHAR(5) NOT NULL
ALTER TABLE CONGTRINH
	ADD CONSTRAINT PK_MACT PRIMARY KEY(MACT)
ALTER TABLE CONGTRINH
	ALTER COLUMN MACT CHAR(5) NOT NULL
ALTER TABLE NHANVIEN
	ADD CONSTRAINT PK_MANV PRIMARY KEY(MANV)
ALTER TABLE NHANVIEN
	ALTER COLUMN MANV CHAR(5) NOT NULL
ALTER TABLE PHANCONG
	ADD CONSTRAINT PK_MANV_MACT PRIMARY KEY(MANV,MACT)
ALTER TABLE PHANCONG ALTER COLUMN MANV CHAR(5) NOT NULL
ALTER TABLE PHANCONG ALTER COLUMN MACT CHAR(5) NOT NULL
--RÀNG BUỘC KHÓA NGOẠI
ALTER TABLE PHANCONG
		ADD CONSTRAINT FK_MANV FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV)
		ON DELETE CASCADE
		ON UPDATE CASCADE
ALTER TABLE PHANCONG
		ADD CONSTRAINT FK_MACT FOREIGN KEY(MACT) REFERENCES CONGTRINH(MACT)
		ON DELETE CASCADE
		ON UPDATE CASCADE
ALTER TABLE NHANVIEN
		ADD CONSTRAINT FK_MAPB FOREIGN KEY(MAPB) REFERENCES PHONGBAN(MAPB)
		ON DELETE CASCADE
		ON UPDATE CASCADE
2. Số ngày công lớn hơn 0 và Ngày hoàn thành lớn hơn ngày khởi công.
-- ràng buộc check
ALTER TABLE PHANCONG
		ADD CONSTRAINT CK_SLNGAYCONG CHECK	(SLNGAYCONG > 0)
ALTER TABLE CONGTRINH
	ADD CONSTRAINT CK_NGAYHT CHECK(NGAYHT>NGAYKC)
3. Tạo ràng buộc giá trị mặc định ban đầu cho ngày khởi công là ngày hiện hành
ALTER TABLE CONGTRINH
	ADD CONSTRAINT CK_NGAYKC DEFAULT GETDATE() FOR NGAYKC
CÂU 3 : (2 điểm)
• Nhập dữ liệu các bảng và nhập thêm dữ liệu bằng lệnh Insert cho các bảng trên, mỗi Table
là chứa khóa chính là 2 record, khóa ngoại là 5 record dữ liệu tùy ý sinh viên.
SELECT * FROM CONGTRINH
INSERT CONGTRINH VALUES('3',N'NHÀ CỘNG ĐỒNG',N'HÀ NỘI','2017-11-11','2017-12-12','2019-10-9')
SELECT * FROM PHONGBAN
INSERT PHONGBAN VALUES('3',N'PHÒNG GIÁM SÁT')
SELECT * FROM NHANVIEN
INSERT NHANVIEN VALUES('259',N'ĐẶNG KIỀU ANH','NU','2002-12-10',N'GIA LAI','3')
SELECT * FROM PHANCONG
INSERT PHANCONG VALUES('3','259','25')
• Thêm vào bảng NhanVien Field Luong và bảng PhanCong filed ThanhTien kiểu dữ liệu
sinh viên tự qui định. Sau đó dùng lệnh UPDATE cập nhật dữ liệu cho 2 field này theo
công thức sau:
❖ Thành tiền = SLNGAYCONG*85000
-- THÊM VÀO LUONG
ALTER TABLE NHANVIEN
	ADD LUONG FLOAT
UPDATE NHANVIEN
	SET LUONG = LUONG + 300000
ALTER TABLE PHANCONG
	ADD THANHTIEN MONEY
UPDATE PHANCONG
	SET THANHTIEN = SLNGAYCONG * 85000
CÂU 4 : Viết các câu truy vấn sau (4 điểm)
1. Danh sách các nhân viên thuộc phòng NC và phòng KT mà có số ngày công từ 10 đến 50
được sắp xếp theo phòng, nếu cùng phòng thì sắp xếp theo SONC giảm dần
SELECT NV.[MANV],[TENNV],NV.[MAPB]
	FROM [dbo].[NHANVIEN] NV JOIN [dbo].[PHONGBAN] PB ON NV.MAPB = PB.MAPB
	JOIN [dbo].[PHANCONG] PC ON PC.MANV = NV.MANV
		WHERE NV.MAPB IN ('NC','KT') AND PC.SLNGAYCONG BETWEEN 10 AND 50
	ORDER BY MAPB,SLNGAYCONG DESC
2. Cho biết công trình nào được khởi công vào tháng 1 năm 2014
SELECT [MACT],[TENCT],[DIADIEM],[NGAYKC]
	FROM [dbo].[CONGTRINH]
	WHERE MONTH(NGAYKC)=1 AND YEAR(NGAYKC)=2014
3. Cho biết tổng số nhân viên theo từng phòng ban và mỗi nhân viên tham gia bao nhiêu
công trình.
SELECT [MAPB],TONGNVPHONG = COUNT([MANV])
	FROM [dbo].[NHANVIEN]
	group by [MAPB]
-- SL CONG TRINH MOI NV THAM GIA
SELECT PC.[MANV],[TENNV],SLCONGTRINHTHAMGIA = COUNT(PC.[MANV])
	FROM [dbo].[PHANCONG] PC JOIN [dbo].[NHANVIEN] NV ON PC.MANV=NV.MANV
	GROUP BY PC.[MANV],[TENNV]
4. Cho biết nhân viên nào chưa tham gia công trình nào cả. Yêu cầu viết bằng 3 cách
(LEFT JOIN, NOT IN, NOT EXISTS) (1 ĐIỂM)
-- NV CHƯA THAM GIA CÔNG TRÌNH NÀO
-- CÁCH 1 LEFT JOIN
SELECT NV.[MANV],[TENNV] 
	FROM [dbo].[NHANVIEN] NV LEFT JOIN [dbo].[PHANCONG] PC ON NV.MANV=PC.MANV
	WHERE PC.MACT IS NULL
-- CÁCH 2 DÙNG NOT IN
SELECT [MANV],[TENNV]
	FROM [dbo].[NHANVIEN]
	WHERE [MANV] NOT IN (SELECT [MANV] FROM [dbo].[PHANCONG])
-- CÁCH 3 DÙNG NOT EXISTS
SELECT [MANV],[TENNV]
	FROM [dbo].[NHANVIEN] NV
	WHERE NOT EXISTS (SELECT * FROM [dbo].[PHANCONG] PC WHERE NV.MANV=PC.MANV)
5. Cho biết công trình nào có nhiều nhân viên tham gia nhất.
-- công trình có nhiều nhân viên tham gia nhất
SELECT TOP 1 WITH TIES PC.[MACT],[TENCT], SLNV = COUNT(MANV)
	FROM [dbo].[CONGTRINH] CT JOIN [dbo].[PHANCONG] PC ON CT.MACT = PC.MACT
	GROUP BY PC.[MACT],[TENCT]
ORDER BY COUNT(MANV) DESC
6. Cho biết công trình nào nào có tổng số ngày công trên 300.
-- công trình có tổng số ngày công trên 300
SELECT PC.[MACT],[TENCT],SLNGAYCONG = SUM([SLNGAYCONG])
	FROM [dbo].[CONGTRINH] CT JOIN [dbo].[PHANCONG] PC ON CT.MACT = PC.MACT
	GROUP BY PC.[MACT],[TENCT]
	HAVING SUM([SLNGAYCONG])>300
7. Xóa các công trình đã hoàn thành năm 2014.
-- XÓA CÁC CT ĐÃ HOÀN THÀNH NĂM 2014 
DELETE FROM CONGTRINH
	WHERE YEAR([NGAYHT])=2014
	







