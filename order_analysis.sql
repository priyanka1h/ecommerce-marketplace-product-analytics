/* total number of order */
select count(order_id) as total_orders
from orders;

select DISTINCT order_status
from orders;

/* frequent order status for operation analysis */
select order_status,
count(*) as frequent_order_status
from orders
group by order_status
order by frequent_order_status desc;

/* avg cancelation rate - risk analysis*/
select
COUNT(CASE WHEN order_status = 'canceled' THEN 1 END) * 100.0 /
COUNT(*) AS cancellation_rate 
from orders;

/* order trend analysis */
select
MONTHNAME(order_purchase_timestamp) as month_name,
count(*) as monthly_order_rate
from orders
group by MONTHNAME(order_purchase_timestamp)
order by monthly_order_rate desc;

select 
dayname(order_purchase_timestamp) as weekname,
count(*) as day_wise_order_frequency
from orders
group by dayname(order_purchase_timestamp)
order by day_wise_order_frequency desc;

select 
case 
when hour(order_purchase_timestamp) BETWEEN 0 AND 5 THEN 'Night'
when hour(order_purchase_timestamp) BETWEEN 6 AND 11 THEN 'Morning'
when hour(order_purchase_timestamp) BETWEEN 12 AND 16 THEN 'Afternoon'
else 'Evening'
END time_frame,
count(*) as hour_wise_order_frequency
from orders
group by time_frame
order by hour_wise_order_frequency desc;

/*average delivery time */
select 
avg(
   datediff(
   order_delivered_customer_date,order_purchase_timestamp
   )
) as avg_delivery_delay
from orders
where order_delivered_customer_date IS NOT NULL;

/* depicting orders that were delyed/on time */
select 
case
when (order_delivered_customer_date > order_estimated_delivery_date) then 'order_delayed'
when (order_delivered_customer_date <= order_estimated_delivery_date) then 'order_ontime'
else 'missing_orders'
end as delivery_delay,
count(order_id) as number_of_orders
from orders
group by delivery_delay
order by number_of_orders;

/* delay rate*/
select
count(case
        when order_delivered_customer_date > order_estimated_delivery_date
        then 1
      end) * 100.0 / count(*) AS delay_rate
from orders
where order_delivered_customer_date IS NOT NULL;

/* avg delay duration */
select
avg(DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date)) AS avg_delay_days
from orders
where order_delivered_customer_date IS NOT NULL
  and order_delivered_customer_date > order_estimated_delivery_date;

/* on time delivery duration */
select
count(case
        when order_delivered_customer_date <= order_estimated_delivery_date
        then 1
      end) * 100.0 / count(*) AS on_time_rate
from orders
where order_delivered_customer_date IS NOT NULL;

/* city-state with highest delay count */
select customer_state,
customer_city,
sum(order_delivered_customer_date > order_estimated_delivery_date) as delay_count
from customers c
join orders o
on c.customer_id = o.customer_id
group by customer_state,
customer_city
order by delay_count desc;

/* avg order approval time */
select
avg(
DATEDIFF(order_approved_at,order_purchase_timestamp) 
)as avg_order_approval_time
from
orders;

/* order with unusual high approval delays */
select order_id,
DATEDIFF(order_approved_at, order_purchase_timestamp) as high_approval_delay
from orders
where order_approved_at IS NOT NULL
order by high_approval_delay desc;

/* which month has high cancelation */
select
MONTHNAME(order_purchase_timestamp) AS ordered_month,
count(*) as high_cancelation_count
from orders
where order_status = 'canceled'
group by ordered_month
order by high_cancelation_count desc;

/*state with high_canceletion_count */
select 
c.customer_state,
COUNT(CASE WHEN order_status='canceled' THEN 1 END) high_cancelation_count
from customers c
join orders o
on c.customer_id = o.customer_id
where order_status = 'canceled'
group by c.customer_state
order by high_cancelation_count desc;

/* how revenue is trending on monthly basis */
select
MONTHNAME(o.order_purchase_timestamp) as month_name,
round(sum(oi.price),2) as total_revenue
from orders o
join order_items oi
on o.order_id = oi.order_id
group by MONTHNAME(o.order_purchase_timestamp)
order by total_revenue desc;







