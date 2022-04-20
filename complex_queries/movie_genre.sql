select category.name, count(film.film_id) from category
join film_category on (film_category.category_id = category.category_id)
join film 		on (film.film_id = film_category.film_id)
group by category.name
	

select category.name, count(film.film_id) as number_of_movies from category
join film_category on (film_category.category_id = category.category_id)
join film 		on (film.film_id = film_category.film_id) 
--where category.name in ('Music')
group by category.name
order by category.name
limit 120


--group by category.name


-------------------------------------------------------------------------------------------


select customer.customer_id,
             TRIM(CONCAT(customer.first_name, ' ', customer.last_name)) as customer_name,
             sum(payment.amount) as total_amount--,cte_sales.Genre--, cte_sales.total_sales
        from customer
        join payment on (payment.customer_id=customer.customer_id)
        group by 
	        customer.customer_id,
	        customer_name
	    order by total_amount desc
		    limit 500
		    
	        
	        
        
        
        