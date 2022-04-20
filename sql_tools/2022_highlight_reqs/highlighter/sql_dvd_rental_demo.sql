--https://sqlformat.org/#:~:text=%20SQLFormat%20is%20a%20free%20online%20formatter%20for,service%20to%20use%20it%20in%20your%20own%20applications.
SELECT film.title,
       category.name,
       inventory.film_id,
       rental.rental_date,
       payment.amount
FROM film
JOIN film_category  ON film.film_id                 = film_category.film_id
JOIN category       ON film_category.category_id    = category.category_id
JOIN inventory      ON inventory.film_id            = film.film_id
JOIN rental         ON rental.inventory_id          = inventory.inventory_id
JOIN payment        ON payment.customer_id          = rental.customer_id
WHERE --film.title 			like 'a%' 		and
 LOWER (category.name) like 'c%'
  AND rental.rental_date> '2005-10-08' AND payment.amount> 6 AND payment.amount< 8
LIMIT 20
