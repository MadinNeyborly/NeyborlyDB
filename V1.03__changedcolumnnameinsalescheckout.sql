ALTER TABLE public.sales_checkout RENAME COLUMN payment_status TO status;
ALTER TABLE public.sales_checkout ALTER COLUMN status SET DEFAULT 'payment pending'::text;
