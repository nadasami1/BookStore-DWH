create database Book_dwh

use Book_dwh

create schema bronze 

create schema silver

create schema gold

--------------bronze schema--------------

create table bronze.author_book
(
 AuthorID varchar(50),
 BookID varchar(50)
)

create table bronze.author
(
 AuthorID varchar(50),
 AuthorName varchar(50)
)

create table bronze.book_order
(
 OrderID varchar(50),
 CustomerID varchar(50),
 OrderDate varchar(50)
)
create table bronze.book
(
 BookID varchar(50),
 CategoryID varchar(50),
 Title varchar(50),
 ISBN varchar(50),
 Year varchar(50),
 Price varchar(50),
 NoPages varchar(50),
 BookDescription varchar(100)
)


create table bronze.category
(
 CategoryID varchar(50),
 CategoryDescription varchar(100)
)

	
create table bronze.customer
(
 CustomerID varchar(50),
 FirstName varchar(50),
 LastName varchar(50),
 ZipCode varchar(50),
 City varchar(50),
 State varchar(50)
)
			
create table bronze.ordering
(
 OrderID varchar(50),
 BookID varchar(50),
 Price varchar(50),
 Quantity varchar(50)
)

--------------silver schema--------------

create table silver.author
(
 AuthorID int,
 AuthorName varchar(50)
)

select * from silver.author

create table silver.author_book
(
 AuthorID int,
 BookID  int
)

select * from silver.author_book

create table silver.book
(
 BookID int,
 CategoryID int,
 Title varchar(50),
 ISBN varchar(50),
 Year int,
 Price float,
 NoPages int,
 BookDescription varchar(max)
)

select * from silver.book

create table silver.book_order
(
 OrderID int,
 CustomerID int,
 OrderDate date
)

select * from silver.book_order

create table silver.category
(
 CategoryID int,
 CategoryDescription varchar(100)
)

select * from silver.category

create table silver.customer
(
 CustomerID int,
 FullName varchar(50),
 FirstName varchar(50),
 LastName varchar(50),
 ZipCode int,
 City varchar(50),
 State varchar(50)
)

select * from silver.customer

create table silver.ordering
(
 OrderID int,
 BookID int,
 Price float,
 Quantity float
)


select * from silver.ordering

--------------gold schema--------------

create table gold.customer_dim
(
 Customer_sk int identity (1,1) primary key,
 CustomerID int,
 FirstName varchar(50),
 LastName varchar(50),
 FullName varchar(50),
 city varchar(50)
)

select * from gold.customer_dim

create table gold.book_dim 
(
 book_sk int identity (1,1) primary key,
 BookID int,
 Title varchar(50),
 ISBN varchar(50),
 Year int,
 Price float,
 NoPages int,
 BookDescription varchar(max),
 CategoryDescription varchar(100)
)

select * from gold.book_dim
 
create table gold.author_dim
(
 author_Sk int identity (1,1) primary key,
 AuthorID int,
 AuthorName varchar(50),
 BookID  int
)

select * from gold.author_dim

create table gold.fact_orders
(
 sales_sk int identity (1,1) primary key,
 OrderID int,
 author_Sk int references gold.author_dim (author_Sk) ,
 book_sk int references gold.book_dim (book_sk) ,
 Customer_sk int references gold.customer_dim (Customer_sk),
 Price float,
 Quantity int,
 TotalAmount float
)

select * from gold.fact_orders
