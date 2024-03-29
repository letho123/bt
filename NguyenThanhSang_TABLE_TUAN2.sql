﻿--Sang
--Tuan2
--C3 10-12

--1. Tạo CSDL QLSV
CREATE DATABASE QLSV
DROP DATABASE QLSV
--TẠO TABLE BẰNG CÔNG CỤ DESIGN
--2.1 TẠO BẢNG BẰNG LỆNH
--CÁCH 1 : TẠO BẢNG CÓ ĐẦY ĐỦ CÁC RÀNG BUỘC KHÓA CHÍNH, KHÓA NGOẠI, CHECK, DEFAULT 
--TẠO BẢNG CHA TRƯỚC, BẢNG CON XONG
--TẠO BẢNG NHÓM SẢN PHẨM
USE QLST
CREATE TABLE NHOMSP
	(MANHOM INT PRIMARY KEY,
	TENNHOM NVARCHAR(15))
--TẠO TABLE NHACUNGCAP
CREATE TABLE NHACUNGCAP
	(MANCC INT PRIMARY KEY,
	TENNCC NVARCHAR(40) NOT NULL,
	DIACHI NVARCHAR(60),
	PHONE NVARCHAR(24),
	SOFAX NVARCHAR(24),
	DCMAIL NVARCHAR(50))
-- TẠO BẢNG SẢN PHẨM CÓ KHÓA NGOẠI, RÀNG BUỘC QUI ĐỊNH NHẬP DƯ LIỆU
	CREATE TABLE SANPHAM
		(MASP INT PRIMARY KEY,
		TENSP NVARCHAR(40) NOT NULL,
		MANCC INT REFERENCES NHACUNGCAP(MANCC),
		MOTA NVARCHAR(50),
		MANHOM INT REFERENCES NHOMSP(MANHOM),
		DVT NVARCHAR(20),
		GIAGOC MONEY CHECK(GIAGOC>0),
		SLTON INT CHECK(SLTON>0))
	CREATE TABLE KHACHHANG
		(MAKH NCHAR(5) PRIMARY KEY,
		TENKH NVARCHAR(40) NOT NULL,
		LOAIKH NVARCHAR(3) CHECK (LOAIKH IN ('VIP','TV','VL')),
		DIACHI NVARCHAR(60),
		PHONE NVARCHAR(24),
		SOFAX NVARCHAR(24),
		DCMAIL NVARCHAR(50),
		NGAYDKTHE DATE DEFAULT GETDATE())
--TẠO BẢNG HÓA ĐƠN
	CREATE TABLE HOADON
		(MAHD INT PRIMARY KEY,
		NGAYLAP DATETIME CHECK(NGAYLAP>=GETDATE()),
		NGAYGIAO DATETIME,
		NOICHUYEN NVARCHAR(60),
		MAKH NCHAR(5) REFERENCES KHACHHANG(MAKH))
-- TẠO BẢNG CHITIETHD
	CREATE TABLE CTHD
		(MAHD INT REFERENCES HOADON(MAHD),
		 MASP INT REFERENCES SANPHAM(MASP),
		 SOLUONG SMALLINT CHECK(SOLUONG>0),
		 DONGIA MONEY,
		 CHIETKHAU MONEY CHECK(CHIETKHAU>0),
		 PRIMARY KEY(MAHD,MASP))
--1. Dùng T-SQL tạo CSDL Movies với các tham số sau:
--Tập tin Datafile có: Name: Movies_data; pathname: 
--C:\Movies\Movies_data.mdf; Size: 25 MB; Maxsize: 40 MB; FileGrowth: 1 MB. 
--Tập tin Log file có: Name: Movies_log; pathname: C:\Movies\Movies_log.ldf; Size: 6 MB; Maxsize: 8 MB; FileGrowth: 1 MB.
CREATE DATABASE MOVIES
ON PRIMARY
	(NAME ='MOVIES_DATA',
	FILENAME='D:\HECSDL\MOVIES_DATA.MDF',
	SIZE=25,
	MAXSIZE=40,
	FILEGROWTH =1)
LOG ON
	(NAME ='MOVIES_LOG',
	FILENAME='D:\HECSDL\MOVIES_LOG.LDF',
	SIZE=6,
	MAXSIZE=8,
	FILEGROWTH =1)

--2. Thực hiện, kiểm tra kết quả sau mỗi lần thực hiện: 
SP_HELPDB
--Thêm một Datafile thứ 2 có Name: Movies_data2; pathname: C:\Movies\Movies_data2.ndf; Size: 10 MB; thông số khác không cần chỉ định.
ALTER DATABASE MOVIES
	ADD File (Name =MOVIES_DATA2,
	Filename ='D:\HECSDL\MOVIES_DATA2.NDF',
	SIZE =10 MB)
SP_HELPDB MOVIES
--Tăng kích cỡ của data file thứ 2 từ 10 MB lên 15 MB. Kiểm tra lại
ALTER DATABASE MOVIES
		MODIFY FILE(NAME='MOVIES_DATA2',SIZE=15)
SP_HELPDB MOVIES
