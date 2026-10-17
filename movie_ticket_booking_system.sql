------ database
CREATE DATABASE movie_ticket_booking;
USE movie_ticket_booking;

---- table creation
-----1. Movies table
CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(120) NOT NULL,
    genre VARCHAR(40),
    release_year INT,
    duration_minutes INT,
    certificate VARCHAR(10),
    rating DECIMAL(3,1)
);

----2. Theaters table
CREATE TABLE theaters (
    theater_id INT PRIMARY KEY,
    theater_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    address VARCHAR(150),
    phone VARCHAR(15) UNIQUE
);

------3. Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE,
    phone VARCHAR(15) UNIQUE,
    city VARCHAR(50),
    joined_on DATE
);

-----4. Screens table
CREATE TABLE screens (
    screen_id INT PRIMARY KEY,
    theater_id INT NOT NULL,
    screen_name VARCHAR(40),
    screen_type VARCHAR(30),
    total_seats INT,
    FOREIGN KEY (theater_id)
        REFERENCES theaters(theater_id)
);

------5. Seats table
CREATE TABLE seats (
    seat_id INT PRIMARY KEY,
    screen_id INT NOT NULL,
    seat_number VARCHAR(10),
    seat_type VARCHAR(20),
    seat_price DECIMAL(8,2),
    seat_status VARCHAR(20) DEFAULT 'Available',
    UNIQUE (screen_id, seat_number),
    FOREIGN KEY (screen_id)
        REFERENCES screens(screen_id)
);

------6. Showtimes table
CREATE TABLE showtimes (
    showtime_id INT PRIMARY KEY,
    movie_id INT NOT NULL,
    theater_id INT NOT NULL,
    screen_id INT NOT NULL,
    show_date DATE,
    show_time TIME,
    language VARCHAR(30),
    FOREIGN KEY (movie_id)
        REFERENCES movies(movie_id),
    FOREIGN KEY (theater_id)
        REFERENCES theaters(theater_id),
    FOREIGN KEY (screen_id)
        REFERENCES screens(screen_id)
);

------7. Bookings table
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    showtime_id INT NOT NULL,
    booking_date DATETIME,
    number_of_tickets INT,
    total_amount DECIMAL(10,2),
    booking_status VARCHAR(20),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY (showtime_id)
        REFERENCES showtimes(showtime_id)
);

------8. Booking seats table
CREATE TABLE booking_seats (
    booking_seat_id INT PRIMARY KEY,
    booking_id INT NOT NULL,
    seat_id INT NOT NULL,
    ticket_price DECIMAL(8,2),
    UNIQUE (booking_id, seat_id),
    FOREIGN KEY (booking_id)
        REFERENCES bookings(booking_id),
    FOREIGN KEY (seat_id)
        REFERENCES seats(seat_id)
);


-----9. Payments table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    booking_id INT NOT NULL UNIQUE,
    payment_date DATETIME,
    payment_method VARCHAR(30),
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    transaction_ref VARCHAR(40) UNIQUE,
    FOREIGN KEY (booking_id)
        REFERENCES bookings(booking_id)
);

------10. Reviews table
CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    movie_id INT NOT NULL,
    review_date DATE,
    rating DECIMAL(3,1),
    review_text VARCHAR(300),
    UNIQUE (customer_id, movie_id),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY (movie_id)
        REFERENCES movies(movie_id)
);

-------insert the table value
-------1. Insert movies — 30 records
INSERT INTO movies VALUES
(1,'The Last Journey','Drama',2024,148,'U/A',8.1),
(2,'Code Red','Action',2025,132,'U/A',7.8),
(3,'Moonlight Melody','Romance',2023,124,'U',7.2),
(4,'Galaxy Warriors','Sci-Fi',2025,156,'U/A',8.4),
(5,'Silent Witness','Thriller',2022,139,'A',7.9),
(6,'Laugh Out Loud','Comedy',2024,118,'U',6.9),
(7,'The Lost Kingdom','Adventure',2021,145,'U/A',7.5),
(8,'Ocean Mystery','Mystery',2025,130,'U/A',7.7),
(9,'Final Over','Sports',2023,142,'U',8.0),
(10,'Hidden Truth','Crime',2024,136,'A',7.6),
(11,'Little Stars','Family',2022,112,'U',7.1),
(12,'Shadow Protocol','Action',2025,151,'U/A',8.2),
(13,'Beyond Earth','Sci-Fi',2024,149,'U/A',7.9),
(14,'Summer Rain','Romance',2021,121,'U',6.8),
(15,'Midnight Call','Horror',2023,108,'A',7.0),
(16,'City Lights','Drama',2022,127,'U/A',7.4),
(17,'The Great Escape','Adventure',2025,143,'U/A',8.1),
(18,'Perfect Plan','Comedy',2023,116,'U',7.3),
(19,'Deep Blue','Thriller',2024,134,'U/A',7.8),
(20,'Kings Promise','Historical',2021,158,'U/A',7.6),
(21,'Pixel Dreams','Animation',2025,105,'U',7.9),
(22,'The Verdict','Courtroom',2022,141,'U/A',8.3),
(23,'Wild Track','Adventure',2024,129,'U/A',7.2),
(24,'One More Chance','Romance',2025,123,'U',7.5),
(25,'Black Signal','Mystery',2023,137,'A',7.7),
(26,'Mountain Road','Drama',2021,133,'U',7.0),
(27,'Turbo Run','Action',2024,120,'U/A',7.4),
(28,'The Inventor','Biography',2022,146,'U',8.0),
(29,'Red Planet','Sci-Fi',2025,154,'U/A',8.5),
(30,'Home Again','Family',2023,110,'U',7.1);

---------2. Insert theaters — 30 records
INSERT INTO theaters VALUES
(1,'Grand Cinemas 1','Chennai','11 Main Road','0445001001'),
(2,'Star Screens 1','Coimbatore','12 Main Road','0445001002'),
(3,'CityPlex 1','Trichy','13 Main Road','0445001003'),
(4,'Royal Movies 1','Madurai','14 Main Road','0445001004'),
(5,'Galaxy Theatre 1','Salem','15 Main Road','0445001005'),
(6,'Sunrise Cinemas 1','Erode','16 Main Road','0445001006'),
(7,'Metroplex 1','Vellore','17 Main Road','0445001007'),
(8,'Silver Screen 1','Tirunelveli','18 Main Road','0445001008'),
(9,'Dream Cinemas 1','Thanjavur','19 Main Road','0445001009'),
(10,'Prime Theatre 1','Dindigul','20 Main Road','0445001010'),
(11,'Grand Cinemas 2','Chennai','21 Main Road','0445001011'),
(12,'Star Screens 2','Coimbatore','22 Main Road','0445001012'),
(13,'CityPlex 2','Trichy','23 Main Road','0445001013'),
(14,'Royal Movies 2','Madurai','24 Main Road','0445001014'),
(15,'Galaxy Theatre 2','Salem','25 Main Road','0445001015'),
(16,'Sunrise Cinemas 2','Erode','26 Main Road','0445001016'),
(17,'Metroplex 2','Vellore','27 Main Road','0445001017'),
(18,'Silver Screen 2','Tirunelveli','28 Main Road','0445001018'),
(19,'Dream Cinemas 2','Thanjavur','29 Main Road','0445001019'),
(20,'Prime Theatre 2','Dindigul','30 Main Road','0445001020'),
(21,'Grand Cinemas 3','Chennai','31 Main Road','0445001021'),
(22,'Star Screens 3','Coimbatore','32 Main Road','0445001022'),
(23,'CityPlex 3','Trichy','33 Main Road','0445001023'),
(24,'Royal Movies 3','Madurai','34 Main Road','0445001024'),
(25,'Galaxy Theatre 3','Salem','35 Main Road','0445001025'),
(26,'Sunrise Cinemas 3','Erode','36 Main Road','0445001026'),
(27,'Metroplex 3','Vellore','37 Main Road','0445001027'),
(28,'Silver Screen 3','Tirunelveli','38 Main Road','0445001028'),
(29,'Dream Cinemas 3','Thanjavur','39 Main Road','0445001029'),
(30,'Prime Theatre 3','Dindigul','40 Main Road','0445001030');

-----3. Insert customers — 30 records
INSERT INTO customers VALUES
(1,'Aarav Kumar','aarav.kumar@example.com','9876501001','Chennai','2026-01-01'),
(2,'Diya Sharma','diya.sharma@example.com','9876501002','Coimbatore','2026-02-02'),
(3,'Arjun Raj','arjun.raj@example.com','9876501003','Trichy','2026-03-03'),
(4,'Meera Devi','meera.devi@example.com','9876501004','Madurai','2026-04-04'),
(5,'Kavin Kumar','kavin.kumar@example.com','9876501005','Salem','2026-05-05'),
(6,'Nila Priya','nila.priya@example.com','9876501006','Erode','2026-06-06'),
(7,'Rohan Das','rohan.das@example.com','9876501007','Vellore','2026-07-07'),
(8,'Ananya S','ananya.s@example.com','9876501008','Chennai','2026-08-08'),
(9,'Vikram M','vikram.m@example.com','9876501009','Trichy','2026-09-09'),
(10,'Isha Patel','isha.patel@example.com','9876501010','Madurai','2026-01-10'),
(11,'Sanjay K','sanjay.k@example.com','9876501011','Salem','2026-02-11'),
(12,'Kavya R','kavya.r@example.com','9876501012','Coimbatore','2026-03-12'),
(13,'Pranav N','pranav.n@example.com','9876501013','Erode','2026-04-13'),
(14,'Aditi Rao','aditi.rao@example.com','9876501014','Vellore','2026-05-14'),
(15,'Hari Prasad','hari.prasad@example.com','9876501015','Chennai','2026-06-15'),
(16,'Mithra S','mithra.s@example.com','9876501016','Trichy','2026-07-16'),
(17,'Surya V','surya.v@example.com','9876501017','Madurai','2026-08-17'),
(18,'Pooja M','pooja.m@example.com','9876501018','Salem','2026-09-18'),
(19,'Dinesh B','dinesh.b@example.com','9876501019','Coimbatore','2026-01-19'),
(20,'Lavanya T','lavanya.t@example.com','9876501020','Erode','2026-02-20'),
(21,'Rahul Dev','rahul.dev@example.com','9876501021','Vellore','2026-03-21'),
(22,'Sneha P','sneha.p@example.com','9876501022','Chennai','2026-04-22'),
(23,'Ajay Kumar','ajay.kumar@example.com','9876501023','Trichy','2026-05-23'),
(24,'Janani R','janani.r@example.com','9876501024','Madurai','2026-06-24'),
(25,'Naveen S','naveen.s@example.com','9876501025','Salem','2026-07-25'),
(26,'Keerthi M','keerthi.m@example.com','9876501026','Coimbatore','2026-08-26'),
(27,'Manoj K','manoj.k@example.com','9876501027','Erode','2026-09-27'),
(28,'Riya N','riya.n@example.com','9876501028','Vellore','2026-01-01'),
(29,'Gokul P','gokul.p@example.com','9876501029','Chennai','2026-02-02'),
(30,'Swetha L','swetha.l@example.com','9876501030','Trichy','2026-03-03');

-------4. Insert screens — 30 records
INSERT INTO screens VALUES
(1,1,'Screen 1','2D',100),
(2,2,'Screen 2','3D',120),
(3,3,'Screen 3','IMAX',140),
(4,4,'Screen 4','2D',160),
(5,5,'Screen 5','3D',180),
(6,6,'Screen 6','IMAX',100),
(7,7,'Screen 7','2D',120),
(8,8,'Screen 8','3D',140),
(9,9,'Screen 9','IMAX',160),
(10,10,'Screen 10','2D',180),
(11,11,'Screen 11','3D',100),
(12,12,'Screen 12','IMAX',120),
(13,13,'Screen 13','2D',140),
(14,14,'Screen 14','3D',160),
(15,15,'Screen 15','IMAX',180),
(16,16,'Screen 16','2D',100),
(17,17,'Screen 17','3D',120),
(18,18,'Screen 18','IMAX',140),
(19,19,'Screen 19','2D',160),
(20,20,'Screen 20','3D',180),
(21,21,'Screen 21','IMAX',100),
(22,22,'Screen 22','2D',120),
(23,23,'Screen 23','3D',140),
(24,24,'Screen 24','IMAX',160),
(25,25,'Screen 25','2D',180),
(26,26,'Screen 26','3D',100),
(27,27,'Screen 27','IMAX',120),
(28,28,'Screen 28','2D',140),
(29,29,'Screen 29','3D',160),
(30,30,'Screen 30','IMAX',180);

--------5. Insert seats — 30 records
INSERT INTO seats VALUES
(1,1,'A1','Regular',180,'Available'),
(2,2,'B1','Premium',250,'Available'),
(3,3,'C1','Recliner',400,'Reserved'),
(4,4,'D1','Regular',180,'Available'),
(5,5,'E1','Premium',250,'Available'),
(6,6,'A2','Recliner',400,'Reserved'),
(7,7,'B2','Regular',180,'Available'),
(8,8,'C2','Premium',250,'Available'),
(9,9,'D2','Recliner',400,'Reserved'),
(10,10,'E2','Regular',180,'Available'),
(11,11,'A3','Premium',250,'Available'),
(12,12,'B3','Recliner',400,'Reserved'),
(13,13,'C3','Regular',180,'Available'),
(14,14,'D3','Premium',250,'Available'),
(15,15,'E3','Recliner',400,'Reserved'),
(16,16,'A4','Regular',180,'Available'),
(17,17,'B4','Premium',250,'Available'),
(18,18,'C4','Recliner',400,'Reserved'),
(19,19,'D4','Regular',180,'Available'),
(20,20,'E4','Premium',250,'Available'),
(21,21,'A5','Recliner',400,'Reserved'),
(22,22,'B5','Regular',180,'Available'),
(23,23,'C5','Premium',250,'Available'),
(24,24,'D5','Recliner',400,'Reserved'),
(25,25,'E5','Regular',180,'Available'),
(26,26,'A6','Premium',250,'Available'),
(27,27,'B6','Recliner',400,'Reserved'),
(28,28,'C6','Regular',180,'Available'),
(29,29,'D6','Premium',250,'Available'),
(30,30,'E6','Recliner',400,'Reserved');

--------6. Insert showtimes — 30 records
INSERT INTO showtimes VALUES
(1,1,1,1,'2026-10-01','10:00:00','Tamil'),
(2,2,2,2,'2026-10-02','13:30:00','English'),
(3,3,3,3,'2026-10-03','17:00:00','Hindi'),
(4,4,4,4,'2026-10-04','20:30:00','Tamil'),
(5,5,5,5,'2026-10-05','10:00:00','English'),
(6,6,6,6,'2026-10-06','13:30:00','Hindi'),
(7,7,7,7,'2026-10-07','17:00:00','Tamil'),
(8,8,8,8,'2026-10-08','20:30:00','English'),
(9,9,9,9,'2026-10-09','10:00:00','Hindi'),
(10,10,10,10,'2026-10-10','13:30:00','Tamil'),
(11,11,11,11,'2026-10-11','17:00:00','English'),
(12,12,12,12,'2026-10-12','20:30:00','Hindi'),
(13,13,13,13,'2026-10-13','10:00:00','Tamil'),
(14,14,14,14,'2026-10-14','13:30:00','English'),
(15,15,15,15,'2026-10-15','17:00:00','Hindi'),
(16,16,16,16,'2026-10-16','20:30:00','Tamil'),
(17,17,17,17,'2026-10-17','10:00:00','English'),
(18,18,18,18,'2026-10-18','13:30:00','Hindi'),
(19,19,19,19,'2026-10-19','17:00:00','Tamil'),
(20,20,20,20,'2026-10-20','20:30:00','English'),
(21,21,21,21,'2026-10-21','10:00:00','Hindi'),
(22,22,22,22,'2026-10-22','13:30:00','Tamil'),
(23,23,23,23,'2026-10-23','17:00:00','English'),
(24,24,24,24,'2026-10-24','20:30:00','Hindi'),
(25,25,25,25,'2026-10-25','10:00:00','Tamil'),
(26,26,26,26,'2026-10-26','13:30:00','English'),
(27,27,27,27,'2026-10-27','17:00:00','Hindi'),
(28,28,28,28,'2026-10-28','20:30:00','Tamil'),
(29,29,29,29,'2026-11-01','10:00:00','English'),
(30,30,30,30,'2026-11-02','13:30:00','Hindi');

--------7. Insert bookings — 30 records
INSERT INTO bookings VALUES
(1,1,1,'2026-09-01 11:07:00',2,360,'Confirmed'),
(2,2,2,'2026-09-02 12:14:00',3,750,'Confirmed'),
(3,3,3,'2026-09-03 13:21:00',1,400,'Pending'),
(4,4,4,'2026-09-04 14:28:00',2,360,'Cancelled'),
(5,5,5,'2026-09-05 15:35:00',3,750,'Confirmed'),
(6,6,6,'2026-09-06 16:42:00',1,400,'Confirmed'),
(7,7,7,'2026-09-07 17:49:00',2,360,'Pending'),
(8,8,8,'2026-09-08 18:56:00',3,750,'Cancelled'),
(9,9,9,'2026-09-09 19:03:00',1,400,'Confirmed'),
(10,10,10,'2026-09-10 20:10:00',2,360,'Confirmed'),
(11,11,11,'2026-09-11 21:17:00',3,750,'Pending'),
(12,12,12,'2026-09-12 10:24:00',1,400,'Cancelled'),
(13,13,13,'2026-09-13 11:31:00',2,360,'Confirmed'),
(14,14,14,'2026-09-14 12:38:00',3,750,'Confirmed'),
(15,15,15,'2026-09-15 13:45:00',1,400,'Pending'),
(16,16,16,'2026-09-16 14:52:00',2,360,'Cancelled'),
(17,17,17,'2026-09-17 15:59:00',3,750,'Confirmed'),
(18,18,18,'2026-09-18 16:06:00',1,400,'Confirmed'),
(19,19,19,'2026-09-19 17:13:00',2,360,'Pending'),
(20,20,20,'2026-09-20 18:20:00',3,750,'Cancelled'),
(21,21,21,'2026-09-21 19:27:00',1,400,'Confirmed'),
(22,22,22,'2026-09-22 20:34:00',2,360,'Confirmed'),
(23,23,23,'2026-09-23 21:41:00',3,750,'Pending'),
(24,24,24,'2026-09-24 10:48:00',1,400,'Cancelled'),
(25,25,25,'2026-09-25 11:55:00',2,360,'Confirmed'),
(26,26,26,'2026-09-26 12:02:00',3,750,'Confirmed'),
(27,27,27,'2026-09-27 13:09:00',1,400,'Pending'),
(28,28,28,'2026-09-28 14:16:00',2,360,'Cancelled'),
(29,29,29,'2026-09-01 15:23:00',3,750,'Confirmed'),
(30,30,30,'2026-09-02 16:30:00',1,400,'Confirmed');

-------8. Insert booking seats — 30 records
INSERT INTO booking_seats VALUES
(1,1,1,180),(2,2,2,250),(3,3,3,400),
(4,4,4,180),(5,5,5,250),(6,6,6,400),
(7,7,7,180),(8,8,8,250),(9,9,9,400),
(10,10,10,180),(11,11,11,250),(12,12,12,400),
(13,13,13,180),(14,14,14,250),(15,15,15,400),
(16,16,16,180),(17,17,17,250),(18,18,18,400),
(19,19,19,180),(20,20,20,250),(21,21,21,400),
(22,22,22,180),(23,23,23,250),(24,24,24,400),
(25,25,25,180),(26,26,26,250),(27,27,27,400),
(28,28,28,180),(29,29,29,250),(30,30,30,400);

-------9. Insert payments — 30 records
INSERT INTO payments VALUES
(1,1,'2026-09-01 12:05:00','UPI',360,'Success','TXN2026000001'),
(2,2,'2026-09-02 13:10:00','Credit Card',750,'Success','TXN2026000002'),
(3,3,'2026-09-03 14:15:00','Debit Card',400,'Pending','TXN2026000003'),
(4,4,'2026-09-04 15:20:00','Net Banking',360,'Failed','TXN2026000004'),
(5,5,'2026-09-05 16:25:00','Cash',750,'Success','TXN2026000005'),
(6,6,'2026-09-06 17:30:00','UPI',400,'Success','TXN2026000006'),
(7,7,'2026-09-07 18:35:00','Credit Card',360,'Pending','TXN2026000007'),
(8,8,'2026-09-08 19:40:00','Debit Card',750,'Failed','TXN2026000008'),
(9,9,'2026-09-09 20:45:00','Net Banking',400,'Success','TXN2026000009'),
(10,10,'2026-09-10 11:50:00','Cash',360,'Success','TXN2026000010'),
(11,11,'2026-09-11 12:55:00','UPI',750,'Pending','TXN2026000011'),
(12,12,'2026-09-12 13:00:00','Credit Card',400,'Failed','TXN2026000012'),
(13,13,'2026-09-13 14:05:00','Debit Card',360,'Success','TXN2026000013'),
(14,14,'2026-09-14 15:10:00','Net Banking',750,'Success','TXN2026000014'),
(15,15,'2026-09-15 16:15:00','Cash',400,'Pending','TXN2026000015'),
(16,16,'2026-09-16 17:20:00','UPI',360,'Failed','TXN2026000016'),
(17,17,'2026-09-17 18:25:00','Credit Card',750,'Success','TXN2026000017'),
(18,18,'2026-09-18 19:30:00','Debit Card',400,'Success','TXN2026000018'),
(19,19,'2026-09-19 20:35:00','Net Banking',360,'Pending','TXN2026000019'),
(20,20,'2026-09-20 11:40:00','Cash',750,'Failed','TXN2026000020'),
(21,21,'2026-09-21 12:45:00','UPI',400,'Success','TXN2026000021'),
(22,22,'2026-09-22 13:50:00','Credit Card',360,'Success','TXN2026000022'),
(23,23,'2026-09-23 14:55:00','Debit Card',750,'Pending','TXN2026000023'),
(24,24,'2026-09-24 15:00:00','Net Banking',400,'Failed','TXN2026000024'),
(25,25,'2026-09-25 16:05:00','Cash',360,'Success','TXN2026000025'),
(26,26,'2026-09-26 17:10:00','UPI',750,'Success','TXN2026000026'),
(27,27,'2026-09-27 18:15:00','Credit Card',400,'Pending','TXN2026000027'),
(28,28,'2026-09-28 19:20:00','Debit Card',360,'Failed','TXN2026000028'),
(29,29,'2026-09-01 20:25:00','Net Banking',750,'Success','TXN2026000029'),
(30,30,'2026-09-02 11:30:00','Cash',400,'Success','TXN2026000030');

------10. Insert reviews — 30 records
INSERT INTO reviews VALUES
(1,1,1,'2026-09-01',8.0,'Great movie and sound!'),
(2,2,2,'2026-09-02',7.5,'Story was engaging.'),
(3,3,3,'2026-09-03',9.0,'Good family entertainer.'),
(4,4,4,'2026-09-04',6.5,'Excellent performances.'),
(5,5,5,'2026-09-05',8.5,'Worth watching once.'),
(6,6,6,'2026-09-06',8.0,'The music was wonderful.'),
(7,7,7,'2026-09-07',7.5,'A little slow in places.'),
(8,8,8,'2026-09-08',9.0,'Fantastic visuals.'),
(9,9,9,'2026-09-09',6.5,'Nice screenplay.'),
(10,10,10,'2026-09-10',8.5,'Would recommend it.'),
(11,11,11,'2026-09-11',8.0,'Great movie and sound!'),
(12,12,12,'2026-09-12',7.5,'Story was engaging.'),
(13,13,13,'2026-09-13',9.0,'Good family entertainer.'),
(14,14,14,'2026-09-14',6.5,'Excellent performances.'),
(15,15,15,'2026-09-15',8.5,'Worth watching once.'),
(16,16,16,'2026-09-16',8.0,'The music was wonderful.'),
(17,17,17,'2026-09-17',7.5,'A little slow in places.'),
(18,18,18,'2026-09-18',9.0,'Fantastic visuals.'),
(19,19,19,'2026-09-19',6.5,'Nice screenplay.'),
(20,20,20,'2026-09-20',8.5,'Would recommend it.'),
(21,21,21,'2026-09-21',8.0,'Great movie and sound!'),
(22,22,22,'2026-09-22',7.5,'Story was engaging.'),
(23,23,23,'2026-09-23',9.0,'Good family entertainer.'),
(24,24,24,'2026-09-24',6.5,'Excellent performances.'),
(25,25,25,'2026-09-25',8.5,'Worth watching once.'),
(26,26,26,'2026-09-26',8.0,'The music was wonderful.'),
(27,27,27,'2026-09-27',7.5,'A little slow in places.'),
(28,28,28,'2026-09-28',9.0,'Fantastic visuals.'),
(29,29,29,'2026-09-01',6.5,'Nice screenplay.'),
(30,30,30,'2026-09-02',8.5,'Would recommend it.');

SELECT *FROM movies;
SELECT *FROM theaters;
SELECT *FROM customers;
SELECT *FROM screens;
SELECT *FROM seats;
SELECT *FROM showtimes;
SELECT *FROM bookings;
SELECT *FROM booking_seats;
SELECT *FROM payments;
SELECT *FROM reviews;


---------1.Question: Create a table to store movie offers using a primary key, NOT NULL, UNIQUE, CHECK, and DEFAULT constraints.
CREATE TABLE movie_offers (
    offer_id INT PRIMARY KEY,
    offer_name VARCHAR(100) NOT NULL,
    discount_percent DECIMAL(5,2)
        CHECK (discount_percent BETWEEN 0 AND 100),
    offer_code VARCHAR(30) UNIQUE,
    offer_status VARCHAR(20) DEFAULT 'Active'
);

--------2.Question: Insert an offer, update its discount, and delete it.
INSERT INTO movie_offers
VALUES (1, 'Weekend Offer', 10, 'WEEKEND10', 'Active');

UPDATE movie_offers
SET discount_percent = 15
WHERE offer_id = 1;

SELECT * FROM movie_offers;

DELETE FROM movie_offers
WHERE offer_id = 1;

-------3.Question: Display unique movie genres and list movies rated 8 or above in descending rating order.
SELECT DISTINCT genre
FROM movies;

SELECT title, genre, rating
FROM movies
WHERE rating >= 8
ORDER BY rating DESC;

-------4.Question: Display the five highest-rated movies, skipping the first five movies in the sorted list.
SELECT title, rating
FROM movies
ORDER BY rating DESC, movie_id
LIMIT 5 OFFSET 5;

-------5.Question: Find the total movies, average rating, highest rating, lowest rating, total duration and number of different genres.
SELECT
    COUNT(*) AS total_movies,
    AVG(rating) AS average_rating,
    MAX(rating) AS highest_rating,
    MIN(rating) AS lowest_rating,
    SUM(duration_minutes) AS total_duration,
    COUNT(DISTINCT genre) AS different_genres
FROM movies;

--------6.Question: Display each movie genre with its movie count and average rating, showing only genres with at least two movies.
SELECT
    genre,
    COUNT(*) AS total_movies,
    AVG(rating) AS average_rating
FROM movies
GROUP BY genre
HAVING COUNT(*) >= 2;

--------7.Question: Display booking ID, customer name, movie title, booking status and payment status.
SELECT
    b.booking_id,
    c.customer_name,
    m.title AS movie_title,
    b.booking_status,
    p.payment_status
FROM bookings b
INNER JOIN customers c
    ON b.customer_id = c.customer_id
INNER JOIN showtimes st
    ON b.showtime_id = st.showtime_id
INNER JOIN movies m
    ON st.movie_id = m.movie_id
LEFT JOIN payments p
    ON b.booking_id = p.booking_id;
    
--------8.Question: Display movie names, theater names, screen names, show dates, showtimes and seat numbers.
SELECT
    m.title,
    t.theater_name,
    sc.screen_name,
    st.show_date,
    st.show_time,
    s.seat_number
FROM showtimes st
JOIN movies m
    ON st.movie_id = m.movie_id
JOIN theaters t
    ON st.theater_id = t.theater_id
JOIN screens sc
    ON st.screen_id = sc.screen_id
JOIN seats s
    ON sc.screen_id = s.screen_id;
    
-------9.Question: Find movies whose ratings are higher than the average rating of all movies.
SELECT title, rating
FROM movies
WHERE rating > (
    SELECT AVG(rating)
    FROM movies
)
ORDER BY rating DESC;

-------10.Question: Find the highest-rated movie or movies in each genre.
SELECT title, genre, rating
FROM movies m
WHERE rating = (
    SELECT MAX(m2.rating)
    FROM movies m2
    WHERE m2.genre = m.genre
);

--------11.Question: Combine the city names from customers and theaters, first without duplicates and then with duplicates.
------ UNION removes duplicates
SELECT city FROM customers
UNION
SELECT city FROM theaters;

------ UNION ALL preserves duplicates
SELECT city FROM customers
UNION ALL
SELECT city FROM theaters;

-------12.Question: Categorize movies according to their ratings.
SELECT
    title,
    rating,
    CASE
        WHEN rating >= 8.0 THEN 'Excellent'
        WHEN rating >= 7.0 THEN 'Good'
        ELSE 'Average'
    END AS movie_category
FROM movies;

--------13.Question: Calculate the total successful payment amount for each payment method using a CTE.
WITH payment_summary AS (
    SELECT payment_method, amount
    FROM payments
    WHERE payment_status = 'Success'
)
SELECT
    payment_method,
    COUNT(*) AS total_payments,
    SUM(amount) AS total_amount
FROM payment_summary
GROUP BY payment_method;

------14.Question: Create a view that displays booking information with customer names, movie names and payment statuses.
CREATE VIEW booking_details AS
SELECT
    b.booking_id,
    c.customer_name,
    m.title AS movie_title,
    b.total_amount,
    b.booking_status,
    p.payment_status
FROM bookings b
JOIN customers c
    ON b.customer_id = c.customer_id
JOIN showtimes st
    ON b.showtime_id = st.showtime_id
JOIN movies m
    ON st.movie_id = m.movie_id
LEFT JOIN payments p
    ON b.booking_id = p.booking_id;
    
-------15.Question: Create an index to help queries that filter bookings by status.
CREATE INDEX idx_booking_status
ON bookings(booking_status);

-------16.Question: Create a trigger that prevents a booking from being inserted with zero or a negative number of tickets.
DELIMITER //

CREATE TRIGGER check_ticket_quantity
BEFORE INSERT ON bookings
FOR EACH ROW
BEGIN
    IF NEW.number_of_tickets <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Ticket quantity must be greater than zero';
    END IF;
END //

DELIMITER ;

-------17.Question: Create a stored procedure that displays bookings for a given status.
DELIMITER //

CREATE PROCEDURE GetBookingsByStatus(
    IN p_status VARCHAR(20)
)
BEGIN
    SELECT
        booking_id,
        customer_id,
        showtime_id,
        total_amount,
        booking_status
    FROM bookings
    WHERE booking_status = p_status;
END //

DELIMITER ;

-------18.Question: Create a function that returns the total number of bookings for a particular customer.
DELIMITER //

CREATE FUNCTION CustomerBookingCount(
    p_customer_id INT
)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total_bookings INT;

    SELECT COUNT(*)
    INTO total_bookings
    FROM bookings
    WHERE customer_id = p_customer_id;

    RETURN total_bookings;
END //

DELIMITER ;

--------19.Question: Update a booking inside a transaction and undo the change.
START TRANSACTION;

UPDATE bookings
SET booking_status = 'Cancelled'
WHERE booking_id = 1;

SELECT *
FROM bookings
WHERE booking_id = 1;

ROLLBACK;

SELECT *
FROM bookings
WHERE booking_id = 1;

-------20.Question: Practise changing, emptying and removing a table.
-- Add a column
ALTER TABLE movies
ADD COLUMN language VARCHAR(30);

-- Remove the column if you no longer need it
ALTER TABLE movies
DROP COLUMN language;

-------21.Question: Give a database user permission to read movie information, then revoke that permission.
CREATE USER 'booking_reader'@'localhost'
IDENTIFIED BY 'PracticeOnly_123!';
GRANT SELECT
ON movie_ticket_booking.movies
TO 'booking_reader'@'localhost';
REVOKE SELECT
ON movie_ticket_booking.movies
FROM 'booking_reader'@'localhost';

------22.Question: Change the status of a pending booking, then delete a specific review.
UPDATE bookings
SET booking_status = 'Confirmed'
WHERE booking_id = 3
  AND booking_status = 'Pending';

SELECT *
FROM bookings
WHERE booking_id = 3;
DELETE FROM reviews
WHERE review_id = 30;

SELECT *
FROM reviews
WHERE review_id = 30;

------23.Question: Rank movies by rating and assign each movie a unique row number.
SELECT
    title,
    genre,
    rating,
    RANK() OVER (
        ORDER BY rating DESC
    ) AS movie_rank,
    ROW_NUMBER() OVER (
        ORDER BY rating DESC, movie_id
    ) AS row_number
FROM movies;

------24.Question: Display customers who have made at least one booking.
SELECT
    c.customer_id,
    c.customer_name,
    c.email
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.customer_id = c.customer_id
);

------25.Question: Display table definitions and verify primary keys, foreign keys, unique constraints and indexes.
-- DQL: Read data
SELECT * FROM movies;

-- DDL: Inspect table structure
SHOW CREATE TABLE bookings;

-- Inspect foreign-key relationships
SHOW CREATE TABLE booking_seats;

-- Inspect indexes and unique constraints
SHOW INDEX FROM customers;

-- Inspect available tables
SHOW TABLES;




 