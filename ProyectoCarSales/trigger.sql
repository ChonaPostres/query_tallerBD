-- Uso de triggers para manejo de Logs de transacciones sobre tabla 
create table if not exists auditoria("nombretabla" varchar, "accion" varchar, "fecha-hora" timestamp, "usuario" varchar, "valorcampo" varchar);
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

create trigger TR_Insert_ofertas after insert on ofertas
for each row execute procedure SP_auditoria();

create trigger TR_Update_ofertas after update on ofertas
for each row execute procedure SP_auditoria();

create trigger TR_Delete_ofertas before delete on ofertas
for each row execute procedure SP_auditoria();

create trigger TR_Insert_vehiculos after insert on vehiculos
for each row execute procedure SP_auditoria();

create trigger TR_Update_vehiculos after update on vehiculos
for each row execute procedure SP_auditoria();

create trigger TR_Delete_vehiculos before delete on vehiculos
for each row execute procedure SP_auditoria();

create trigger TR_Insert_caracteristicas after insert on caracteristicas
for each row execute procedure SP_auditoria();

create trigger TR_Update_caracteristicas after update on caracteristicas
for each row execute procedure SP_auditoria();

create trigger TR_Delete_caracteristicas before delete on caracteristicas
for each row execute procedure SP_auditoria();

create trigger TR_Insert_estados after insert on estados
for each row execute procedure SP_auditoria();

create trigger TR_Update_estados after update on estados
for each row execute procedure SP_auditoria();

create trigger TR_Delete_estados before delete on estados
for each row execute procedure SP_auditoria();

create trigger TR_Insert_motores after insert on motores
for each row execute procedure SP_auditoria();

create trigger TR_Update_motores after update on motores
for each row execute procedure SP_auditoria();

create trigger TR_Delete_motores before delete on motores
for each row execute procedure SP_auditoria();

create trigger TR_Insert_empresas after insert on empresas
for each row execute procedure SP_auditoria();

create trigger TR_Update_empresas after update on empresas
for each row execute procedure SP_auditoria();

create trigger TR_Delete_empresas before delete on empresas
for each row execute procedure SP_auditoria();

create trigger TR_Insert_condicion_cuerpos after insert on condicion_cuerpos
for each row execute procedure SP_auditoria();

create trigger TR_Update_condicion_cuerpos after update on condicion_cuerpos
for each row execute procedure SP_auditoria();

create trigger TR_Delete_condicion_cuerpos before delete on condicion_cuerpos
for each row execute procedure SP_auditoria();

create trigger TR_Insert_condicion_mecanicas after insert on condicion_mecanicas
for each row execute procedure SP_auditoria();

create trigger TR_Update_condicion_mecanicas after update on condicion_mecanicas
for each row execute procedure SP_auditoria();

create trigger TR_Delete_condicion_mecanicas before delete on condicion_mecanicas
for each row execute procedure SP_auditoria();

create trigger TR_Insert_tipo_vendedores after insert on tipo_vendedores
for each row execute procedure SP_auditoria();

create trigger TR_Update_tipo_vendedores after update on tipo_vendedores
for each row execute procedure SP_auditoria();

create trigger TR_Delete_tipo_vendedores before delete on tipo_vendedores
for each row execute procedure SP_auditoria();

create trigger TR_Insert_tipo_cuerpos after insert on tipo_cuerpos
for each row execute procedure SP_auditoria();

create trigger TR_Update_tipo_cuerpos after update on tipo_cuerpos
for each row execute procedure SP_auditoria();

create trigger TR_Delete_tipo_cuerpos before delete on tipo_cuerpos
for each row execute procedure SP_auditoria();

create trigger TR_Insert_colores after insert on colores
for each row execute procedure SP_auditoria();

create trigger TR_Update_colores after update on colores
for each row execute procedure SP_auditoria();

create trigger TR_Delete_colores before delete on colores
for each row execute procedure SP_auditoria();

create trigger TR_Insert_cilindros after insert on cilindros
for each row execute procedure SP_auditoria();

create trigger TR_Update_cilindros after update on cilindros
for each row execute procedure SP_auditoria();

create trigger TR_Delete_cilindros before delete on cilindros
for each row execute procedure SP_auditoria();

create trigger TR_Insert_specs_regionales after insert on specs_regionales
for each row execute procedure SP_auditoria();

create trigger TR_Update_specs_regionales after update on specs_regionales
for each row execute procedure SP_auditoria();

create trigger TR_Delete_specs_regionales before delete on specs_regionales
for each row execute procedure SP_auditoria();

create trigger TR_Insert_horse_powers after insert on horse_powers
for each row execute procedure SP_auditoria();

create trigger TR_Update_horse_powers after update on horse_powers
for each row execute procedure SP_auditoria();

create trigger TR_Delete_horse_powers before delete on horse_powers
for each row execute procedure SP_auditoria();

create trigger TR_Insert_costados_manubrio after insert on costados_manubrio
for each row execute procedure SP_auditoria();

create trigger TR_Update_costados_manubrio after update on costados_manubrio
for each row execute procedure SP_auditoria();

create trigger TR_Delete_costados_manubrio before delete on costados_manubrio
for each row execute procedure SP_auditoria();

create trigger TR_Insert_tipo_transmisiones after insert on tipo_transmisiones
for each row execute procedure SP_auditoria();

create trigger TR_Update_tipo_transmisiones after update on tipo_transmisiones
for each row execute procedure SP_auditoria();

create trigger TR_Delete_tipo_transmisiones before delete on tipo_transmisiones
for each row execute procedure SP_auditoria();

create trigger TR_Insert_tipo_combustibles after insert on tipo_combustibles
for each row execute procedure SP_auditoria();

create trigger TR_Update_tipo_combustibles after update on tipo_combustibles
for each row execute procedure SP_auditoria();

create trigger TR_Delete_tipo_combustibles before delete on tipo_combustibles
for each row execute procedure SP_auditoria();

create trigger TR_Insert_anios after insert on anios
for each row execute procedure SP_auditoria();

create trigger TR_Update_anios after update on anios
for each row execute procedure SP_auditoria();

create trigger TR_Delete_anios before delete on anios
for each row execute procedure SP_auditoria();

create trigger TR_Insert_modelos after insert on modelos
for each row execute procedure SP_auditoria();

create trigger TR_Update_modelos after update on modelos
for each row execute procedure SP_auditoria();

create trigger TR_Delete_modelos before delete on modelos
for each row execute procedure SP_auditoria();

-- Ejemplo Insert colores
insert into colores(color) values ('Cyan');
-- Ver Tablas
select * from colores;
select * from auditoria;
