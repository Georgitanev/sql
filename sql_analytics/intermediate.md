﻿#### JOINS

#### In dvd rental

#### Two tables
```sql
select 		*
from 		employeedemographics
```
```
select 		*
from 		employeesalary;
```

###### Showing everything with same id

```sql
select *
from 		employeedemographics
inner join 	employeesalary
		on 	employeedemographics.employeeid = employeesalary.employeeid
```

###### Select where name is not 'Michael' salary desc
	
```sql
select 		employeedemographics.employeeid, firstname, lastname
from 		employeedemographics
inner JOIN 	employeesalary
        on  employeedemographics.employeeid = employeesalary.employeeid
where 		firstname <> 'Michael'
order by 	Salary desc
```

###### Salesman salaries:

```sql
select 		jobtitle, salary
from 		employeedemographics
inner join 	employeesalary
		on 	employeedemographics.employeeid = employeesalary.employeeid
where 		jobtitle = 'Salesman'
```

###### group by average salary:

```sql
select 		jobtitle, avg(Salary)
from 		employeedemographics
inner join 	employeesalary
		on 	employeedemographics.employeeid = employeesalary.employeeid
where 		jobtitle = 'Salesman'
group by 	jobtitle
```

#### self join one name
```sql
SELECT
    e.first_name  employee,
    m.first_name  manager
FROM
    employee e
INNER JOIN 	employee m ON m.employee_id = e.manager_id
ORDER BY 	manager;
```

#### self join with as and order by
```sql
select		e.first_name as e_name,
			m.first_name as m_name
from 		employee 	 as e 
inner join 	employee 	 as m on m.employee_id = e.manager_id
order by 	e_name, m_name;
```


```sql
SELECT
    e.first_name  || ' ' || e.last_name employee,
    m.first_name  || ' ' || m.last_name manager
FROM
    employee e
INNER JOIN 	employee m ON m.employee_id = e.manager_id
ORDER BY 	manager;
```


### Unions
```sql
Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')
```


##### Table 3 Query:

```sql
Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)
```


##### Table 3 Insert:

```sql
Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')
```

```sql

select employeeid from employeedemographics
union 
select employeeid from employeesalary
```


#### case
```sql

select 	firstname, lastname, age,
case	-- first condition met :)
	when age = 31 then 	'he is 31 years old'
	when age > 30 then 	'Old'
	else 				'Yound'
end 					he_is
from 	employeedemographics
where 	age is not null
order by 
		age
```	

```sql

select 	firstname, lastname, jobtitle, salary
from 	employeedemographics
join 	employeesalary on employeedemographics.employeeid = employeesalary.employeeid
```

#### salary rasing with case statement
```sql

select 	firstname, lastname, jobtitle, salary,
case
	when jobtitle = 'Salesman' 		then salary + (salary * .10)
	when jobtitle = 'Accountant' 	then salary + (salary * .05)
	when jobtitle = 'HR' 			then salary + (salary * .000001)
	else								 salary + (salary * .03)
end as salary_after_raise
from 	employeedemographics
join 	employeesalary on employeedemographics.employeeid = employeesalary.employeeid
```






