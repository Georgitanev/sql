select  products.product_name						,
		products.product_id							,
		categories.category_name					,
		sum(od.quantity * od.unit_price * (1 - od.discount)) as product_revenue
from 	products
join 	categories 				on products.category_id 	= categories.category_id
join 	order_details as od 	on products.product_id 		= od.product_id
join 	orders 					on od.order_id 				= orders.order_id
where 	extract(year from orders.order_date) = 1996
group by 
	products.product_name	,
	products.product_id		,
	categories.category_name
having sum(od.quantity * od.unit_price * (1 - od.discount)) > 5000
order by 
	products.product_name	,
	products.product_id