-- public.sales_checkout_computed source
drop view if exists public.sales_checkout_computed;
CREATE OR REPLACE VIEW public.sales_checkout_computed AS 
with initial_table as (
SELECT sales_checkout.checkout_id,
    order_id,
    customer_id,
	sales_checkout.date_add,
	sales_checkout.date_upd,
	sales_checkout.discount_amount,
	sales_checkout.discount_code,
	sales_checkout.status as checkout_status,
	cart_status,
	shipping_fee,
	shipping_id,
    sales_order.gross_amount,
    sales_order.total_quantity,
    sales_order.status
   FROM sales_checkout
     JOIN sales_order ON sales_order.checkout_id = sales_checkout.checkout_id
  GROUP BY 
 sales_checkout.checkout_id,
 customer_id,
 sales_checkout.date_add,
 sales_checkout.date_upd,
 sales_checkout.discount_amount,
 sales_checkout.discount_code,
 sales_checkout.status,
 cart_status,
 shipping_fee,
 shipping_id,
 order_id,
 sales_order.status
),
delivery_flags as (
select
checkout_id,
customer_id,
date_add,
date_upd,
discount_amount,
discount_code,
cart_status,
shipping_fee,
shipping_id,
order_id,
checkout_status,
CASE
    WHEN status = 'completed' THEN 1
    ELSE 0 end as completed_orders,
CASE
    WHEN status <> 'completed' THEN 1
    ELSE 0 end as pending_orders,
gross_amount,
total_quantity
from initial_table
)
select
checkout_id,
customer_id,
date_add,
date_upd,
discount_amount,
discount_code,
cart_status,
checkout_status,
shipping_fee,
shipping_id,
Sum(completed_orders) as completed_orders,
Sum(pending_orders) as pending_orders,
sum(delivery_flags.gross_amount+delivery_flags.shipping_fee) AS total_amount,
Sum(total_quantity) as total_quantity,
count(distinct order_id) as no_of_orders
from delivery_flags
group by
checkout_id,
customer_id,
checkout_status,
date_add,
date_upd,
discount_amount,
discount_code,
cart_status,
shipping_fee,
shipping_id