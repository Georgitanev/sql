--https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial
--1.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

--2.
select name 
from world
where continent='Europe'
and gdp/population > (
select gdp/population 
from world
where name = 'United Kingdom'
)

--3.
select name, continent from world
where continent = 
(select continent from world
where name ='Argentina') 
or 
continent = 
(select continent from world
where name='Australia')
ORDER by name
--4.
select name, population
 from world
where population > 
(select population from world
where name='Canada')
and population <
(select population from world
where name='Poland')

--5.
SELECT 
  name, 
  CONCAT(ROUND((population*100)/(SELECT population 
                                 FROM world WHERE name='Germany'), 0), '%')
FROM world
where
continent = 'Europe'
--6.

select name from world
where gdp > ALL(select gdp
from world
where continent ='Europe' and
gdp>0)
--7.
SELECT continent, name, area 
  FROM world
 WHERE area IN (SELECT MAX(area) 
                  FROM world 
                 GROUP BY continent);
--8.

Select continent,name 
from world x
Where x.name <= ALL(select y.name from world y
                    where x.continent=y.continent)
ORDER BY continent

--9.
