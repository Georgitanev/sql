edit: to comment sql code use at start and at the end 

-- Northwind tables :)
## How to approach more complex queries

#### Northwind schema
![Build Status](https://github.com/Georgitanev/sql/blob/master/complex_queries/northwind/Northwind_4tables_schema_complex_query.png?raw=true)


--Taks - GET:
--product_name, product_id, category_name, Product_revenue
--for orders from 1996 year
--where product revenue > 5000
--ordered by product_name, product_id

How to approach a query that has all the basic DML clauses
expressions, JOINs, WHERE, GROUP BY, HAVING, etc.

Northwind DB

Give list of products that have created more than $5000 in revenue in 1996
show the productname, productID, and categoryname. Order by productname.

Basic order of statements is:

Select
from
JOINS
where
group by
having
order by

Don't start from beggining
General approach is: make small changes, execute a lot. If it doesn't run, your last small change broke it.

General order for problem decomposition of complex SQL queries is:
0.1. Look at the question - what will I need?
What tables
group by
subquery
outer joins
big expressions

0.2 get some working code
1. get the joins right
3. write any expressions, and verify them
4. write any where clause expressions, and verify them
5. arrange the columns and rows in preparation for grouping
5. add the grouping visually verify
6. add the having
7. add the order by
8. format up sql code


0. Just get some code working :) 

#### 1. Simple Select
```sql

select 	Products.Product_ID
from 	products
```

--Give a list of products that have create more than $5000 in revenue in 1996
--show the productname, product_id and category name. Order by product name.
--1. get the joins RIGHT!!!

#### 2. JOINS
select with case -> check salary and return different strings. Formatted code 
```sql
select  products.product_id
from 	products
join 	categories 		on products.category_id 	= categories.category_id
join 	order_details 	on products.product_id 		= order_details.product_id
join 	orders 			on order_details.order_id 	= orders.order_id
```
## 2.  Add some columns
--Give a list of products that have create more than $5000 in revenue in 1996
--show the productname, product_id and category name. Order by product name.
--2. Write any expressions and verify them. Add year of order date and revenue
-- Product_ID, year, quantity, unit_price, discount, revenue line revenue - (quantity * price * (1-discount))

```sql
select  products.product_name						,
		extract(year from orders.order_date) as year,
		products.product_id							,
		categories.category_name					,
		(od.quantity * od.unit_price * (1 - od.unit_price))
from 	products
join 	categories              on products.category_id 	= categories.category_id
join 	order_details as od     on products.product_id 		= od.product_id
join 	orders                  on od.order_id 				= orders.order_id
```

##  3 WHERE and order by  
--Give a list of products that have create more than $5000 in revenue in 1996
--show the productname, product_id and category name. Order by product name.
--3.Writing where clause expressions and verify them 

-- Product_ID, revenue line revenue - (quantity * price * (1-discount)
-- add where. order by order date, 

```sql
select  products.product_name						,
		extract(year from orders.order_date) as year,
		products.product_id							,
		categories.category_name					,
		(od.quantity * od.unit_price * (1 - od.unit_price))
from 	products
join 	categories 				on products.category_id 	= categories.category_id
join 	order_details as od 	on products.product_id 		= od.product_id
join 	orders 					on od.order_id 				= orders.order_id
-- where extract(year from orders.order_date) = 1996 -- because it's a function it's not making index scan!!!
-- extract(year from orders.order_date) = 1996 this works with index scan if I create index with same function:
-- create index idx_order_date_year on orders using btree(extract(year from orders.order_date));
where  orders.order_date >= '1996-01-01' and orders.order_date <= '1996-12-31'
order by 
	products.product_name
```

## 4 Arrange columns
--Give a list of products that have create more than $5000 in revenue in 1996
--show the productname, product_id and category name. Order by product name.
--4 Arrange columns (add product name and category name) 
--Products.product_name, products.product_id,  categories.category_name, revenue
-- order by products.product_name, products.product_id, categories.category_name
-- and rows in preparation for grouping - Do NOT group
-- Grouping preparation

```sql
select  products.product_name						,
		extract(year from orders.order_date) as year,
		products.product_id							,
		categories.category_name					,
		(od.quantity * od.unit_price * (1 - od.unit_price))
from 	products
join 	categories 				on products.category_id 	= categories.category_id
join 	order_details as od 	on products.product_id 		= od.product_id
join 	orders 					on od.order_id 				= orders.order_id
where 	extract(year from orders.order_date) = 1996
order by 
	products.product_name	,
	products.product_id		,
	categories.category_name
```

## 5. Order by product name. add grouping visually verify
--Give a list of products that have create more than $5000 in revenue in 1996
--show the productname, product_id and category name, revenue 
--5. Order by product name. add grouping visually verify

```sql
select  products.product_name						,
		products.product_id							,
		categories.category_name					,
		sum(od.quantity * od.unit_price * (1 - od.unit_price)) as product_revenue
from 	products
join 	categories 				on products.category_id 	= categories.category_id
join 	order_details as od 	on products.product_id 		= od.product_id
join 	orders 					on od.order_id 				= orders.order_id
where 	extract(year from orders.order_date) = 1996
group by 
	products.product_name	,
	products.product_id		,
	categories.category_name
order by 
	products.product_name	,
	products.product_id		,
	categories.category_name
```

## 6. Add having. Order by product_name, product_id
--Give a list of products that have create more than $3000 in revenue in 1996
--show the productname, product_id and category name. Order by product name.
--6. Add having. Order by product_name, product_id

```sql
select  products.product_name						,
		products.product_id							,
		categories.category_name					,
		sum(od.quantity * od.unit_price * (1 - od.discount)) as product_revenue
from 	products
join 	categories 				on products.category_id 	= categories.category_id
join 	order_details as od 	on products.product_id 		= od.product_id
join 	orders 					on od.order_id 				= orders.order_id
where 	extract(year from orders.order_date) = 1996
group by 
	products.product_name	,
	products.product_id		,
	categories.category_name
having sum(od.quantity * od.unit_price * (1 - od.discount)) > 5000
order by 
	products.product_name	,
	products.product_id		,
	categories.category_name
```

--Give a list of products that have create more than $5000 in revenue in 1996
--show the productname, product_id and category name. Order by product name.
--7. add the order by. CODE formatting. 

```sql
select  products.product_name						,
		products.product_id							,
		categories.category_name					,
		sum(od.quantity * od.unit_price * (1 - od.discount)) as product_revenue
from 	products
join 	categories 				on products.category_id 	= categories.category_id
join 	order_details as od 	on products.product_id 		= od.product_id
join 	orders 					on od.order_id 				= orders.order_id
where 	extract(year from orders.order_date) = 1996
group by 
	products.product_name	,
	products.product_id		,
	categories.category_name
having sum(od.quantity * od.unit_price * (1 - od.discount)) > 5000
order by 
	products.product_name	,
	products.product_id				--gives unique ordering because it's PK
```