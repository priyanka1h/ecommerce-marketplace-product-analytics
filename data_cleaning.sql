USE marketplace_project;
SELECT database();

/*handling duplicate values*/
select customer_id, COUNT(*) AS cnt
from customers
group by customer_id
having count(*) > 1;

select order_id 
from orders
group by order_id
having count(*) > 1;

select order_id, 
order_item_id
from order_items
group by order_item_id, order_id
having count(*) > 1;

select order_id,
payment_sequential 
from order_payments
group by order_id, payment_sequential
having count(*) > 1;

/* uniqueness validated successfully */







