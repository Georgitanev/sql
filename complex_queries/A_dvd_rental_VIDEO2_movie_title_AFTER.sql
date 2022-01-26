-- DVD rental schema - httpswww.postgresqltutorial.compostgresql-sample-database
-- SQL expressions joins, where, group by, having, etc


--Task 2
   -- select top customers names who spent most money on movies from Children and Family category. 
   -- Next column for their total spendings for movies of all categories 
   -- top 10 results


--So My general approach is start with some selects to explore tables.
--To see good the ER diagram of database with all tables and connections
--To see the road who connects all data, that I will use in this select statement

--To make some changes, test, check and extend - and to repeat this
--
--small changes and checks


select title from film limit 10

select name from category
-----------------------------------------

--SELECT
--FROM
--WHERE
--GROUP BY
--HAVING
--ORDER BY

--Run something, make small changes, execute, extend
--If doesn't run debug, make some little change. run!


--0.1 Look at the task - what I need to make it done
--What tables
--if you use like statement, where in statement etc. check whether names starts with Capital or small letters.
--in Postgre you need to use lower() because it's Case sensitive and make difference between A and a.

--group by
--subquery
--outer joins
--big expression

--0.2 Start writing some code like - 
--select column from table, to see result. Extend!
--Basic order of statements is

-- Select from JOINS where group by having order by


--1 get some working code

select title from film limit 10

select name from category

--2 get the joins right

--Task 2
   -- select top customers names who spent most money on movies from Children and Family category. 
   -- Next column for their total spendings for movies of all categories 
   -- top 10 results
   
select customer.customer_id, customer.first_name, customer.last_name
from customer
join payment on (payment.customer_id = customer.customer_id)
join rental 		on (payment.rental_id 			= rental.rental_id)
join inventory 		on (rental.inventory_id 		= inventory.inventory_id)
join film 			on (inventory.film_id 			= film.film_id)
join film_category 	on (film_category.film_id 		= film.film_id)
join category 		on (film_category.category_id 	= category.category_id)



--3 write any expressions, and verify them


select customer.customer_id, customer.first_name, customer.last_name,
		payment.amount
from customer
join payment on (payment.customer_id = customer.customer_id)
join rental 		on (payment.rental_id 			= rental.rental_id)
join inventory 		on (rental.inventory_id 		= inventory.inventory_id)
join film 			on (inventory.film_id 			= film.film_id)
join film_category 	on (film_category.film_id 		= film.film_id)
join category 		on (film_category.category_id 	= category.category_id)
			

--4 write any where clause expressions, and verify them
--		sum(payment.amount) 							as total_amount, 


select customer.customer_id, customer.first_name, customer.last_name,
		payment.amount
from customer
join payment on (payment.customer_id = customer.customer_id)
join rental 		on (payment.rental_id 			= rental.rental_id)
join inventory 		on (rental.inventory_id 		= inventory.inventory_id)
join film 			on (inventory.film_id 			= film.film_id)
join film_category 	on (film_category.film_id 		= film.film_id)
join category 		on (film_category.category_id 	= category.category_id)
			
		where category.name in ('Children','Family') -- 367 -- Adam	Gooch - total amount ~ 9$
order by customer.first_name

		
--5 arrange the columns and rows in preparation for grouping
select customer.customer_id, 
		customer.first_name, 
		customer.last_name,
		payment.amount
from customer
join payment on (payment.customer_id = customer.customer_id)
join rental 		on (payment.rental_id 			= rental.rental_id)
join inventory 		on (rental.inventory_id 		= inventory.inventory_id)
join film 			on (inventory.film_id 			= film.film_id)
join film_category 	on (film_category.film_id 		= film.film_id)
join category 		on (film_category.category_id 	= category.category_id)
			
		where category.name in ('Children','Family') -- 367 -- Adam	Gooch - total amount ~ 9$
order by customer.customer_id,
		customer.first_name, 
		customer.last_name


--6 add the grouping visually verify
--Using a combination of RTRIM and LTRIM will strip any white-space on each end.
--CONCAT to append the name segments together
--COALESCE to replace NULL with an empty string
--https://stackoverflow.com/questions/48576847/how-to-combine-first-name-middle-name-and-last-name-in-sql-server

select customer.customer_id, 
		RTRIM(LTRIM(
		Concat(coalesce(customer.first_name), ' ', coalesce(customer.last_name)) )) as customer_names,
		sum(payment.amount) as total_spent_kids
from customer
join payment on (payment.customer_id = customer.customer_id)
join rental 		on (payment.rental_id 			= rental.rental_id)
join inventory 		on (rental.inventory_id 		= inventory.inventory_id)
join film 			on (inventory.film_id 			= film.film_id)
join film_category 	on (film_category.film_id 		= film.film_id)
join category 		on (film_category.category_id 	= category.category_id)
			
		where category.name in ('Children','Family') -- 367 -- Adam	Gooch - total amount ~ 9$
--		and Concat(coalesce(customer.first_name), ' ', coalesce(customer.last_name)) = 'Guy Brownlee' -- 50.92
group by
		customer.customer_id,
		customer_names
order by total_spent_kids desc


		
--7 add the having
--
--8 add the order by

--Task 2
   -- select top customers names who spent most money on movies from Children and Family category. 
   -- Next column for their total spendings for movies of all categories 
   -- top 10 results
   -- With https://stackoverflow.com/questions/12552288/sql-with-clause-example

with CTE_kids_spending as (
	select customer.customer_id as id_kids, 
			RTRIM(LTRIM(
			Concat(coalesce(customer.first_name), ' ', coalesce(customer.last_name)) )) as customer_names,
			sum(payment.amount) as total_spent_kids
	from customer
	join payment on (payment.customer_id = customer.customer_id)
	join rental 		on (payment.rental_id 			= rental.rental_id)
	join inventory 		on (rental.inventory_id 		= inventory.inventory_id)
	join film 			on (inventory.film_id 			= film.film_id)
	join film_category 	on (film_category.film_id 		= film.film_id)
	join category 		on (film_category.category_id 	= category.category_id)
			where category.name in ('Children','Family')
	group by
			customer.customer_id,
			customer_names
	order by total_spent_kids desc
)

	
select customer.customer_id, 
		RTRIM(LTRIM(
		Concat(coalesce(customer.first_name), ' ', coalesce(customer.last_name)) )) as customer_names,
		sum(payment.amount) as total_spent,
		CTE_kids_spending.total_spent_kids
from customer
join payment on (payment.customer_id = customer.customer_id)
join rental 		on (payment.rental_id 			= rental.rental_id)
join inventory 		on (rental.inventory_id 		= inventory.inventory_id)
join film 			on (inventory.film_id 			= film.film_id)
join film_category 	on (film_category.film_id 		= film.film_id)
join category 		on (film_category.category_id 	= category.category_id)
join CTE_kids_spending on (CTE_kids_spending.id_kids = customer.customer_id)
group by
		customer.customer_id,
		customer_names,
		CTE_kids_spending.total_spent_kids
order by total_spent_kids desc
	limit 10

--9 format up sql code
with CTE_kids_spending as (
	select customer.customer_id as id_kids, 
			RTRIM(LTRIM(
			Concat(coalesce(customer.first_name), ' ', coalesce(customer.last_name)) )) as customer_names,
			sum(payment.amount) as total_spent_kids
  from customer
  join payment
    on (payment.customer_id       = customer.customer_id)
  join rental
    on (payment.rental_id         = rental.rental_id)
  join inventory
    on (rental.inventory_id       = inventory.inventory_id)
  join film
    on (inventory.film_id         = film.film_id)
  join film_category
    on (film_category.film_id     = film.film_id)
  join category
    on (film_category.category_id = category.category_id)
 where category.name in ( 'Children', 'Family' )
 group by customer.customer_id,
          customer_names
 order by total_spent_kids desc
)

	
select customer.customer_id, 
		RTRIM(LTRIM(
		Concat(coalesce(customer.first_name), ' ', coalesce(customer.last_name)) )) as customer_names,
		sum(payment.amount) as total_spent,
		CTE_kids_spending.total_spent_kids
  from customer
  join payment
    on (payment.customer_id       = customer.customer_id)
  join rental
    on (payment.rental_id         = rental.rental_id)
  join inventory
    on (rental.inventory_id       = inventory.inventory_id)
  join film
    on (inventory.film_id         = film.film_id)
  join film_category
    on (film_category.film_id     = film.film_id)
  join category
    on (film_category.category_id = category.category_id)
  join CTE_kids_spending
    on (CTE_kids_spending.id_kids = customer.customer_id)
 group by customer.customer_id,
          customer_names,
          CTE_kids_spending.total_spent_kids
 order by total_spent_kids desc
	limit 10

--Just get some code working )


   -- select top customers names who spent most money on movies from Children and Family category. 
   -- Next column for their total spendings for movies of all categories 
   -- top 10 results
