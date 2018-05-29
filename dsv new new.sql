drop database if exists dsv;
create database dsv;
use dsv;

create table Travel_Agencies(
travel_agency_id int(20) primary key,
travel_agency_details text  
);

create table Customers(
customer_id int(20),
customer_name varchar(30), -- improvement
-- customer_address_id int,
-- customer_contact_id int,
primary key (customer_id)
-- foreign key (customer_address_id) references Customers_Addresses(customer_address_id),
-- foreign key (customer_contact_id) references Customers_Contact(customer_contact_id)
);

create table Customers_Addresses(
address_id int(20),
customer_houseno int,
customer_street varchar(30),
customer_city varchar(30),
customer_zipcode int,
customer_country varchar(30),
customer_id int,
foreign key  (customer_id) references Customers(customer_id));

/* create table Customers_Addresses(
customer_address_id int,
customer_id int,
address_id int,
date_from date,
date_to date,
primary key (customer_address_id),
foreign key (customer_id) references Customers(customer_id),
foreign key (address_id) references Addresses(address_id));
*/

create table Contacts(
contact_id int(20) primary key,
customer_id int(20),
customer_contactnumber varchar(30),
customer_contactnumber2 varchar(30),
customer_officenumber varchar(30),
foreign key (customer_id) references Customers(customer_id)
);

create table Customers_Contact (
customer_contact_id int(20),
contact_id int(20),
customer_id int(20),
-- Imp date_from date,
-- Imp date_to date,
primary key (customer_contact_id),
foreign key (customer_id) references Customers(customer_id),
foreign key (contact_id) references Contacts(contact_id));

create table Ref_Booking_Outcomes (
outcome_code int(20) primary key,
outcome_description text);

create table Ref_Booking_Status (
status_code int(20) primary key,
status_description text);

create table Bookings(
booking_id int(20) primary key,
customer_id int(20),
outcome_code int(20),
status_code int(50),
travel_agency_id int(20),
date_of_booking date,
booking_details text,

foreign key (customer_id) references Customers(customer_id),
foreign key (outcome_code) references Ref_Booking_Outcomes(outcome_code),
foreign key (status_code) references Ref_Booking_Status(status_code),
foreign key (travel_agency_id) references Travel_Agencies(travel_agency_id)
);

create table Services(
service_id int(20) unique primary key,
service_details text
);

create table Service_Bookings(
booking_id int(20),
service_id int(20),
booking_start_date date,
booking_end_date date,
other_details text,
foreign key (booking_id) references Bookings(booking_id),
foreign key (service_id) references Services(service_id)
);

create table Airlines(
airline_id int(20),
airline_details text,
constraint airline_id foreign key (airline_id) references Services(service_id)
);

create table Cars(
car_id int(20),
car_details text,
constraint car_id foreign key (car_id) references Services(service_id)
);

create table Hotels(
hotel_id int(20),
hotel_details text,
constraint hotel_id foreign key (hotel_id) references Services(service_id)
);

create table Restaurants(
restaurant_id int(20),
restaurant_details text,
constraint restaurant_id foreign key (restaurant_id) references Services(service_id)
);


create table Payments(
payment_id int(20) primary key,
booking_id int(20),
payment_amount int(50),
payment_date date,
other_details text,

foreign key (booking_id) references Bookings(booking_id)
);

create table Staff_Information(
staff_id int(20) primary key,
staff_first_name varchar(30),
staff_last_name varchar(30),
staff_contact_number int(30),
staff_position varchar(30),
staff_address_details varchar(30),
staff_salary int(30));

create table Sales_Period(
sales_period_id int primary key,
sales_period_start_date date,
sales_period_end_date date); 

create table Sales_Staff(
discount_rate int(20),
customer_id int(20),
staff_id int(20),
payment_id int(20),
booking_id int(20),
sales_period_id int(20),

foreign key (staff_id) references Staff_Information (staff_id),
foreign key (payment_id) references Payments (payment_id),
foreign key (booking_id) references Bookings (booking_id),
foreign key (sales_period_id) references Sales_Period (sales_period_id));

 -- sales period remove because it moved to sales (sales_start_date & sales_end_date).
/*create table Sales_Period(
sales_period_id int primary key,
sales_period_start_date date,
sales_period_end_date date,
discount_rate int,
payment_id int,
foreign key (payment_id) references Payments(payment_id)); 

-- 
create table Expenses(
-- expenses_id int primary key,
staff_salary int,
house_expenses int,
car_expenses int,
airline_expenses int,
hotel_expenses int,
maintenance int,
Years year,
foreign key (staff_salary) references Staff_salary(staff_salary)); 
*/
/*select Years, (payment_amount - (staff_salary + house_expenses+ car_expenses + airline_expenses+ hotel_expenses+ maintenance))
as Projections
from Payments, Expenses;
*/
-- select  payment_id - TotalExpenses 
-- as Projections
--  from Payments, Expenses;
/*create table Loss (
discount_rate int(20),
payment_amount int(20),
payment_date date,
outcome_code int(20),
status_code int(20),
foreign key (outcome_code) references Bookings (outcome_code),
foreign key (status_code) references Bookings (status_code),
foreign key (discount_rate) references Staff_Sales (discount_rate),
foreign key (payment_amount) references Payments (payment_amount),
foreign key (payment_date) references Payments (payment_date));*/

/*create table Profit (
payment_amount int(50),
payment_date date,
outcome_code int(20),
status_code int(20),
foreign key (outcome_code) references Bookings (outcome_code),
foreign key (status_code) references Bookings (status_code),
foreign key (payment_amount) references Payments (payment_amount),
foreign key (payment_date) references Payments (payment_date));*/

/*insert into Services 
values
(901, 'Airline1'),
(902, 'Airline2'),
(903, 'Airline3'),
(904, 'Airline4'),
(905, 'Airline5'),
(906, 'Airline6'),
(907, 'Airline7'),
(908, 'Airline8'),
(909, 'Airline9'),
(910, 'Airline10'),
(911, 'Airline11'),
(912, 'Airline12'),
(913, 'Airline13'),
(914, 'Airline14'),
(915, 'Airline15'),
(916, 'Airline16'),
(917, 'Airline17'),
(918, 'Airline18'),
(919, 'Airline19'),
(920, 'Airline20');


insert into Airlines 
values 
(901, 'Airlines1'),
(902, 'Airlines2'),
(903, 'Airlines3'),
(904, 'Airlines4'),
(905, 'Airlines5'),
(906, 'Airlines6'),
(907, 'Airlines7'),
(908, 'Airlines8'),
(909, 'Airlines9'),
(910, 'Airlines10'),
(911, 'Airlines11'),
(912, 'Airlines12'),
(913, 'Airlines13'),
(914, 'Airlines14'),
(915, 'Airlines15'),
(916, 'Airlines16'),
(917, 'Airlines17'),
(918, 'Airlines18'),
(919, 'Airlines19'),
(920, 'Airlines20');

insert into Travel_agencies
values
(701, 'TravelAgency1'),
(702, 'TravelAgency2'),
(703, 'TravelAgency3'),
(704, 'TravelAgency4'),
(705, 'TravelAgency5'),
(706, 'TravelAgency6'),
(707, 'TravelAgency7'),
(708, 'TravelAgency8'),
(709, 'TravelAgency9'),
(710, 'TravelAgency10'),
(711, 'TravelAgency11'),
(712, 'TravelAgency12'),
(713, 'TravelAgency13'),
(714, 'TravelAgency14'),
(715, 'TravelAgency15'),
(716, 'TravelAgency16'),
(717, 'TravelAgency17'),
(718, 'TravelAgency18'),
(719, 'TravelAgency19'),
(720, 'TravelAgency20');


insert into Customers
values
(601, 'Zara Basyani'),
(602, 'Natalie \'The nut\' Leong'),
(603, 'Jim'),
(604, 'Tim'),
(605, 'Lim'),
(606, 'Dan'),
(607, 'Jake'),
(608, 'Joe'),
(609, 'Moe'),
(610, 'Will'),
(611, 'Ron'),
(612, 'Bill'),
(613, 'Jason'),
(614, 'Marie'),
(615, 'Anne'),
(616, 'Jude'),
(617, 'Eric'),
(618, 'Ralph'),
(619, 'Leo'),
(620, 'Bennedict');

insert into Customers_Addresses
values
(501, 20, 'Jalan Sampan', 'Selangor', 5340, 'Malaysia', 601),
(502, 15, 'Jalan Impan', 'Selangor', 2340, 'Malaysia', 602),
(503, 11, 'Jalan Upin', 'Selangor', 5340, 'Malaysia', 603),
(504, 22, 'Jalan Impin', 'Selangor', 5340, 'Malaysia', 604),
(505, 16, 'Jalan Ipin', 'Selangor', 5240, 'Malaysia', 605),
(506, 19, 'Jalan Sampan', 'Selangor', 5340, 'Malaysia', 606),
(507, 21, 'Jalan Ipin', 'Selangor', 5240, 'Malaysia', 607),
(508, 23, 'Jalan Upin', 'Selangor', 5340, 'Malaysia', 608),
(509, 15, 'Jalan Sampan', 'Selangor', 5240, 'Malaysia', 609),
(510, 12, 'Jalan Impan', 'Selangor', 5340, 'Malaysia', 610),
(511, 27, 'Jalan Laman', 'Selangor', 5340, 'Malaysia', 611),
(512, 20, 'Jalan Sampan', 'Selangor', 5340, 'Malaysia', 612),
(513, 17, 'Jalan Ipin', 'Selangor', 5340, 'Malaysia', 613),
(514, 14, 'Jalan Sampan', 'Selangor', 5240, 'Malaysia', 614),
(515, 24, 'Jalan Limpin', 'Selangor', 5340, 'Malaysia', 615),
(516, 12, 'Jalan Laman', 'Selangor', 5340, 'Malaysia', 616),
(517, 30, 'Jalan Sampan', 'Selangor', 5240, 'Malaysia', 617),
(518, 21, 'Jalan Sampan', 'Selangor', 5340, 'Malaysia', 618),
(519, 29, 'Jalan Impin', 'Selangor', 5240, 'Malaysia', 619),
(520, 18, 'Jalan Upin', 'Selangor', 5240, 'Malaysia', 620);


insert into Contacts
value
(401, 601, '012-231231', null, '03-3023425'),
(402, 602, '016-432423', '016-43275648', '03-4612893'),
(403, 603, '013-231412', null, '03-4259783'),
(404, 604, '011-432435', null, '03-4623783'),
(405, 605, '010-432422', null, '03-6147238'),
(406, 606, '017-432434', '016-745323', '03-1452978'),
(407, 607, '012-752133', null, '03-5123431'),
(408, 608, '019-643624', null, '03-5231603'),
(409, 609, '017-675795', null, '03-4132523'),
(410, 610, '012-523515', null, '03-5263198'),
(411, 611, '014-427392', null, '03-4139782'),
(412, 612, '015-403627', '016-745376', '03-5441982'),
(413, 613, '016-648921', null, '03-8953423'),
(414, 614, '017-526891', null, '03-8932641'),
(415, 615, '014-562983', null, '03-3023425'),
(416, 616, '013-641928', '016-756865', '03-7849233'),
(417, 617, '014-537192', null, '03-6423832'),
(418, 618, '016-469132', null, '03-4252563'),
(419, 619, '016-523653', '016-466467', '03-5323332'),
(420, 620, '014-412613', null, '03-4231352');


insert into Customers_Contact
value
(301,401,601),
(302,402,602),
(303,403,603),
(304,404,604),
(305,405,605),
(306,406,606),
(307,407,607),
(308,408,608),
(309,409,609),
(310,410,610),
(311,411,611),
(312,412,612),
(313,413,613),
(314,414,614),
(315,415,615),
(316,416,616),
(317,417,617),
(318,418,618),
(319,419,619),
(320,420,620);

insert into Ref_Booking_Outcomes
value
(201, 'Paid'),
(202, 'Pending');

insert into Ref_Booking_Status
value
(101, 'Approved'),
(102, 'Cancelled');

insert into Bookings
value
(1001, 601, 201, 101, 701, '2018/3/4', 'awesome!'),
(1002, 602, 202, 102, 702, '2018/3/4', 'awesome!'),
(1003, 603, 201, 101, 703, '2018/3/4', 'awesome!'),
(1004, 604, 202, 102, 704, '2018/3/4', 'awesome!'),
(1005, 605, 201, 101, 705, '2018/3/4', 'awesome!'),
(1006, 606, 202, 102, 706, '2018/3/4', 'awesome!'),
(1007, 607, 201, 101, 707, '2018/3/4', 'awesome!'),
(1008, 608, 202, 102, 708, '2018/3/4', 'awesome!'),
(1009, 609, 201, 101, 709, '2018/3/4', 'awesome!'),
(1010, 610, 202, 102, 710, '2018/3/4', 'awesome!'),
(1011, 611, 201, 101, 711, '2018/3/4', 'awesome!'),
(1012, 612, 202, 102, 712, '2018/3/4', 'awesome!'),
(1013, 613, 201, 101, 713, '2018/3/4', 'awesome!'),
(1014, 614, 202, 102, 714, '2018/3/4', 'awesome!'),
(1015, 615, 201, 101, 715, '2018/3/4', 'awesome!'),
(1016, 616, 202, 102, 716, '2018/3/4', 'awesome!'),
(1017, 617, 201, 101, 717, '2018/3/4', 'awesome!'),
(1018, 618, 202, 102, 718, '2018/3/4', 'awesome!'),
(1019, 619, 201, 101, 719, '2018/3/4', 'awesome!'),
(1020, 620, 202, 102, 720, '2018/3/4', 'awesome!');

insert into Service_Bookings
value
(2001, 901, '2018/3/4', '2018/3/8', 'Awesome!'),
(2002, 902, '2018/3/4', '2018/3/8', null),
(2003, 903, '2018/3/4', '2018/3/8', null),
(2004, 904, '2018/3/4', '2018/3/8', null),
(2005, 905, '2018/3/4', '2018/3/8', null),
(2006, 906, '2018/3/4', '2018/3/8', null),
(2007, 907, '2018/3/4', '2018/3/8', null),
(2008, 908, '2018/3/4', '2018/3/8', null),
(2009, 909, '2018/3/4', '2018/3/8', null),
(2010, 910, '2018/3/4', '2018/3/8', null),
(2011, 911, '2018/3/4', '2018/3/8', null),
(2012, 912, '2018/3/4', '2018/3/8', null),
(2013, 913, '2018/3/4', '2018/3/8', null),
(2014, 914, '2018/3/4', '2018/3/8', null),
(2015, 915, '2018/3/4', '2018/3/8', null),
(2016, 916, '2018/3/4', '2018/3/8', null),
(2017, 917, '2018/3/4', '2018/3/8', null),
(2018, 918, '2018/3/4', '2018/3/8', null),
(2019, 919, '2018/3/4', '2018/3/8', null),
(2020, 920, '2018/3/4', '2018/3/8', null);

insert into Airlines
value
(3001, 'Deets!'),
(3002, 'Deets!'),
(3003, 'Deets!'),
(3004, 'Deets!'),
(3005, 'Deets!'),
(3006, 'Deets!'),
(3007, 'Deets!'),
(3008, 'Deets!'),
(3009, 'Deets!'),
(3010, 'Deets!'),
(3011, 'Deets!'),
(3012, 'Deets!'),
(3013, 'Deets!'),
(3014, 'Deets!'),
(3015, 'Deets!'),
(3016, 'Deets!'),
(3017, 'Deets!'),
(3018, 'Deets!'),
(3019, 'Deets!'),
(3020, 'Deets!');


insert into Cars
value
(4001, 'Honda'),
(4002, 'Honda'),
(4003, 'Honda'),
(4004, 'Honda'),
(4005, 'Honda'),
(4006, 'Honda'),
(4007, 'Honda'),
(4008, 'Honda'),
(4009, 'Honda'),
(4010, 'Toyota'),
(4011, 'Toyota'),
(4012, 'Toyota'),
(4013, 'Toyota'),
(4014, 'Toyota'),
(4015, 'Toyota'),
(4016, 'Toyota'),
(4017, 'Toyota'),
(4018, 'Toyota'),
(4019, 'Toyota'),
(4020, 'Toyota');



insert into Hotels
value
(5001, 'Hyatt'),
(5002, 'Hyatt'),
(5003, 'Hyatt'),
(5004, 'Hyatt'),
(5005, 'Hyatt'),
(5006, 'Hyatt'),
(5007, 'Hyatt'),
(5008, 'Hyatt'),
(5009, 'Hyatt'),
(5010, 'Hyatt'),
(5011, 'Hilton'),
(5012, 'Hilton'),
(5013, 'Hilton'),
(5014, 'Hilton'),
(5015, 'Hilton'),
(5016, 'Hilton'),
(5017, 'Hilton'),
(5018, 'Hilton'),
(5019, 'Hilton'),
(5020, 'Hilton');

insert into Restaurants
value
(6001, 'McD'),
(6002, 'McD'),
(6003, 'McD'),
(6004, 'McD'),
(6005, 'McD'),
(6006, 'McD'),
(6007, 'McD'),
(6008, 'McD'),
(6009, 'McD'),
(6010, 'McD'),
(6011, 'KFC'),
(6012, 'KFC'),
(6013, 'KFC'),
(6014, 'KFC'),
(6015, 'KFC'),
(6016, 'KFC'),
(6017, 'KFC'),
(6018, 'KFC'),
(6019, 'KFC'),
(6020, 'KFC');


insert into Payments
value
(7001, 1001, 5001, '2018/2/4', 'lorem ipsum'),
(7002, 1002, 5002, '2018/2/4', 'lorem ipsum'),
(7003, 1003, 5003, '2018/2/4', 'lorem ipsum'),
(7004, 1004, 5004, '2018/2/4', 'lorem ipsum'),
(7005, 1005, 5005, '2018/2/4', 'lorem ipsum'),
(7006, 1006, 5006, '2018/2/4', 'lorem ipsum'),
(7007, 1007, 5007, '2018/2/4', 'lorem ipsum'),
(7008, 1008, 5008, '2018/2/4', 'lorem ipsum'),
(7009, 1009, 5009, '2018/2/4', 'lorem ipsum'),
(7010, 1010, 5010, '2018/2/4', 'lorem ipsum'),
(7011, 1011, 5011, '2018/2/4', 'lorem ipsum'),
(7012, 1012, 5012, '2018/2/4', 'lorem ipsum'),
(7013, 1013, 5013, '2018/2/4', 'lorem ipsum'),
(7014, 1014, 5014, '2018/2/4', 'lorem ipsum'),
(7015, 1015, 5015, '2018/2/4', 'lorem ipsum'),
(7016, 1016, 5016, '2018/2/4', 'lorem ipsum'),
(7017, 1017, 5017, '2018/2/4', 'lorem ipsum'),
(7018, 1018, 5018, '2018/2/4', 'lorem ipsum'),
(7019, 1019, 5019, '2018/2/4', 'lorem ipsum'),
(7020, 1020, 5020, '2018/2/4', 'lorem ipsum');

insert into Staff_Information
value
(8001, 'Elon', 'Musk', 012534643, 'clerk', '5th street', 2000),
(8002, 'Elon', 'Dusk', 012534643, 'clerk', '7th street', 2000),
(8003, 'Elon', 'Rusk', 012534643, 'clerk', '4th street', 2000),
(8004, 'Eton', 'Husk', 012534643, 'clerk', '5th street', 2000),
(8005, 'Eron', 'Tusk', 012534643, 'clerk', '8th street', 2000),
(8006, 'Elon', 'Wusk', 012534643, 'clerk', '9th street', 2000),
(8007, 'Emon', 'Busk', 012534643, 'clerk', '3rd street', 2000),
(8008, 'Elon', 'Nusk', 012534643, 'clerk', '5th street', 2000),
(8009, 'Elon', 'Lusk', 012534643, 'clerk', '3rd street', 2000),
(8010, 'Elon', 'Dusk', 012534643, 'manager', '5th street', 5000),
(8011, 'Elon', 'Wusk', 012534643, 'manager', '9th street', 5000),
(8012, 'Exon', 'Wusk', 012534643, 'manager', '4th street', 6000),
(8013, 'Eson', 'Husk', 012534643, 'manager', '5th street', 5000),
(8014, 'Edon', 'Dusk', 012534643, 'manager', '7th street', 6000),
(8015, 'Egon', 'musk', 012534643, 'manager', '8th street', 7000),
(8016, 'Efon', 'Dusk', 012534643, 'manager', '6th street', 5000),
(8017, 'Ekon', 'Dusk', 012534643, 'clerk', '6th street', 2000),
(8018, 'Eyon', 'Wusk', 012534643, 'clerk', '4th street', 2000),
(8019, 'Ewon', 'Husk', 012534643, 'clerk', '9th street', 2000),
(8020, 'Efon', 'Wusk', 012534643, 'clerk', '8th street', 2000);


insert into Sales_Staff
value
('2018/2/4','2018/3/8', 10, 601,8001,7001,1001),
('2018/2/4','2018/3/8', 10, 602,8002,7002,1002),
('2018/2/4','2018/3/8', 10, 603,8003,7003,1003),
('2018/2/4','2018/3/8', 10, 604,8004,7004,1004),
('2018/2/4','2018/3/8', 15, 605,8005,7005,1005),
('2018/2/4','2018/3/8', 15, 606,8006,7006,1006),
('2018/2/4','2018/3/8', 15, 607,8007,7007,1007),
('2018/2/4','2018/3/8', 15, 608,8008,7008,1008),
('2018/2/4','2018/3/8', 10, 609,8009,7009,1009),
('2018/2/4','2018/3/8', 10, 610,8010,7010,1010),
('2018/2/4','2018/3/8', 15, 611,8011,7011,1011),
('2018/2/4','2018/3/8', 15, 612,8012,7012,1012),
('2018/2/4','2018/3/8', 10, 613,8013,7013,1013),
('2018/2/4','2018/3/8', 10, 614,8014,7014,1014),
('2018/2/4','2018/3/8', 10, 615,8015,7015,1015),
('2018/2/4','2018/3/8', 15, 616,8016,7016,1016),
('2018/2/4','2018/3/8', 15, 617,8017,7017,1017),
('2018/2/4','2018/3/8', 15, 618,8018,7018,1018),
('2018/2/4','2018/3/8', 15, 619,8019,7019,1019),
('2018/2/4','2018/3/8', 10, 620,8020,7020,1020);

insert into Loss
value
(10, 5001, '2018/2/4', 202, 102),
(10, 5002, '2018/2/4', 202, 102),
(10, 5003, '2018/2/4', 202, 102),
(10, 5004, '2018/2/4', 202, 102),
(10, 5005, '2018/2/4', 202, 102),
(10, 5006, '2018/2/4', 202, 102),
(10, 5007, '2018/2/4', 202, 102),
(10, 5008, '2018/2/4', 202, 102),
(10, 5009, '2018/2/4', 202, 102),
(10, 5010, '2018/2/4', 202, 102),
(10, 5011, '2018/2/4', 202, 102),
(10, 5012, '2018/2/4', 202, 102),
(10, 5013, '2018/2/4', 202, 102),
(10, 5014, '2018/2/4', 202, 102),
(10, 5015, '2018/2/4', 202, 102),
(10, 5016, '2018/2/4', 202, 102),
(10, 5017, '2018/2/4', 202, 102),
(10, 5018, '2018/2/4', 202, 102),
(10, 5019, '2018/2/4', 202, 102),
(10, 5020, '2018/2/4', 202, 102);

insert into Profit
value
(300, '2018/2/4',  201, 101),
(301, '2018/2/4',  201, 101),
(302, '2018/2/4',  201, 101),
(303, '2018/2/4',  201, 101),
(304, '2018/2/4',  201, 101),
(305, '2018/2/4',  201, 101),
(306, '2018/2/4',  201, 101),
(307, '2018/2/4',  201, 101),
(308, '2018/2/4',  201, 101),
(309, '2018/2/4',  201, 101),
(310, '2018/2/4',  201, 101),
(311, '2018/2/4',  201, 101),
(312, '2018/2/4',  201, 101),
(313, '2018/2/4',  201, 101),
(314, '2018/2/4',  201, 101),
(315, '2018/2/4',  201, 101),
(316, '2018/2/4',  201, 101),
(317, '2018/2/4',  201, 101),
(318, '2018/2/4',  201, 101),
(319, '2018/2/4',  201, 101),
(320, '2018/2/4',  201, 101);*/

insert into Travel_Agencies 
values
(1000, 'travelAgency1'),
(1001, 'travelAgency2'),
(1002, 'travelAgency3'),
(1003, 'travelAgency4'),
(1004, 'travelAgency5'),
(1005, 'travelAgency6'),
(1006, 'travelAgency7'),
(1007, 'travelAgency8'),
(1008, 'travelAgency9'),
(1009, 'travelAgency10'),
(1010, 'travelAgency11'),
(1011, 'travelAgency12'),
(1012, 'travelAgency13'),
(1013, 'travelAgency14'),
(1014, 'travelAgency15'),
(1015, 'travelAgency16'),
(1016, 'travelAgency17'),
(1017, 'travelAgency18'),
(1018, 'travelAgency19'),
(1019, 'travelAgency20');

insert into Customers 
values
(2000, 'John Paul'),
(2001, 'Lee Tan Ming'),
(2002, 'Kee En Ming'),
(2003, 'Ali Baba'),
(2004, 'Jacob Wong'),
(2005, 'Nicole Leong'),
(2006, 'Zara Basyirah'),
(2007, 'Wee Ling Yin'),
(2008, 'Natalie Leong'),
(2009, 'Chai Ervin'),
(2010, 'Sia Ming Yang'),
(2011, 'Chew Jia Jer'),
(2012, 'Malia Lee'),
(2013, 'Sasha Obama'),
(2014, 'Malia Obama'),
(2015, 'Barack Obama'),
(2016, 'Denzel Washington'),
(2017, 'George Washington'),
(2018, 'Barbara Bush'),
(2019, 'George Bush')
;

insert into Customers_Addresses 
values
(3000, 1, 'street1', 'Kuala Lumpur', 43000, 'Malaysia', 2000),
(3001, 2, 'street2', 'Georgetown ', 43001, 'Malaysia', 2001),
(3002, 3, 'street3', 'Kuala Lumpur', 43002, 'Malaysia', 2002),
(3003, 4, 'street4', 'Sydney', 43032, 'Australia', 2003),
(3004, 5, 'street5', 'Shinjuku', 57000, 'Japan', 2004),
(3005, 1, 'street6', 'Harajuku', 67000, 'Japan', 2005),
(3006, 2, 'street7', 'Melbourne', 57100, 'Australia', 2006),
(3007, 3, 'street8', 'Perth', 43021, 'Australia', 2007),
(3008, 19, 'street9', 'New York', 56000, 'USA', 2008),
(3009, 12, 'street10', 'Las Vegas', 67100, 'USA', 2009),
(3010, 13, 'street11', 'Los Angeles', 32000, 'USA', 2010),
(3011, 14, 'street12', 'Johor Bahru', 67000, 'Malaysia', 2011),
(3012, 15, 'street13', 'Barcelona', 46200, 'Spain', 2012),
(3013, 20, 'street14', 'Madrid', 56700, 'Spain', 2013),
(3014, 21, 'street15', 'Stockholm', 23400, 'Sweden', 2014),
(3015, 25, 'street16', 'Shibuya', 45600, 'Japan', 2015),
(3016, 26, 'street17', 'Seoul', 67800, 'Korea', 2016),
(3017, 30, 'street18', 'Busan', 33400, 'Korean', 2017),
(3018, 31, 'street19', 'Paris', 44500, 'France', 2018),
(3019, 41, 'street20', 'London', 22200, 'UK', 2019);

insert into Contacts
values
(4000, 2000, '012-231231', null, '03-3023425'),
(4001, 2001, '016-432423', '016-43275648', '03-4612893'),
(4002, 2002, '013-231412', null, '03-4259783'),
(4003, 2003, '011-432435', null, '03-4623783'),
(4004, 2004, '010-432422', null, '03-6147238'),
(4005, 2005, '017-432434', '016-745323', '03-1452978'),
(4006, 2006, '012-752133', null, '03-5123431'),
(4007, 2007, '019-643624', null, '03-5231603'),
(4008, 2008, '017-675795', null, '03-4132523'),
(4009, 2009, '012-523515', null, '03-5263198'),
(4010, 2010, '014-427392', null, '03-4139782'),
(4011, 2011, '015-403627', '016-745376', '03-5441982'),
(4012, 2012, '016-648921', null, '03-8953423'),
(4013, 2013, '017-526891', null, '03-8932641'),
(4014, 2014, '014-562983', null, '03-3023425'),
(4015, 2015, '013-641928', '016-756865', '03-7849233'),
(4016, 2016, '014-537192', null, '03-6423832'),
(4017, 2017, '016-469132', null, '03-4252563'),
(4018, 2018, '016-523653', '016-466467', '03-5323332'),
(4019, 2019, '014-412613', null, '03-4231352');

insert into Customers_Contact
values
(5000,4000,2000),
(5001,4001,2001),
(5002,4002,2002),
(5003,4003,2003),
(5004,4004,2004),
(5005,4005,2005),
(5006,4006,2006),
(5007,4007,2007),
(5008,4008,2008),
(5009,4009,2009),
(5010,4010,2010),
(5011,4011,2011),
(5012,4012,2012),
(5013,4013,2013),
(5014,4014,2014),
(5015,4015,2015),
(5016,4016,2016),
(5017,4017,2017),
(5018,4018,2018),
(5019,4019,2019);

insert into Ref_Booking_Outcomes
values
(0, 'Cancelled'),
(1, 'Approved');

insert into Ref_Booking_Status
values
(10, 'Unpaid'),
(11, 'Paid');

insert into Services
values
(6000, 'airlines'),
(6001, 'airlines'),
(6002, 'airlines'),
(6003, 'airlines'),
(6004, 'airlines'),
(6005, 'airlines'),
(6006, 'airlines'),
(6007, 'airlines'),
(6008, 'airlines'),
(6009, 'airlines'),
(6010, 'airlines'),
(6011, 'airlines'),
(6012, 'airlines'),
(6013, 'airlines'),
(6014, 'airlines'),
(6015, 'airlines'),
(6016, 'airlines'),
(6017, 'airlines'),
(6018, 'airlines'),
(6019, 'airlines'),
(7000, 'cars'),
(7001, 'cars'),
(7002, 'cars'),
(7003, 'cars'),
(7004, 'cars'),
(7005, 'cars'),
(7006, 'cars'),
(7007, 'cars'),
(7008, 'cars'),
(7009, 'cars'),
(7010, 'cars'),
(7011, 'cars'),
(7012, 'cars'),
(7013, 'cars'),
(7014, 'cars'),
(7015, 'cars'),
(7016, 'cars'),
(7017, 'cars'),
(7018, 'cars'),
(7019, 'cars'),
(8000, 'hotels'),
(8001, 'hotels'),
(8002, 'hotels'),
(8003, 'hotels'),
(8004, 'hotels'),
(8005, 'hotels'),
(8006, 'hotels'),
(8007, 'hotels'),
(8008, 'hotels'),
(8009, 'hotels'),
(8010, 'hotels'),
(8011, 'hotels'),
(8012, 'hotels'),
(8013, 'hotels'),
(8014, 'hotels'),
(8015, 'hotels'),
(8016, 'hotels'),
(8017, 'hotels'),
(8018, 'hotels'),
(8019, 'hotels'),
(9000, 'restaurant'),
(9001, 'restaurant'),
(9002, 'restaurant'),
(9003, 'restaurant'),
(9004, 'restaurant'),
(9005, 'restaurant'),
(9006, 'restaurant'),
(9007, 'restaurant'),
(9008, 'restaurant'),
(9009, 'restaurant'),
(9010, 'restaurant'),
(9011, 'restaurant'),
(9012, 'restaurant'),
(9013, 'restaurant'),
(9014, 'restaurant'),
(9015, 'restaurant'),
(9016, 'restaurant'),
(9017, 'restaurant'),
(9018, 'restaurant'),
(9019, 'restaurant');

insert into Airlines
values
(6000, 'airlines1'),
(6001, 'airlines2'),
(6002, 'airlines3'),
(6003, 'airlines4'),
(6004, 'airlines5'),
(6005, 'airlines6'),
(6006, 'airlines7'),
(6007, 'airlines8'),
(6008, 'airlines9'),
(6009, 'airlines10'),
(6010, 'airlines11'),
(6011, 'airlines12'),
(6012, 'airlines13'),
(6013, 'airlines14'),
(6014, 'airlines15'),
(6015, 'airlines16'),
(6016, 'airlines17'),
(6017, 'airlines18'),
(6018, 'airlines19'),
(6019, 'airlines20');

insert into Cars
values
(7000, 'car1'),
(7001, 'car2'),
(7002, 'car3'),
(7003, 'car4'),
(7004, 'car5'),
(7005, 'car6'),
(7006, 'car7'),
(7007, 'car8'),
(7008, 'car9'),
(7009, 'car10'),
(7010, 'car11'),
(7011, 'car12'),
(7012, 'car13'),
(7013, 'car14'),
(7014, 'car15'),
(7015, 'car16'),
(7016, 'car17'),
(7017, 'car18'),
(7018, 'car19'),
(7019, 'car20');

insert into Hotels
values
(8000, 'hotel1'),
(8001, 'hotel2'),
(8002, 'hotel3'),
(8003, 'hotel4'),
(8004, 'hotel5'),
(8005, 'hotel6'),
(8006, 'hotel7'),
(8007, 'hotel8'),
(8008, 'hotel9'),
(8009, 'hotel10'),
(8010, 'hotel11'),
(8011, 'hotel12'),
(8012, 'hotel13'),
(8013, 'hotel14'),
(8014, 'hotel15'),
(8015, 'hotel16'),
(8016, 'hotel17'),
(8017, 'hotel18'),
(8018, 'hotel19'),
(8019, 'hotel20');

insert into Restaurants
values 
(9000, 'restaurant1'),
(9001, 'restaurant2'),
(9002, 'restaurant3'),
(9003, 'restaurant4'),
(9004, 'restaurant5'),
(9005, 'restaurant6'),
(9006, 'restaurant7'),
(9007, 'restaurant8'),
(9008, 'restaurant9'),
(9009, 'restaurant10'),
(9010, 'restaurant11'),
(9011, 'restaurant12'),
(9012, 'restaurant13'),
(9013, 'restaurant14'),
(9014, 'restaurant15'),
(9015, 'restaurant16'),
(9016, 'restaurant17'),
(9017, 'restaurant18'),
(9018, 'restaurant19'),
(9019, 'restaurant20');

insert into Bookings
values
(12000, 2000, 0, 10, 1000, '2015-01-02', 'details1'),
(12001, 2001, 1, 11, 1001, '2015-02-03', 'details2'),
(12002, 2002, 0, 10, 1002, '2015-04-05', 'details3'),
(12003, 2003, 1, 11, 1003, '2015-05-06', 'details4'),
(12004, 2004, 0, 10, 1004, '2015-12-31', 'details5'),
(12005, 2005, 1, 11, 1005, '2015-12-31', 'details6'),
(12006, 2006, 0, 11, 1006, '2016-01-02', 'details7'),
(12007, 2007, 1, 10, 1007, '2016-02-03', 'details8'),
(12008, 2008, 1, 11, 1008, '2016-03-05', 'details9'),
(12009, 2009, 1, 10, 1009, '2016-04-30', 'details10'),
(12010, 2010, 0, 11, 1010, '2016-05-29', 'details11'),
(12011, 2011, 1, 10, 1011, '2016-06-28', 'details12'),
(12012, 2012, 1, 11, 1012, '2017-01-02', 'details13'),
(12013, 2013, 0, 11, 1013, '2017-02-03', 'details14'),
(12014, 2014, 1, 10, 1014, '2017-03-05', 'details15'),
(12015, 2015, 1, 11, 1015, '2017-05-01', 'details16'),
(12016, 2016, 0, 11, 1016, '2017-05-02', 'details17'),
(12017, 2017, 1, 10, 1017, '2017-06-28', 'details18'),
(12018, 2018, 1, 11, 1018, '2017-08-31', 'details19'),
(12019, 2019, 1, 10, 1019, '2017-12-31', 'details20'),
(12020, 2010, 0, 11, 1000, '2015-02-02', 'details21'),
(12021, 2011, 1, 11, 1010, '2015-03-31', 'details22'),
(12022, 2013, 1, 11, 1011, '2015-08-27', 'details23'),
(12023, 2004, 0, 11, 1002, '2016-03-20', 'details24'),
(12024, 2002, 1, 11, 1003, '2016-08-19', 'details25'),
(12025, 2003, 0, 11, 1009, '2016-09-01', 'details26'),
(12026, 2004, 1, 11, 1018, '2017-01-11', 'details27'),
(12027, 2012, 1, 11, 1019, '2017-03-02', 'details28'),
(12028, 2015, 0, 11, 1011, '2017-04-20', 'details29');
/*(12029, 2000, 0, 11, 1010, '2017-05-31', 'details30'),
(12030, 2001, 0, 11, 1011, '2018-01-31', 'details31'),
(12031, 2015, 0, 11, 1011, '2017-04-20', 'details32'),
(12032, 2000, 0, 11, 1010, '2017-05-31', 'details33'),
(12033, 2001, 0, 11, 1011, '2018-01-31', 'details34'),
(12034, 2015, 0, 11, 1011, '2017-04-20', 'details35'),
(12035, 2000, 0, 11, 1010, '2017-05-31', 'details36'),
(12036, 2001, 0, 11, 1011, '2018-01-31', 'details37'),
(12037, 2015, 0, 11, 1011, '2017-04-20', 'details38'),
(12038, 2000, 0, 11, 1010, '2017-05-31', 'details39'),
(12039, 2016, 0, 11, 1011, '2018-01-31', 'details40'),
(12040, 2002, 0, 11, 1011, '2017-04-20', 'details41');*/

insert into Payments
values
(10000, 12001, 1111, '2015-02-03', 'otherdetails1'),
(10001, 12003, 1111, '2015-05-06', 'otherdetails2'),
(10002, 12005, 1111, '2015-12-31', 'otherdetails3'),
(10003, 12006, 2323, '2016-01-02', 'otherdetails4'),
(10004, 12008, 2323, '2016-03-05', 'otherdetails5'),
(10005, 12010, 2323, '2016-05-29', 'otherdetails6'),
(10006, 12012, 2344, '2017-01-02', 'otherdetails7'),
(10007, 12013, 4556, '2017-02-03', 'otherdetails8'),
(10008, 12015, 4569, '2017-05-01', 'otherdetails9'),
(10009, 12016, 6645, '2017-05-02', 'otherdetails10'),
(10010, 12018, 6789, '2017-08-31', 'otherdetails11'),
(10011, 12020, 8666, '2015-02-02', 'otherdetails12'),
(10012, 12021, 8900, '2015-03-31', 'otherdetails13'),
(10013, 12022, 9064, '2015-08-27', 'otherdetails14'),
(10014, 12023, 12312, '2016-03-20', 'otherdetails15'),
(10015, 12024, 12302, '2016-08-19', 'otherdetails16'),
(10016, 12025, 12311, '2016-09-01', 'otherdetails17'),
(10017, 12026, 12312, '2017-01-11', 'otherdetails18'),
(10018, 12027, 12312, '2017-03-02', 'otherdetails19'),
(10019, 12028, 12333, '2017-04-20', 'otherdetails20');
/*(10023, 12029, 12333, '2017-05-31', 'otherdetails21'),
(10024, 12030, 12311, '2018-01-31', 'otherdetails22'),
(10025, 12031, 12311, '2017-04-20', 'otherdetails23'),
(10026, 12032, 12312, '2017-05-31', 'otherdetails24'),
(10027, 12033, 12312, '2018-01-31', 'otherdetails25'),
(10028, 12034, 12302, '2017-04-20', 'otherdetails26');
(10029, 12035, 12302, '2017-05-31', 'otherdetails27'),
(10030, 12036, 9064, '2018-01-31', 'otherdetails28'),
(10031, 12037, 8900, '2017-04-20', 'otherdetails29'),
(10032, 12038, 8666, '2017-05-31', 'otherdetails30'),
(10033, 12039, 6789, '2018-01-31', 'otherdetails31'),
(10034, 12040, 2002, '2017-04-20', 'otherdetails32');
(10022, 12031, 12333, '2015-03-30', 'otherdetails23'),
(10023, 12032, 12333, '2016-01-30', 'otherdetails24'),
(10024, 12033, 12333, '2016-02-27', 'otherdetails25'),
(10025, 12034, 12333, '2016-03-30', 'otherdetails26'),
(10026, 12035, 12333, '2017-01-30', 'otherdetails27'),
(10027, 12036, 12333, '2017-02-30', 'otherdetails28'),
(10028, 12037, 12333, '2018-01-30', 'otherdetails29'),
(10029, 12038, 12333, '2018-02-20', 'otherdetails30');*/

insert into Staff_Information
values
(11000, 'Chang An', 'Lee', 011111111, 'staff_position1', 'staff_address_details1', 1000),
(11001, 'Gabriel', 'Wong', 011111112, 'staff_position2', 'staff_address_details2', 2000),
(11002, 'Justin', 'Foley', 011111113, 'staff_position3', 'staff_address_details3', 3000),
(11003, 'Hannah', 'Baker', 011111114, 'staff_position4', 'staff_address_details4', 1000),
(11004, 'Clay', 'Jensen',  011111115, 'staff_position1', 'staff_address_details5', 2500),
(11005, 'Jessica', 'Davies', 011111116, 'staff_position4', 'staff_address_details6', 5000),
(11006, 'Sam', 'Smith', 011111117, 'staff_position3', 'staff_address_details7', 3000),
(11007, 'Jamie', 'Addams', 011111118, 'staff_position2', 'staff_address_details8', 4000),
(11008, 'Garrett', 'Buttler', 011111119, 'staff_position1', 'staff_address_details9', 2000),
(11009, 'Simmie', 'Lim', 011111120, 'staff_position5', 'staff_address_details10', 4000),
(11010, 'Sammie', 'Lim', 011111121, 'staff_position5', 'staff_address_details10', 4000),
(11011, 'Dennis', 'Leong', 011111122, 'staff_position2', 'staff_address_details11', 4000),
(11012, 'Zara', 'Basyirah', 011111123, 'staff_position1', 'staff_address_details12', 1000),
(11013, 'Minnie', 'Mouse', 011111124, 'staff_position2', 'staff_address_details13', 4000),
(11014, 'Mickey', 'Mouse', 011111125, 'staff_position1', 'staff_address_details14', 3000),
(11015, 'Goofy', 'Dog', 011111126, 'staff_position3', 'staff_address_details15', 900),
(11016, 'Donald', 'Duck', 011111127, 'staff_position2', 'staff_address_details16', 1000),
(11017, 'Jeffrey', 'Cheah', 011111128, 'staff_position1', 'staff_address_details17', 800),
(11018, 'Tony', 'Fernandes', 011111129, 'staff_position4', 'staff_address_details18', 4000),
(11019, 'Falken', 'Cheah', 011111130, 'staff_position1', 'staff_address_details19', 4000);
;

insert into Sales_Period
values
(13000, '2015-01-01', '2015-02-11'),
(13001, '2015-02-01', '2015-03-11'),
(13002, '2015-03-01', '2015-04-11'),
(13003, '2015-04-01', '2015-05-11'),
(13004, '2015-05-01', '2015-06-11'),
(13005, '2015-06-01', '2015-07-11'),
(13006, '2016-01-01', '2016-02-11'),
(13007, '2016-02-01', '2016-03-11'),
(13008, '2016-02-01', '2016-04-11'),
(13009, '2016-02-01', '2016-05-11'),
(13010, '2016-02-01', '2016-06-11'),
(13011, '2016-02-01', '2016-07-11'),
(13012, '2017-01-01', '2016-02-11'),
(13013, '2017-02-01', '2015-03-11'),
(13014, '2017-03-01', '2015-04-11'),
(13015, '2017-04-01', '2015-05-11'),
(13016, '2017-05-01', '2015-06-11'),
(13017, '2017-06-01', '2015-07-11'),
(13018, '2017-07-01', '2015-08-11'),
(13019, '2017-08-01', '2015-09-11'),
(13020, '2017-09-01', '2015-10-11');

insert into Sales_Staff
values
(10, 2001, 11000, 10000, 12001, 13000), -- , 1111, '2015-02-03', 'otherdetails1'),
(null, 2003, 11005, 10001, 12003, null), -- 1111, '2015-05-06', 'otherdetails2'),
(10, 2005, 11011, 10002, 12005, 13005), -- 1111, '2015-12-31', 'otherdetails3'),
(20, 2006, 11018, 10003, 12006, 13010), -- 2323, '2016-01-02', 'otherdetails4'),
(30, 2008, 11001, 10004, 12008, 13018), -- 2323, '2016-03-05', 'otherdetails5'),
(10, 2010, 11002, 10005, 12010, 13001), -- 2323, '2016-05-29', 'otherdetails6'),
(null, 2012, 11005, 10006, 12012, null), -- 2344, '2017-01-02', 'otherdetails7'),
(10, 2013, 11000, 10007, 12013, 13010),  -- 4556, '2017-02-03', 'otherdetails8'),
(null, 2015, 11011, 10008, 12015, null), -- 4569, '2017-05-01', 'otherdetails9'),
(20, 2016, 11018, 10009, 12016, 13000), -- 6645, '2017-05-02', 'otherdetails10'),
(10, 2018, 11003, 10010, 12018, 13008), -- 6789, '2017-08-31', 'otherdetails11'),
(30, 2020, 11005, 10011, 12020, 13000), -- 8666, '2015-02-02', 'otherdetails12'),
(10, 2021, 11001, 10012, 12021, 13018), -- 8900, '2015-03-31', 'otherdetails13'),
(20, 2022, 11002, 10013, 12022, 13002), -- 9064, '2015-08-27', 'otherdetails14'),
(30, 2023, 11005, 10014, 12023, 13001), -- 12312, '2016-03-20', 'otherdetails15'),
(10, 2024, 11000, 10015, 12024, 13005), -- 12302, '2016-08-19', 'otherdetails16'),
(null, 2025, 11001, 10016, 12025, null), -- 12311, '2016-09-01', 'otherdetails17'),
(null, 2026, 11011, 10017, 12026, null), -- 12312, '2017-01-11', 'otherdetails18'),
(10, 2027, 11018, 10018, 12027, 13002), --  12312, '2017-03-02', 'otherdetails19'),
(10, 2028, 11000, 10019, 12028, 13010); -- 12333, '2017-04-20', 'otherdetails20');

/*insert into Loss
values 
(10, 1111, '2015-02-03'),
(null, 1111, '2015-05-06'),
(10, 1111, '2015-12-31'),
(20, 2323, '2016-01-02'),
(30, 2323, '2016-03-05'),
(10, 2323, '2016-05-29'),
(null, 2344, '2017-01-02'),
(10, 4556, '2017-02-03'),
(null, 4569, '2017-05-01'),
(20, 6645, '2017-05-02'),
(10, 6789, '2017-08-31'),
(30, 8666, '2015-02-02'),
(10, 8900, '2015-03-31'),
(20, 9064, '2015-08-27'),
(30, 12312, '2016-03-20'),
(10, 12302, '2016-08-19'),
(null, 12311, '2016-09-01'),
(null, 12312, '2017-01-11'),
(10, 12312, '2017-03-02'),
(10, 12333, '2017-04-20');*/

/*(12006, 2006, 0, 11, 1006, '2016-01-02', 'details7'),
(12007, 2007, 1, 10, 1007, '2016-02-03', 'details8'),
(12008, 2008, 1, 11, 1008, '2016-03-05', 'details9'),
(12009, 2009, 1, 10, 1009, '2016-04-31', 'details10'),
(12010, 2010, 0, 11, 1010, '2016-05-29', 'details11'),
(12011, 2011, 1, 10, 1011, '2016-06-28', 'details12'),
(12012, 2012, 1, 11, 1012, '2017-01-02', 'details13'),
(12013, 2013, 0, 11, 1013, '2017-02-03', 'details14'),
(12014, 2014, 1, 10, 1014, '2017-03-05', 'details15'),
(12015, 2015, 1, 11, 1015, '2017-05-01', 'details16'),
(12016, 2016, 0, 11, 1016, '2017-05-02', 'details17'),
(12017, 2017, 1, 10, 1017, '2017-06-28', 'details18'),
(12018, 2018, 1, 11, 1018, '2017-08-31', 'details19'),
(12019, 2019, 1, 10, 1019, '2017-12-31', 'details20'),
(12020, 2010, 0, 11, 1000, '2015-02-02', 'details21'),
(12021, 2011, 1, 11, 1010, '2015-03-31', 'details22'),
(12022, 2013, 1, 11, 1011, '2015-08-27', 'details23'),
(12023, 2004, 0, 11, 1002, '2016-03-20', 'details24'),
(12024, 2002, 1, 11, 1003, '2016-08-19', 'details25'),
(12025, 2003, 0, 11, 1009, '2016-09-01', 'details26'),
(12026, 2004, 1, 11, 1018, '2017-01-11', 'details27'),
(12027, 2012, 1, 11, 1019, '2017-03-02', 'details28'),
(12028, 2015, 0, 11, 1011, '2017-04-20', 'details29'),
(12029, 2000, 0, 11, 1010, '2017-05-31', 'details30'),
(12030, 2001, 0, 11, 1011, '2018-01-31', 'details31'),
(12031, 2015, 0, 11, 1011, '2017-04-20', 'details32'),
(12032, 2000, 0, 11, 1010, '2017-05-31', 'details33'),
(12033, 2001, 0, 11, 1011, '2018-01-31', 'details34'),
(12034, 2015, 0, 11, 1011, '2017-04-20', 'details35'),
(12035, 2000, 0, 11, 1010, '2017-05-31', 'details36'),
(12036, 2001, 0, 11, 1011, '2018-01-31', 'details37'),
(12037, 2015, 0, 11, 1011, '2017-04-20', 'details38'),
(12038, 2000, 0, 11, 1010, '2017-05-31', 'details39'),
(12039, 2016, 0, 11, 1011, '2018-01-31', 'details40'),
(12040, 2002, 0, 11, 1011, '2017-04-20', 'details41');*/

/*
(12001, 2001, 1, 11, 1001, '2015-02-03', 'details2'),
(12003, 2003, 1, 11, 1003, '2015-05-06', 'details4'),
(12004, 2004, 0, 10, 1004, '2015-12-31', 'details5'),
(12005, 2005, 1, 11, 1005, '2015-12-31', 'details6'),
(12006, 2006, 0, 11, 1006, '2016-01-02', 'details7'),
(12007, 2007, 1, 10, 1007, '2016-02-03', 'details8'),
(12008, 2008, 1, 11, 1008, '2016-03-05', 'details9'),
(12009, 2009, 1, 10, 1009, '2016-04-31', 'details10'),
(12010, 2010, 0, 11, 1010, '2016-05-29', 'details11'),
(12011, 2011, 1, 10, 1011, '2016-06-28', 'details12'),
(12012, 2012, 1, 11, 1012, '2017-01-02', 'details13'),
(12013, 2013, 0, 11, 1013, '2017-02-03', 'details14'),
(12014, 2014, 1, 10, 1014, '2017-03-05', 'details15'),
(12015, 2015, 1, 11, 1015, '2017-05-01', 'details16'),
(12016, 2016, 0, 11, 1016, '2017-05-02', 'details17'),
(12017, 2017, 1, 10, 1017, '2017-06-28', 'details18'),
(12018, 2018, 1, 11, 1018, '2017-08-31', 'details19'),
(12019, 2019, 1, 10, 1019, '2017-12-31', 'details20'),
(12020, 2010, 0, 11, 1000, '2015-02-02', 'details21'),
(12021, 2011, 1, 11, 1010, '2015-03-31', 'details22'),
(12022, 2013, 1, 11, 1011, '2015-08-27', 'details23'),
(12023, 2004, 0, 11, 1002, '2016-03-20', 'details24'),
(12024, 2002, 1, 11, 1003, '2016-08-19', 'details25'),
(12015, 2003, 0, 11, 1009, '2016-09-01', 'details26'),
(12016, 2004, 1, 11, 1018, '2017-01-11', 'details27'),
(12017, 2012, 1, 11, 1019, '2017-03-02', 'details28'),
(12018, 2015, 0, 11, 1011, '2017-04-20', 'details29')
insert into Profits
values
(1111, '2015-02-03', 'otherdetails1'),
(1111, '2015-05-06', 'otherdetails2'),
(1111, '2015-12-31', 'otherdetails3'),
(2323, '2016-01-02', 'otherdetails4'),
(2323, '2016-03-05', 'otherdetails5'),
(2323, '2016-05-29', 'otherdetails6'),
(2344, '2017-01-02', 'otherdetails7'),
(4556, '2017-02-03', 'otherdetails8'),
(4569, '2017-05-01', 'otherdetails9'),
(6645, '2017-05-02', 'otherdetails10'),
(6789, '2017-08-31', 'otherdetails11'),
(8666, '2015-02-02', 'otherdetails12'),
(8900, '2015-03-31', 'otherdetails13'),
(9064, '2015-08-27', 'otherdetails14'),
(12312, '2016-03-20', 'otherdetails15'),
(12302, '2016-08-19', 'otherdetails16'),
(12311, '2016-09-01', 'otherdetails17'),
(12312, '2017-01-11', 'otherdetails18'),
(12312, '2017-03-02', 'otherdetails19'),
(12333, '2017-04-20', 'otherdetails20');
*/
select * 
from Services;
-- insert into 

select year(Payments.payment_date), Payments.payment_amount as LossCancelled 
from Payments, Bookings, Sales_Staff as LossCancelledTable
where outcome_code in (0) -- put where outcomecode=paid)
and status_code = (11) -- put where outcomecode=cancelled)
and discount_rate is null
-- papapa
order by year (payment_date) asc;

select*
from LossCancelled;

select distinct Loss,
sum ((100-discountrate)/100)*(payment_amount) 
from Loss 
as LossDiscount
where outcome_code in (1) -- put where outcomecode=paid)
and status_code in (11)-- put where outcomecode=Approved)
and discount_rate is not null
order by year (payment_date) asc;

select distinct Profit,
sum (payment_amount) 
from Profit
as Income
where outcome_code in (1)-- put where outcomecode=paid)
and status_code in (11)-- put where outcomecode=Approved)
order by year (payment_date) asc;

create table Projections
select (Income-(LossDiscount + LossCancelled)) as Revenue ,  year (payment_date)
from Income , Loss;



-- insert into Airlines  values  (801, 'Airlines1'), (802, 'Airlines2'), (802, 'Airlines2'), (802, 'Airlines2'), (802, 'Airlines2'), (802, 'Airlines2'), (802, 'Airlines2'),  insert into Travel_agencies values (701, 'lorem ipsum'), (702, 'jewish ipsum')
