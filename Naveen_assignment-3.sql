--Task-1
create database HMBank;
use HMBank;
create table customers (customer_id int primary key,first_name varchar(20),last_name varchar(20),DOB date,email varchar(20),phone_number BigInt,address varchar(20))
create table Accounts (Account_id int primary key,customer_id int foreign key references customers(customer_id),account_type varchar(20),balance BigInt)
create table Transactions(transaction_id int primary key,account_id int foreign key references accounts(account_id),transaction_type varchar(20),amount bigInt,Transaction_date date)
--Task-2
--1
insert into customers values(1,'Naveen', 'kumar','2003-08-10', 'naveen@gmail.com', '9927465367','JNP'),
    (2,'Nathan', 'nate','2002-07-23', 'nathan@gmail.com', '8376453676','KGM'),
    (3,'Charlie', 'Brown', '2001-11-11','charlie@gmail.com','6253425345','PUNE'),
    (4,'David', 'Williams','2004-10-23', 'david@gmail.com', '555223456','HYD'),
    (5,'paul', 'raj', '2001-08-12','paul@gmail.com', '55745657465','CHENNAI'),
    (6,'Ram', 'charan', '2002-01-10','ram@gmail.com', '874635462','DELHI'),
    (7,'Jack', 'king', '2003-02-22','jack@gmail.com', '9809876543','KGM'),
    (8,'Balu', 'balraj', '2000-05-30','balu@gmail.com', '9987654324','JNP'),
    (9,'Santhosh', 'kumar', '1999-03-20','santhish@gmail.com', '87465747756','PUNE'),
    (10,'Oggy', 'Hernandez', '1995-02-15','oggy@gmail.com', '7364865736','CHENNAI')
select *from customers
insert into Accounts (account_id, customer_id, account_type, balance)
values
(1, 1, 'savings', 1000),
(2, 2, 'Zero_balance', 1500),
(3, 3, 'current', 2000),
(4, 4, 'savings', 3000),
(5, 5, 'savings', 2500),
(6, 6, 'Zero_balanced', 1800),
(7, 7, 'current', 2200),
(8, 8, 'savings', 4000),
(9, 9, 'Zero_balanced', 3500),
(10, 10, 'current', 500)
select *from accounts
insert into Transactions (transaction_id, account_id, transaction_type, amount, transaction_date)
values
(1, 1, 'deposit', 500, '2024-05-01'),
(2, 2, 'withdrawal', 200, '2024-04-02'),
(3, 3, 'transfer', 1000, '2024-06-03'),
(4, 4, 'withdrawal', 500, '2024-10-04'),
(5, 5, 'deposit', 800, '2024-07-05'),
(6, 6,'transfer', 300, '2024-09-06'),
(7, 7, 'deposit', 1200, '2024-08-07'),
(8, 8, 'withdrawal', 600, '2024-12-08'),
(9, 9, 'transfer', 1500, '2024-11-09'),
(10, 10, 'withdrawal', 1000, '2024-04-10');
select *from transactions
--2.1
select concat(first_name,' ',last_name) as Name,account_type,email from customers inner join accounts on customers.customer_id=accounts.customer_id 
--2.2
--Details of transactions of a specific person or customers
select concat(first_name,' ',last_name) as Name,transaction_id,transaction_type,amount,transaction_date from transactions inner join accounts on transactions.account_id=accounts.account_id inner join customers on customers.customer_id=accounts.account_id where first_name='Naveen'
--or
--Transaction details of every customer
select concat(first_name,' ',last_name) as Name,transaction_id,transaction_type,amount,transaction_date from transactions,customers,accounts where transactions.account_id=accounts.account_id and customers.customer_id=accounts.account_id
--2.3
update accounts set balance=balance+100 where account_type='zero_balanced'
--2.4
select concat(first_name,' ',last_name) as Full_name from customers
--2.5
delete from transactions where account_id=(select account_id from accounts where balance=0 and account_type='savings')
delete from accounts where balance=0 and account_type='savings'
--2.6
select *from customers where address='PUNE'
--2.7
select account_id,balance from accounts where account_id=1
--2.8
select *from accounts where account_type='current' and balance>1000
--2.9
--sepecific account id
select *from transactions where account_id=1
--specific account type
select *from transactions inner join accounts on accounts.account_id=transactions.account_id where account_type='savings'
--2.10
select account_id,account_type,sum(balance*(0.5/100)) as Interest from accounts where account_type='savings' group by account_id ,account_type
--2.11
select *from accounts where account_id in(select Account_id from accounts where balance<15000)
--2.12
select *from customers where customer_id in(select customer_id from customers where address!='pune')
--Task-3
--1
select first_name,customers.customer_id ,avg(balance) 'Average' from customers inner join accounts on customers.customer_id=accounts.customer_id group by first_name,customers.customer_id
--or
select AVG(balance) AS average_balance from Customers JOIN Accounts ON Customers.customer_id = Accounts.customer_id;
--2
select top 10 balance from accounts order by balance desc 
--3
select sum(amount) as Total_deposits from transactions where transaction_type='deposit' and transaction_date='2024-05-01'
--or
select c.first_name,t.account_id,sum(t.amount) as Total_deposits from customers c inner join accounts a on c.customer_id=a.customer_id inner join transactions t on t.account_id=a.account_id where transaction_type='deposit' and transaction_date='2024-05-01' group by c.first_name , t.account_id

--4
select newest_customer,oldest_customer from (select top 1 concat(first_name,' ',last_name) as Newest_customer from customers order by DOB) as sub ,
(select top 1 concat(first_name,' ',last_name) as Oldest_customer from customers order by DOB Desc) as sub1
--5
select transaction_id,account_type,transaction_type,amount,transaction_date from accounts inner join transactions on accounts.account_id=Transactions.account_id
--6
select concat(first_name,' ',last_name) as CustomerName,account_id,accounts.customer_id,account_type,balance from customers inner join accounts on customers.customer_id=accounts.customer_id
--7
select concat(first_name,' ',last_name) as customername, transaction_id,transaction_type,amount,transaction_date from customers inner join accounts on customers.customer_id=accounts.customer_id inner join transactions on accounts.account_id=transactions.account_id where accounts.account_id=1
--8
select *from customers where customer_id in(
select customer_id from(
select customer_id,count(customer_id) as no_of_accounts from accounts group by customer_id having count(customer_id)>1) as tempTable)
--or
select *from customers where customer_id in (select customer_id from accounts group by customer_id having count(customer_id)>1) 
--9
select (deposit_total-withdrawals_total) as difference_between_depositTota_and_withdrawalTotal from(
select sum(amount) as deposit_total from transactions where transaction_type='deposit') as temp1,
(select sum(amount) as withdrawals_total from transactions where transaction_type='withdrawal') temp2
--10
SELECT account_id ,AVG(balance) "Average Daily Balance" FROM Accounts GROUP BY account_id;
--11
select account_type,sum(balance) 'total_balance' from accounts group by account_type
--12
select account_id,count(account_id) as No_of_transactions from transactions group by account_id order by no_of_transactions desc
--13
select account_id,count(account_id) from transactions group by account_id having count(account_id)>1
--14
SELECT * FROM Transactions WHERE account_id =
(SELECT account_id FROM Transactions
GROUP BY amount,transaction_date,account_id
HAVING COUNT(*)>1) AND
amount = 
(SELECT amount FROM Transactions
GROUP BY amount,transaction_date,account_id
HAVING COUNT(*)>1) AND 
transaction_date = 
(SELECT transaction_date FROM Transactions
GROUP BY amount,transaction_date,account_id
HAVING COUNT(*)>1);

--Task-4
--1
select c.first_name,a.account_id,c.customer_id,c.dob,c.phone_number from customers c inner join accounts a on c.customer_id=a.customer_id where balance in (
select max(balance) from accounts )
--2
select avg(balance) from accounts where customer_id=(
select customer_id from accounts group by customer_id having count(customer_id)>1)
--3
select a.account_id,a.customer_id,a.account_type,a.balance from accounts a inner join transactions t on a.account_id=t.account_id where t.amount>( 
select avg(amount) from transactions )

--or
select *from accounts where account_id in(
select account_id from transactions where amount>(
select avg(amount) as avegrage_amount from transactions))
--4
select *from customers where customer_id not in (select distinct customer_id from accounts)
--5
select sum(balance) as Total_balance from accounts where account_id not in(select distinct account_id from transactions)
--6
select *from transactions where account_id =(
select account_id from accounts where balance=(select min(balance) from accounts))
--7
select *from customers where customer_id in(
select customer_id from accounts group by customer_id having count(customer_id)>1)
--8
SELECT account_type,CONVERT(VARCHAR,(count(*) * 100) / (SELECT COUNT(*) FROM Accounts))+'%'  "Percentage" 
FROM Accounts
GROUP BY account_type;

--9
--using subquery
select *from transactions where account_id=(
select account_id from accounts where customer_id=1)
--without using subqueries
select t.transaction_id,t.account_id,c.customer_id,t.transaction_type,t.amount,t.transaction_date from transactions t inner join accounts a on a.account_id=t.account_id inner join customers c on c.customer_id=a.account_id where c.customer_id=1
--10
SELECT account_type, 
(SELECT SUM(balance) FROM Accounts WHERE account_type =A.account_type) AS total_balance
FROM Accounts A
GROUP BY account_type;
