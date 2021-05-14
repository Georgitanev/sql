select all from employeedemographics

```
select * from employeedemographics
```

only unique employeeid or gender
```
select distinct(employeeid) from employeedemographics
select distinct(gender) 	from employeedemographics
```

count lastname if exist

```
select count(lastname) as last_name from employeedemographics

select max(salary) from employeesalary
select min(salary) from employeesalary
select avg(salary) from employeesalary
```

-------------------
where statement

```
select * from employeedemographics
where age >= 30 and gender = 'Male'
```

```
select * from employeedemographics
where age >= 30 or gender = 'Male'
```

```
select * from employeedemographics
where lower(lastname) like 's%'
```

```
select * from employeedemographics
where lower(lastname) like '%s%'
```

```
select * from employeedemographics
where lower(lastname) like 's%o%'
```

```
select * from employeedemographics
where lower(lastname) like 's%o%'
```
	
```
select * from employeedemographics
where firstname is not null
```

```
select * from employeedemographics
where firstname ='Jim'
```

```
select * from employeedemographics
where firstname in ('Jim', 'Michael')
```

--group by auto distinct values:
--Group by, order by

```
select 		gender 
from 		employeedemographics
group by 	gender
```

```
select 		gender, count(gender)
from 		employeedemographics
group by 	gender
```

--distincted
--gender	count
--Female	3
--Male		6

```
select 		gender, count(gender)
from 		employeedemographics
where 		age > 31
group by 	gender
```
--Male		3
--Female	1


asc order by default - увеличаващ се ред

```
select 		gender, count(gender) as count_gender
from 		employeedemographics
where 		age > 31
group by 	gender
order by 	gender
```

--Female	1
--Male		3


Descending - намаляващ

```
select 		gender, count(gender) as count_gender
from 		employeedemographics
where 		age > 31
group by 	gender
order by 	gender desc
```

--Male		3
--Female	1

```
select 		*
from 		employeedemographics
order by 	age desc, gender desc 	-- z to a
```

```
select 		*
from 		employeedemographics
order by 	4 desc, 5 desc			-- column numbers
```

