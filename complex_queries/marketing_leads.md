
### Get unique leads

Below you will find 3 tables. Based on these tables, build a query to calculate, for each website name, the number of unique leads that were created. 
A lead will be considered unique only on the first lead event for that email in the system. If the same email will have a later lead event from another website it will not count as unique. 

![N|Solid](https://github.com/Georgitanev/sql/blob/master/complex_queries/leads_schema.png?raw=true)

1. Step 1

```sql
select * from websites
```

#### 2. JOINS
```sql
select * from websites
join advertisements on websites.website_id 				= advertisements.website_id
join leads 			on advertisements.advertisement_id	= leads.advertisement_id
```
![Build Status](https://github.com/Georgitanev/sql/blob/master/complex_queries/joins.png?raw=true)

## 2.  select leads
```sql
select * from leads
```
##  3 select over by gives only minimum (first) event_id for every used e-mail.
```sql
select distinct min(event_id) over (partition by email) as eid, email, advertisement_id from leads
```
![Build Status](https://github.com/Georgitanev/sql/blob/master/complex_queries/event_id.png?raw=true)

## 4 selectig advertisement_id, and count repeated id's as unique leads where event id is only first one

```sql
select advertisement_id, count(advertisement_id) as u_leads from leads
		where event_id in (select distinct min(event_id) 
							over (partition by email) as eid from leads)
							group by advertisement_id
```

## 5. Replace leads with CTE_leads (window works only if there is select from window (CTE_leads) ) 
```sql
with CTE_leads as (
		select advertisement_id, count(advertisement_id) as u_leads from leads
		where event_id in (select distinct min(event_id) 
							over (partition by email) as eid from leads)
							group by advertisement_id)
							
select website_name, CTE_leads.u_leads from websites
join advertisements on websites.website_id 				= advertisements.website_id
--join leads 			on advertisements.advertisement_id	= leads.advertisement_id -- commented
join CTE_leads 			on advertisements.advertisement_id	= CTE_leads.advertisement_id
```

## 6. Clean working code + case statement
##### when not null then CTE_leads.u_leads else 0

```sql
with CTE_leads as (
		select advertisement_id, count(advertisement_id) as u_leads from leads
		where event_id in (select distinct min(event_id) 
							over (partition by email) as eid from leads)
							group by advertisement_id)
							
select website_name,
case
	when CTE_leads.u_leads is not null then CTE_leads.u_leads
	else 								0
end 									unique_leads

 from websites
left join advertisements 		on websites.website_id 				= advertisements.website_id
left join CTE_leads 			on advertisements.advertisement_id	= CTE_leads.advertisement_id
```
![Build Status](https://github.com/Georgitanev/sql/blob/master/complex_queries/final_marketing.png?raw=true)
