-- value functions (LEAD,LAG,FIRST_VALUE,LAST_VALUE)
-- order by is must, LEAD AND LAG DOESN'T SuPPORT FRAME

-- TIME SERIES ANALYSIS
-- Min/max use case (month over month) analysis/ year over year analysis

-- Analyze the month over month (mom) performance 
-- by finding the percentage change is sales
-- between the current and previous month

select OrderID,orderdate,month(OrderDate) month,
sales, sum(sales) over(partition by month(OrderDate)) ,
LAG(sales,1) over(order by month(OrderDate) ) prev
from sales.Orders


select *, round(cast((totalsales-prev) as float)/prev*100,2) MOM_per from(
select month(OrderDate) month, sum(sales) totalsales,
LAG(sum(sales),1) over(order by month(OrderDate) ) prev
from sales.Orders
group by month(OrderDate)) t

-- CUSTOMER RETENTION ANALYSIS

--Analyze customer loyalty by ranking customers 
--based on the average number of days between orders

select * from Sales.Orders

select Customerid, avg(daysUntilNextOrder) avgday,
rank() over(order by coalesce(avg(daysUntilNextOrder),999999)) ranks
from(
select CustomerID,OrderDate,
LEAD(OrderDate,1) 
over(partition by customerid order by orderdate) nextmonth,
DATEDIFF(DAY, OrderDate,LEAD(OrderDate,1) 
over(partition by customerid order by orderdate)) daysUntilNextOrder
from Sales.Orders
) t
group by CustomerID

-- First value and last value
-- find the highest and lowest sales for each product

select * from Sales.Orders

Select ProductID, max(Sales), min(Sales) from Sales.Orders
group by ProductID

select productid, sales, 
FIRST_VALUE(sales) 
over(partition by PRODUCTID order by sales desc) maxval,
FIRST_VALUE(sales) 
over(partition by PRODUCTID order by sales) minval,
Sales-FIRST_VALUE(sales) 
over(partition by PRODUCTID order by sales) salesdiffMIN
from Sales.Orders