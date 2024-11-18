-- You can not use 'order by' inside cte
-- None recursive CTEs (Standalone & Nested)

-- Step 1: Find the total Sales per customer
with cte_totalsale as (
select customerid, 
sum(sales) as totalsales from Sales.Orders
group by CustomerID
),
-- Step 2: Find the last order date per customer
cte_lastorderdate as (
select customerid,max(OrderDate) lastorder from Sales.Orders
group by CustomerID

)
-- Step 3: Rank the customers based on total sales per customer
,
cte_rank as(
select cts.CustomerID,RANK()
over(order by totalsales desc) ranks from cte_totalsale cts 

)

-- step 4: segment customers based on their total sales
, cte_segment as (
select *,case when totalsales>100 then 'High'
when totalsales> 50 and totalsales<=100 then 'Medium'
else 'Low' end segmenting
from cte_totalsale
)
-- Main Query
select c.CustomerID,c.FirstName,c.LastName,
cte_totalsale.totalsales, clo.lastorder,ctr.ranks, cs.segmenting
from Sales.Customers c left join
cte_totalsale on cte_totalsale.CustomerID = c.CustomerID
left join cte_lastorderdate clo
on clo.CustomerID=c.CustomerID 
left join cte_rank ctr 
on ctr.CustomerID=c.CustomerID
left join cte_segment cs
on cs.CustomerID=c.CustomerID;


--	RECURSIVE CTE
	
-- generate a sequence of numbers from 1 to 20

with cte_num as (
select 1 as mynumber
union all
select mynumber +1 from cte_num
where mynumber<20
) select * from cte_num;

-- Task: Show the employee hierarchy by displaying 
-- each employee's level within the organization

select * from Sales.Employees;


with cte_hierarchy as (
-- Ancher Query 
select EmployeeID,FirstName,ManagerID, 1 as level
from Sales.Employees where ManagerID is null
union all
select e.EmployeeID,e.FirstName,e.ManagerID, 2 as level from
Sales.Employees e where e.ManagerID = 1
union all
select e1.EmployeeID,e1.FirstName,e1.ManagerID, 3 as level
from Sales.Employees e1 where e1.ManagerID =2
union all
select e2.EmployeeID,e2.FirstName,e2.ManagerID, 4 as level
from Sales.Employees e2 where e2.ManagerID =3
union all
select e3.EmployeeID,e3.FirstName,e3.ManagerID, 5 as level
from Sales.Employees e3 where e3.ManagerID =4
)

-- main query
select * from cte_hierarchy;


with cte_rec as (
-- anchor
select EmployeeID, FirstName, ManagerID, 1 as level
from Sales.Employees where ManagerID is null
-- recursive
union all
select e.EmployeeID,e.FirstName,e.ManagerID, level +1
from Sales.Employees e inner join cte_rec cr 
on e.ManagerID=cr.EmployeeID
) select * from cte_rec

