
--OrganismosPublicos--
insert into organismospublicos(codigoorganismopublico, organismopublico, sector)
select distinct traspaso.codigoorganismopublico::integer, traspaso.organismopublico, sectores.idsector
from traspaso
join sectores
on (traspaso.sector = sectores.sector);
--delete from organismospublicos;

--Procedencias--
insert into procedencias(procedencia, tipo)
select distinct traspaso.procedencia, tipos.tipo
from traspaso
join tipos
on (traspaso.tipo = tipos.tipo);
--delete from procedencias;