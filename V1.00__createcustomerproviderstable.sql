CREATE TABLE public.customer_social_providers (
	customer_social_providers_id serial4 NOT NULL,
	customer_id int4 NOT NULL,
	provider_sub text NULL,
	provider_type text NULL,
	CONSTRAINT customer_social_providers_pk PRIMARY KEY (customer_social_providers_id),
	CONSTRAINT customer_social_providers_fk_1 FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id)
);
CREATE INDEX customer_social_providers_customer_id_idx ON public.customer_social_providers (customer_id);
CREATE UNIQUE INDEX customer_social_providers_pk_idx ON public.customer_social_providers (customer_social_providers_id);
COMMENT ON TABLE public.customer_social_providers IS 'This table stores all oauth login access information of customers';

-- Column comments

COMMENT ON COLUMN public.customer_social_providers.provider_sub IS 'provides the sub value that contains oAuth info';
COMMENT ON COLUMN public.customer_social_providers.provider_type IS 'example: Google/Facebook';
