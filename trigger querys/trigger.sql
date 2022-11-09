-- Parte 1
create table if not exists AUDITORIA("nombretabla" varchar, "accion" varchar, "fecha-hora" timestamp, "usuario" varchar, "valorcampo" varchar);
--drop table auditoria;
create or replace function SP_auditoria () returns Trigger
as 
$$
declare
	fecha_hora timestamp;
	usuario varchar;
begin
	fecha_hora = NOW();
	usuario = USER;
	if (TG_OP = 'INSERT' or TG_OP = 'UPDATE') then
		insert into AUDITORIA values (TG_TABLE_NAME, TG_OP, fecha_hora, usuario, NEW.*::text);
	elseif (TG_OP = 'DELETE') then
		insert into AUDITORIA values (TG_TABLE_NAME, TG_OP, fecha_hora, usuario, OLD.*::text);
	else
		raise notice 'accion no encontrada: %', TG_OP;
	end if;
	
	if TG_OP = 'DELETE' then
    	return old;
	else
    	return new;
END IF;
end;
$$
language plpgsql;

create trigger TR_Insert_licitaciones after insert on licitaciones
for each row execute procedure SP_auditoria();

create trigger TR_Update_licitaciones after update on licitaciones
for each row execute procedure SP_auditoria();

create trigger TR_Delete_licitaciones before delete on licitaciones
for each row execute procedure SP_auditoria();

create trigger TR_Insert_itemeslicitaciones after insert on itemeslicitaciones
for each row execute procedure SP_auditoria();

create trigger TR_Update_itemeslicitaciones after update on itemeslicitaciones
for each row execute procedure SP_auditoria();

create trigger TR_Delete_itemeslicitaciones before delete on itemeslicitaciones
for each row execute procedure SP_auditoria();

-- Ejemplo Update licitaciones
update licitaciones set nombre = 'RUTA 1, KM. 10,00 AL KM. 25,00 TAL TAL-ANTOFAGASTA' where idlicitacion = 28856773;
update licitaciones set nombre = 'nombre licitacion' where idlicitacion = 28856773;
select * from licitaciones where idlicitacion = 28856773;
-- Ver Tablas
select * from licitaciones
select * from auditoria;

-- Parte 2

create table if not exists presupuestomensual("codigounidadcompra" varchar, "periodo" date, "presupuesto" bigint);
drop table presupuestomensual;

insert into presupuestomensual (codigounidadcompra, periodo, presupuesto)
select distinct codigounidadcompra, to_date(to_char(fechaenvio, 'YYYYMM'), 'YYYYMM'), sum(totalnetooc) from licitaciones
group by codigounidadcompra, to_date(to_char(fechaenvio, 'YYYYMM'), 'YYYYMM');

select * from presupuestomensual;

CREATE OR REPLACE FUNCTION Vpresupuesto() returns trigger AS
$$
declare
	totalpresupuesto bigint;
BEGIN
	totalpresupuesto = (select sum(presupuesto) from presupuestomensual 
						group by codigounidadcompra, periodo
						having (codigounidadcompra = (new.codigounidadcompra)::varchar and periodo <= to_date(to_char(new.fechaenvio, 'YYYYMM'), 'YYYYMM')
						and periodo >= to_date(extract(year from new.fechaenvio) || '-' || extract(month from new.fechaenvio - 1) ||'-01')));
	raise notice 'total presupuesto: %', totalpresupuesto;
	if (new.totalnetooc > totalpresupuesto) then
		raise notice 'no queda presupuesto para insertar licitacion: %', new.totalnetooc;
		return null;
	end if;
	return new;
END;
$$
LANGUAGE 'plpgsql';
								
create trigger TR_Insert_licitaciones_presupuesto before insert on licitaciones
for each row execute procedure Vpresupuesto();

create trigger TR_Update_licitaciones_presupuesto before update on licitaciones
for each row execute procedure Vpresupuesto();

select totalnetooc from licitaciones where codigounidadcompra = 5961;
select * from licitaciones;
update licitaciones set totalnetooc = 3534300001 where idlicitacion = 28856773;
select * from presupuestomensual where codigounidadcompra = '5961';


-- Parte 3

create or replace function SP_sumarizacion () returns Trigger
as 
$$
declare
begin
	if ((TG_OP = 'INSERT' or TG_OP = 'UPDATE' or TG_OP = 'DELETE') and new.totallineaneto <> old.totallineaneto) then
		update licitaciones set totalnetooc = new.totallineaneto where idlicitacion = new.idlicitacion;
	else
		raise notice 'accion no encontrada: %', TG_OP;
	end if;
	
	if TG_OP = 'DELETE' then
    	return old;
	else
    	return new;
END IF;
end;
$$
language plpgsql;

create trigger TR_Insert_itemeslicitaciones_sumarizacion after insert on itemeslicitaciones
for each row execute procedure SP_sumarizacion();

create trigger TR_Update_itemeslicitaciones_sumarizacion after update on itemeslicitaciones
for each row execute procedure SP_sumarizacion();

create trigger TR_Delete_itemeslicitaciones_sumarizacion before delete on itemeslicitaciones
for each row execute procedure SP_sumarizacion();

-- Ejemplo:
update itemeslicitaciones set totallineaneto = 2 where idlicitacion = 28856773;
update itemeslicitaciones set totallineaneto = 3534300000 where idlicitacion = 28856773;
select totalnetooc from licitaciones where idlicitacion = 28856773;
select totallineaneto from itemeslicitaciones where idlicitacion = 28856773;
