-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION cloudsqlsuperuser;

-- Drop table

-- DROP TABLE public.brands;

CREATE TABLE public.brands (
	brand_id serial4 NOT NULL,
	brand_name text NOT NULL,
	date_add timestamp NOT NULL,
	date_upd timestamp NOT NULL,
	CONSTRAINT pk_291 PRIMARY KEY (brand_id)
);


-- public.categories definition

-- Drop table

-- DROP TABLE public.categories;

CREATE TABLE public.categories (
	category_id serial4 NOT NULL,
	category_name text NOT NULL,
	date_add timestamp NOT NULL,
	no_of_stores int4 NOT NULL,
	date_upd timestamp NOT NULL,
	CONSTRAINT pk_135 PRIMARY KEY (category_id)
);


-- public.creators definition

-- Drop table

-- DROP TABLE public.creators;

CREATE TABLE public.creators (
	creator_id serial4 NOT NULL,
	creator_name text NOT NULL,
	contact_full_name text NOT NULL,
	contact_email text NOT NULL,
	contact_number text NOT NULL,
	total_sales money NOT NULL,
	status text NOT NULL,
	date_add timestamp NOT NULL,
	date_upd timestamp NOT NULL,
	image text NULL,
	CONSTRAINT pk_94 PRIMARY KEY (creator_id)
);


-- public.customer definition

-- Drop table

-- DROP TABLE public.customer;

CREATE TABLE public.customer (
	customer_id serial4 NOT NULL,
	customer_email text NULL,
	first_name text NULL,
	last_name text NULL,
	first_seen date NOT NULL,
	"type" text NOT NULL,
	date_add timestamp NOT NULL,
	date_upd timestamp NOT NULL,
	image text NULL,
	CONSTRAINT pk_207 PRIMARY KEY (customer_id)
);


-- public.employees definition

-- Drop table

-- DROP TABLE public.employees;

CREATE TABLE public.employees (
	employee_id serial4 NOT NULL,
	first_name text NOT NULL,
	last_name text NOT NULL,
	contact_number text NOT NULL,
	date_joined timestamp NOT NULL,
	title text NOT NULL,
	email text NOT NULL,
	date_add timestamp NOT NULL,
	date_upd timestamp NOT NULL,
	CONSTRAINT pk_247 PRIMARY KEY (employee_id)
);


-- public.statuses definition

-- Drop table

-- DROP TABLE public.statuses;

CREATE TABLE public.statuses (
	status_id serial4 NOT NULL,
	status_name text NOT NULL,
	date_add timestamp NOT NULL,
	is_active bool NOT NULL,
	status_type text NOT NULL,
	date_upd timestamp NOT NULL,
	CONSTRAINT pk_158 PRIMARY KEY (status_id)
);


-- public.stores definition

-- Drop table

-- DROP TABLE public.stores;

CREATE TABLE public.stores (
	store_id serial4 NOT NULL,
	store_name text NOT NULL,
	full_address text NOT NULL,
	city text NOT NULL,
	state text NOT NULL,
	country text NOT NULL,
	square_feet numeric NOT NULL,
	zip_code text NOT NULL,
	latitude numeric(18, 10) NOT NULL,
	longitude numeric(18, 10) NOT NULL,
	date_add timestamp NOT NULL,
	date_upd timestamp NOT NULL,
	stripe_location_id text NOT NULL,
	sales_tax numeric NULL,
	store_photo jsonb NULL,
	store_hours jsonb NULL,
	store_description text NULL,
	parking_cost text NULL,
	virtual_tour text NULL,
	slug text NULL,
	status varchar NULL,
	CONSTRAINT pk_124 PRIMARY KEY (store_id)
);


-- public.creators_stores definition

-- Drop table

-- DROP TABLE public.creators_stores;

CREATE TABLE public.creators_stores (
	store_id int4 NOT NULL,
	creator_id int4 NOT NULL,
	creator_store_name text NOT NULL,
	date_add timestamp NOT NULL,
	date_upd timestamp NOT NULL,
	creator_store_id serial4 NOT NULL,
	fee numeric NULL,
	CONSTRAINT pk_313 PRIMARY KEY (creator_store_id),
	CONSTRAINT fk_317 FOREIGN KEY (creator_id) REFERENCES public.creators(creator_id),
	CONSTRAINT fk_329 FOREIGN KEY (store_id) REFERENCES public.stores(store_id)
);
CREATE INDEX fk_319 ON public.creators_stores USING btree (creator_id);
CREATE INDEX fk_331 ON public.creators_stores USING btree (store_id);


-- public.customer_address definition

-- Drop table

-- DROP TABLE public.customer_address;

CREATE TABLE public.customer_address (
	customer_id int4 NOT NULL,
	full_address text NOT NULL,
	city text NOT NULL,
	state text NOT NULL,
	country text NOT NULL,
	zip_code text NOT NULL,
	date_add timestamp NOT NULL,
	date_upd timestamp NOT NULL,
	shipping_id serial4 NOT NULL,
	CONSTRAINT pk_217 PRIMARY KEY (shipping_id),
	CONSTRAINT fk_225 FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id)
);
CREATE INDEX fk_227 ON public.customer_address USING btree (customer_id);


-- public.item_subcategories definition

-- Drop table

-- DROP TABLE public.item_subcategories;

CREATE TABLE public.item_subcategories (
	category_id int4 NOT NULL,
	subcategory_name text NOT NULL,
	date_add timestamp NOT NULL,
	date_upd timestamp NOT NULL,
	subcategory_id serial4 NOT NULL,
	CONSTRAINT pk_373 PRIMARY KEY (subcategory_id),
	CONSTRAINT fk_382 FOREIGN KEY (category_id) REFERENCES public.categories(category_id)
);
CREATE INDEX fk_384 ON public.item_subcategories USING btree (category_id);


-- public.items definition

-- Drop table

-- DROP TABLE public.items;

CREATE TABLE public.items (
	item_id serial4 NOT NULL,
	item_name text NOT NULL,
	subcategory_id int4 NOT NULL,
	brand_id int4 NOT NULL,
	date_add timestamp NOT NULL,
	date_upd timestamp NOT NULL,
	slug text NULL,
	CONSTRAINT pk_70 PRIMARY KEY (item_id),
	CONSTRAINT fk_300 FOREIGN KEY (brand_id) REFERENCES public.brands(brand_id),
	CONSTRAINT fk_378 FOREIGN KEY (subcategory_id) REFERENCES public.item_subcategories(subcategory_id)
);
CREATE INDEX fk_302 ON public.items USING btree (brand_id);
CREATE INDEX fk_380 ON public.items USING btree (subcategory_id);


-- public.pos_cash_drawers definition

-- Drop table

-- DROP TABLE public.pos_cash_drawers;

CREATE TABLE public.pos_cash_drawers (
	drawer_id serial4 NOT NULL,
	description text NULL,
	current_balance money NOT NULL,
	starting_balance money NOT NULL,
	start_time timestamptz(0) NOT NULL,
	ending_balance money NULL,
	ending_time timestamptz(0) NULL,
	status text NOT NULL,
	paidinout money NOT NULL,
	store_id int4 NOT NULL,
	date_add timestamp NOT NULL,
	date_upd timestamp NOT NULL,
	cash_sales money NULL DEFAULT 0,
	CONSTRAINT pk_177 PRIMARY KEY (drawer_id),
	CONSTRAINT fk_304 FOREIGN KEY (store_id) REFERENCES public.stores(store_id)
);
CREATE INDEX fk_306 ON public.pos_cash_drawers USING btree (store_id);


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
	CONSTRAINT pk_72 PRIMARY KEY (checkout_id),
	CONSTRAINT sales_checkout_1 FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id),
	CONSTRAINT sales_checkout_2 FOREIGN KEY (shipping_id) REFERENCES public.customer_address(shipping_id)
);
CREATE INDEX sales_checkout_customer_id_idx ON public.sales_checkout USING btree (customer_id);
CREATE INDEX sales_checkout_shipping_id_idx ON public.sales_checkout USING btree (shipping_id);


-- public.sales_order definition

-- Drop table

-- DROP TABLE public.sales_order;

CREATE TABLE public.sales_order (
	status text NOT NULL,
	gross_amount money NOT NULL,
	total_quantity int4 NOT NULL,
	date_add timestamp NOT NULL,
	net_amount money NOT NULL,
	tax money NOT NULL,
	fee money NOT NULL,
	order_email text NULL,
	order_type text NOT NULL,
	discount_amount money NULL,
	discount_code text NULL,
	employee_id int4 NULL,
	date_upd timestamp NOT NULL,
	order_id serial4 NOT NULL,
	store_id int4 NOT NULL,
	transaction_type text NULL,
	checkout_id int4 NULL,
	CONSTRAINT pk_8 PRIMARY KEY (order_id),
	CONSTRAINT fk_257 FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id),
	CONSTRAINT fk_428 FOREIGN KEY (store_id) REFERENCES public.stores(store_id),
	CONSTRAINT sales_order_fk FOREIGN KEY (checkout_id) REFERENCES public.sales_checkout(checkout_id)
);
CREATE INDEX fk_165 ON public.sales_order USING btree (status);
CREATE INDEX fk_259 ON public.sales_order USING btree (employee_id);
CREATE INDEX fk_390 ON public.sales_order USING btree (store_id);


-- public.sales_order_history definition

-- Drop table

-- DROP TABLE public.sales_order_history;

CREATE TABLE public.sales_order_history (
	history_id serial4 NOT NULL,
	order_id int4 NOT NULL,
	status text NOT NULL,
	date_add timestamp NOT NULL,
	CONSTRAINT pk_149 PRIMARY KEY (history_id),
	CONSTRAINT fk_153 FOREIGN KEY (order_id) REFERENCES public.sales_order(order_id)
);
CREATE INDEX fk_155 ON public.sales_order_history USING btree (order_id);
CREATE INDEX fk_168 ON public.sales_order_history USING btree (status);


-- public.sales_payments definition

-- Drop table

-- DROP TABLE public.sales_payments;

CREATE TABLE public.sales_payments (
	order_id int4 NOT NULL,
	stripe_transaction_id text NOT NULL,
	card_type text NOT NULL,
	last_4_digits int4 NOT NULL,
	payment_id serial4 NOT NULL,
	CONSTRAINT pk_437 PRIMARY KEY (payment_id),
	CONSTRAINT fk_439 FOREIGN KEY (order_id) REFERENCES public.sales_order(order_id)
);
CREATE INDEX fk_441 ON public.sales_payments USING btree (order_id);


-- public.stores_employees definition

-- Drop table

-- DROP TABLE public.stores_employees;

CREATE TABLE public.stores_employees (
	store_employee_id int4 NOT NULL DEFAULT nextval('stores_employees_employee_id_seq'::regclass),
	status text NOT NULL,
	employee_id serial4 NOT NULL,
	date_add timestamp NOT NULL,
	date_upd timestamp NOT NULL,
	store_id serial4 NOT NULL,
	CONSTRAINT pk_405 PRIMARY KEY (store_employee_id),
	CONSTRAINT fk_409 FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id),
	CONSTRAINT fk_421 FOREIGN KEY (store_id) REFERENCES public.stores(store_id)
);
CREATE INDEX fk_411 ON public.stores_employees USING btree (employee_id);
CREATE INDEX fk_417 ON public.stores_employees USING btree (status);
CREATE INDEX fk_423 ON public.stores_employees USING btree (store_id);


-- public.item_variant definition

-- Drop table

-- DROP TABLE public.item_variant;

CREATE TABLE public.item_variant (
	item_id serial4 NOT NULL,
	variant_name text NULL,
	date_add timestamp NOT NULL,
	date_upd timestamp NOT NULL,
	extra_properties jsonb NULL,
	"size" text NOT NULL,
	"condition" text NOT NULL,
	status text NOT NULL,
	render_3d text NULL,
	item_description text NULL,
	colour text NULL,
	variant_id serial4 NOT NULL,
	product_images jsonb NULL,
	CONSTRAINT pk_58 PRIMARY KEY (variant_id),
	CONSTRAINT variant_ref UNIQUE (item_id, size, condition, colour),
	CONSTRAINT fk_307 FOREIGN KEY (item_id) REFERENCES public.items(item_id)
);
CREATE INDEX fk_309 ON public.item_variant USING btree (item_id);


-- public.pos_cash_transactions definition

-- Drop table

-- DROP TABLE public.pos_cash_transactions;

CREATE TABLE public.pos_cash_transactions (
	drawer_transaction_id serial4 NOT NULL,
	timestamp_add timestamptz(0) NOT NULL,
	drawer_id int4 NOT NULL,
	cash_amount money NOT NULL,
	activity text NOT NULL,
	starting_balance money NOT NULL,
	description text NOT NULL,
	timestamp_upd timestamptz(0) NOT NULL,
	store_employee_id int4 NOT NULL,
	CONSTRAINT pk_188 PRIMARY KEY (drawer_transaction_id),
	CONSTRAINT fk_199 FOREIGN KEY (drawer_id) REFERENCES public.pos_cash_drawers(drawer_id),
	CONSTRAINT fk_418 FOREIGN KEY (store_employee_id) REFERENCES public.stores_employees(store_employee_id)
);
CREATE INDEX fk_201 ON public.pos_cash_transactions USING btree (drawer_id);
CREATE INDEX fk_420 ON public.pos_cash_transactions USING btree (store_employee_id);


-- public.item_inventory definition

-- Drop table

-- DROP TABLE public.item_inventory;

CREATE TABLE public.item_inventory (
	inventory_id serial4 NOT NULL,
	variant_id int4 NOT NULL,
	store_id int4 NOT NULL,
	creator_store_id int4 NOT NULL,
	status text NOT NULL,
	date_add timestamp NOT NULL,
	nft_id serial4 NOT NULL,
	date_upd timestamp NOT NULL,
	price money NOT NULL,
	sales_channels text NOT NULL,
	CONSTRAINT pk_40 PRIMARY KEY (inventory_id),
	CONSTRAINT fk_365 FOREIGN KEY (creator_store_id) REFERENCES public.creators_stores(creator_store_id),
	CONSTRAINT fk_385 FOREIGN KEY (store_id) REFERENCES public.stores(store_id),
	CONSTRAINT fk_65 FOREIGN KEY (variant_id) REFERENCES public.item_variant(variant_id)
);
CREATE INDEX fk_171 ON public.item_inventory USING btree (status);
CREATE INDEX fk_367 ON public.item_inventory USING btree (creator_store_id);
CREATE INDEX fk_387 ON public.item_inventory USING btree (store_id);
CREATE INDEX fk_67 ON public.item_inventory USING btree (variant_id);


-- public.sales_order_line definition

-- Drop table

-- DROP TABLE public.sales_order_line;

CREATE TABLE public.sales_order_line (
	line_id serial4 NOT NULL,
	unit_price money NULL,
	inventory_id int4 NULL,
	order_id int4 NOT NULL,
	date_add timestamp NOT NULL,
	date_upd timestamp NOT NULL,
	creator_store_id int4 NOT NULL,
	description text NULL,
	CONSTRAINT pk_25 PRIMARY KEY (line_id),
	CONSTRAINT fk_172 FOREIGN KEY (order_id) REFERENCES public.sales_order(order_id),
	CONSTRAINT fk_431 FOREIGN KEY (creator_store_id) REFERENCES public.creators_stores(creator_store_id),
	CONSTRAINT fk_81 FOREIGN KEY (inventory_id) REFERENCES public.item_inventory(inventory_id)
);
CREATE INDEX "FK_174" ON public.sales_order_line USING btree (order_id);
CREATE INDEX "FK_433" ON public.sales_order_line USING btree (creator_store_id);
CREATE INDEX "FK_83" ON public.sales_order_line USING btree (inventory_id);


-- public.categories_stores source

CREATE MATERIALIZED VIEW public.categories_stores
TABLESPACE pg_default
AS SELECT DISTINCT concat(categories.category_id, stores.store_id) AS category_store_id,
    categories.category_id,
    stores.store_id
   FROM item_inventory
     JOIN item_variant ON item_inventory.variant_id = item_variant.variant_id
     JOIN items ON item_variant.item_id = items.item_id
     JOIN brands ON items.brand_id = brands.brand_id
     JOIN item_subcategories ON items.subcategory_id = item_subcategories.subcategory_id
     JOIN creators_stores ON item_inventory.creator_store_id = creators_stores.creator_store_id
     JOIN stores ON item_inventory.store_id = stores.store_id
     JOIN categories ON item_subcategories.category_id = categories.category_id
     JOIN creators ON creators_stores.creator_id = creators.creator_id
WITH DATA;


-- public.inventory_all_details source

CREATE OR REPLACE VIEW public.inventory_all_details
AS SELECT item_inventory.inventory_id,
    item_inventory.status AS inventory_status,
    item_inventory.price,
    item_variant.variant_name,
    item_variant.size,
    item_variant.condition,
    item_variant.render_3d,
    item_variant.status AS variant_status,
    item_variant.product_images,
    item_variant.extra_properties,
    item_variant.item_description,
    item_variant.colour,
    items.item_name,
    brands.brand_name,
    item_subcategories.subcategory_name,
    creators_stores.creator_store_name,
    stores.store_name,
    stores.full_address,
    stores.city,
    stores.state,
    stores.country,
    stores.stripe_location_id,
    stores.zip_code,
    categories.category_name,
    item_variant.variant_id,
    items.item_id,
    brands.brand_id,
    creators_stores.creator_store_id,
    stores.store_id,
    categories.category_id,
    item_subcategories.subcategory_id,
    creators.creator_id,
    creators.creator_name,
    creators.contact_full_name,
    creators.contact_email,
    creators.contact_number
   FROM item_inventory
     JOIN item_variant ON item_inventory.variant_id = item_variant.variant_id
     JOIN items ON item_variant.item_id = items.item_id
     JOIN brands ON items.brand_id = brands.brand_id
     JOIN item_subcategories ON items.subcategory_id = item_subcategories.subcategory_id
     JOIN creators_stores ON item_inventory.creator_store_id = creators_stores.creator_store_id
     JOIN stores ON item_inventory.store_id = stores.store_id
     JOIN categories ON item_subcategories.category_id = categories.category_id
     JOIN creators ON creators_stores.creator_id = creators.creator_id;


-- public.item_computed source

CREATE OR REPLACE VIEW public.item_computed
AS SELECT items.item_id,
    items.item_name,
    items.subcategory_id,
    items.brand_id,
    items.date_add,
    items.date_upd,
    items.slug,
    min(item_inventory.price) AS min_price,
    count(item_inventory.inventory_id) AS no_of_inventory
   FROM items
     LEFT JOIN item_variant ON item_variant.item_id = items.item_id
     LEFT JOIN item_inventory ON item_variant.variant_id = item_inventory.variant_id
  GROUP BY items.item_id;


-- public.items_variant_computed source

CREATE OR REPLACE VIEW public.items_variant_computed
AS SELECT item_variant.item_id,
    item_variant.variant_id,
    item_variant.variant_name,
    item_variant.size,
    item_variant.condition,
    item_variant.render_3d,
    item_variant.status,
    item_variant.product_images,
    item_variant.extra_properties,
    item_variant.item_description,
    item_variant.colour,
    min(item_inventory.price) AS min_price,
    count(item_inventory.inventory_id) AS no_of_inventory
   FROM item_variant
     JOIN item_inventory ON item_variant.variant_id = item_inventory.variant_id
  WHERE item_inventory.status = 'published'::text
  GROUP BY item_variant.variant_id, item_variant.variant_name, item_variant.size, item_variant.condition, item_variant.render_3d, item_variant.status, item_variant.product_images, item_variant.extra_properties, item_variant.item_description, item_variant.colour;


-- public.variant_all_details source

CREATE OR REPLACE VIEW public.variant_all_details
AS SELECT categories.category_id,
    item_subcategories.subcategory_id,
    brands.brand_id,
    item_variant.variant_id,
    items.item_id,
    categories.category_name,
    item_subcategories.subcategory_name,
    brands.brand_name,
    items.item_name,
    item_variant.variant_name,
    item_variant.size,
    item_variant.condition,
    item_variant.render_3d,
    item_variant.status AS variant_status,
    item_variant.product_images,
    item_variant.extra_properties,
    item_variant.item_description,
    item_variant.colour,
    creators_stores.creator_store_name,
    stores.store_name,
    stores.full_address,
    stores.city,
    stores.state,
    stores.country,
    stores.stripe_location_id,
    stores.zip_code,
    stores.store_id,
    creators_stores.creator_store_id,
    creators.creator_id,
    creators.creator_name,
    creators.contact_full_name,
    creators.contact_email,
    creators.contact_number,
    min(item_inventory.price) AS min_price,
    count(item_inventory.inventory_id) AS no_of_inventory,
    concat(item_variant.variant_id, creators_stores.creator_store_id) AS variant_all_id
   FROM item_variant
     JOIN item_inventory ON item_variant.variant_id = item_inventory.variant_id
     JOIN items ON item_variant.item_id = items.item_id
     JOIN brands ON items.brand_id = brands.brand_id
     JOIN item_subcategories ON items.subcategory_id = item_subcategories.subcategory_id
     JOIN creators_stores ON item_inventory.creator_store_id = creators_stores.creator_store_id
     JOIN stores ON item_inventory.store_id = stores.store_id
     JOIN categories ON item_subcategories.category_id = categories.category_id
     JOIN creators ON creators_stores.creator_id = creators.creator_id
  WHERE item_inventory.status = 'published'::text
  GROUP BY categories.category_id, item_subcategories.subcategory_id, brands.brand_id, item_variant.variant_id, items.item_id, categories.category_name, item_subcategories.subcategory_name, brands.brand_name, items.item_name, item_variant.variant_name, item_variant.size, item_variant.condition, item_variant.render_3d, item_variant.status, item_variant.product_images, item_variant.extra_properties, item_variant.item_description, item_variant.colour, creators_stores.creator_store_name, stores.store_name, stores.full_address, stores.city, stores.state, stores.country, stores.stripe_location_id, stores.zip_code, stores.store_id, creators_stores.creator_store_id, creators.creator_id, creators.creator_name, creators.contact_full_name, creators.contact_email, creators.contact_number;
