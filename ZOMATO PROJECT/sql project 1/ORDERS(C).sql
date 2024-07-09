show databases;

use project1;
-- create table salespeople
create table salespeople (
snum int ,
sname varchar(10),
city varchar(10),
comm float,
primary key (snum));

insert into salespeople values 
(1001,"peel","london",0.12),
(1002,"serres","san jose",0.13),
(1003,"axelrod","New york",0.10),
(1004,"Motika","London",0.11),
(1007,"Rafkin","Barcelona",0.15);

SELECT * FROM salespeople;
-- create table customer

create table cust(
cnum int ,
cname varchar(10),
city varchar(10),
rating int ,
snum int ,
primary key(CNUM),
foreign key (SNUM) references salespeople(snum));

insert into cust values 
(2001,"Hoffman","London",100,1001),
(2002,"Giovanne","Rome",200,1003),
(2003,"liu","san jose",300,1002),
(2004,"grass","berlin",100,1002),
(2006,"Clemens","London",300,1007),
(2007,"Pereira","rome",100,1004),
(2008,"James","London",200,1007);

-- create table orders 

create table orders (
onum int ,
amt float ,
odate date ,
cnum int,
snum int,
foreign key (cnum) references cust(cnum),
foreign key (snum) references salespeople(snum),
primary key (onum));

desc orders;

insert into orders values 
(3001,18.69,"1994-10-03",2008,1007),
(3002,1900.10,"1994-10-03",2007,1004),
(3003,767.19,"1994-10-03",2001,1001),
(3005,5160.45,"1994-10-03",2003,1002),
(3006,1098.16,"1994-10-04",2008,1007),
(3007,75.75,"1994-10-05",2004,1002),
(3008,4723.00,"1994-10-05",2006,1001),
(3009,1713.23,"1994-10-04",2002,1003),
(3010,1309.95,"1994-10-06",2004,1002),
(3011,9891.88,"1994-10-06",2006,1001);


-- querey : 4.	Write a query to match the salespeople to the customers according to the city they are living.

select s.snum , s.city , c.cname from salespeople as s
inner join 
cust as c
on s.snum = c.snum;


-- querey :5.	Write a query to select the names of customers and the salespersons who are providing service to them.

select c.cname , s.sname from cust as c
 inner join
salespeople as s
on c.snum = s.snum;


-- Querey :6.	Write a query to find out all orders by 
-- customers not located in the same cities as that of their salespeople

select o.onum , c.cnum , c.city from orders as o 
inner join 
cust as c on o.cnum = c.cnum
join 
salespeople as s on o.snum = s.snum
where c.city <> s.city;

-- Querey : 7.	Write a query that lists each order number followed by name of customer who made that order

SELECT O.ONUM , C.CNAME FROM ORDERS AS O 
INNER JOIN 
CUST AS C 
ON C.CNUM = O.CNUM;


-- QUEREY : 8.	Write a query that finds all pairs of customers having the same ratinG

select C1.CNAME ,  C2.CNAME , C1.RATING FROM CUST AS C1
JOIN 
CUST AS C2 
ON C1.RATING =C2.RATING AND C1.CNAME < C2.CNAME;

-- QUEREY : 9.	Write a query to find out all pairs of customers served by a single salesperson
SELECT c1.cname AS customer1, c2.cname AS customer2, c1.snum
FROM Cust c1
JOIN Cust c2 ON c1.snum = c2.snum AND c1.cnum < c2.cnum;

-- QUEREY : 10.	Write a query that produces all pairs of salespeople who are living in same city
SELECT s1.sname AS salesperson1, s2.sname AS salesperson2, s1.city
FROM Salespeople s1
JOIN Salespeople s2 ON s1.city = s2.city AND s1.snum < s2.snum;


-- QUEREY : 11.	Write a Query to find all orders credited to the same salesperson who services Customer 2008

SELECT o.*
FROM Orders o
JOIN Cust c ON o.cnum = c.cnum
WHERE o.snum = (SELECT snum FROM Cust WHERE cnum = 2008);

-- QUEREY : 12.	Write a Query to find out all orders that are greater than the average for Oct 4th

SELECT o.*
FROM Orders o
WHERE o.amt > (SELECT AVG(amt)FROM Orders
WHERE odate = '2023-10-04');

-- QUEREY : 13.	Write a Query to find all orders attributed to salespeople in London.

SELECT o.*
FROM Orders o
JOIN Salespeople s ON o.snum = s.snum
WHERE s.city = 'London';

-- QUEREY : 14.	Write a query to find all the customers whose cnum is 1000 above the snum of Serres. 

SELECT c.*
FROM Cust c
WHERE c.cnum = (SELECT snum FROM Salespeople WHERE sname = 'Serres') + 1000;


-- QUEREY : 15.	Write a query to count customers with ratings above San Jose’s average rating.

SELECT COUNT(*)FROM Cust
WHERE rating > (
    SELECT AVG(rating)
    FROM Cust
    WHERE city = 'San Jose');
    
-- QUEREY : 16.	Write a query to show each salesperson with multiple customers.
SELECT s.sname, COUNT(c.cnum) AS num_customers
FROM Salespeople s
JOIN Cust c ON s.snum = c.snum
GROUP BY s.sname
HAVING COUNT(c.cnum) > 1;






