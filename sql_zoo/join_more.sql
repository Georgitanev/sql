--https://sqlzoo.net/wiki/More_JOIN_operations

--1.

--5.(What is the id of the film 'Casablanca')

select id from movie where title='Casablanca'

--6.
--List of all actor for movie 'Casablanca'

select 	name 
from 	actor JOIN casting ON(actor.id=casting.actorid)
where 	casting.movieid=11768

--7.
--Obtain the cast list for the film 'Alien'

SELECT 	name
FROM 	actor
JOIN 	casting ON (actor.id=casting.actorid AND casting.movieid 
		= (SELECT movie.id FROM movie WHERE title = 'Alien'))

--8.
--List the films in which 'Harrison Ford' has appeared

select 	movie.title 
from 	movie JOIN casting ON(movie.id=casting.movieid)
WHERE 	casting.actorid = 
		(select actor.id 
			from actor 
			where actor.name ='Harrison Ford')

--9.
--List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]


select 	movie.title 
from 	movie JOIN casting ON(movie.id=casting.movieid)
WHERE 	casting.actorid = 
		(select actor.id 
			from actor where actor.name ='Harrison Ford' AND ord !=1) 

--10.List the films together with the leading star for all 1962 films.

SELECT 	title, name
FROM 	movie JOIN casting 	ON (id=movieid) 
			  JOIN actor 	ON (actor.id = actorid)
WHERE yr=1962 and ord=1

--11.


###
--for help
--https://github.com/jisaw/sqlzoo-solutions/blob/master/more-join.sql