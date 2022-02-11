-- public.creatorstore_earnings source

CREATE OR REPLACE VIEW public.creatorstore_earnings
AS SELECT creators_stores.creator_store_name,
    creators_stores.fee,
    creators_stores.creator_store_id,
    creators.creator_id,
    creators.creator_name,
    creators.contact_full_name,
    creators.contact_email,
    creators.contact_number,
    stores.store_name,
    stores.full_address,
    stores.store_id,
    sum(sales_order_line.unit_price) AS total_sales_amount,
    count(sales_order_line.line_id) AS no_of_sales
   FROM creators_stores
     JOIN stores ON creators_stores.store_id = stores.store_id
     JOIN creators ON creators_stores.creator_id = creators.creator_id
     JOIN sales_order_line ON creators_stores.creator_store_id = sales_order_line.creator_store_id
  GROUP BY creators_stores.creator_store_name, creators_stores.fee, stores.store_name, stores.full_address, stores.store_id, creators_stores.creator_store_id, creators.creator_id, creators.creator_name, creators.contact_full_name, creators.contact_email, creators.contact_number;