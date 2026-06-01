/*total revenue generated from all order_item*/
select 
sum(price) as total_items
from order_items;

/*average_order_item_price*/
select
avg(price) as avg_order_item_price
from order_items;

/*total freight cost*/
select 
sum(freight_value) as total_freight_value
from order_items;

/*avg freight cost per item */
select
avg(freight_value) as avg_freight_cost
from order_items;

/*avg no of item per order*/
select 
avg(order_item_count) as avg_order_items
from
( 
  select
  order_id,
  count(*) as order_item_count
from order_items
group by order_id
)as t;

/* order with single item and multiple items - using CTE*/
With item_counts as (
select
 order_id,
 count(*) as item_count
 from order_items
 group by order_id
) 
select 
case
 when item_count = 1 then 'single_order_item'
 else 'multiple_order_item'
 end as order_type,
count(*) as total_order 
from item_counts
group by order_type;

select 
case 
when item_count = 1 then 'single_item'
else 'multiple_item'
end as order_type,
count(*) as total_orders
from(
select
order_id,
count(*) as item_count
from order_items
group by order_id
) t
group by order_type
order by total_orders desc;

/*orders with high no of order_items*/
select order_id,
count(*) as total_orders
from order_items
group by order_id
order by total_orders desc;

/*products generating high revenue */
select 
product_id,
round(
sum(price),2
)as high_revenue
from order_items
group by product_id
order by high_revenue desc;

/*products most frequently purchased*/
select product_id,
count(*) as most_frequently_purchased
from order_items
group by product_id
order by most_frequently_purchased desc;

/*sellers making highest revenue */
select seller_id,
round(
sum(price),
2
)as high_revenue
from order_items
group by seller_id
order by high_revenue desc;

/* sellers with high no of orders */
select 
seller_id,
count(DISTINCT order_id) as total_orders
from order_items
group by seller_id
order by total_orders desc;

/*order contributing high revenue - total order per value*/
select 
order_id,
round(
sum(price),
2)
 as total_revenue
from order_items
group by order_id
order by total_revenue desc;

/* products contributing for highest revenue */
select product_id,
Round(
sum(price) * 100 /
( select sum(price) from order_items)
,2) as revenue_percentage
from
order_items
group by product_id
order by revenue_percentage desc;

/* product with high price and purchase frequency */
WITH product_price as
(
select
product_id,
Round(avg(price),2) as avg_price,
count(*) as order_frequency
from order_items
group by product_id
order by order_frequency desc
)
select *,
case 
 when avg_price > 1000 and order_frequency > 1 then 'high price and high frequency'
 when avg_price > 1000 then 'high price and low frequency'
 else 'low price product'
 end as product_category
from product_price
order by avg_price desc;








 
 






