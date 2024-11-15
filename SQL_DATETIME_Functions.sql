-- part Extractions
-- Day(), Month(), year()

select orderid, CreationTime, 
year(creationtime), MONTH(CreationTime),
DAY(creationtime)
from Sales.Orders

-- we can use datepart to extract week/quarter from date 
-- (DATEPART)
select orderid, CreationTime, 
year(creationtime), MONTH(CreationTime),
DAY(creationtime), DATEPART(week, CreationTime),
DATEPART(QUARTER, CreationTime),
DATEPART(HOUR, CreationTime),
DATEPART(MINUTE, CreationTime),
DATEPART(SECOND, CreationTime),
DATEPART(MICROSECOND, CreationTime)
from Sales.Orders


-- DATENAME 
select orderid, CreationTime, 
year(creationtime), MONTH(CreationTime),
DAY(creationtime), DATEPART(week, CreationTime),
DATEPART(QUARTER, CreationTime) ,
DATENAME(month, CreationTime),
DATENAME(YEAR, CreationTime),
DATENAME(DAY, CreationTime),
DATENAME(WEEKDAY, CreationTime)
from Sales.Orders

-- DATETRUNC (WE SPECIFY THE MINIMUM RANGE OF DATETIME LIKE
-- MIN(ANYTHING AFTER MIN WILL BE SET AS 0(FOR EXAMPLE: SECONDS))
--/ SEC(SAME RUKE AS ABOVE, ANYTHING AFTER THIS WILL E RESETED AS 0)
select orderid, CreationTime, 
DATEPART(QUARTER, CreationTime) ,
DATENAME(month, CreationTime),
DATETRUNC(MINUTE,CreationTime),
DATETRUNC(HOUR,CreationTime)
FROM Sales.Orders

-- USE CASE 

SELECT DATETRUNC(MONTH,CREATIONTIME), COUNT(*) 
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH,CREATIONTIME)

-- EOMONTH (END OF THE MONTH)
SELECT eomONTH(CREATIONTIME), 
CAST(DATETRUNC(MONTH,CreationTime) AS date)
FROM Sales.Orders

-- How many orders were placed each year?
select YEAR(OrderDate), COUNT(OrderID)
from sales.Orders
group by YEAR(OrderDate)

select cast(DATETRUNC(YEAR, OrderDate) as date), COUNT(OrderID)
from sales.Orders
group by cast(DATETRUNC(YEAR, OrderDate) as date)


-- How many orders were placed each month?
select month(OrderDate), COUNT(OrderID)
from sales.Orders
group by month(OrderDate)

select datename(month,OrderDate), COUNT(OrderID)
from sales.Orders
group by datename(month,OrderDate)

-- Use case : Data Filtering

-- Show all orders that were placed during the 
--month of february

select *,MONTH(orderdate), count(OrderID) from Sales.Orders
where MONTH(orderdate)=2
group by MONTH(orderdate)

select * from Sales.Orders
where MONTH(orderdate)=2


-- COMPARISON of OUTPUT type of diffrent fucntions
-- DATEPART --> INT (Output)
-- DATENAME --> STRING (Output)
-- DATETRUNC --> DATETIME (Output)
-- EOMONTH --> DATE (Output)


-- DATE FORMATING

-- FORMAT()
select FORMAT(OrderDate,'ddd-MMM-yyyy') ,
FORMAT(OrderDate,'dd-MMM-yyyy'),
FORMAT(OrderDate,'dd-MMM-yyyy') 
from Sales.Orders

-- show creationtime using the following format:
-- day wed jan q1 2025 12:34:56 pm
select 'Day '+ FORMAT(OrderDate,'ddd') +' '
+ FORMAT(OrderDate,'MMM') + ' Q'+ 
DATEname(QUARTER,OrderDate)+ ' '+ 
FORMAT(CreationTime,'yyyy hh:mm:ss tt')
from Sales.Orders

-- Use Case (Data Aggregation)
select format(OrderDate,'MMM yy'),count(*)
from Sales.Orders
group by format(OrderDate,'MMM yy')

-- Use Case (Data Standardization)


-- CONVERT()
select CONVERT(float, ProductID) from sales.Orders
select CONVERT(varchar, ProductID) from sales.Orders

--CAST()

select cast('123' as float)


-- DATE CALCULATIONS
-- DATEADD() / DATEDIFF()

-- Dateadd(part, interval, date) --> (year,2,orderdate)
--> (year, -4, orderdate)

select OrderDate, DATEADD(YEAR,-2,OrderDate) ,
DATEADD(day,-10,OrderDate),
DATEADD(month,4,OrderDate)
from Sales.Orders


-- DATEDIFF(part, start_Date, end_date)
select BirthDate, DATEdiff(YEAR,BirthDate,getdate()) 
from Sales.Employees


-- Find the average shipping duration in days for each month
select month(OrderDate),
avg(DATEDIFF(day,OrderDate,ShipDate)) 
from Sales.Orders
group by month(OrderDate)

-- Find the number of days between each order and previous order
select OrderID, OrderDate,
LEAD(OrderDate) over(order by orderdate) nxt,
LAG(OrderDate) over(order by orderdate) prv,
DATEDIFF(DAY,LAG(OrderDate) over(order by orderdate),OrderDate)

from Sales.Orders

-- ISDATE 
select ISDATE('123')
select ISDATE('2025-08-13')