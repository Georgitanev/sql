--https://sqlzoo.net/wiki/SELECT_from_WORLD_Tutorial

--1.

SELECT name, continent, population FROM world

--2.
SELECT 	name 
FROM 	world
WHERE 	population > 200000000

--3.
select 	name, gdp/population 
from 	world
where   population > 200000000

--4.
select name, population/1000000  
from 	world
where	continent = 'South America'

--5.
select 	name, population 
from 	world
where	name in ('France', 'Germany', 'Italy')

--6.
select 	name 
from 	world
where 	name like 'United%'

--7.
select 	name, population, area
from 	world
where	area > 3000000 or population > 250000000

--8.
select 	name, population, area
from 	world
where	area > 3000000 xor population > 250000000

--9.
select 	name, round(population/1000000, 2) , round(gdp/1000000000, 2) 
from 	world
where	continent='South America'

--10.
select 	name, round(gdp/population, -3) 
from 	world
where	gdp > 1000000000000

--11.
SELECT 	name, capital
FROM 	world
WHERE	LENGTH(name) = LENGTH(capital)

--12.
SELECT 	name, capital 
from 	world
where	LEFT(name,1) = LEFT(capital,1)
and		name <> capital

--13.
SELECT 	name
FROM 	world
WHERE 	name NOT LIKE '% %'
	AND name LIKE '%a%'  
	AND name LIKE '%e%' 
	AND name LIKE '%i%' 
	AND name LIKE '%o%' 
	AND name LIKE '%u%' 

