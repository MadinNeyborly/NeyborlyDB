-- public.sales_checkout_computed source

CREATE OR REPLACE VIEW public.sales_checkout_computed
AS WITH initial_table AS (
         SELECT sales_checkout.checkout_id,
            sales_order.order_id,
            sales_checkout.customer_id,
            sales_checkout.date_add,
            sales_checkout.date_upd,
            sales_checkout.discount_amount,
            sales_checkout.discount_code,
            sales_checkout.status AS checkout_status,
            sales_checkout.cart_status,
            sales_checkout.shipping_fee,
            sales_checkout.shipping_id,
            sales_order.gross_amount,
            sales_order.total_quantity,
            sales_order.status
           FROM sales_checkout
             JOIN sales_order ON sales_order.checkout_id = sales_checkout.checkout_id
          GROUP BY sales_checkout.checkout_id, sales_checkout.customer_id, sales_checkout.date_add, sales_checkout.date_upd, sales_checkout.discount_amount, sales_checkout.discount_code, sales_checkout.cart_status, sales_checkout.shipping_fee, sales_checkout.shipping_id, sales_order.order_id, sales_order.status
        ), delivery_flags AS (
         SELECT initial_table.checkout_id,
            initial_table.customer_id,
            initial_table.date_add,
            initial_table.date_upd,
            initial_table.discount_amount,
            initial_table.discount_code,
            initial_table.checkout_status,
            initial_table.cart_status,
            initial_table.shipping_fee,
            initial_table.shipping_id,
            initial_table.order_id,
                CASE
                    WHEN initial_table.status = 'completed'::text THEN 1
                    ELSE 0
                END AS completed_orders,
                CASE
                    WHEN initial_table.status <> 'completed'::text THEN 1
                    ELSE 0
                END AS pending_orders,
            initial_table.gross_amount,
            initial_table.total_quantity
           FROM initial_table
        )
 SELECT delivery_flags.checkout_id,
    delivery_flags.customer_id,
    delivery_flags.date_add,
    delivery_flags.date_upd,
    delivery_flags.discount_amount,
    delivery_flags.discount_code,
    delivery_flags.checkout_status,
    delivery_flags.cart_status,
    delivery_flags.shipping_fee,
    delivery_flags.shipping_id,
    sum(delivery_flags.completed_orders) AS completed_orders,
    sum(delivery_flags.pending_orders) AS pending_orders,
    sum(delivery_flags.gross_amount) AS total_amount,
    sum(delivery_flags.total_quantity) AS total_quantity,
    count(DISTINCT delivery_flags.order_id) AS no_of_orders
   FROM delivery_flags
  GROUP BY delivery_flags.checkout_id, delivery_flags.customer_id, delivery_flags.checkout_status, delivery_flags.date_add, delivery_flags.date_upd, delivery_flags.discount_amount, delivery_flags.discount_code, delivery_flags.cart_status, delivery_flags.shipping_fee, delivery_flags.shipping_id;