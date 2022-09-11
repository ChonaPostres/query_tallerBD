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
