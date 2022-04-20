----------------------------------------Find First and last movie rented from dvd rental!
--- for testing select of first date when customer made a purchase.


-- Taks
--select all people who didn't return their DVD's, show name, town, country, number of DVDs  

-- DVD rental schema - httpswww.postgresqltutorial.compostgresql-sample-database
-- SQL expressions joins, where, group by, having, etc


--So My general approach is start with some selects to explore tables.
--To see good the ER diagram of database with all tables and connections
--To see the road who connects all data, that I will use in this select statement

--To make some changes, test, check and extend - and to repeat this
--
--small changes and checks

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


-- DVD rental schema - httpswww.postgresqltutorial.compostgresql-sample-database
-- SQL expressions joins, where, group by, having, etc

--So My general approach is start with some selects to explore tables.
--To see good the ER diagram of database with all tables and connections
--To see the road who connects all data, that I will use in this select statement

--To make some changes, test, check and extend - and to repeat this
--
--small changes and checks

--1 get some working code

-- Taks
--select all people who didn't return their DVD's, show name, town, country, number of DVDs  

select rental.customer_id from rental 

select rental.customer_id 
from rental 

	
--2 get the joins right
select rental.customer_id 
from rental 
join customer on (customer.customer_id = rental.customer_id)
join address on (address.address_id = customer.address_id)
join city on (city.city_id = address.city_id)
join country on (country.country_id = city.country_id)
limit 10


	
--3 write any expressions, and verify them
select rental.customer_id, rental.return_date,
		case when rental.return_date is null then 1 else 0 end
from rental 
join customer on (customer.customer_id = rental.customer_id)
join address on (address.address_id = customer.address_id)
join city on (city.city_id = address.city_id)
join country on (country.country_id = city.country_id)

limit 10



--4 write any where clause expressions, and verify them
-- Taks
--select all people who didn't return their DVD's, show name, town, country, number of DVDs  

select 	rental.customer_id, customer.first_name, city.city, country.country,
		count(case when rental.return_date is null then 1 else 0 end)
from rental 
join customer on (customer.customer_id = rental.customer_id)
join address on (address.address_id = customer.address_id)
join city on (city.city_id = address.city_id)
join country on (country.country_id = city.country_id)
where rental.return_date is null --and rental.customer_id = 15
	group by 
		rental.customer_id,
		customer.first_name, 
		city.city, 
		country.country
limit 10

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

----------------------------------------------- 

select * from (
				select 	sum(rental.customer_id) as customer_id, 
		sum(CASE WHEN rental.return_date IS NULL THEN 1 ELSE 0 END) as rental_delay
from 	rental 
where 	rental.return_date is null
--group by 
--	rental.customer_id
order by
	rental_delay desc) as foo2
	

-----------------------------------------------------

select 	rental.customer_id as customer_id				, 
		customer.first_name								,
		count(CASE WHEN rental.return_date IS NULL THEN 1 ELSE 0 END) as rental_delay
from 	rental 
join 	customer on (customer.customer_id = rental.customer_id)
where 	rental.return_date is null
group by 
	rental.customer_id,
	customer.first_name
order by
	rental_delay desc


-----------------------------------------------------
select 	rental.customer_id as customer_id				, 
		customer.first_name								,
		city.city as town								,
		country.country									,
		count(CASE WHEN rental.return_date IS NULL THEN 1 ELSE 0 END) as rental_delay
from 	rental 
join 	customer on (customer.customer_id = rental.customer_id)
join 	address on (customer.address_id = address.address_id)
join 	city on (city.city_id = address.city_id)
join 	country on (country.country_id = city.country_id)
where 	rental.return_date is null
group by 
	rental.customer_id,
	customer.first_name,
	city.city,
	country.country
order by
	rental_delay desc
		

	