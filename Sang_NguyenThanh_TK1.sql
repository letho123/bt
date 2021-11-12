﻿-- NGUYỄN THANH SANG
-- LỚP DHKTPM16ATT
-- C3(10-12)
CÂU 1 : 
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
CÂU 2 :
USE QLCT
CREATE TABLE PHONGBAN(MAPB CHAR(5), TENPB NVARCHAR(50))
CREATE TABLE CONGTRINH(MACT CHAR(5), TENCT NVARCHAR(40), DIADIEM NVARCHAR(50), NGAYCAPGP DATE, NGAYKC DATE, NGAYHT DATE)
CREATE TABLE NHANVIEN(MANV CHAR(5), TENNV NVARCHAR(30), PHAI CHAR(5), NGAYSINH DATE, DIACHI NVARCHAR(50), MAPB CHAR(5))
CREATE TABLE PHANCONG(MACT CHAR(5), MANV CHAR(5), SLNGAYCONG INT)
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
-- ràng buộc check
ALTER TABLE PHANCONG
		ADD CONSTRAINT CK_SLNGAYCONG CHECK	(SLNGAYCONG > 0)
ALTER TABLE CONGTRINH
	ADD CONSTRAINT CK_NGAYHT CHECK(NGAYHT>NGAYKC)
ALTER TABLE CONGTRINH
	ADD CONSTRAINT CK_NGAYKC DEFAULT GETDATE() FOR NGAYKC
CÂU 3:
SELECT * FROM CONGTRINH
INSERT CONGTRINH VALUES('3',N'NHÀ CỘNG ĐỒNG',N'HÀ NỘI','2017-11-11','2017-12-12','2019-10-9')
SELECT * FROM PHONGBAN
INSERT PHONGBAN VALUES('3',N'PHÒNG GIÁM SÁT')
SELECT * FROM NHANVIEN
INSERT NHANVIEN VALUES('259',N'ĐẶNG KIỀU ANH','NU','2002-12-10',N'GIA LAI','3')
SELECT * FROM PHANCONG
INSERT PHANCONG VALUES('3','259','25')
-- THÊM VÀO LUONG
ALTER TABLE NHANVIEN
	ADD LUONG FLOAT
UPDATE NHANVIEN
	SET LUONG = LUONG + 300000
ALTER TABLE PHANCONG
	ADD THANHTIEN MONEY
UPDATE PHANCONG
	SET THANHTIEN = SLNGAYCONG * 85000
CÂU 4 : 
SELECT NV.[MANV],[TENNV],NV.[MAPB]
	FROM [dbo].[NHANVIEN] NV JOIN [dbo].[PHONGBAN] PB ON NV.MAPB = PB.MAPB
	JOIN [dbo].[PHANCONG] PC ON PC.MANV = NV.MANV
		WHERE NV.MAPB IN ('NC','KT') AND PC.SLNGAYCONG BETWEEN 10 AND 50
	ORDER BY MAPB,SLNGAYCONG DESC
SELECT [MACT],[TENCT],[DIADIEM],[NGAYKC]
	FROM [dbo].[CONGTRINH]
	WHERE MONTH(NGAYKC)=1 AND YEAR(NGAYKC)=2014
SELECT TONGNVPHONG1 = COUNT([MANV])
	FROM [dbo].[NHANVIEN]
	WHERE MAPB = '1'
-- SL CONG TRINH MOI NV THAM GIA
SELECT PC.[MANV],[TENNV],SLCONGTRINHTHAMGIA = COUNT(PC.[MANV])
	FROM [dbo].[PHANCONG] PC JOIN [dbo].[NHANVIEN] NV ON PC.MANV=NV.MANV
	GROUP BY PC.[MANV],[TENNV]
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
-- công trình có nhiều nhân viên tham gia nhất
SELECT TOP 1 WITH TIES PC.[MACT],[TENCT], SLNV = COUNT(MANV)
	FROM [dbo].[CONGTRINH] CT JOIN [dbo].[PHANCONG] PC ON CT.MACT = PC.MACT
	GROUP BY PC.[MACT],[TENCT]
ORDER BY COUNT(MANV) DESC
-- công trình có tổng số ngày công trên 300
SELECT PC.[MACT],[TENCT],SLNGAYCONG = SUM([SLNGAYCONG])
	FROM [dbo].[CONGTRINH] CT JOIN [dbo].[PHANCONG] PC ON CT.MACT = PC.MACT
	GROUP BY PC.[MACT],[TENCT]
	HAVING SUM([SLNGAYCONG])>300
-- XÓA CÁC CT ĐÃ HOÀN THÀNH NĂM 2014 
DELETE FROM CONGTRINH
	WHERE YEAR([NGAYKC])=2014
	







