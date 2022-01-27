----------------------------------------Find First and last movie rented from dvd rental!
--- for testing select of first date when customer made a purchase.


-- Taks 3 - Select first rented movie and last rented movie per customer
-- first 10 results


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

-- Taks 3 - Select first rented movie and last rented movie per customer
-- first 10 results

select rental.customer_id from rental limit 10

select film.title  from film

--2 get the joins right



--3 write any expressions, and verify them
-- Taks 3 - Select first rented movie and last rented movie per customer
-- first 10 results


--------



------------------------------------------------

	
	
-----------------------



--3 write any expressions, and verify them
-- Taks 3 - Select first rented movie and last rented movie per customer
-- first 10 results

----------


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

with fisrt_watched_movie
  as (select rental.customer_id as customer1,
             film.title as first_movie
        from rental
        join inventory
          on (inventory.inventory_id = rental.inventory_id)
        join film
          on (film.film_id           = inventory.film_id)
       where rental.rental_id in (   select min(rental_id) as first_rental_id
                                       from rental
                                      group by customer_id )),
     last_watched_movie
  as (select rental.customer_id as customer2,
             film.title as last_movie
        from rental
        join inventory
          on (inventory.inventory_id = rental.inventory_id)
        join film
          on (film.film_id           = inventory.film_id)
       where rental.rental_id in (   select max(rental_id) as last_rental_id
                                       from rental
                                      group by customer_id ))
select fisrt_watched_movie.customer1 as customer_num,
       fisrt_watched_movie.first_movie,
       last_watched_movie.last_movie
  from fisrt_watched_movie
  join last_watched_movie
    on (last_watched_movie.customer2 = fisrt_watched_movie.customer1)


--Just get some code working )

		
