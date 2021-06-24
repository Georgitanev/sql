--Lower vs upper with lower_index vs normal index
#### Postgresql is case sensitive - it makes a difference between lowercase and Uppercase
#### So in this case, we need to create lowercase index for searching with lowercase letters faster.

explain analyze shows the execution plan.
```sql
explain analyze
select  film.title 
from 	film
where 	film.title = 'Grosse Wonderful'


Index Only Scan using idx_title on film  (cost=0.28..8.29 rows=1 width=15) (actual time=0.040..0.041 rows=1 loops=1)
  Index Cond: (title = 'Grosse Wonderful'::text)
  Heap Fetches: 1
Planning Time: 0.134 ms
Execution Time: 0.070 ms
```

#### Creating index with lowercase :) for searching with lowercase letters faster in index!

```sql
CREATE INDEX films_title_lowercase_index
ON film (lower(title) ASC NULLS LAST);


explain analyze
select  film.title 
from 	film
where 	lower(film.title) = 'grosse wonderful'
order by 
		film.title
```
-- like is more faster than left

		
-- like vs left
```sql
explain analyze
select  film.title 
from 	film
where 	lower(film.title) like 'ab%'
order by 
		film.title
```
	

```sql
explain analyze
select  film.title 
from 	film
where 	film.title like 'Ab%'
order by 
		film.title
```		
	
```sql
CREATE EXTENSION pg_trgm;
```

```sql
-- creating index with gin and gin_trgm_ops for indexing trigrams for faster search with like 'abc%' for example
		
CREATE EXTENSION pg_trgm;

-- creating index with gin and gin_trgm_ops for indexing trigrams for faster search with like 'abc%' for example
CREATE INDEX idx_film_title_gin_lower ON film USING gin (lower(title) gin_trgm_ops);

explain analyze
select  film.title 
from 	film
where 	left(lower(film.title),2) = 'ab'
order by 
		film.title

-- When it's left() function, it makes seq scan, not index scan
  ->  Seq Scan on film  (cost=0.00..71.50 rows=5 width=15) (actual time=0.673..0.673 rows=0 loops=1)
-- When it's like 

-- like vs left
explain analyze
select  film.title 
from 	film
where 	lower(film.title) like 'ab%'
order by 
		film.title
		
  ->  Bitmap Heap Scan on film  (cost=20.04..35.55 rows=5 width=15) (actual time=0.017..0.017 rows=0 loops=1)
  ->  Bitmap Index Scan on idx_film_title_gin_lower  (cost=0.00..20.04 rows=5 width=0) (actual time=0.015..0.015 rows=0 loops=1)

```
-----------------------------------------------------

```sql
explain analyze
select  film.title, category.name
from 	film join 	film_category	on (film.film_id 				= film_category.film_id)
			 join	category 		on (film_category.category_id 	= category.category_id)
where 	lower(film.title) like 'ac%'
order by film.title, category.name desc
limit 20
```

```sql
explain analyze
select  film.title, payment.amount
from 	film 		join 	inventory	on
 							(film.film_id 			= inventory.film_id)
					join	rental 		on
 							(inventory.inventory_id = rental.inventory_id)
 					join 	payment		on
	 						(rental.rental_id		= payment.rental_id)
where 		lower(film.title) like 'ac%'
		and	payment.amount > 5

order by film.title desc
limit 20
```


```sql
select  film.title, payment.amount
from 	film 		
					join 	inventory	on
 							(film.film_id 			= inventory.film_id)
					join	rental 		on
 							(inventory.inventory_id = rental.inventory_id)
 					join 	payment		on
	 						(rental.rental_id		= payment.rental_id)
where 		lower(film.title) 	like 	'a%'
		and	payment.amount 		> 5 	and payment.amount < 7

group by film.title, payment.amount
order by film.title desc
limit 200
```

```sql
select 			c."name", avg(f.rental_rate), count(f.film_id)
from 			category 		as c
left 	join 	film_category 	as fc 	on (fc.category_id	= c.category_id)
left 	join 	film 			as f 	on (f.film_id		= fc.film_id)
group by 		c."name"
having 			avg(f.rental_rate)>2 	and count(f.film_id)>5;

select name from category limit 100
```

