
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

--Regiones--
insert into regiones (idregion, region, pais) values (1, 'Región Aysén del General Carlos Ibáñez del Campo', 'CL');
insert into regiones (idregion, region, pais) values (2, 'Región de Antofagasta', 'CL');
insert into regiones (idregion, region, pais) values (3, 'Región de Arica y Parinacota', 'CL');
insert into regiones (idregion, region, pais) values (4, 'Región de Atacama', 'CL');
insert into regiones (idregion, region, pais) values (5, 'Región de Coquimbo', 'CL');
insert into regiones (idregion, region, pais) values (6, 'Región de la Araucanía', 'CL');
insert into regiones (idregion, region, pais) values (7, 'Región de los Lagos', 'CL');
insert into regiones (idregion, region, pais) values (8, 'Región de Los Ríos', 'CL');
insert into regiones (idregion, region, pais) values (9, 'Región de Tarapacá', 'CL');
insert into regiones (idregion, region, pais) values (10, 'Región de Valparaíso', 'CL');
insert into regiones (idregion, region, pais) values (11, 'Región del Biobío', 'CL');
insert into regiones (idregion, region, pais) values (12, 'Región del Libertador General Bernardo O´Higgins', 'CL');
insert into regiones (idregion, region, pais) values (13, 'Región del Biobío', 'CL');
insert into regiones (idregion, region, pais) values (14, 'Región del Maule', 'CL');
insert into regiones (idregion, region, pais) values (15, 'Región del Ñuble', 'CL');
insert into regiones (idregion, region, pais) values (16, 'Región Metropolitana de Santiago', 'CL');
insert into regiones (idregion, region, pais) values (17, 'Extranjero', 'CO');
insert into regiones (idregion, region, pais) values (18, 'Extranjero', 'CA');
insert into regiones (idregion, region, pais) values (19, 'Extranjero', 'US');
insert into regiones (idregion, region, pais) values (20, 'NA', 'NA');
insert into regiones (idregion, region, pais) values (21, '13', 'NA');
--delete from regiones;

insert into ciudades(ciudad, region)
select distinct traspaso.ciudadunidadcompra, regiones.idregion
from traspaso
join regiones
on (traspaso.regionunidadcompra = regiones.region);
--delete from ciudades;