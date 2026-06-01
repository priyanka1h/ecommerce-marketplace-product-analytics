/*geography analysis*/

select DISTINCT customer_state,
customer_city
from customers
order by customer_state asc, customer_city asc;

/* customer concentration by region - depicting states with highest no of customers */
select count(DISTINCT customer_unique_id) as total_customer,
customer_state
from customers
group by customer_state
order by total_customer desc;

/* depicting under particular state which city has highest no of customers - to identidy top markets */
select count(DISTINCT customer_unique_id) as total_cust,
customer_city
from customers
group by customer_city
order by total_cust desc;

/* identifying demand market */
select customer_state,
count(order_id) as total_orders
from customers c
join orders o
on c.customer_id = o.customer_id
group by customer_state
order by total_orders desc;

/* identifying revenue value markets */
select c.customer_city,
 sum(o_item.price) as total_gmv
from customers c
join orders o
on c.customer_id = o.customer_id
join order_items as o_item
on o.order_id = o_item.order_id
   group by c.customer_city
   order by total_gmv desc;
   
/* Analysing AOV to understand purchase pattern - avg amount spent per order*/
select DISTINCT c.customer_state,
c.customer_city,
avg(o_item.price) as avg_order_value
from customers c
join orders o
on c.customer_id = o.customer_id
join(
  select order_id,
  price
  from order_items
) o_item
on o.order_id = o_item.order_id
group by c.customer_state, c.customer_city
order by avg_order_value desc;
/* This depicts highest customer, orders and GMV was from SP - state and sao paulo city, but avg is highest from PB and pianco city */

/* cancelation analysis */
select c.customer_state,
count(*) as canceletion_region
from customers c
join orders o
on c.customer_id = o.customer_id
WHERE order_status = 'canceled'
group by customer_state
order by canceletion_region desc;

/* delivery delays to track SLA analysis */
select customer_city,
avg(DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date)) as avg_delay
from customers c
join orders o
on c.customer_id = o.customer_id
group by customer_city
order by avg_delay desc;

/* states with highest repeat customer count - retention anaylsys */
select customer_state,
count(*) as repeat_customer
from (
   select 
   c.customer_state,
   c.customer_unique_id
   from customers c
   join orders o
   on c.customer_id = o.customer_id
   group by c.customer_state, c.customer_unique_id
   having count(DISTINCT o.order_id > 1)
) t
group by customer_state
order by repeat_customer desc;

/* cities with high revenue and high shipping cost */
select c.customer_city,
sum(o_item.price) as high_price,
sum(o_item.freight_value) as high_freight
from customers c
join orders o
on c.customer_id = o.customer_id
join order_items as o_item
   on o.order_id = o_item.order_id
group by customer_city
order by high_price desc, high_freight desc;










