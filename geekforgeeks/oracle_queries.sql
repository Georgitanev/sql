--emp and department tables run in Oracle
--https://livesql.oracle.com/apex/livesql/file/content_O5AEB2HE08PYEPTGCFLZU9YCV.html
--Worksheet
--https://livesql.oracle.com/apex/f?p=590:1:8208767158186::LEVEL1:RP::
--
--https://www.youtube.com/watch?v=-6v7ctxC7yk&list=PLqM7alHXFySGweLxxAdBDK1CcDEgF-Kwx&ab_channel=GeeksforGeeks

--(Only work in Oracle 3, )


--1. Find second highest salary of employee from emp table

select max(sal) from emp
where sal not in(select max(sal) from emp)

OR
select max(sal) from emp
where sal <(select max(sal) from emp)

--2. Department - high salary by department

select max(sal), deptno 
from emp
group by deptno;

2.1--(how many employees in each department?)
select count(*), deptno
from emp
group by deptno;

--3. Display alternate reccords (oracle only)

--(rownum)
select rownum, empno, sal, ename from emp;

--(order by salary desc)
select rownum, empno, sal, ename from emp
order by sal desc;

--(get rows who are with odd numbers !=/2 (1,3,5,...)
select * from 
    (select rownum rn, empno, ename, sal
        from emp
        order by rn)
        where mod (rn, 2) != 0;

--(same with even numbers)
select * from 
    (select rownum rn, empno, ename, sal
        from emp
        order by rn)
        where mod (rn, 2) = 0;

--4. Display duplicate of a column
--(in table there is no duplicated names of employees)
--(so you can search by job column where there is duplicates)

--(displays name, (number of repeating names of employees))

select ename, count(*)
from emp
group by ename;

--(job)
select job, count(*)
from emp
group by job;

--(duplicate values - name, count of repeats)

select ename, count(*)
from emp
group by ename
having count(*)>1;

--(job)
select job, count(*)
from emp
group by job
having count(*)>1;

--5. Pattern matching in SQL

--(select names who start with 'M'

select ename from emp
where ename like 'M%';

--(select names who Ends with 'N')
select ename from emp
where ename like '%N';

--(select names who have letter 'M' in the name)

select ename from emp
where ename like '%M%';

(not contain 'M' in name)

select ename from emp
where ename not like '%M%';

--6. Pattern searching in SQL

--6.1
--(Display names of all employees whose name contains
--exacly 4 letters)

select ename from emp
where ename like '____';

--6.2
--(Display names of all employees whose name contains
--the (i)second letter and 'L'(ii) fourth letter as 'M'

select ename from emp
where ename like '_L%';

select ename from emp
where ename like '___M%';

--6.3
--(Display the emloyee names and hire dates for
--the employees joined in the month of December)

select hiredate, ename from emp
where hiredate like '%DEC%';

--6.4
--(Display the names of employees whose name contains exactly 2 'L' s)

select ename from emp
where ename like '%LL%'

--6.5
--(Display the name of employees whose name starts with

select ename from emp
where ename like 'J%S'

--7. Display nth row in SQL

select * from emp
where rownum<=4
minus
select * from emp
where rownum<=3

--###
--OR

select * from 
(select rownum r,ename, sal from emp)
where r=4;

--###
--OR

select * from (select rownum r, emp.* from emp)
where r=4;

--7.1 Display 2nd, 3rd and 7nth records

select * from (select rownum r, emp.* from emp)
where r in (2,3,7);


--(IN MySQL)
SELECT 
    productCode, productName, buyPrice
FROM
    products
ORDER BY buyPrice DESC
LIMIT 4 , 1;
(start from row 4, limit 1 row after that (4) )
--(IN MySQL) END --


--8. Union vs uniun all
--(union eliminates duplicate values)
--(Must have:
--same numbers of columns
--compatible data types
--same logical order)

select city from sample1
union
select city from sample2

--(include duplicates)

select city from sample1
union all
select city from sample2

--9. inner JOIN

select ename, sal, dept.deptno,dname, loc
from emp,dept
where emp.deptno=dept.deptno;

--###

select ename,sal,d.deptno,dname,loc
from emp e,dept d
where e.deptno=d.deptno;

--(in Chicago)

select ename,sal,d.deptno,dname,loc
from emp e,dept d
where e.deptno=d.deptno
AND LOC='CHICAGO';

--(DEPARTMENT + SUM(salary))
select dname, sum(sal) from emp e, dept d
where e.deptno=d.deptno
group by dname;

--DNAME	SUM(SAL)
--RESEARCH	10875
--SALES	9400
--ACCOUNTING	8750

--10
--Self join











