1 -- select title, category name, film id, rental date, payment amount


--Basic order of statements is:

--1 Select from JOINS where group by having order by

--2 get some working code
--
--3 get the joins right
--
--4 write any expressions, and verify them
-- 
--5 write any where clause expressions, and verify them
--
--6 arrange the columns and rows in preparation for grouping
--
--7 add the grouping visually verify
--
--8 add the having
--
--9 add the order by
--
--10 format up sql code
--
--Just get some code working :)


select 		film.title, category.name, inventory.film_id, rental.rental_date, payment.amount
from 		film  	join film_category 	on film.film_id 				= film_category.film_id
					join category 		on film_category.category_id 	= category.category_id
					join inventory 		on inventory.film_id 			= film.film_id
					join rental 		on rental.inventory_id 			= inventory.inventory_id
					join payment 		on payment.customer_id 			= rental.customer_id

			where 	--film.title 			like 'a%' 		and
					lower(category.name) 	like 'c%' 		and
				 	rental.rental_date 	> 	'2005-10-08' 	and
					payment.amount 		> 	6				and payment.amount < 8
															limit 20