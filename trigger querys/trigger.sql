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
for each row
execute procedure SP_auditoria();

create trigger TR_Delete_licitaciones before delete on licitaciones
for each row
execute procedure SP_auditoria();

create trigger TR_Insert_itemeslicitaciones after insert on itemeslicitaciones
for each row
execute procedure SP_auditoria();

create trigger TR_Update_itemeslicitaciones after update on itemeslicitaciones
for each row
execute procedure SP_auditoria();

create trigger TR_Delete_itemeslicitaciones before delete on itemeslicitaciones
for each row
execute procedure SP_auditoria();

-- Ejemplo Update licitaciones
update licitaciones set nombre = 'RUTA 1, KM. 10,00 AL KM. 25,00 TAL TAL-ANTOFAGASTA' where idlicitacion = 28856773;
update licitaciones set nombre = 'nombre licitacion' where idlicitacion = 28856773;
select * from licitaciones where idlicitacion = 28856773;
-- Ver Tablas
select * from licitaciones
select * from auditoria;
