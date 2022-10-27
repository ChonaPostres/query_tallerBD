--create type t_prodvalor as (idrubro integer, rubro varchar(255), montogastado bigint);
create or replace function listamontosxrubros (fechaaceptacion_inicio date, Fechaaceptacion_final date) returns setof t_prodvalor
as 
$$

declare
	nivel1 cursor for select id_rubro, rubro, 0::bigint from rubros where rubropadre is null;
	nivel2 cursor (padre integer) for select rubros.id_rubro, rubros.rubro, 0::bigint from rubros where rubropadre = padre;
	nivel3 cursor (padre integer) for select rubros.id_rubro, rubros.rubro, sum(itemeslicitaciones.totallineaneto) from rubros join productos ON productos.rubro = rubros.id_rubro join itemeslicitaciones ON itemeslicitaciones.codigoproducto = productos.codigoproductos join licitaciones ON itemeslicitaciones.idlicitacion = licitaciones.idlicitacion where rubropadre = padre and licitaciones.fechaaceptacion between fechaaceptacion_inicio and Fechaaceptacion_final group by rubros.id_rubro, rubros.rubro ;
	nivel4 cursor (padre integer) for select rubros.id_rubro, productos.nombreproducto, sum(itemeslicitaciones.totallineaneto) from rubros join productos ON productos.rubro = rubros.id_rubro join itemeslicitaciones ON itemeslicitaciones.codigoproducto = productos.codigoproductos join licitaciones ON itemeslicitaciones.idlicitacion = licitaciones.idlicitacion where rubropadre = padre and licitaciones.fechaaceptacion between fechaaceptacion_inicio and Fechaaceptacion_final group by rubros.id_rubro, productos.nombreproducto;

	registro1 t_prodvalor;
	registro2 t_prodvalor;
	registro3 t_prodvalor;
	registro4 t_prodvalor;
	counterN1 bigint;
	counterN2 bigint;
begin
	for registro1 in nivel1 loop
		return next registro1;
		open nivel2 (padre:=registro1.id_rubro);
		raise notice 'registro1: %', registro1.id_rubro;
		loop
			fetch next from nivel2 into registro2;
			exit when not found;
			return next registro2;
			raise notice 'registro2: %', registro2.idrubro;
			open nivel3 (padre:=registro2.idrubro);
			loop
				fetch next from nivel3 into registro3;
				exit when not found;
				return next registro3;
				raise notice 'registro3: %', registro3.idrubro;
				open nivel4 (padre:=registro2.idrubro);
				loop
					fetch next from nivel4 into registro4;
					exit when not found;
					return next registro4;
					raise notice 'registro4: %', registro4.idrubro;
				end loop;
				close nivel4;
			end loop;
			close nivel3;
		end loop;
		close nivel2;
	end loop;
end;
$$
language plpgsql;

select * from listamontosxrubros(date '2019/03/01', date '2019/04/01');

--select rubros.id_rubro, rubros.rubro, sum(itemeslicitaciones.totallineaneto) from rubros join rubros rubros2 ON rubros2.id_rubro = rubros.rubropadre join rubros rubros3 ON rubros3.id_rubro = rubros2.rubropadre join productos ON productos.rubro = rubros.id_rubro join itemeslicitaciones ON itemeslicitaciones.codigoproducto = productos.codigoproductos group by rubros.id_rubro, rubros.rubro;
