-- DVD rental schema - https://www.postgresqltutorial.com/postgresql-sample-database/
-- SQL expressions: joins, where, group by, having, etc


--1 select customer first and last name, movie title, category name, total payment amount
--2 rental time // rental_date - return_date
--3 Only payments made in 2007
--4 only moviews from categories Children and Family
--4 total amount to payments



--where title contains 'a' or 'e' or 'o' // extras for the end

select title from film

select name from category

--SELECT
--FROM
--WHERE
--GROUP BY
--HAVING
--ORDER BY

--Run something, make small changes, execute, extend
--If doesn't run debug, make some little change. run!


--0.1 Look at the task - what I need to make it done?
--What tables?
--if you use like statement, where in statement etc. check whether names starts with Capital or small letters.
--in Postgre you need to use lower() because it's Case sensitive and make difference between A and a.

--group by?
--subquery?
--outer joins?
--big expression?

--0.2 Start writing some code like - 
--select column from table, to see result. Extend!
--Basic order of statements is:

-- Select from JOINS where group by having order by

--1 get some working code
--
--2 get the joins right
--
--3 write any expressions, and verify them
-- 
--4 write any where clause expressions, and verify them
--
--5 arrange the columns and rows in preparation for grouping
--
--6 add the grouping visually verify
--
--7 add the having
--
--8 add the order by
--
--9 format up sql code
--
--Just get some code working :)


--1 get some working code
select title from film

select name from category

--2 joining tables 

-- select title, category name
-----------------select film.title, category.name from film, category

-- So here there is a catch
-- bridge table




--3 write any expressions, and verify them
--total payments


-- Only payments made in 2007
---------select payment.payment_date from payment
--4 write any where clause expressions, and verify them
-- you can minimize results by using like statement for a while and remove it after. to not processing 100 000 rows in evey test. 
-- I am choosing 'a' because if there is index if will find them fast. And like this reduce the CPU time and time for testing.





-- date is showing like 2007,00000 but it actually in 2007 format.



-- categories - Children and Family
-- remove this from column result - date_part('year', payment.payment_date) as year  - it was only for visual verification





--5 arrange the columns and rows in preparation for grouping
-- add like 'a' again for reducing results



--customer 
--customer_id Clients who spent most money for children video renting



select customer.customer_id, customer.first_name
	from customer 
limit 10
----------------full customer name

select customer.customer_id, TRIM(CONCAT(customer.first_name, ' ', customer.last_name)) as customer_name
	from customer 
	order by customer.customer_id
limit 10

-------------------JOIN
select customer.customer_id, 
		TRIM(CONCAT(customer.first_name, ' ', customer.last_name)) as customer_name,
		payment.amount
	from customer 
	join payment on (payment.customer_id = customer.customer_id)
	order by customer.customer_id
limit 50

--------------------JOIN + order by
select customer.customer_id, 
		TRIM(CONCAT(customer.first_name, ' ', customer.last_name)) as customer_name,
		payment.amount
	from customer 
	join payment on (payment.customer_id = customer.customer_id)
	order by customer.customer_id,
			customer_name
limit 50
------------------- Group by + sum amount + limit 10

select customer.customer_id,
	TRIM(CONCAT(customer.first_name, ' ', customer.last_name)) as customer_name,
	sum(payment.amount) as total_spending
	from customer 
	join payment on (payment.customer_id = customer.customer_id)
	group by
		customer.customer_id,
		customer_name
	order by customer.customer_id,
			customer_name
limit 10

--------------------------------------- where something

select customer.customer_id,
	TRIM(CONCAT(customer.first_name, ' ', customer.last_name)) as customer_name,
	sum(payment.amount) as total_spending
	from customer 
	join payment on (payment.customer_id = customer.customer_id)
	group by
		customer.customer_id,
		customer_name
	order by customer.customer_id,
			customer_name
limit 10
-------------------------------------------
select customer.customer_id,
	TRIM(CONCAT(customer.first_name, ' ', customer.last_name)) as customer_name,
	sum(payment.amount) as total_spending
	from customer 
	join payment on (payment.customer_id = customer.customer_id)
	group by
		customer.customer_id,
		customer_name
	order by
		total_spending desc
limit 10


---------------------------------Categories-----
select customer.customer_id
        from customer
        join rental
          on (rental.customer_id    = customer.customer_id)
        join inventory
          on (rental.inventory_id   = inventory.inventory_id)
        join film
          on (inventory.film_id     = film.film_id)
        join film_category
          on (film_category.film_id = film.film_id)
        join category
          on (category.category_id  = film_category.category_id)


---------------------------------Categories----- Where + CTE + test cte
with cte_id_name
  as (select customer.customer_id
        from customer
        join rental
          on (rental.customer_id    = customer.customer_id)
        join inventory
          on (rental.inventory_id   = inventory.inventory_id)
        join film
          on (inventory.film_id     = film.film_id)
        join film_category
          on (film_category.film_id = film.film_id)
        join category
          on (category.category_id  = film_category.category_id)
       where category.name in ( 'Children', 'Family' ))

select cte_id_name.customer_id from cte_id_name limit 10
  -----------------------------------Order by asc ----------------- select customers + amount + categories Child and Animation ------------------------------------------
    ----------------------------------------------------------------------------------------------

with cte_id_name
  as (select customer.customer_id
        from customer
        join rental
          on (rental.customer_id    = customer.customer_id)
        join inventory
          on (rental.inventory_id   = inventory.inventory_id)
        join film
          on (inventory.film_id     = film.film_id)
        join film_category
          on (film_category.film_id = film.film_id)
        join category
          on (category.category_id  = film_category.category_id)
       where category.name in ( 'Children', 'Family' ))
       

select customer.customer_id,
	TRIM(CONCAT(customer.first_name, ' ', customer.last_name)) as customer_name,
	sum(payment.amount) as total_spending
	from customer 
	join payment on (payment.customer_id = customer.customer_id)
	where payment.customer_id in (select cte_id_name.customer_id from cte_id_name)
	group by
		customer.customer_id,
		customer_name
	order by customer.customer_id,
			customer_name
------------------------------------------------------------------------ + Having total_spending > 50
with cte_id_name
  as (select customer.customer_id
        from customer
        ----------
        join payment on (payment.customer_id = customer.customer_id)
        join rental on (rental.rental_id = payment.rental_id)
        -------------
--        join rental
--          on (rental.customer_id    = customer.customer_id)
          ------
        join inventory
          on (rental.inventory_id   = inventory.inventory_id)
        join film
          on (inventory.film_id     = film.film_id)
        join film_category
          on (film_category.film_id = film.film_id)
        join category
          on (category.category_id  = film_category.category_id)
       where category.name in ( 'Children', 'Family' )) -- Eleonor Hunt exist! id 148
       
	
select customer.customer_id,
	TRIM(CONCAT(customer.first_name, ' ', customer.last_name)) as customer_name,
	sum(payment.amount) as total_spending
	from customer 
	join payment on (payment.customer_id = customer.customer_id)
	where payment.customer_id in (select cte_id_name.customer_id from cte_id_name)
--	and     customer.customer_id = '590'
	group by
		customer.customer_id,
		customer_name
	order by total_spending desc --------------0772 --- prez payment e 0.252 ------51164 - alll --- 35707 rental direct not by payment + rental

 ----------------------------------------------------------------------------------------------
 --------------------------------Test without with window --------------------------------------------------------------

with cte_id_name
  as (select customer.customer_id
        from customer
        join rental
          on (rental.customer_id    = customer.customer_id)
        join inventory
          on (rental.inventory_id   = inventory.inventory_id)
        join film
          on (inventory.film_id     = film.film_id)
        join film_category
          on (film_category.film_id = film.film_id)
        join category
          on (category.category_id  = film_category.category_id)
       where category.name in ( 'Children', 'Family' )), 
			total_payments_all_categories as ( select	customer.customer_id as kids_category_id,
													sum(payment.amount) as total_spending_all_payments
													from customer 
													join payment on 
														(payment.customer_id 	= customer.customer_id)
												    join rental
												      on (rental.rental_id    	= payment.rental_id)
												    join inventory
												      on (rental.inventory_id   = inventory.inventory_id)
												    join film
												      on (inventory.film_id     = film.film_id)
												    join film_category
												      on (film_category.film_id = film.film_id)
												    join category
												      on (category.category_id  = film_category.category_id)
												--       where category.name in ( 'Children', 'Family' )
--												       	and     customer.customer_id = '590' --13 --20 results
												       	and 
													       	payment.customer_id in (select cte_id_name.customer_id from cte_id_name)
													group by
														customer.customer_id
													order by total_spending_all_payments desc

       ) -- Eleonor Hunt exist! id 148
       
       
   -- select customer name, total spending on movies from Children and Family category. 
   -- And total spending for all categories per customer.
   -- top 10 results
       
-------------------- all of them -- 

select 		customer.customer_id,
	TRIM(CONCAT(customer.first_name, ' ', customer.last_name)) as customer_name,
	sum(payment.amount) as total_spending,
	total_payments_all_categories.total_spending_all_payments
	from customer 
	join payment on 
		(payment.customer_id 	= customer.customer_id)
    join rental
      on (rental.rental_id    	= payment.rental_id)
    join inventory
      on (rental.inventory_id   = inventory.inventory_id)
    join film
      on (inventory.film_id     = film.film_id)
    join film_category
      on (film_category.film_id = film.film_id)
    join category
      on (category.category_id  = film_category.category_id)
      
join total_payments_all_categories
		on (total_payments_all_categories.kids_category_id = customer.customer_id)
       where category.name in ( 'Children', 'Family' )
--       	and     customer.customer_id = '590' --13 --20 results
       	and 
	       	payment.customer_id in (select cte_id_name.customer_id from cte_id_name)
	group by
		customer.customer_id,
		customer_name,
		total_payments_all_categories.total_spending_all_payments
	order by total_spending desc
		limit 10