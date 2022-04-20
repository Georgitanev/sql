WITH t1 AS (
		SELECT f.title as film_title,
	         c.name AS category_name,
			     NTILE(4) OVER (ORDER BY f.rental_duration) AS standard_quartile
		 FROM film f
		 JOIN film_category as fc
		USING (film_id)
		 JOIN category c
		USING (category_id)
)
  SELECT DISTINCT * 
   FROM (
   SELECT category_name,
	        standard_quartile,
	        COUNT(film_title) 
	        OVER(PARTITION BY standard_quartile ORDER BY category_name)
    FROM t1
   WHERE category_name 
      IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
ORDER BY 1) sub