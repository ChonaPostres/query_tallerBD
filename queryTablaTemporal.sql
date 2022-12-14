-- Table: public.traspaso

-- DROP TABLE IF EXISTS public.traspaso;

CREATE TABLE IF NOT EXISTS public.traspaso
(
    idt character varying(255) COLLATE pg_catalog."default",
    codigo character varying(255) COLLATE pg_catalog."default",
    linkt character varying(255) COLLATE pg_catalog."default",
    nombre text COLLATE pg_catalog."default",
    descripcion text COLLATE pg_catalog."default",
    tipo character varying(255) COLLATE pg_catalog."default",
    procedencia character varying(255) COLLATE pg_catalog."default",
    estratodirecto character varying(255) COLLATE pg_catalog."default",
    escompraagil character varying(255) COLLATE pg_catalog."default",
    codigotipo character varying(255) COLLATE pg_catalog."default",
    codigoabreviatura character varying(255) COLLATE pg_catalog."default",
    descripciontipooc text COLLATE pg_catalog."default",
    idplandecompra character varying(255) COLLATE pg_catalog."default",
    codigoestado character varying(255) COLLATE pg_catalog."default",
    estado character varying(255) COLLATE pg_catalog."default",
    codigoestadorpoveedor character varying(255) COLLATE pg_catalog."default",
    estadoproveedor character varying(255) COLLATE pg_catalog."default",
    fechacreacion character varying(255) COLLATE pg_catalog."default",
    fechaenvio character varying(255) COLLATE pg_catalog."default",
    fechasolicitudcancelacion character varying(255) COLLATE pg_catalog."default",
    fechaultimamodificacion character varying(255) COLLATE pg_catalog."default",
    fechaaceptacion character varying(255) COLLATE pg_catalog."default",
    fechacancelacion character varying(255) COLLATE pg_catalog."default",
    tieneitems character varying(255) COLLATE pg_catalog."default",
    promediocalificacion character varying(255) COLLATE pg_catalog."default",
    cantidadevaluacion character varying(255) COLLATE pg_catalog."default",
    montototal character varying(255) COLLATE pg_catalog."default",
    tipomoneda character varying(255) COLLATE pg_catalog."default",
    montototalpesos character varying(255) COLLATE pg_catalog."default",
    impuestos character varying(255) COLLATE pg_catalog."default",
    tipoimpuesto character varying(255) COLLATE pg_catalog."default",
    descuentos character varying(255) COLLATE pg_catalog."default",
    cargos character varying(255) COLLATE pg_catalog."default",
    totalnetooc character varying(255) COLLATE pg_catalog."default",
    codigounidadcompra character varying(255) COLLATE pg_catalog."default",
    rutunidadcompra character varying(255) COLLATE pg_catalog."default",
    unidadcompra character varying(255) COLLATE pg_catalog."default",
    codigoorganismopublico character varying(255) COLLATE pg_catalog."default",
    organismopublico character varying(255) COLLATE pg_catalog."default",
    sector character varying(255) COLLATE pg_catalog."default",
    actividadcomprador character varying(255) COLLATE pg_catalog."default",
    ciudadunidadcompra character varying(255) COLLATE pg_catalog."default",
    regionunidadcompra character varying(255) COLLATE pg_catalog."default",
    paisunidadcompra character varying(255) COLLATE pg_catalog."default",
    codigosucursal character varying(255) COLLATE pg_catalog."default",
    rutsucursal character varying(255) COLLATE pg_catalog."default",
    sucursal character varying(255) COLLATE pg_catalog."default",
    codigoproveedor character varying(255) COLLATE pg_catalog."default",
    nombreproveedor character varying(255) COLLATE pg_catalog."default",
    actividadproveedor character varying(255) COLLATE pg_catalog."default",
    comunaproveedor character varying(255) COLLATE pg_catalog."default",
    regionproveedor character varying(255) COLLATE pg_catalog."default",
    paisproveedor character varying(255) COLLATE pg_catalog."default",
    financiamiento character varying(255) COLLATE pg_catalog."default",
    porcentajeiva character varying(255) COLLATE pg_catalog."default",
    pais character varying(255) COLLATE pg_catalog."default",
    tipodespacho character varying(255) COLLATE pg_catalog."default",
    formapago character varying(255) COLLATE pg_catalog."default",
    codigolicitacion character varying(255) COLLATE pg_catalog."default",
    iditem character varying(255) COLLATE pg_catalog."default",
    codigocategoria character varying(255) COLLATE pg_catalog."default",
    categoria character varying(500) COLLATE pg_catalog."default",
    codigoproductoonu character varying(255) COLLATE pg_catalog."default",
    nombreproductogenerico character varying(255) COLLATE pg_catalog."default",
    rubron1 character varying(255) COLLATE pg_catalog."default",
    rubron2 character varying(255) COLLATE pg_catalog."default",
    rubron3 character varying(255) COLLATE pg_catalog."default",
    especificacioncomprador text COLLATE pg_catalog."default",
    especificacionproveedor text COLLATE pg_catalog."default",
    cantidad character varying(255) COLLATE pg_catalog."default",
    unidadmedida character varying(255) COLLATE pg_catalog."default",
    monedaitem character varying(255) COLLATE pg_catalog."default",
    precioneto character varying(255) COLLATE pg_catalog."default",
    totalcargos character varying(255) COLLATE pg_catalog."default",
    totaldescuentos character varying(255) COLLATE pg_catalog."default",
    totalimpuestos character varying(255) COLLATE pg_catalog."default",
    totallineaneto character varying(255) COLLATE pg_catalog."default",
    formapago2 character varying(255) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.traspaso
    OWNER to postgres;