-- public.sales_checkout definition

-- Drop table

-- DROP TABLE public.sales_checkout;

CREATE TABLE public.sales_checkout (
	checkout_id serial4 NOT NULL,
	customer_id int4 NOT NULL,
	total_quantity int4 NOT NULL,
	date_add timestamp NOT NULL,
	discount_amount text NULL,
	discount_code text NULL,
	date_upd timestamp NOT NULL,
	cart_status text NULL,
	shipping_fee money NULL DEFAULT 0,
	shipping_id int4 NULL,
	CONSTRAINT pk_72 PRIMARY KEY (checkout_id)
);
CREATE INDEX sales_checkout_customer_id_idx ON public.sales_checkout USING btree (customer_id);
CREATE INDEX sales_checkout_shipping_id_idx ON public.sales_checkout USING btree (shipping_id);


-- public.sales_checkout foreign keys

ALTER TABLE public.sales_checkout ADD CONSTRAINT sales_checkout_1 FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);
ALTER TABLE public.sales_checkout ADD CONSTRAINT sales_checkout_2 FOREIGN KEY (shipping_id) REFERENCES public.customer_address(shipping_id);