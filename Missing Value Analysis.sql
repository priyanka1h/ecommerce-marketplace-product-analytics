USE marketplace_project;

/* Handling missing values */
select 
SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
SUM(CASE WHEN customer_unique_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_unique_id,
SUM(CASE WHEN customer_city IS NULL THEN 1 ELSE 0 END) AS missing_customer_city,
SUM(CASE WHEN customer_zip_code_prefix IS NULL THEN 1 ELSE 0 END) AS missing_zipcode,
SUM(CASE WHEN customer_state IS NULL THEN 1 ELSE 0 END) AS missing_customer_state
FROM customers;

select
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) as missing_order_id,
SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) as missing_customer_id,
SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) as missing_status,
SUM(CASE WHEN order_purchase_timestamp IS NULL THEN 1 ELSE 0 END) as missing_timestamp,
SUM(CASE WHEN order_approved_at IS NULL THEN 1 ELSE 0 END) as missing_approval_data,
SUM(CASE WHEN order_delivered_carrier_date IS NULL THEN 1 ELSE 0 END) as missing_carrier_date,
SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) as missing_delivery_date,
SUM(CASE WHEN order_estimated_delivery_date IS NULL THEN 1 ELSE 0 END) as missing_estimated_data
FROM orders;

select
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) as missing_order_id,
SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) as missing_order_item,
SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) as missing_product_id,
SUM(CASE WHEN seller_id IS NULL THEN 1 ELSE 0 END) as missing_seller_id,
SUM(CASE WHEN shipping_limit_date IS NULL THEN 1 ELSE 0 END) as missing_shipping_date,
SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) as missing_price,
SUM(CASE WHEN freight_value IS NULL THEN 1 ELSE 0 END) as missing_freight_value
FROM order_items;

SELECT
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) as missing_order_id,
SUM(CASE WHEN payment_sequential IS NULL THEN 1 ELSE 0 END) as missing_payment,
SUM(CASE WHEN payment_type IS NULL THEN 1 ELSE 0 END) as missing_payment_type,
SUM(CASE WHEN payment_installments IS NULL THEN 1 ELSE 0 END) as missing_payment_installments,
SUM(CASE WHEN payment_value IS NULL THEN 1 ELSE 0 END) as missing_payment_value
FROM order_payments;









