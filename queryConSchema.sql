create schema if not exists esquemanuevo AUTHORIZATION postgres;
create table if not exists esquemanuevo.rubros (
	id_rubro serial not null,
	rubro varchar(255) not null,
	rubropadre int,
	constraint pk_rubros primary key (id_rubro)
);


alter table esquemanuevo.rubros add constraint fk_rubros_rubros
	foreign key (rubropadre) references esquemanuevo.rubros(id_rubro);

CREATE TABLE if not exists esquemanuevo.paises
(
    codigopais character varying(5) NOT NULL,
    pais character varying(100) NOT NULL,
    constraint pk_paises primary key (codigopais)
);


create table if not exists esquemanuevo.regiones (
	idregion INTEGER not null,
	region varchar(100) not null,
	pais varchar(5) not null,
	constraint pk_regiones primary key (idregion),
	constraint fk_regiones_paises foreign key (pais) references esquemanuevo.paises(codigopais)
);
create table if not exists esquemanuevo.ciudades (
	idciudad serial not null,
	region integer not null,
	ciudad varchar(255) not null,
	constraint pk_ciudades primary key (idciudad),
	constraint fk_ciudades foreign key (region) references esquemanuevo.regiones(idregion)
);
create table if not exists esquemanuevo.actividadesproveedores (
	idactividadproveedor serial not null,
	actividadproveedor varchar(255),
	constraint pk_actividadesproveedores primary key (idactividadproveedor)
);
create table if not exists esquemanuevo.proveedores (
	codigoproveedor integer not null,
	nombreproveedor varchar(255) not null,
	actividad integer not null,
	comuna integer not null,
	promedioevaluacion double precision,
	cantidadevaluacion integer,
	constraint pk_proveedores primary key (codigoproveedor),
	constraint fk_proveedores_actividadesproveedores foreign key (actividad) references esquemanuevo.actividadesproveedores(idactividadproveedor),
	constraint fk_proveedores_ciudades foreign key (comuna) references esquemanuevo.ciudades(idciudad)
);
create table if not exists esquemanuevo.sucursales (
	codigosucursal integer not null,
	rutsucursal varchar(12) not null,
	sucursal varchar(255),
	proveedor integer,
	constraint pk_sucursales primary key (codigosucursal),
	constraint fk_sucursales_proveedores foreign key (proveedor) references esquemanuevo.proveedores(codigoproveedor)
);
create table if not exists esquemanuevo.tipos (
	tipo varchar(10) not null,
	codigoabreviatura character(10) not null,
	descripcion varchar(200) not null,
	codigotipo integer not null,
	constraint pk_tipos primary key (tipo)
);
create table if not exists procedencias (
	idprocedencia serial not null,
	procedencia varchar(255) not null,
	tipo varchar(10),
	constraint pk_procedencias primary key (idprocedencia),
	constraint fk_procedencias_tipos foreign key (tipo) references esquemanuevo.tipos(tipo)
);
create table if not exists esquemanuevo.estadoscompras (
	codigoestado integer not null,
	estado varchar(200),
	constraint pk_estadoscompras primary key (codigoestado)
);
create table if not exists esquemanuevo.estadosproveedores (
	codigoestado integer not null,
	estado varchar(200),
	constraint pk_estadosproveedores primary key (codigoestado)
);
create table if not exists esquemanuevo.tiposimpuestos (
	tipoimpuesto serial not null,
	impuesto varchar(100),
	constraint pk_tiposimpuestos primary key (tipoimpuesto)
);
create table if not exists esquemanuevo.sectores(
	idsector serial not null,
	sector varchar(255) not null,
	constraint pk_sectores primary key (idsector)
);
create table if not exists esquemanuevo.organismospublicos (
	codigoorganismopublico integer not null,
	organismopublico varchar(255) not null,
	sector integer not null,
	constraint pk_organismospublicos primary key (codigoorganismopublico),
	constraint fk_organismospublicos_sectores foreign key (sector) references esquemanuevo.sectores(idsector)
);
create table if not exists esquemanuevo.unidadescompras (
	codigounidadcompra integer not null,
	rutunidadcompra varchar(12) not null,
	unidadcompra varchar(255),
	codigoorganismopublico integer not null,
	ciudad integer not null,
	constraint pk_unidadescompras primary key (codigounidadcompra),
	constraint fk_unidadescompras_organismospublicos foreign key (codigoorganismopublico) references esquemanuevo.organismospublicos(codigoorganismopublico),
	constraint fk_unidadescompras_ciudades foreign key (ciudad) references esquemanuevo.ciudades(idciudad)
);
create table if not exists esquemanuevo.tiposdespachos (
	idtipodespacho integer not null,
	tipodespacho varchar(255),
	constraint pk_tiposdespachos primary key (idtipodespacho)
);
create table if not exists esquemanuevo.tiposdespachos (
	idtipodespacho integer not null,
	tipodespacho varchar(255),
	constraint pk_tiposdespachos primary key (idtipodespacho)
);
CREATE TABLE if not exists esquemanuevo.tiposmonedas
(
    codigomoneda character(3) NOT NULL,
    nombremoneda character varying(100) NOT NULL,
    constraint pk_tiposmonedas primary key (codigomoneda)
);
CREATE TABLE if not exists esquemanuevo.formaspagos
(
    idformapago integer NOT NULL,
    formapago character varying(255),
    constraint pk_formaspagos primary key (idformapago)
);
CREATE TABLE if not exists esquemanuevo.categorias
(
    codigocategoria bigint NOT NULL,
    categoria character varying(255),
    constraint pk_categorias primary key (codigocategoria)
);
CREATE TABLE if not exists esquemanuevo.unidadesmedidas
(
    codigounidadmedida serial NOT NULL,
    unidadmedida character varying(255) NOT NULL,
    constraint pk_unidadesmedidas primary key (codigounidadmedida)
);
CREATE TABLE if not exists esquemanuevo.productos
(
    codigoproductos bigint NOT NULL,
    nombreproducto character varying(250) NOT NULL,
	rubro bigint,
    constraint pk_productos primary key (codigoproductos),
	constraint fk_productos_rubros foreign key (rubro) references esquemanuevo.rubros(id_rubro) 
);
