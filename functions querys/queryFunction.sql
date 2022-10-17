create or replace function ValidaRUT (rut character varying (12)) returns integer
as 
$$   
declare
--- declaración de variables a usar, formato: nombre tipo
begin
--- cuerpo de la función
	raise notice 'Value: %', rut;
	if (rut is null) then
		return 1;
	elseif (validarcaracteresrut(rut) = false) then 
		return 2;
	end if;
	return 0;
end;
$$ 
language plpgsql;

create or replace function ValidarCaracteresRUT (rut character varying (12)) returns boolean
as
$$
declare
	count integer;
begin
	count = 1;
	
	loop
	--raise notice 'substring: %', substr(rut, count, 1);
	if (substr(rut, count, 1) != '0' and substr(rut, count, 1) != '1' and
	   substr(rut, count, 1) != '2' and substr(rut, count, 1) != '3' and
	   substr(rut, count, 1) != '4' and substr(rut, count, 1) != '5' and
	   substr(rut, count, 1) != '6' and substr(rut, count, 1) != '7' and
	   substr(rut, count, 1) != '8' and substr(rut, count, 1) != '9' and
	   substr(rut, count, 1) != '.' and substr(rut, count, 1) != '-' and
	   substr(rut, count, 1) != 'k') then
		--raise notice 'false';
		return false;
	end if;
	if (count = char_length(rut)) then
		exit;
	end if;
	count = count + 1;
	end loop;
	return true;
end;
$$
language plpgsql;

-- Consulta a tabla unidadescompras para ver los rutunidadcompra que sean invalidos 
select rutunidadcompra, validarut(rutunidadcompra) from unidadescompras
where validarut(rutunidadcompra) <> 0;