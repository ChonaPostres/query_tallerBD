-- Table: public.traspaso

-- DROP TABLE IF EXISTS public.traspaso;

CREATE TABLE IF NOT EXISTS public.traspaso
(
    --Vehicle title
    title character varying(255) COLLATE pg_catalog."default", 
    --Vehicle price
    price_in_aed character varying(255) COLLATE pg_catalog."default", 
    --Total Kilometer vehicle travelled
    kilometers character varying(255) COLLATE pg_catalog."default",
    --Body condition
    body_condition text COLLATE pg_catalog."default",
    --Mechanical condition
    mechanical_condition text COLLATE pg_catalog."default",
    --Seller Type
    seller_type character varying(255) COLLATE pg_catalog."default",
    --Body type
    body_type character varying(255) COLLATE pg_catalog."default",
    --Number of cylinder
    no_of_cylinders character varying(255) COLLATE pg_catalog."default",
    --Transmission type
    transmission_type character varying(255) COLLATE pg_catalog."default",
    --Regional Specification
    regional_specs character varying(255) COLLATE pg_catalog."default",
    --Horsepower
    horsepower character varying(255) COLLATE pg_catalog."default",
    --Fuel type
    fuel_type text COLLATE pg_catalog."default",
    --Steering side
    steering_side character varying(255) COLLATE pg_catalog."default",
    --Model year
    "year" character varying(255) COLLATE pg_catalog."default",
    --Vehicle color
    color character varying(255) COLLATE pg_catalog."default",
    --Emirate(like state)
    emirate character varying(255) COLLATE pg_catalog."default",
    --Motor trim
    motors_trim character varying(255) COLLATE pg_catalog."default",
    --Manufacturing company
    company character varying(255) COLLATE pg_catalog."default",
    --Vehicle model
    model character varying(255) COLLATE pg_catalog."default",
    --Ad posted date
    date_posted character varying(255) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.traspaso
    OWNER to postgres;