--https://sqlzoo.net/wiki/SELECT_from_Nobel_Tutorial
--1.
SELECT 	yr, subject, winner
FROM 	nobel
WHERE 	yr = 1950

--2.
SELECT 	winner
FROM 	nobel
WHERE 	yr = 1962
AND 	subject = 'Literature'

--3.
select 	yr, subject
from 	nobel
where 	winner='Albert Einstein'

--4.
select 	winner from nobel
where 	yr >=2000 and subject = 'Peace'

--5.
select 	yr, subject, winner 
from 	nobel
where	subject='Literature'
		and 	yr >= 1980
		and 	yr <= 1989

--6.

SELECT * 
FROM nobel
WHERE winner in ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama')

--7.

select 	winner 
from 	nobel
where 	winner like 'John%'

--8.

select 	yr, subject, winner 
from 	nobel
where			subject = 'Physics'
		and 	yr 		= 1980
		or 		subject = 'Chemistry'
		and		yr 		= '1984'

--9.

select 	yr, subject, winner
from 	nobel
where		yr 		= 	1980	
		and	subject != 'Chemistry' 
		and subject != 'Medicine'

--10.

select 	yr, subject, winner 
from 	nobel
where		(subject= 'Medicine' 	and 	yr < 1910) 
		or	(subject='Literature'  	and 	yr >=2004)

--11.

select * 
from 	nobel
where	winner='PETER GRÜNBERG'

--12.

SELECT * FROM nobel
WHERE 
winner = 'Eugene O''neill'

--13.

select 	winner, yr, subject 
from 	nobel
where 	winner like 'Sir%'
ORDER BY yr DESC, winner

--14.

SELECT winner, subject 
FROM 	nobel
WHERE 	yr = 1984 
ORDER BY 
	CASE WHEN subject IN ('Chemistry', 'Physics') THEN 2 ELSE 1 END, subject, winner