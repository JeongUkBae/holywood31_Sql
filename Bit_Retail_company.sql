select * from tab;
drop table member;
drop table admin;
drop table account;
drop table article;
--***** select tab
select * from tab;

--***** select Count
select count(*) from tab;

--***** select table
select * from customers;
select * from employees;

--***** drop table
drop table Suppliers;

--*****
-- create Customers table 
--*****
CREATE TABLE Customers(
    customer_id VARCHAR2(15) PRIMARY KEY,
    customer_name VARCHAR2(15) NOT NULL,
    contact_name VARCHAR2(15) NOT NULL,
    address VARCHAR2(15) NOT NULL,
    city VARCHAR2(15) NOT NULL,
    postal_code VARCHAR2(15) NOT NULL,
    country VARCHAR2(15) NOT NULL
);

--*****
-- Create Employees
--*****
CREATE TABLE Employees(
    employee_id VARCHAR2(15) PRIMARY KEY,
    last_name VARCHAR2(15) NOT NULL,
    first_name VARCHAR2(15) NOT NULL,
    birth_date VARCHAR2(15) NOT NULL,
    photo VARCHAR2(15),
    notes VARCHAR2(15)
);

--*****
-- Create Shippers
--*****
CREATE TABLE Shippers(
    shipper_id VARCHAR2(15) PRIMARY KEY,
    shipper_name VARCHAR2(15) NOT NULL,
    phone VARCHAR2(15) NOT NULL
);

--*****
-- Create Orders
--*****
CREATE TABLE Orders(
order_id NUMBER PRIMARY KEY,
customer_id VARCHAR2(15),
employee_id VARCHAR2(15),
order_date DATE DEFAULT SYSDATE,
shipper_id VARCHAR2(15),
CONSTRAINT customers_fk_orders FOREIGN KEY(customer_id)
REFERENCES Customers(customer_id),
CONSTRAINT employees_fk_orders FOREIGN KEY(employee_id)
REFERENCES employees(employee_id),
CONSTRAINT shippers_fk_orders FOREIGN KEY(shipper_id)
REFERENCES Shippers(shipper_id)
);

--*****
-- Create Suppliers
--*****
create table Suppliers(
supplier_id varchar2(15) primary key,
supplier_name varchar2(15) not null,
contact_name varchar2(15) not null,
address varchar2(15) not null,
city varchar2(15) not null,
postal_code varchar2(15) not null,
country varchar2(15) not null,
phone varchar2(15) not null
);

--*****
-- Create Categories
--*****
create table Categories(
category_id number primary key,
category_name varchar2(15) not null,
description varchar2(15)
);

--*****
-- Create Products
--*****
create table Products(
product_id number primary key,
product_name varchar2(15) not null,
supplier_id varchar2(15),
category_id number,
unit varchar2(15),
price number not null,
constraint suppliers_fk_Products foreign key(supplier_id)
references Suppliers(supplier_id),
constraint categories_fk_produets foreign key(category_id)
references Categories(category_id)
);


--*****
-- Create OrderDetails
--*****
create table Orderdetails(
order_detail_id varchar2(15) primary key,
order_id number,
product_id number,
quantity number not null,
constraint orders_fk_orderdetails foreign key(order_id)
references Orders(order_id),
constraint products_fk_orderdetails foreign key(product_id)
references Products(product_id)
);
