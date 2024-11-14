-- COMBINE THE DATA FROM EMPLOYEES 
-- AND CUSTOMERS INTO ONE TABLE

-- union (it removes duplicates)
select * from Sales.Employees
select * from Sales.Customers


select  FirstName First_name,
LastName Last_name 
from Sales.Employees
union
select FirstName,LastName
from Sales.Customers

-- union all(keep duplicates and faster)
select  FirstName First_name,
LastName Last_name 
from Sales.Employees
union all
select FirstName,LastName
from Sales.Customers

-- except (distinct rows from first query 
-- that are not present in 2nd query)
-- here order of the queries affects the final result


-- find employees who are not customers
-- at the same time

select FirstName, LastName
from Sales.Employees
except
select FirstName, LastName from Sales.Customers

-- intersect (all common rows in both query)

-- find the employees who are also customers
select FirstName, LastName
from Sales.Employees
intersect
select FirstName, LastName from Sales.Customers

-- Use cases of set operators
-- combine similar table before analyzing the data


-- orders are stored in separate tables (orders and ordersArchive)
-- combine all orders into one report without duplicates

select * from Sales.Orders
union 
select * from Sales.OrdersArchive