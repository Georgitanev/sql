select all from employeedemographics

```sql
select * from employeedemographics
```

only unique employeeid or gender
```sql
select distinct(employeeid) from employeedemographics
select distinct(gender) 	from employeedemographics
```

count lastname if exist

```sql
select count(lastname) as last_name from employeedemographics

select max(salary) from employeesalary
select min(salary) from employeesalary
select avg(salary) from employeesalary
```

-------------------
where statement

```sql
select * from employeedemographics
where age >= 30 and gender = 'Male'
```

```sql
select * from employeedemographics
where age >= 30 or gender = 'Male'
```

```sql
select * from employeedemographics
where lower(lastname) like 's%'
```

```sql
select * from employeedemographics
where lower(lastname) like '%s%'
```

```sql
select * from employeedemographics
where lower(lastname) like 's%o%'
```

```sql
select * from employeedemographics
where lower(lastname) like 's%o%'
```
	
```sql
select * from employeedemographics
where firstname is not null
```

```sql
select * from employeedemographics
where firstname ='Jim'
```

```sql
select * from employeedemographics
where firstname in ('Jim', 'Michael')
```

--group by auto distinct values:
--Group by, order by

```sql
select 		gender 
from 		employeedemographics
group by 	gender
```

```sql
select 		gender, count(gender)
from 		employeedemographics
group by 	gender
```
```sql
distincted
gender	count
Female		3
Male		6
```
```sql
select 		gender, count(gender)
from 		employeedemographics
where 		age > 31
group by 	gender
```
```sql
Male		3
Female		1
```

asc order by default - увеличаващ се ред

```sql
select 		gender, count(gender) as count_gender
from 		employeedemographics
where 		age > 31
group by 	gender
order by 	gender
```

```sql
Female	1
Male	3
```

Descending - намаляващ

```sql
select 		gender, count(gender) as count_gender
from 		employeedemographics
where 		age > 31
group by 	gender
order by 	gender desc
```

```sql
Male		3
Female		1
```

```sql
select 		*
from 		employeedemographics
order by 	age desc, gender desc 	-- z to a
```

```sql
select 		*
from 		employeedemographics
order by 	4 desc, 5 desc			-- column numbers
```

