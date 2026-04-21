-- Tạo cơ sở dữ liệu
CREATE DATABASE books_management;
USE books_management;
CREATE TABLE BOOKS (
    MaSach CHAR(5) PRIMARY KEY,
    TenSach VARCHAR(200) NOT NULL,
    SoLuong INT CHECK (SoLuong >= 0),
    GiaThue DECIMAL(10, 2) DEFAULT 5000
);
ALTER TABLE BOOKs 
ADD NgayNhap DATE not null;
CREATE TABLE BORROW_BOOKS (
    MaMuon INT AUTO_INCREMENT PRIMARY KEY,
    MaSach CHAR(5),
    NgayMuon DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (MaSach) REFERENCES BOOKS(MaSach)
);
select * from books;