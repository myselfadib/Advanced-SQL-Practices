-- Find the total sales across all orders

Select sum(sales) total_sales from sales.Orders;

-- Find total sales for each product

Select ProductID as p,sum(sales) total_sales from sales.Orders
group by ProductID;

-- find total sales for each prodcut
-- additionally provide details such order id & order date

select ProductID, OrderID, OrderDate ,OrderStatus,sum(sales) 
over(Partition by OrderStatus)from Sales.Orders;

select ProductID, OrderID, OrderDate,sales, sum(sales) over() totalSales,sum(sales) 
over(Partition by ProductID) TotalSalesByProducts from Sales.Orders;

-- find the total sales for each combination of product 
-- and order status
select * from Sales.Orders;
 select ProductID ,OrderID, OrderDate,sales , OrderStatus,sum(sales) 
over(partition by productid, orderstatus) TotalSales
 from Sales.Orders;

  select ProductID , OrderStatus,sum(sales) 
over(partition by productid, orderstatus) TotalSales
 from Sales.Orders;

-- Rank each order based on their sales from highest to lowest
-- additionally provide details order id, order date
select OrderID, OrderDate, sales ,
rank() over(order by sales desc) as ranking
from sales.Orders;

-- frame window fucntion

select orderid, orderdate,orderstatus,sales,
sum(sales) over(partition by orderstatus order by orderdate
rows between current row and 2 following) total_sales
from Sales.Orders;


select orderid, orderdate,orderstatus,sales,
sum(sales) over(partition by orderstatus order by orderdate) total_sales
from Sales.Orders;

select orderid, orderdate,orderstatus,sales,
sum(sales) over(partition by orderstatus order by orderid) total_sales
from Sales.Orders;

select orderid, orderdate,orderstatus,sales,
sum(sales) over(partition by orderstatus) total_sales
from Sales.Orders;

-- find the total sales of each order status for product 101 ,102

select productid, orderstatus , sum(sales) 
over(partition by orderstatus)
from Sales.Orders
where ProductID in (101, 102)

-- rank customers based on their total sales
select * from Sales.Orders

select customerid, sum(sales) as total,
 DENSE_RANK() over(order by sum(sales) desc)
from Sales.Orders
group by CustomerID

