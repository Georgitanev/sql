#### Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.

https://www.hackerrank.com/challenges/revising-the-select-query/problem

The CITY table is described as follows:
...

### MY SQL

```sql
select * from city
where   countrycode ='USA'
and     population > 100000

```

#### name and population > 120000

```sql
select name from city
where   countrycode ='USA'
and     population > 120000
```


#### Query all columns (attributes) for every row in the CITY table.
```sql
select * from city
```


#### Query all columns for a city in CITY with the ID 1661.

```sql
select * from city
where   id = 1661
```

```sql
select * from city
where   id = 1661
```

#### Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
```sql
select * from city 
where COUNTRYCODE = 'JPN'
```

#### Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
```sql
select name from city 
where COUNTRYCODE = 'JPN'
```

#### Query a list of CITY and STATE from the STATION table.

```sql
select city, state from station
```


#### Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.

```sql
select  distinct city from station
where   id % 2 = 0
```
