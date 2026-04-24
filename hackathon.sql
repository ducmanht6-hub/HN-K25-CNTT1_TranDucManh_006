drop database if exists library_db;

-- Tạo CSDL 
create database library_db;
use library_db;

-- Tạo bảng 
create table users(
	user_id varchar(5) primary key not null,
    full_name varchar(100) not null,
    email varchar(100) not null unique,
    phone varchar(15) not null unique
);

create table categories(
	category_id varchar(5) primary key not null,
    category_name varchar(100) not null unique
);

create table books(
	book_id varchar(5) primary key not null,
    title varchar(100) not null unique,
    category_id varchar(5),
    price decimal(10,2) not null,
    stock int not null,
    foreign key (category_id) references categories(category_id)
);

create table borrows(
	borrow_id int primary key not null auto_increment,
    user_id varchar(5),
    book_id varchar(5),
    status varchar(20),
    borrow_date date not null,
    foreign key (user_id) references users(user_id),
    foreign key (book_id) references books(book_id)
);

-- Nhập dữ liệu vào bảng 
insert into users(user_id, full_name, email, phone)
values
	('U01','Nguyễn Văn An','a@m.com','0912345678'),
    ('U02','Trần Thị Bích','b@m.com','0923456789'),
    ('U03','Lê Hoàng Minh','mi@m.com','0934567890'),
    ('U04','Phạm Thu Hà','h@m.com','0945678901'),
    ('U05','Võ Quốc Huy','hu@m.com','0956789012');
    
insert into categories(category_id, category_name)
values
	('C01','IT'),
    ('C02','Literature'),
    ('C03','Science'),
    ('C04','History');
    
insert into books(book_id, title, category_id, price, stock)
values
	('B01','Clean Code','C01', 250000, 10),
    ('B02','Design Pattern','C01', 300000, 5),
    ('B03','Tat Den','C02', 50000, 20),
    ('B04','Universe','C03', 150000, 8),
    ('B05','Sapiens','C04', 200000, 15);
    
insert into borrows(user_id, book_id, borrow_date, status)
values
	('U01','B01','2025-10-01','Borrowing'),
    ('U02','B03','2025-10-02','Returned'),
    ('U03','B02','2025-10-03','Returned'),
    ('U04','B05','2025-10-04','Lost'),
    ('U05','B01','2025-10-05','Borrowing');

-- Sách 'sapiens' tăng stock lên 10 và price lên 5% 
update books
set stock = stock + 10
where book_id = 'B05';

update books
set price = price * 1.5
where book_id = 'B05';

-- Cập nhật số điện thoại user_id = 'U03'
update users
set phone = '0999999999'
where user_id = 'U03';

-- Xóa tất cả bản ghi mượn sách đã trả và mượn trước '2025-10-03'(Tắt safe mode)
delete  from borrows
where status = 'Returned'
and borrow_date < '2025-10-03';

-- Tắt safe mode
set sql_safe_module = 0; 

-- liệt kê các sách giá đền bù từ 100000 đến 250000 và stock > 0 
select book_id, title, price from books
where price between 100000 and 250000 
and stock > 0;

-- Lấy thông tin họ tên, email có họ là 'Nguyễn'
select full_name, email from users
where full_name like '%Nguyễn%';

-- Hiển thị danh sách mượn borrow_id, user_id, borrow_date và borrow_date giảm dần
select borrow_id, user_id, borrow_date from borrows
order by borrow_date desc;

-- Lấy 3 sách có giá đền bù đắt nhất
select title, price from books
order by price desc
limit 3;

-- Hiển thị title, stock bỏ qua 2 sách đầu lấy 2 sách tiếp theo
select title, stock from books
limit 2 offset 2;

