-- Query optimization

--select columns by their names not * 
--limit results to what you really need.


explain analyze
	
select * from customer --0.146 ----------------------3.394 -- with order by 0.489 -- 0.149 -- 599 rows 
						--Execution Time: 0.275 ms
order by 
	last_name -- 1.357
	
	
limit 10

select 
customer_id,
store_id,
last_name,
first_name,
email,
address_id,
activebool,
create_date,
last_update,
active
from customer   ---0.224 -- 0.017
--order by 
--	last_name -- 1.531
limit 10


