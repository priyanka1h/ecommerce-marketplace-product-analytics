DESCRIBE orders; /*To describe the data type of each column*/

SET SQL_SAFE_UPDATES = 0;

/*Setting to NULL values */
UPDATE orders
SET order_estimated_delivery_date = NULL
WHERE order_estimated_delivery_date = '';

/*Changing the data type */
ALTER TABLE orders
MODIFY order_estimated_delivery_date DATETIME;

/*The delivery date was before the purchase date
fixed the issue by changing the datatype of date related columns to datetime*/
select count(*) as inavlid_data_check
from orders
where order_delivered_customer_date < order_purchase_timestamp;

SELECT count(*) as canceled_order_count
from orders
where order_status = 'canceled';

/* When order is canceled then delivery date should be blank or NULL 
- indicating possible refund workflows */
select 
count(*) as invalid_delivery_data
from orders
where order_status = 'canceled'
AND order_delivered_customer_date IS NOT NULL;

select price, freight_value
from order_items
where price <= 0 AND freight_value <= 0; 

select *
from order_payments
where payment_value <= 0;
/*To check negative or zero amount - revenue analysis*/

select order_status, count(*) as status_count
from orders
group by order_status;

select order_delivered_carrier_date,
order_delivered_customer_date
from orders
where order_delivered_carrier_date > order_delivered_customer_date;



