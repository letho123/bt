﻿--Nguyễn Thanh Sang
-- Lớp
--C3(10-12)
--1. Tạo csdl QLBH 
CREATE DATABASE QLBH2
ON PRIMARY
	(NAME = 'QLBH21_DATA'
	FILENAME = 'D:\HECSDL\QLBH21_DATA.MDF',
	SIZE = 8,
	MAXSIZE = 15,
	FILEGROWTH = 1)
LOG ON
	(NAME = 'QLBH2_LOG',
	FILENAME = 'D:\HECSDL\QLBH2_LOG.NDF',
	SIZE = 4,
	FILEGROWTH =1)
--2.MỞ CSDL ĐỂ SD
	USE QLBH
-- 3. TẠO TABLE MÀ KHÔNG CÓ RÀNG  BUỘC
	CREATE TABLE NHOMSP(MANHOM INT, TENNHOM NVARCHAR(40))
--3.1 tẠO BANGE CÓ SỐ TỰ ĐỘNG TĂNG 

	CREATE TABLE SANPHAM(MASP INT IDENTITY , TENSP NVARCHAR(40), SLT INT)

	CREATE TABLE SP(MASP INT IDENTITY(4,7) , TENSP NVARCHAR(40), SLT INT)
--3.2 TẠO BẢNG MÀ CÓ CỘT TÍNH TOÁN
	CREATE TABLE CTHD(MAHD CHAR(10), MASP INT, SOLUONG INT, DONGIA MONEY, THANHTIEN AS SOLUONG*DONGIA)
--4. SỬA CHỮA CẤU TRÚC BẢNG 
--4.1 THÊM CỘT NGÀY NHẬP VÀO BẢNG SẢN PHẨM
	ALTER TABLE SANPHAM ADD NGAYNHAP DATE
--4.2 SỬA CHỮA DỮ LIỆU CHO CỘT 
	ALTER TABLE SANPHAM ALTER COLUMN TENSP NVARCHAR(50)
--4.3 XÓA CỘT ĐÃ CÓ
	ALTER TABLE SANPHAM DROP COLUMN NGAYNHAP
--5. THÊM CÁC RÀNG BUỘC
--5.1 THÊM RÀNG BUỘC KHÓA CHÍNH
	ALTER TABLE NHOMSP
		ADD CONSTRAINT PK_MANHOM PRIMARY KEY(MANHOM)
	ALTER TABLE NHOMSP
		ALTER COLUMN MANHOM INT NOT NULL
	ALTER TABLE SANPHAM ADD MANHOM INT
	-- THÊM RÀNG BUỘC KHÓA CHÍNH CHO BẢNG SẢN PHẨM
	ALTER TABLE SANPHAM
		ADD CONSTRAINT PK_MASP PRIMARY KEY (MASP)
	-- THÊM RÀNG BUỘC KHÓA CHÍNH CHO CHI TIẾT HÓA ĐƠN
	ALTER TABLE CTHD 
		ADD CONSTRAINT PK_MAHD_MASP PRIMARY KEY(MAHD,MASP)
	ALTER TABLE CTHD ALTER COLUMN MAHD CHAR(10) NOT NULL
	ALTER TABLE CTHD ALTER COLUMN MASP INT NOT NULL

	-- TẠO THÊM BẢNG HÓA ĐƠN
	CREATE TABLE HOADON (MAHD CHAR(10) PRIMARY KEY, NGAYLAP DATE , NGAYGIAO DATE, MAKH CHAR(10))
--5.2 THÊM RÀNG BUỘC KHÓA NGOẠI
	ALTER TABLE SANPHAM
		ADD CONSTRAINT FK_MANHOM FOREIGN KEY(MANHOM) REFERENCES NHOMSP(MANHOM)
	ALTER TABLE CTHD
		ADD CONSTRAINT FK_MAHD FOREIGN KEY(MAHD) REFERENCES HOADON(MAHD)
	ALTER TABLE CTHD
		ADD CONSTRAINT FK_MASP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)
--TẠO QUAN HỆ GIỮA SP VÀ NHÓM SP
	ALTER TABLE SP ADD CONSTRAINT PK_MASP1 PRIMARY KEY(MASP)
	ALTER TABLE SP ADD MANHOM INT
--5.3 THÊM RÀNG BUỘC KHÓA NGOẠI KHI SỬA HAY XÓA DỮ LIỆU CỦA BẢNG CHA THÌ DỮ LIỆU CÓ BÊN BẢNG CON CŨNG BỊ SỬA HOẶC XÓA THEO
	ALTER TABLE SP
		ADD CONSTRAINT FK_MANHOM1 FOREIGN KEY(MANHOM) REFERENCES NHOMSP(MANHOM)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	ALTER TABLE SANPHAM DROP CONSTRAINT FK_MANHOM
--5.3 THÊM RÀNG BUỘC QUI ĐỊNH NHẬP DỮ LIỆU - RÀNG BUỘC CHECK
	ALTER TABLE SANPHAM
		ADD CONSTRAINT CK_SLT CHECK(SLT>=10 AND SLT<=100)
	HAY
	ALTER TABLE SANPHAM
		ADD CONSTRAINT CK_SLT CHECK(SLT BETWEEN 10 AND 100)
--5.4 THÊM RÀNG BUỘC LÀ TÊN SP CHỈ NHẬP TÁO, NHO, CAM, LÊ
	ALTER TABLE SANPHAM
		ADD CONSTRAINT CK_TENSP CHECK (TENSP=N'TÁO' OR TENSP=N'NHO' OR TENSP=N'CAM' OR TENSP=N'LÊ')
	HAY
	ALTER TABLE SANPHAM
		ADD CONSTRAINT CK_TENSP CHECK (TENSP IN(N'TÁO',N'NHO',N'CAM',N'LÊ'))
--5.5 THÊM RÀNG BUỘC GIÁ TRỊ MẶC ĐỊNH BAN ĐẦU
	ALTER TABLE SANPHAM 
		ADD CONSTRAINT DF_SLT DEFAULT 50 FOR SLT
	ALTER TABLE HOADON
		ADD CONSTRAINT DF_NGAYLAP DEFAULT GETDATE() FOR NGAYLAP
	ALTER TABLE HOADON
		ADD CONSTRAINT CK_NGAYLAP CHECK(NGAYGIAO>=NGAYLAP)
--5.6 XÓA RÀNG BUỘC
	ALTER TABLE HOADON
		DROP CONSTRAINT CK_NGAYLAP
--6. XÓA TABLE
	DROP TABLE SP