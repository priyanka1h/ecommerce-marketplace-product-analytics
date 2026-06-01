/*frequently used payment type*/
select 
payment_type,
count(*) as frequent_payment_type
from order_payments
group by payment_type
order by frequent_payment_type;

/* payment type distribution */
select 
payment_type,
count(*) as payment_count,
round(
count(*) * 100 / (select count(*) from order_payments),2
) as distibution_order_payments
from order_payments
group by payment_type
order by distibution_order_payments desc;

/*depicting which payment type contributes the most for the revenue */
select payment_type,
round(sum(payment_value),2)as payment_revenue
from order_payments
group by payment_type
order by payment_revenue desc;

/* total payment_value processed */
select 
round(sum(payment_value),2) as total_payment_value
from order_payments;

/*avg payment per order*/
select 
round(avg(order_payment),2)as avg_payment_per_order
from(
select 
order_id,
sum(payment_value) as order_payment
from order_payments
group by order_id
order by order_payment desc
) t;

/*order with highest payment value */
select 
order_id,
sum(payment_value) as total_payment
from order_payments
group by order_id
order by total_payment desc;

/* avg no of installments used */
select
avg(payment_installments) as avg_installments
from order_payments;

/*payment type using installments */
select
payment_type,
count(*) as installment_count
from order_payments
WHERE payment_installments > 1
group by payment_type
order by  installment_count desc;

/*depicting if high/low order are using installments*/
select
payment_installments,
round(sum(payment_value),2) as order_value
from order_payments
where payment_installments > 1
group by payment_installments
order by order_value desc;

/*depicting which customer is spending the highest through payment */
select c.customer_unique_id,
sum(o_pay.payment_value) as payment_sum
from customers c
join orders o
on c.customer_id = o.customer_id
join order_payments o_pay
on o.order_id = o_pay.order_id
group by c.customer_unique_id
order by payment_sum desc;

/*preferred payment type by customer*/
select *
from(
select
 c.customer_unique_id,
o_pay.payment_type,
count(*) as usage_count,
 Rank() Over(
            PARTITION BY c.customer_unique_id
            ORDER BY COUNT(*) DESC
        ) AS payment_rank
from customers c
join orders o
on c.customer_id = o.customer_id
join order_payments o_pay
on o.order_id = o_pay.order_id
group by c.customer_unique_id,
o_pay.payment_type
)t
where payment_rank =1;

/*repeat customer payment behavior*/
select c.customer_unique_id,
count(DISTINCT o.order_id) as total_orders,
count(DISTINCT o_pay.payment_type) as payment_methods_used,
    group_concat(
        DISTINCT o_pay.payment_type
        ORDER BY o_pay.payment_type
    ) as payment_behaviors
from customers c
join orders o
on c.customer_id = o.customer_id
join order_payments o_pay
on o.order_id = o_pay.order_id
group by c.customer_unique_id
having count(o.order_id) > 1
order by payment_methods_used DESC,
         total_orders DESC;

/*depicting if there are multiple payments for single order*/
select order_id,
count(*) as total_orders,
count(DISTINCT payment_type) as payment_methods_used,
    group_concat(
        DISTINCT payment_type
        ORDER BY payment_type
    ) as payment_behaviors
from order_payments 
group by order_id
HAVING COUNT(*) > 1
order by payment_methods_used DESC,
         total_orders DESC;