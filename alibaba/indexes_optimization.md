#### alibaba query optimiz

--alibaba query optimiz
--https://alibaba-cloud.medium.com/principles-and-optimization-of-5-postgresql-indexes-btree-hash-gin-gist-and-brin-4d133e7f1842

#### For explain plan in dbeaver use CTRL+SHIFT+E
#### Try insert several times intil it's made without an error!

```sql
create table tbl_label(uid int primary key, c1 int, c2 text, c3 numeric, c4 timestamp, c5 interval, c6 int);  


insert into tbl_label select 	id					,   
								random()*10000		, 
								md5(random()::text)	,   
								10000*random()		, 
								clock_timestamp()	,   
								(random()*1000::int||' hour')::interval,   
								random()*99999   
								from 	generate_series(1,10000000) t(id);  
```

--Updated Rows	10000000
--Finish time	Fri Jun 18 21:02:07 EEST 2021

```sql
select * from tbl_label limit 10;
```
--truncate tbl_label 	-- empty 	table
--delete tbl_label		-- delete 	table
analyze tbl_label;  

--Updated Rows	0
--Query	analyze tbl_label ;  
--ANALYZE  
--Finish time	Fri Jun 18 20:26:28 EEST 2021


--Check the hash degree for each column:

--Description of n_distinct  
--  
---1 indicates that each row in the column is unique.  
--  
-->=1 indicates the number of unique values in the column  
--  
--<1 indicates the number/total number of unique values in the column    
--  
--Description of correlation  
--It indicates the linear correlation between this column and the data stack storage, where 1 indicates perfect positive correlation. As the value gets closer to 0, the data distribution is more discrete. <0 indicates an inverse correlation.  
--  
--Uid is auto-increment, c4 increases by time, so the correlation is 1, a perfect positive correlation.  

```sql
select tablename,attname,n_distinct,correlation from pg_stats where tablename='tbl_label'; 
```

--tablename		attname		n_distinct	correlation
--tbl_label		uid			-1			0.99909395
--tbl_label		c1			9948		0.0034751222
--tbl_label		c2			-1			-0.0014111185
--tbl_label		c3			-1			0.0036791798
--tbl_label		c4			-1			0.99909395
--tbl_label		c5			-1			0.0000107693995
--tbl_label		c6			101569		-0.0058178236

```sql
select sum(pg_column_size(1)) from tbl_label
```

--40 000 000
```sql
SELECT
   relname  as table_name,
   pg_size_pretty(pg_total_relation_size(relid)) As "Total Size",
   pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid)) as "Index Size",
   pg_size_pretty(pg_relation_size(relid)) as "Actual Size"
   FROM 	pg_catalog.pg_statio_user_tables 
   where 	relname = 'tbl_label'
ORDER BY pg_total_relation_size(relid) DESC;
```

--table_name		Total Size	Index Size	Actual Size
--tbl_label			1331 MB		215 MB		1116 MB

```sql
explain (analyze,verbose,timing,costs,buffers) select * from tbl_label where c1 between 1 and 80
```
--Execution Time: 17405.382 ms	-- 40 	mil (all rows)

```sql
explain (analyze,verbose,timing,costs,buffers) select * from tbl_label where c1 between 1 and 100 and c6=100 and c2='abc'; 
```

--no idexes
--Gather  (cost=1000.00..227191.43 rows=1 width=80) (actual time=17222.887..17237.991 rows=0 loops=1)
--  Output: uid, c1, c2, c3, c4, c5, c6
--  Workers Planned: 2
--  Workers Launched: 2
--  Buffers: shared hit=24814 read=118044
--  I/O Timings: read=47654.384
--  ->  Parallel Seq Scan on public.tbl_label  (cost=0.00..226191.33 rows=1 width=80) (actual time=17202.470..17202.471 rows=0 loops=3)
--        Output: uid, c1, c2, c3, c4, c5, c6
--        Filter: ((tbl_label.c1 >= 1) AND (tbl_label.c1 <= 100) AND (tbl_label.c6 = 100) AND (tbl_label.c2 = 'abc'::text))
--        Rows Removed by Filter: 3333333
--        Buffers: shared hit=24814 read=118044
--        I/O Timings: read=47654.384
--        Worker 0: actual time=17193.590..17193.592 rows=0 loops=1
--          Buffers: shared hit=8281 read=39339
--          I/O Timings: read=15859.890
--        Worker 1: actual time=17196.841..17196.842 rows=0 loops=1
--          Buffers: shared hit=8248 read=39096
--          I/O Timings: read=15884.615
--Planning Time: 5.511 ms
--Execution Time: 17238.026 ms
```sql
create index idx_tbl_label2 on tbl_label using btree(c2);

explain (analyze,verbose,timing,costs,buffers) select * from tbl_label where c1 between 1 and 100 and c6=100 and c2='abbc';
```
--only BTree index on c2

--Index Scan using idx_tbl_label2 on public.tbl_label  (cost=0.56..8.59 rows=1 width=80) (actual time=1.151..1.152 rows=0 loops=1)
--  Output: uid, c1, c2, c3, c4, c5, c6
--  Index Cond: (tbl_label.c2 = 'abbc'::text)
--  Filter: ((tbl_label.c1 >= 1) AND (tbl_label.c1 <= 100) AND (tbl_label.c6 = 100))
--  Buffers: shared hit=3 read=1
--  I/O Timings: read=1.103
--Planning Time: 0.105 ms
--Execution Time: 1.175 ms
--
--FASTER 10 000 times faster from (17238.026 ms)

-- second execution:
--Index Scan using idx_tbl_label2 on public.tbl_label  (cost=0.56..8.59 rows=1 width=80) (actual time=0.031..0.032 rows=0 loops=1)
--  Output: uid, c1, c2, c3, c4, c5, c6
--  Index Cond: (tbl_label.c2 = 'abbc'::text)
--  Filter: ((tbl_label.c1 >= 1) AND (tbl_label.c1 <= 100) AND (tbl_label.c6 = 100))
--  Buffers: shared hit=4
--Planning Time: 0.103 ms
--Execution Time: 0.053 ms

--FASTER
--Creating gin index

```sql
create index idx_tbl_label_1 on tbl_label using gin(c1,c6);
```

explain (analyze,verbose,timing,costs,buffers) select * from tbl_label where c1 between 1 and 100 and c6=100 and c2='abbc'; 
-- GIN + B-tree index on c2:
--Index Scan using idx_tbl_label2 on public.tbl_label  (cost=0.56..8.59 rows=1 width=80) (actual time=0.028..0.029 rows=0 loops=1)
--  Output: uid, c1, c2, c3, c4, c5, c6
--  Index Cond: (tbl_label.c2 = 'abbc'::text)
--  Filter: ((tbl_label.c1 >= 1) AND (tbl_label.c1 <= 100) AND (tbl_label.c6 = 100))
--  Buffers: shared hit=4
--Planning Time: 0.123 ms
--Execution Time: 0.052 ms
--NO difference with GIN index !!!!!!!!!!!!!! on c1 and c6 - it's not using it at all -> Index Cond: (tbl_label.c2 = 'abbc'::text)

```sql
explain (analyze,verbose,timing,costs,buffers) select * from tbl_label where c1 between 55 and 57 and c6=10000 and c2='abbc';
```
-- no sense to use:
--create index idx_tbl_label_c1c2c6 on tbl_label using btree(c1,c2,c6);


explain (analyze,verbose,timing,costs,buffers) select * from tbl_label where c1 between 55 and 57 and c6=10000
--explain (analyze,verbose,timing,costs,buffers) select * from tbl_label where c1 between 55 and 57 and c6=10000
--  Buffers: shared hit=4193 read=138665
--  I/O Timings: read=49014.102
--  ->  Parallel Seq Scan on public.tbl_label  (cost=0.00..215774.67 rows=1 width=80) (actual time=17616.666..17616.668 rows=0 loops=3)
--        Output: uid, c1, c2, c3, c4, c5, c6
--        Filter: ((tbl_label.c1 >= 55) AND (tbl_label.c1 <= 57) AND (tbl_label.c6 = 10000))
--        Rows Removed by Filter: 3333333
--        Buffers: shared hit=4193 read=138665
--        I/O Timings: read=49014.102
--        Worker 0: actual time=17607.656..17607.658 rows=0 loops=1
--          Buffers: shared hit=1406 read=46248
--          I/O Timings: read=16252.906
--        Worker 1: actual time=17605.280..17605.281 rows=0 loops=1
--          Buffers: shared hit=1392 read=45978
--          I/O Timings: read=16382.295
--Planning Time: 0.793 ms
--Execution Time: 17647.221 ms

explain (analyze,verbose,timing,costs,buffers) select * from tbl_label where c1 between 55 and 57 and c6=10000
-- WITH GIN index:
--explain (analyze,verbose,timing,costs,buffers) select * from tbl_label where c1 between 55 and 57 and c6=10000
--Bitmap Heap Scan on public.tbl_label  (cost=92.00..96.02 rows=1 width=80) (actual time=411.912..411.914 rows=0 loops=1)
--  Output: uid, c1, c2, c3, c4, c5, c6
--  Recheck Cond: ((tbl_label.c1 >= 55) AND (tbl_label.c1 <= 57) AND (tbl_label.c6 = 10000))
--  Buffers: shared hit=13979
--  ->  Bitmap Index Scan on idx_tbl_label_1  (cost=0.00..92.00 rows=1 width=0) (actual time=411.906..411.906 rows=0 loops=1)
--        Index Cond: ((tbl_label.c1 >= 55) AND (tbl_label.c1 <= 57) AND (tbl_label.c6 = 10000))
--        Buffers: shared hit=13979
--Planning Time: 0.131 ms
--Execution Time: 411.975 ms
-- FASTER - not filter by b-tree column need index on c1 and c6 for faster search!!!

```sql
create index idx_tbl_label_btree_c1_c6 on tbl_label using btree(c1, c6);
explain (analyze,verbose,timing,costs,buffers) select * from tbl_label where c1 between 55 and 57 and c6=10000
```

--Index Scan using idx_tbl_label_btree_c1_c6 on public.tbl_label  (cost=0.43..78.62 rows=1 width=80) (actual time=5.616..5.617 rows=0 loops=1)
--  Output: uid, c1, c2, c3, c4, c5, c6
--  Index Cond: ((tbl_label.c1 >= 55) AND (tbl_label.c1 <= 57) AND (tbl_label.c6 = 10000))
--  Buffers: shared hit=2 read=9
--  I/O Timings: read=5.029
--Planning Time: 12.626 ms
--Execution Time: 5.651 ms
--Btree is faster than GIN index!!! PROVED

-- second execution:
--Index Scan using idx_tbl_label_btree_c1_c6 on public.tbl_label  (cost=0.43..78.62 rows=1 width=80) (actual time=0.116..0.116 rows=0 loops=1)
--  Output: uid, c1, c2, c3, c4, c5, c6
--  Index Cond: ((tbl_label.c1 >= 55) AND (tbl_label.c1 <= 57) AND (tbl_label.c6 = 10000))
--  Buffers: shared hit=11
--Planning Time: 0.153 ms
--Execution Time: 0.137 ms

```sql
create index idx_tbl_label_1 on tbl_label using gin(c1,c6);

explain (analyze,verbose,timing,costs,buffers) select * from tbl_label where c1 between 55 and 57 and c6=10000
```

--same speed:
--Execution Time: 0.138 ms

--NOT a big difference in size:
--Btree 	on c1, c6 = 214MB
--GIN 		on c1, c6 = 161MB

```sql
create index idx_tbl_label_c2 on tbl_label using gin(c2);
```

--GIN Index ON c2 is BIGGER THAN BTREE INDEX => idx_tbl_label_c2 819MB (GIN) VS 563MB (BTREE)
--c2 -> 085c47feb8c2978ed0099c97115efd92 - text
--GIN is not efficient this time!!!!!!!!!
```sql
explain (analyze,verbose,timing,costs,buffers) select * from tbl_label where c1 between 55 and 57 and c6 in (10000, 8888) --chosed gin
```

--GIN 	INDEX
--Execution Time: 459.695 ms
--BTREE INDEX
--Execution Time: 12.286 ms

--Btree is ~ x40 times faster

