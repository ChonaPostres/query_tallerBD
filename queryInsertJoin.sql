/
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
-- Limpia los datos de regiones
select distinct regionunidadcompra from traspaso
union
select distinct regionproveedor from traspaso;

insert into regiones (idregion,region,pais) values (1,'Región de Tarapacá','CL');
insert into regiones (idregion,region,pais) values (2,'Región de Antofagasta','CL');
insert into regiones (idregion,region,pais) values (3,'Región de Atacama','CL');
insert into regiones (idregion,region,pais) values (4,'Región de Coquimbo','CL');
insert into regiones (idregion,region,pais) values (5,'Región de Valparaíso','CL');
insert into regiones (idregion,region,pais) values (6,'Región del Libertador General Bernardo O´Higgins','CL');
insert into regiones (idregion,region,pais) values (7,'Región del Maule','CL');
insert into regiones (idregion,region,pais) values (8,'Región del Biobio','CL');
insert into regiones (idregion,region,pais) values (9,'Región de La Araucanía','CL');
insert into regiones (idregion,region,pais) values (10,'Región de Los Lagos','CL');
insert into regiones (idregion,region,pais) values (11,'Región Aisén del General Carlos Ibañez del Campo','CL');
insert into regiones (idregion,region,pais) values (12,'Región de Magallanes y Antártica Chilena','CL');
insert into regiones (idregion,region,pais) values (13,'Región Metropolitana de Santiago','CL');
insert into regiones (idregion,region,pais) values (14,'Región de Los Ríos','CL');
insert into regiones (idregion,region,pais) values (15,'Región de Arica y Parinacota','CL');
insert into regiones (idregion,region,pais) values (16,'Región de Ñuble','CL');

update traspaso set regionunidadcompra = 'Región de Tarapacá'
where upper(regionunidadcompra) like '%TARAP%';
update traspaso set regionproveedor = 'Región de Tarapacá'
where upper(regionproveedor) like '%TARAP%';

update traspaso set regionunidadcompra = 'Región de Antofagasta'
where upper(regionunidadcompra) like '%ANTOFA%';
update traspaso set regionproveedor = 'Región de Antofagasta'
where upper(regionproveedor) like '%ANTOFA%';

update traspaso set regionunidadcompra = 'Región de Atacama'
where upper(regionunidadcompra) like '%ATACAM%';
update traspaso set regionproveedor = 'Región de Atacama'
where upper(regionproveedor) like '%ATACAM%';

update traspaso set regionunidadcompra = 'Región de Coquimbo'
where upper(regionunidadcompra) like '%COQUIM%';
update traspaso set regionproveedor = 'Región de Coquimbo'
where upper(regionproveedor) like '%COQUIM%';

update traspaso set regionunidadcompra = 'Región de Valparaíso'
where upper(regionunidadcompra) like '%VALPARA%';
update traspaso set regionproveedor = 'Región de Valparaíso'
where upper(regionproveedor) like '%VALPARA%';

update traspaso set regionunidadcompra = 'Región del Libertador General Bernardo O´Higgins'
where upper(regionunidadcompra) like '%HIGGI%';
update traspaso set regionproveedor = 'Región del Libertador General Bernardo O´Higgins'
where upper(regionproveedor) like '%HIGGI%';

update traspaso set regionunidadcompra = 'Región del Maule'
where upper(regionunidadcompra) like '%MAULE%';
update traspaso set regionproveedor = 'Región del Maule'
where upper(regionproveedor) like '%MAULE%';
update traspaso set regionproveedor = 'Región del Maule'
where upper(regionproveedor) like '%TALCA%';

update traspaso set regionunidadcompra = 'Región del Biobio'
where upper(regionunidadcompra) like '%BIOB%';
update traspaso set regionproveedor = 'Región del Biobio'
where upper(regionproveedor) like '%BIOB%';

update traspaso set regionunidadcompra = 'Región de La Araucanía'
where upper(regionunidadcompra) like '%ARAUCAN%';
update traspaso set regionproveedor = 'Región de La Araucanía'
where upper(regionproveedor) like '%ARAUCAN%';

update traspaso set regionunidadcompra = 'Región de Los Lagos'
where upper(regionunidadcompra) like '%LAGOS%';
update traspaso set regionproveedor = 'Región de Los Lagos'
where upper(regionproveedor) like '%LAGOS%';

update traspaso set regionunidadcompra = 'Región Aisén del General Carlos Ibañez del Campo'
where upper(regionunidadcompra) like '%AYS%';
update traspaso set regionproveedor = 'Región Aisén del General Carlos Ibañez del Campo'
where upper(regionproveedor) like '%AYS%';

update traspaso set regionunidadcompra = 'Región de Magallanes y Antártica Chilena'
where upper(regionunidadcompra) like '%MAGALL%';
update traspaso set regionproveedor = 'Región de Magallanes y Antártica Chilena'
where upper(regionproveedor) like '%MAGALL%';

update traspaso set regionunidadcompra = 'Región Metropolitana de Santiago'
where upper(regionunidadcompra) like '%SANTIA%';
update traspaso set regionproveedor = 'Región Metropolitana de Santiago'
where upper(regionproveedor) like '%SANTIA%' or upper(regionproveedor) like '%METROPO%';

update traspaso set regionunidadcompra = 'Región de Los Ríos'
where upper(regionunidadcompra) like '%LOS R%';
update traspaso set regionproveedor = 'Región de Los Ríos'
where upper(regionproveedor) like '%LOS R%';

update traspaso set regionunidadcompra = 'Región de Arica y Parinacota'
where upper(regionunidadcompra) like '%ARICA%';
update traspaso set regionproveedor = 'Región de Arica y Parinacota'
where upper(regionproveedor) like '%ARICA%';

update traspaso set regionunidadcompra = 'Región de Ñuble'
where upper(regionunidadcompra) like '%UBLE%';
update traspaso set regionproveedor = 'Región de Ñuble'
where upper(regionproveedor) like '%UBLE%';
--delete from regiones;

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
drop table if exists tmp_unidadescompra;
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

--Proveedores--
select distinct traspaso.codigoproveedor::integer, traspaso.nombreproveedor, ciudades.idciudad, replace(promediocalificacion, ',','.')::numeric as promediocalificacion, traspaso.cantidadevaluacion::numeric
into tmp_proveedores
from traspaso
join ciudades
on (traspaso.comunaproveedor = ciudades.ciudad);

insert into proveedores(codigoproveedor, nombreproveedor, comuna, promedioevalaucion, cantidadevalaucion)
select codigoproveedor, nombreproveedor, max(idciudad) as idciudad,  promediocalificacion, cantidadevaluacion
from tmp_proveedores
group by codigoproveedor, nombreproveedor, promediocalificacion, cantidadevaluacion;

drop table tmp_proveedores;
--delete from proveedores;

--Productos--
--insert into productos(codigoproducto,rubro)
--select distinct traspaso.codigoproductoonu :: bigint ,rubros.id_rubro
--FROM traspaso
--join rubros
--on(traspaso.rubron3 = rubros.rubro)
--where traspaso.rubron3 <> 'NA'
--where traspaso.codigoproductoonu = '14111601'

