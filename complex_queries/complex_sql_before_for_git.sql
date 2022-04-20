-- DVD rental schema - httpswww.postgresqltutorial.compostgresql-sample-database
-- SQL expressions joins, where, group by, having, etc

select 	film.title, category.name, 
		sum(payment.amount) 							as total_amount, 
		sum(rental.return_date - rental.rental_date) 	as time_rented
from payment
join rental 		on (payment.rental_id 			= rental.rental_id)
join inventory 		on (rental.inventory_id 		= inventory.inventory_id)
join film 			on (inventory.film_id 			= film.film_id)
join film_category 	on (film_category.film_id 		= film.film_id)
join category 		on (film_category.category_id 	= category.category_id)
	where date_part('year', payment.payment_date ) = '2007'
		and category.name in ('Children','Family')
group by
	film.title, category.name
having sum(payment.amount) = 120
order by 
	total_amount desc
limit 200


--Task
--select movie name, Genre, total payment and total rental time for movies who's rent payment date (payment_date) was in 2007
--from movie category children and family
--with payment amount = 100
-- first 100 results


--So My general approach is start with some selects to explore tables.
--To see good the ER diagram of database with all tables and connections
--To see the road who connects all data, that I will use in this select statement

--To make some changes, test, check and extend - and to repeat this
--
--small changes and checks


--1 select movie name, Genre, total payment and rental time
--2 rental time 
--3 Only payments made in 2007
--4 only moviews from categories Children and Family
--5 total amount to payments
--6 having total amount  = 1000
--7 check and format the code


select title from film limit 10

select name from category
-----------------------------------------

select film.title, payment.amount, rental.rental_date, rental.return_date
from payment
join rental on (payment.rental_id = rental.rental_id)
join inventory on (rental.inventory_id = inventory.inventory_id)
join film on (inventory.film_id = film.film_id)
join film_category on (film_category.film_id = film.film_id)
join category on (film_category.category_id = category.category_id)
where film.title = 'Ace Goldfinger' and rental.return_date notnull
limit 200



--	AND rental.inventory_id = inventory.inventory_id
--	AND inventory.film_id = film.film_id
--	AND film_category.film_id = film.film_id
--	AND film_category.category_id = category.category_id

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
select title from film

select name from category

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
--Just get some code working )


-------------------------------end final
select 	film.title, category.name, 
		sum(payment.amount) 							as total_amount, 
		sum(rental.return_date - rental.rental_date) 	as time_rented
from payment
join rental 		on (payment.rental_id 			= rental.rental_id)
join inventory 		on (rental.inventory_id 		= inventory.inventory_id)
join film 			on (inventory.film_id 			= film.film_id)
join film_category 	on (film_category.film_id 		= film.film_id)
join category 		on (film_category.category_id 	= category.category_id)
	where date_part('year', payment.payment_date ) = '2007'
		and category.name in ('Children','Family')
group by
	film.title, category.name
having sum(payment.amount) = 120
order by 
	total_amount desc
limit 200