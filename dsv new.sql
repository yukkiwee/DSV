drop database if exists dsv;
create database dsv;
use dsv;

create table Travel_Agencies(
travel_agency_id int primary key,
travel_agency_details text  
);

create table Customers(
customer_id int,
-- customer_address_id int,
-- customer_contact_id int,
primary key (customer_id)
-- foreign key (customer_address_id) references Customers_Addresses(customer_address_id),
-- foreign key (customer_contact_id) references Customers_Contact(customer_contact_id)
);

create table Customers_Addresses(
address_id int,
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
contact_id int primary key,
customer_id int,
customer_contactnumber varchar(30),
customer_contactnumber2 varchar(30),
customer_officenumber varchar(30),
foreign key (customer_id) references Customers(customer_id)
);

create table Customers_Contact (
customer_contact_id int,
contact_id int,
customer_id int,
date_from date,
date_to date,
primary key (customer_contact_id),
foreign key (customer_id) references Customers(customer_id),
foreign key (contact_id) references Contacts(contact_id));

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
service_id int unique primary key,
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
constraint airline_id foreign key (airline_id) references Services(service_id)
);

create table Cars(
car_id int,
car_details text,
constraint car_id foreign key (car_id) references Services(service_id)
);

create table Hotels(
hotel_id int,
hotel_details text,
constraint hotel_id foreign key (hotel_id) references Services(service_id)
);

create table Restaurants(
restaurant_id int,
restaurant_details text,
constraint restaurant_id foreign key (restaurant_id) references Services(service_id)
);


create table Payments(
payment_id int primary key,
booking_id int,
payment_amount int,
payment_date date,
other_details text,

foreign key (booking_id) references Bookings(booking_id)
);

create table Staff_salary(
staff_salary int primary key);

create table Staff_Information(
staff_id int primary key,
staff_first_name varchar(30),
staff_last_name varchar(30),
staff_contact_number int,
staff_position varchar(30),
staff_address_details varchar(30),
staff_salary int,

foreign key (staff_salary) references Staff_salary(staff_salary));



create table Sales_Staff(
sales_first_date date,
sales_end_date date,
discount_rate int,
customer_id int,
staff_id int,
payment_id int,
booking_id int,

foreign key (staff_id) references Staff_Information (staff_id),
foreign key (payment_id) references Payments (payment_id),
foreign key (booking_id) references Bookings (booking_id));

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
create table Loss (
discount_rate int,
payment_amount int,
payment_date int,
outcome_code int,
status_code int,
foreign key (outcome_code) references booking_id (outcome_code),
foreign key (status_code) references bookind_id (status_code),
foreign key (discount_rate) references Staff_Sales (discount_rate),
foreign key (payment_amount) references Payments (payment_amount),
foreign key (payment_date) references Payments (payment_date));

create table Profit (
payment_amount int,
payment_date int,
outcome_code int,
status_code int,
foreign key (outcome_code) references booking_id (outcome_code),
foreign key (status_code) references bookind_id (status_code),
foreign key (payment_amount) references Payments (payment_amount),
foreign key (payment_date) references Payments (payment_date));

insert into Services 
values
(111, 'Airline'),
(112, 'Airline');

insert into Airlines 
values 
(111, 'Airlines1'),
(112, 'Airlines2');

select * 
from Services;
-- insert into 

select distinct Loss,
sum (payment_amount) 
from Loss 
as LossCancelled
where outcome_code in (-- put where outcomecode=paid)
and status_code in (-- put where outcomecode=cancelled)
and discount_rate is null
order by year (payment_date) asc;

select distinct Loss,
sum ((100-discountrate)/100)*(payment_amount) 
from Loss 
as LossDiscount
where outcome_code in (-- put where outcomecode=paid)
and status_code in (-- put where outcomecode=Approved)
and discount_rate is not null
group by year(payment_date) asc;

select distinct Profit,
sum (payment_amount) 
from Profit
as Income
where outcome_code in (-- put where outcomecode=paid)
and status_code in (-- put where outcomecode=Approved)
group by year (payment_date) asc;

create table Projections
select (Income-(LossDiscount + LossCancelled)) as Revenue ,  year (payment_date)
from Income , Loss;