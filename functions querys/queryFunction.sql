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
	elseif (validarformatorut(rut) = false) then 
		return 3;
	elseif (validardvrut(rut) = false) then
		return 4;
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
	   substr(rut, count, 1) != 'k' and substr(rut, count, 1) != '-' and
	   substr(rut, count, 1) != 'K') then
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
create or replace function ValidarFormatoRUT (rut character varying (12)) returns boolean
as
$$
declare
	--count integer;
begin
	if length(rut)>12 then --quita los posibles mayores de 12 caracteres
		return false;
	elseif
		left(right(rut,(2)), 1) != '-' then--verifica que el - este antes del codigo verificador
	return false;
		elseif
			rut not like '%.%.%' and length(rut)> 10 then -- verifica que si tiene mas de 10 caracts que use el formato con puntos
		return false;
			elseif
				rut like '%.%.%' and length(rut)<= 10 then -- verifica que si tiene menos de 10 caracts que no use el formato con puntos
			return false;
	else return true;
	end if;
end;
$$
language plpgsql;
create or replace function ValidarDVRUT (rut character varying (12)) returns boolean
as
$$
declare
	count integer;
	modulo11 character varying(8);
	copiarut character varying(8);
	suma integer;
	resultado integer;
begin
	count :=1;
	suma :=0;
	resultado :=0;
	modulo11 :='32765432';
	copiarut := translate (substr(rut,1,length(rut)-2),'.','');
	--raise notice 'copiarut: %', copiarut;

	while (count <= length(copiarut)) loop
	suma := suma + (substr(copiarut,count,1)::integer * substr(modulo11,count,1)::integer);
	count := count + 1;
	end loop;
	--raise notice 'suma: %', suma;
	resultado := 11 - mod(suma,11);
	--raise notice 'resultado: %', resultado;
	if right(rut,1) = resultado::character varying(2) then
		return true;
	elseif 10 = resultado and right(rut,1) = 'k' then
		return true;
	elseif 10 = resultado and right(rut,1) = 'K' then
		return true;
	elseif 11 = resultado and right(rut,1) = '0' then
		return true;
	else return false;
	end if;

end;
$$
language plpgsql;
-- Consulta a tabla unidadescompras para ver los rutunidadcompra que sean invalidos
select rutunidadcompra, validarut(rutunidadcompra) from unidadescompras
where validarut(rutunidadcompra) <> 0;
