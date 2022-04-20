-- DVD rental schema - https://www.postgresqltutorial.com/postgresql-sample-database/
-- SQL expressions: joins, where, group by, having, etc


--Task
--select movie name, Genre, total payment and total rental time for movies who's rent payment date (payment_date) was in 2007
--from movie category children and family
--with payment amount >= 100
-- first 100 results


--So My general approach is start with some selects to explore tables.
--To see good the ER diagram of database with all tables and connections
--To see the road who connects all data, that I will use in this select statement

--To make some changes, test, check and extend - and to repeat this
--
--small changes and checks


--1 select movie name, Genre, total payment and total rental time
--2 total payment// rental time //
--3 Only payments made in 2007
--4 only moviews from categories Children and Family
--5 total amount to payments
--6 having total amount > = 100
--7 check and format the code


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
select title from film

select name from category

--2 get the joins right

select payment.amount, (rental.return_date - rental.rental_date) as total_rental_time
 from payment
join rental on (payment.rental_id = rental.rental_id)
join inventory on (inventory.inventory_id = rental.inventory_id)
join film on (film.film_id = inventory.film_id)
join film_category on (film_category.film_id = film.film_id)
join category on (category.category_id = film_category.category_id)



--3 write any expressions, and verify them
select payment.amount, (rental.return_date - rental.rental_date) as total_rental_time
 from payment
join rental on (payment.rental_id = rental.rental_id)
join inventory on (inventory.inventory_id = rental.inventory_id)
join film on (film.film_id = inventory.film_id)
join film_category on (film_category.film_id = film.film_id)
join category on (category.category_id = film_category.category_id)

--4 write any where clause expressions, and verify them
select payment.amount, (rental.return_date - rental.rental_date) as total_rental_time
 from payment
join rental on (payment.rental_id = rental.rental_id)
join inventory on (inventory.inventory_id = rental.inventory_id)
join film on (film.film_id = inventory.film_id)
join film_category on (film_category.film_id = film.film_id)
join category on (category.category_id = film_category.category_id)
where date_part('year', payment.payment_date) = 2007


--select date_part('year', your_column) from your_table;

--7.99
--1.99
--7.99
--2.99
--1 select movie name, Genre, total payment and total rental time /////
--2 total payment// total rental time //
--3 Only payments made in 2007 //////
--4 only moviews from categories Children and Family /////
--5 total amount to payments
--6 having total amount > = 100
--7 check and format the code


--5 arrange the columns and rows in preparation for grouping
select film.title, category.name as Genre,
			payment.amount, 
			(rental.return_date - rental.rental_date) as total_rental_time
 from payment
join rental on (payment.rental_id = rental.rental_id)
join inventory on (inventory.inventory_id = rental.inventory_id)
join film on (film.film_id = inventory.film_id)
join film_category on (film_category.film_id = film.film_id)
join category on (category.category_id = film_category.category_id)
where date_part('year', payment.payment_date) = 2007 
and category.name in ('Children', 'Family')
order by
	film.title, category.name, payment.amount, total_rental_time

--6 add the grouping visually verify
select 		film.title, 
			category.name as Genre,
			sum(payment.amount) as total_payment,
			sum(rental.return_date - rental.rental_date) as total_rental_time
 from payment
join rental on (payment.rental_id = rental.rental_id)
join inventory on (inventory.inventory_id = rental.inventory_id)
join film on (film.film_id = inventory.film_id)
join film_category on (film_category.film_id = film.film_id)
join category on (category.category_id = film_category.category_id)
where date_part('year', payment.payment_date) = 2007 
and category.name in ('Children', 'Family')
group by
	film.title, category.name
order by
	film.title, category.name, total_rental_time
	
	
	--African Egg
--	47.89 -- 47.89 veryfied
--	select sum(payment.amount) from payment 
--	where payment.payment_id in ('22338','29349','20148','18073','29548','23865','27756','27101','17778','31907','32006')
	
--
--7 add the having

select 		film.title 										as movie_name, 
			category.name 									as Genre,
			sum(payment.amount) 							as total_payment,
			sum(rental.return_date - rental.rental_date)	as total_rental_time
 from payment
join rental on (payment.rental_id = rental.rental_id)
join inventory on (inventory.inventory_id = rental.inventory_id)
join film on (film.film_id = inventory.film_id)
join film_category on (film_category.film_id = film.film_id)
join category on (category.category_id = film_category.category_id)
where date_part('year', payment.payment_date) = '2007'
and category.name in ('Children', 'Family')
group by
	film.title, category.name
having sum(payment.amount) > 100
order by
	total_payment desc
	
	
--1 select movie name, Genre, total payment and total rental time /////
--2 total payment// total rental time //
--3 Only payments made in 2007 //////
--4 only moviews from categories Children and Family /////
--5 total amount to payments
--6 having total amount > = 100
--7 check and format the code

	
	
--
--8 add the order by
--
--9 format up sql code - online formatted
select film.title 									as movie_name,
       category.name 								as Genre,
       sum(payment.amount) 							as total_payment,
       sum(rental.return_date - rental.rental_date) as total_rental_time
  from payment
  join rental
    on (payment.rental_id      = rental.rental_id)
  join inventory
    on (inventory.inventory_id = rental.inventory_id)
  join film
    on (film.film_id           = inventory.film_id)
  join film_category
    on (film_category.film_id  = film.film_id)
  join category
    on (category.category_id   = film_category.category_id)
 where date_part('year', payment.payment_date) = '2007'
   and category.name in ( 'Children', 'Family' )
 group by film.title,
          category.name
having sum(payment.amount) > 100
 order by total_payment desc
	 
--
--Just get some code working :)


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
having sum(payment.amount) >= 100
order by 
	total_amount desc