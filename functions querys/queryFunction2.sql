-- Parte 1
create or replace function Listaritemescompradosendedor (
    cod_organismopublico integer, 
	cod_unidadcompra integer,
    cod_sector integer, 
	nombre_proveedor character varying,
    nombre_producto character varying, 
	cod_rubron1 integer, cod_rubron3 integer, 
	fechainicio date, fechafinal date
)
returns table (
	organismoPublico character varying,
	unidadCompra character varying,
	sector character varying,
	proveedor character varying,
	producto character varying,
	rubron3 character varying,
	fechaaceptacion date,
	totallienaneto bigint
)
as
$$
declare
begin
	return query 
	select
		organismospublicos.organismopublico,
		unidadescompras.unidadcompra, 
		sectores.sector, 
		proveedores.nombreproveedor, 
		productos.nombreproducto, 
		rubron3.rubro, 
		licitaciones.fechaaceptacion,
		itemeslicitaciones.totallineaneto
	from itemeslicitaciones
	join licitaciones ON licitaciones.idlicitacion = itemeslicitaciones.idlicitacion
	join unidadescompras ON unidadescompras.codigounidadcompra = licitaciones.codigounidadcompra
	join organismospublicos ON organismospublicos.codigoorganismopublico = unidadescompras.codigoorganismopublico
	join sectores ON sectores.idsector = organismospublicos.sector
	join sucursales ON sucursales.codigosucursal = licitaciones.codigosucursal
	join proveedores ON proveedores.codigoproveedor = sucursales.proveedor
	join productos ON productos.codigoproductos = itemeslicitaciones.codigoproducto
	join rubros as rubron1 ON rubron1.id_rubro = productos.rubro
	join rubros as rubron2 ON rubron2.id_rubro = rubron1.rubropadre
	join rubros as rubron3 ON rubron3.id_rubro = rubron2.rubropadre
	where 
		(cod_organismopublico = organismospublicos.codigoorganismopublico or cod_organismopublico is null) and
		(cod_unidadcompra = unidadescompras.codigounidadcompra or cod_unidadcompra is null) and
		(cod_sector = sectores.idsector or cod_sector is null) and
		(nombre_proveedor = proveedores.nombreproveedor or nombre_proveedor is null) and
		(nombre_producto = productos.nombreproducto or nombre_producto is null) and
		(cod_rubron1 = rubron1.id_rubro or cod_rubron1 is null) and 
		(cod_rubron3 = rubron3.id_rubro or cod_rubron3 is null) and
		(licitaciones.fechaaceptacion between fechainicio and fechafinal 
		or fechainicio is null or fechafinal is null)
		;
end;
$$
language plpgsql;
-- Ejemplos de uso
select * from Listaritemescompradosendedor(7231, 1881, null, 'JUAN CARLOS', null, null, null, date '2019/03/01', date '2019/04/01');
select * from Listaritemescompradosendedor(7231, null, null, null, null, null, null, date '2019/03/01', date '2019/04/01');
select * from Listaritemescompradosendedor(null, null, null, null, null, null, null, null, null);

create type t_prodvalor as (idrubro integer, rubro varchar(255));
create or replace function listamontosxrubros (fechaaceptacion_inicio date, Fechaaceptacion_final date) returns setof t_prodvalor
as 
$$
declare
	nivel1 cursor for select id_rubro, rubro from rubros where rubropadre is null;
	nivel2 cursor (padre integer) for select id_rubro, rubro from rubros where rubropadre = padre;
	registro1 t_prodvalor;
	registro2 t_prodvalor;
	agrupacionmontogastado1 bigint;
	agrupacionmontogastado2 bigint;
begin
	agrupacionmontogastado1 = 0;
	agrupacionmontogastado2 = 0;
	for registro1 in nivel1 loop
		return next registro1;
		agrupacionmontogastado1 = agrupacionmontogastado1 + (select totallineaneto from rubros join productos ON productos.rubro = registro1.id_rubro join itemeslicitaciones ON itemeslicitaciones.codigoproducto = productos.codigoproductos where rubros.id_rubro = registro1.id_rubro);
		raise notice 'agrupacionmontogastado1: %', agrupacionmontogastado1;
		
		open nivel2 (padre:=registro1.id_rubro);
		loop
			fetch next from nivel2 into registro2;
			agrupacionmontogastado2 = agrupacionmontogastado2 + (select totallineaneto from rubros join productos ON productos.rubro = registro1.id_rubro join itemeslicitaciones ON itemeslicitaciones.codigoproducto = productos.codigoproductos where rubros.id_rubro = registro2.idrubro);
			raise notice 'agrupacionmontogastado2: %', agrupacionmontogastado2;
			exit when not found;
			return next registro2;
		end loop;
		close nivel2;
	end loop;
	raise notice 'agrupacionmontogastado1: %', agrupacionmontogastado1;
	raise notice 'agrupacionmontogastado2: %', agrupacionmontogastado2;
end;
$$
language plpgsql;

select * from listamontosxrubros(date '2019/03/01', date '2019/04/01');