--create type t_prodvalor as (idrubro integer, rubro varchar(255));
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