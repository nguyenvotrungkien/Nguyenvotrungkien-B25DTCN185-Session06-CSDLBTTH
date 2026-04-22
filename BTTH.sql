-- dữ liệu mẫu em nhờ AI tạo
CREATE DATABASE HotelDB;
USE HotelDB;
-- USERS
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100)
);
-- HOTELS
CREATE TABLE hotels (
    hotel_id INT PRIMARY KEY,
    hotel_name VARCHAR(100),
    star_rating INT
);
-- BOOKINGS
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    user_id INT,
    hotel_id INT,
    total_price INT,
    status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);
INSERT INTO users VALUES
(1, 'Nguyen Van A'),
(2, 'Tran Thi B'),
(3, 'Le Van C'),
(4, 'Pham Thi D');
INSERT INTO hotels VALUES
(1, 'Luxury Hotel', 5),
(2, 'Premium Hotel', 4),
(3, 'Standard Hotel', 3);
INSERT INTO bookings VALUES
(1, 1, 1, 30000000, 'COMPLETED'),
(2, 1, 1, 25000000, 'COMPLETED'), 
(3, 1, 2, 20000000, 'COMPLETED'),
(4, 1, 2, 15000000, 'COMPLETED'),
(5, 2, 1, 10000000, 'COMPLETED'),
(6, 2, 1, 45000000, 'COMPLETED'), 
(7, 2, 3, 10000000, 'COMPLETED'),
(8, 3, 1, 40000000, 'COMPLETED'),
(9, 3, 1, -5000000, 'COMPLETED'),
(10, 3, 2, 20000000, 'COMPLETED'),
(11, 4, 1, 10000000, 'COMPLETED'),
(12, 4, 2, 15000000, 'COMPLETED'),
(13, 1, 1, 10000000, 'CANCELLED');
-- select 
-- lấy tên khách hàng, số sao của nhà hàng, tổng tiền đã chi tiêu
select u.full_name, h.star_rating, sum(b.total_price) total_price
-- từ bảng users 
from users u
-- nối 2 bảng hotels và booking
join bookings b on u.user_id = b.user_id -- nối bảng này để biết user sẽ đặt những đơn nào
join hotels h on h.hotel_id = b.hotel_id  -- nối bảng này để mỗi đơn booking ở trên sẽ đặt ở hotel nào mấy sao
-- điều kiện kiểm tra trạng thái phải là COMPLETED và để chống bẫy em thêm 1 phần kiểm thử nếu tổng tiền bị lưu bị âm
where b.status = 'COMPLETED' and b.total_price > 0 
--  đảm bảo mỗi khách hàng có total_price riêng
group by u.user_id, h.hotel_id
-- dùng having bởi vì cột này đã được tổng hợp trong bảng trên 
having total_price > 50000000
-- sắp xếp với số sao của nhà hotel trước nếu trùng thì lấy tên khách hàng nào chi nhiều hơn
order by h.star_rating DESC, u.full_name DESC