---Task:1. Database Design:
--1. Create the database named "TechShop"
create database Techshop
--2.Define the schema for the Customers, Products, Orders, OrderDetails and Inventory tables based on the provided schema&
--4. Create appropriate Primary Key and Foreign Key constraints for referential integrity
create table customers (
CustomerId int primary key,
FirstName varchar(20),
LastName varchar(20),
Email varchar(25),
phone BigInt,
Address varchar(50))

create table products ( productId int primary key,productName varchar(20),description varchar(50),price int) 

create table orders (OrderId int primary key,customerId int references Customers(customerId),orderDate date,TotalAmount Bigint) 

create table orderDetails (OrderDetailsId int primary key,OrderId int references orders(orderId),productId int references products(productId),Quantity int)

create table inventory(inventoryId int primary key,productId int references products(productId),QuantityInStock int,LastStockUpdate date)

create table category (categoryid int primary key,categoryname varchar(20))
--5.
insert into customers (customerId,FirstName, LastName, Email, Phone, Address) VALUES
    (1,'Naveen', 'kumar', 'naveen@gmail.com', '9927465367', '123 Elm St'),
    (2,'Nathan', 'nate', 'nathan@gmail.com', '8376453676', '456 Oak St'),
    (3,'Charlie', 'Brown', 'charlie@gmail.com','6253425345', '789 Pine St'),
    (4,'David', 'Williams', 'david@gmail.com', '555223456', '321 Maple St'),
    (5,'paul', 'raj', 'paul@gmail.com', '55745657465', '654 Birch St'),
    (6,'Ram', 'charan', 'ram@gmail.com', '874635462', '987 Cedar St'),
    (7,'Jack', 'king', 'jack@gmail.com', '9809876543', '159 Walnut St'),
    (8,'Balu', 'balraj', 'balu@gmail.com', '9987654324', '357 Ash St'),
    (9,'Santhosh', 'kumar', 'santhish@gmail.com', '87465747756', '753 Fir St'),
    (10,'Oggy', 'Hernandez', 'oggy@gmail.com', '7364865736', '852 Poplar St');
select *from customers

INSERT INTO Products VALUES
	(1,'lan','which is used to connect internet',399) ,
    (2,'Monitor', '27-inch 4K monitor with slim bezels', 299),
    (3,'Mouse', 'Wireless gaming mouse with customizable buttons', 49),
    (4,'Printer', 'All-in-one printer with wireless printing', 199),
    (5,'Tablet', '10-inch tablet with high-resolution display', 199),
    (6,'Smartwatch', 'Fitness tracker with heart rate monitor', 129),
    (7,'Router', 'Dual-band gigabit router for high-speed internet', 89),
    (8,'External Hard Drive', 'Portable hard drive with 1TB storage', 59),
    (9,'Camera', 'Mirrorless camera with 24MP sensor', 599),
    (10,'Bluetooth Speaker', 'Waterproof Bluetooth speaker with 20W output', 79),
	(11,'Keyboard', 'Mechanical keyboard with RGB lighting', 79);
select *from products

INSERT INTO Orders (orderId, CustomerID, OrderDate, TotalAmount)
VALUES
    (101,1, '2024-08-10', 200),
    (102,2, '2024-02-23', 120),
    (103,3, '2024-03-21', 500),
    (104,4, '2024-05-12', 190),
    (105,5, '2024-06-10', 390),
    (106,6, '2024-09-09', 150),
    (107,7, '2024-10-16', 440),
    (108,8, '2024-03-20', 230),
    (109,9, '2024-02-18', 170),
    (110,10, '2024-04-10', 150);
select *from orders

INSERT INTO OrderDetails (OrderdetailsID, orderId,ProductID, Quantity)
VALUES
    (1000,101, 1, 1),
    (1001,102, 2, 2),
    (1002,103, 3, 1),
    (1003,104, 4, 1),
    (1004,105, 5, 2),
    (1005,106, 6, 1),
    (1006,107, 7, 3),
    (1007,108, 8, 2),
    (1008,109, 9, 1),
    (1009,110, 10, 2);
select *from orderDetails

INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate) VALUES
(1, 1, 50, '2025-03-28'),
(2, 2, 75, '2024-05-18'),
(3, 3, 100, '2024-04-13'),
(4, 4, 25, '2025-05-15'),
(5, 5, 60, '2024-04-20'),
(6, 6, 80, '2025-10-30'),
(7, 7, 45, '2024-12-21'),
(8, 8, 30, '2025-11-19'),
(9, 9, 55, '2024-05-08'),
(10, 10,70, '2025-02-17');
select *from inventory

insert into category values(1,'electronic')
insert into category values(2,'computer_peripherals')
insert into category values(3,'portable_devices')
insert into category values(4,'networking_devices')

--Tasks 2: Select, Where, Between, AND, LIKE:

--1.Write an SQL query to retrieve the names and emails of all customers. 
select FirstName,LastName,email from customers
--2.Write an SQL query to list all orders with their order dates and corresponding customer names
select c.firstName,c.Lastname,o.orderID,o.orderDate from orders o inner join customers c ON o.customerId=c.customerId 
--3.Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.
insert into customers (customerId,Firstname,Lastname,email,Address) values (11,'subhash','chandrbhos','subhas@gmail.com','hyd')
--4.Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%
update products set price=price*1.10 where productName in('keyboard','printer','tablet','smartwatch','router')
--5.Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter
declare @Orderid int;
set @orderid=101
delete from orderdetails where orderid=@orderid
delete from orders where orderid=@orderid
--6.Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information
insert into orders (orderId,CustomerId,orderDate) values (111,9,'2024-06-28')
--7.Write an SQL query to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. Allow users to input the customer ID and new contact information.
Declare @customerid int,@email varchar(20),@address varchar(20)
set @customerid=11
set @email='subhasnew@gmail.com'
set @address='Pune '
update customers set email=@email,address=@address where customerid=@customerid
select *from customers
--8.Write an SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.
UPDATE Orders
SET TotalAmount = (
    SELECT sum(od.Quantity * p.Price)
    FROM OrderDetails od
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE od.OrderID = Orders.OrderID
)
WHERE OrderID IN (SELECT OrderID FROM OrderDetails);
--9.Write an SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.
Declare @customerid1 int
set @customerid1=2
delete from orderdetails where orderid in (select orderid from orders where customerid=@customerid1)
delete from orders where orderid in(select orderid from orders where customerid=@customerid1)
--10.. Write an SQL query to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details
insert into products (productId,productName,price) values(12,'Lapi',70000)
--
alter table orders add status varchar(20) default 'pending'
select *from orders

--11.. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status.
Declare @orderid1 int,@status varchar(10)
set @orderid1=103
set @status='shipped'
update orders set status=@status where orderid=@orderid1
--12.Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.
alter table customers add NoOfOrders int

UPDATE Customers
SET NoOfOrders = (
    SELECT COUNT(customerid)
    FROM Orders
    WHERE Orders.CustomerID = Customers.CustomerID
)
--task-3
--Task 3. Aggregate functions, Having, Order By, GroupBy and Joins:
--1.Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order.
select  c.FirstName,c.LastName,o.orderid,o.orderdate,o.totalamount from customers c inner join orders o on  c.customerid=o.customerid
--or
select c.firstname,c.lastname,o.orderid,o.orderdate,o.totalamount from customers c, orders o where c.customerid=o.customerid
--2.Write an SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue
SELECT ProductName, SUM(OrderDetails.Quantity * Products.Price) AS TotalRevenue
FROM 
    OrderDetails, Products
WHERE 
    OrderDetails.ProductID = Products.ProductID
GROUP BY 
    Products.ProductName;

--3.Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information.
select c.firstname,c.lastname,c.phone,c.email,count(o.orderId) as nooftimesOrdered from customers c inner join orders o on c.customerid=o.customerid group by c.firstname,c.lastname,c.phone,c.email having count(o.orderid)>1
--4.Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.
select top 1 productname,quantity from products,orderdetails order by  quantity desc
---or
select top 1 p.productname,o.quantity as priority from products p inner join orderdetails o on p.productId=o.productId order by quantity desc ; 
--
alter table products add categoryid int , foreign key (categoryid) references category(categoryid)
update products set categoryid=2 where productid=1
update products set categoryid=2 where productid=2
update products set categoryid=2 where productid=3
update products set categoryid=2 where productid=4
update products set categoryid=1 where productid=5
update products set categoryid=1 where productid=6
update products set categoryid=4 where productid=7
update products set categoryid=1 where productid=8
update products set categoryid=3 where productid=9
update products set categoryid=1 where productid=10
update products set categoryid=2 where productid=11
update products set categoryid=2 where productid=12
--
--5.Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories.
select productname,categoryname from products,category where products.categoryid=category.categoryid
--or
select p.productname,c.categoryname from products p inner join category c on p.categoryid=c.categoryid
--6.Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value
SELECT c.FirstName, c.LastName, AVG(o.TotalAmount) AS AverageOrderValue
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;
--7.Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.
SELECT P.ProductName,SUM(P.Price*OD.Quantity) "Revenue"
FROM Products P
INNER JOIN OrderDetails OD
ON P.ProductID=OD.ProductID
GROUP BY P.ProductName
HAVING SUM(P.Price*OD.Quantity) IN 
	(SELECT SUM(P.Price*OD.Quantity) "Revenue"
		FROM Products P
		INNER JOIN OrderDetails OD
		ON P.ProductID=OD.ProductID
		GROUP BY P.ProductName
		ORDER BY Revenue DESC
		OFFSET 0 ROWS
		FETCH NEXT 1 ROW ONLY);
--or
select top 1 c.firstname,o.orderId,o.totalAmount from customers c, orders o where c.customerid=o.customerid order by o.totalAmount desc 
--8.Write an SQL query to list electronic gadgets and the number of times each product has been ordered.
select productname,count(customerId) as nooforder from products left join orders on productid=customerid group by productname
--9.Write an SQL query to find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter.
declare @productid int
set @productid=3
select concat(firstname,' ',lastname) as Name,email,phone,address  from customers where customerid=(select customerid from orders where orderid=(select orderid from orderdetails where productid=(select productid from products where productid=@productid))) 

--10.Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters.
 DECLARE @STARTDATE DATE;
DECLARE @ENDDATE DATE;

SET @STARTDATE='2023-03-01';
SET @ENDDATE='2024-11-01';

SELECT sum(TotalAmount) "Total Revenue" FROM Orders WHERE OrderDate between @STARTDATE AND @ENDDATE;

--Task-4
--Task 4. Subquery and its type:
--1.Write an SQL query to find out which customers have not placed any orders.
select *from customers where customerid not in( select distinct customerid from orders)
--2.Write an SQL query to find the total number of products available for sale.
select count(distinct productid) from inventory where quantityinstock is not null;
--3.Write an SQL query to calculate the total revenue generated by TechShop.
select sum(price*quantity) as TotalRevenue from products,orderdetails where products.productid=orderdetails.productid
--or
SELECT SUM(TotalAmount) "Total Revenue" FROM Orders;
--4.Write an SQL query to calculate the average quantity ordered for products in a specific category. Allow users to input the category name as a parameter.
declare @categoryname varchar(20)
set @categoryname='computer_peripherals'
select avg(quantity) from orderdetails inner join products on products.productid=orderdetails.productid where orderdetails.productid in(select productid from products where categoryid in(select categoryid from category where categoryname=@categoryname))
--5.Write an SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter
declare @customerid int;
set @customerid=1;
select sum(TotalAmount) from orders where customerid=@customerid
--6.Write an SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed
SELECT FirstName, LastName, NumOrdersPlaced
FROM ( SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS NumOrdersPlaced
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.FirstName, c.LastName
) AS CustomerOrders
ORDER BY NumOrdersPlaced 
--or
select concat(firstname,' ',lastname) as Name ,count(orders.customerid) most_orders from customers inner join orders on customers.customerid=orders.customerid group by firstname,lastname having count(orders.customerid)>1
--7.Write an SQL query to find the most popular product category, which is the one with the highest total quantity ordered across all orders.
SELECT C.CategoryName ,SUM(OD.Quantity) "Quantity Ordered" FROM  Category C
INNER JOIN Products P ON P.CategoryID = C.CategoryID
INNER JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY C.CategoryName
HAVING SUM(OD.Quantity) IN 
(SELECT SUM(OD.Quantity)  FROM  Category C
INNER JOIN Products P ON P.CategoryID = C.CategoryID
INNER JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY C.CategoryName
ORDER BY SUM(OD.Quantity) DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROW ONLY);

--8.Write an SQL query to find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending.
SELECT FirstName+' '+LastName "Customer Name",SUM(O.TotalAmount) "Total Revenue" FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName,C.LastName
HAVING SUM(O.TotalAmount) = 
(SELECT SUM(O.TotalAmount) "Total Revenue" FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName,C.LastName
ORDER BY SUM(O.TotalAmount) DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROW ONLY);
--9.Write an SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers
--for each customer
select (totalamount/count(orders.customerid)) as average from orders inner join customers on  customers.customerid=orders.customerid group by totalamount
--for all customers
SELECT AVG(TotalAmount) as average FROM Orders; 
--or
SELECT SUM(TotalAmount)/COUNT(TotalAmount) as average FROM Orders

--10.Write an SQL query to find the total number of orders placed by each customer and list their names along with the order count
select concat(firstname,' ',lastname) as Name,count(orders.customerid) 'NoOfOrders' from customers inner join orders on customers.customerid=orders.customerid group by firstname,lastname
