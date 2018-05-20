drop database if exists dsv;
create database dsv;
use dsv;

create table Travel_Agencies(
  travel_agency_id int primary key,
  travel_agency_details text  
);

create table Customers(
customer_id int,
customer_details text,

primary key (customer_id));

create table Ref_Booking_Outcomes (
outcome_code int primary key,
outcome_description text);

create table Ref_Booking_Status (
status_code int primary key,
status_description text);

create table Bookings(
booking_id int primary key,
customer_id int,
outcome_code int,
status_code int,
travel_agency_id int,
date_of_booking date,
booking_details text,

foreign key (customer_id) references Customers(customer_id),
foreign key (outcome_code) references Ref_Booking_Outcomes(outcome_code),
foreign key (status_code) references Ref_Booking_Status(status_code),
foreign key (travel_agency_id) references Travel_Agencies(travel_agency_id)
);

create table Services(
service_id int primary key,
service_details text
);


create table Service_Bookings(
booking_id int,
service_id int,
booking_start_date date,
booking_end_date date,
other_details text,
foreign key (booking_id) references Bookings(booking_id),
foreign key (service_id) references Services(service_id)
);

create table Airlines(
airline_id int,
airline_details text,
foreign key (airline_id) references Services(service_id)
);

create table Cars(
car_id int,
car_details text,
foreign key (car_id) references Services(service_id)
);

create table Hotels(
hotel_id int,
hotel_details text,
foreign key (hotel_id) references Services(service_id)
);

create table Restaurants(
restaurant_id int,
restaurant_details text,
foreign key (restaurant_id) references Services(service_id)
);

create table Payments(
payment_id int primary key,
booking_id int,
payment_amount int,
payment_date date,
other_details text,
foreign key (booking_id) references Bookings(booking_id)
);

create table Addresses(
address_id int,
address_details text,

primary key (address_id)); 

create table Customers_Addresses(
customer_address_id int,
customer_id int,
address_id int,
date_from date,
date_to date,

primary key (customer_address_id),
foreign key (customer_id) references Customers(customer_id),
foreign key (address_id) references Addresses(address_id));






