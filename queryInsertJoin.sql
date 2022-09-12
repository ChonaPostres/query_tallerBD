/*
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
*/
--Ciudades--
insert into ciudades(ciudad, region)
select distinct traspaso.ciudadunidadcompra, regiones.idregion
from traspaso
join regiones
on (traspaso.regionunidadcompra = regiones.region);
--delete from ciudades;

--Proveedores--
-- no funciona por que en traspaso.promediocalificacion::numeric no funciona el casteo debido a que los numeros estan con ','
insert into proveedores(codigoproveedor, nombreproveedor, comuna, promedioevalaucion, cantidadevalaucion)
select distinct traspaso.codigoproveedor::integer, traspaso.nombreproveedor, ciudades.idciudad, replace(promediocalificacion, ',','.')::numeric, traspaso.cantidadevaluacion::numeric
from traspaso
join ciudades
on (traspaso.comunaproveedor = ciudades.ciudad);
--delete from proveedores;

--UnidadesCompras--
update traspaso set rutunidadcompra = '61.607.301-k'
where codigounidadcompra = '61.607.301-k';

drop table if exists tmp_unidadescompra;

select distinct codigounidadcompra::integer, upper(rutunidadcompra) as rutunidadcompra, unidadcompra,codigoorganismopublico::integer,
c.idciudad
into tmp_unidadescompra
from traspaso t
join ciudades c on t.ciudadunidadcompra = c.ciudad;

insert into unidadescompras (codigounidadcompra, rutunidadcompra,
unidadcompra,codigoorganismopublico, ciudad)
select codigounidadcompra, rutunidadcompra,
max(unidadcompra), codigoorganismopublico, max(idciudad) as idciudad
from tmp_unidadescompra
group by codigounidadcompra, rutunidadcompra, codigoorganismopublico;
--delete from unidadescompras;

--Rubros--
insert into rubros (rubro) 
select DISTINCT rubron1 from traspaso;

insert into rubros(rubro,rubropadre)
select distinct traspaso.rubron2, rubros.id_rubro
from traspaso
join rubros
on (traspaso.rubron1 = rubros.rubro);

insert into rubros(rubro,rubropadre)
select distinct traspaso.rubron3, rubros.id_rubro
from traspaso
join rubros
on (traspaso.rubron2 = rubros.rubro);
--delete from rubros;

--Productos--
--insert into productos(codigoproducto,rubro)
--select distinct traspaso.codigoproductoonu :: bigint ,rubros.id_rubro
--FROM traspaso
--join rubros
--on(traspaso.rubron3 = rubros.rubro)
--where traspaso.rubron3 <> 'NA'
--where traspaso.codigoproductoonu = '14111601'

