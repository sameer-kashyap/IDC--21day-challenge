## Phase 1: Foundation & Inspection

-- List all unique pizza categories (DISTINCT).
select 
	distinct category 
from pizza_types;

-- Display pizza_type_id, name, and ingredients, replacing NULL ingredients with "Missing Data". Show first 5 rows.
select pizza_type_id , name ,coalesce(ingredients,"Missing Data") as ingredients
from pizza_types
order by name
limit 5;

-- Check for pizzas missing a price (IS NULL).
select pizza_id 
from pizzas 
where price is NULL;


## Phase 2: Filtering & Exploration
-- Orders placed on '2015-01-01' (SELECT + WHERE).

select * 
from orders 
where date = '2015-01-01';

-- List pizzas with price descending.
select * 
from pizzas
order by price desc;

-- Pizzas sold in sizes 'L' or 'XL'.

select * 
from pizzas 
where size in ('L','XL');

-- Pizzas priced between $15.00 and $17.00.
select * 
from pizzas 
where price between 15 and 17;



-- Pizzas with "Chicken" in the name.
select * 
from pizza_types
where name like '%Chicken%';







-- Orders on '2015-02-15' or placed after 8 PM.
select * 
from orders 
where date = '2015-02-15' 
or time > '20:00:00';

## Phase 3: Sales Performance
-- Total quantity of pizzas sold (SUM).

select sum(quantity) as total_quantity
from order_details;

-- Average pizza price (AVG).
select avg(price) as avg_Price
from pizzas;

-- Total order value per order (JOIN, SUM, GROUP BY).

select order_id , sum(quantity*price)
from pizzas p 
join order_details o 
on p.pizza_id = o.pizza_id
group by order_id ;

-- Total quantity sold per pizza category (JOIN, GROUP BY).
select pt.category, sum(quantity) as quantity_sold
from order_details od
join pizzas p 
on od.pizza_id = p.pizza_id
join pizza_types pt 
on p.pizza_type_id = pt.pizza_type_id
group by pt.category;

-- Categories with more than 5,000 pizzas sold (HAVING).
select pt.category, sum(quantity) as quantity_sold
from order_details od
join pizzas p 
on od.pizza_id = p.pizza_id
join pizza_types pt 
on p.pizza_type_id = pt.pizza_type_id
group by pt.category
having quantity_sold>5000;

-- Pizzas never ordered (LEFT/RIGHT JOIN).
select p.* ,od.order_details_id
from pizzas p
left join order_details od 
on p.pizza_id = od.pizza_id
where od.order_details_id is NULL;

-- Price differences between different sizes of the same pizza (SELF JOIN).
SELECT p1.pizza_type_id, p1.size AS size_a, p2.size AS size_b, (p1.price - p2.price) AS price_diff 
FROM pizzas p1 
JOIN pizzas p2 ON p1.pizza_type_id = p2.pizza_type_id 
AND p1.size <> p2.size
where (p1.price - p2.price) >0
ORDER BY p1.pizza_type_id, ABS(p1.price - p2.price) DESC;

















