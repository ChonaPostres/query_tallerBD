----------------------------------------------------------Parte 1----------------------------------------------------------
-------Tipos-------
insert into tipos(tipo,codigoabreviatura,descripcion,codigotipo)
select distinct tipo, codigoabreviatura, descripciontipooc, codigotipo::integer
from traspaso;
--delete from tipos;

-------EstadosCompras-------
insert into estadoscompras(codigoestado,estado)
select distinct codigoestado::integer,estado from traspaso;
--delete from estadoscompras;

-------EstadosProveedores-------
insert into estadosproveedores(codigoestado, estado)
select distinct cast(codigoestadorpoveedor as integer), estadoproveedor
from traspaso;
--delete from estadosproveedores;

-------TiposImpuestos-------
insert into tiposimpuestos(impuesto)
select distinct tipoimpuesto from traspaso;
--delete from tiposimpuestos;

-------TiposDespachos-------
insert into tiposdespachos(idtipodespacho, tipodespacho)
select distinct cast(tipodespacho as integer), 'tipodespacho'
from traspaso;
--delete from tiposdespachos;

-------TiposMonedas-------
insert into tiposmonedas(codigomoneda,nombremoneda)
select distinct tipomoneda, 'x' from traspaso;
update tiposmonedas set nombremoneda = 'Pesos Chilenos'
where codigomoneda = 'CLP';
update tiposmonedas set nombremoneda = 'Unidad Tributaria Mensual'
where codigomoneda = 'UTM';
update tiposmonedas set nombremoneda = 'Euros'
where codigomoneda = 'EUR';
update tiposmonedas set nombremoneda = 'Dolar Norteamericano'
where codigomoneda = 'USD';
update tiposmonedas set nombremoneda = 'Unidad de Fomento'
where codigomoneda = 'CLF';
--delete from tiposmonedas;

-------UnidadesMedidas-------
insert into unidadesmedidas(unidadmedida)
select distinct unidadmedida from traspaso;
--delete from unidadesmedidas;

-------FormasPagos-------
insert into formaspagos(idformapago,formapago)
select distinct formapago::int, formapago2 from traspaso
where formapago <> 'NA' and (formapago<>'39' or formapago2<>'NA');
--delete from formaspagos;

-------Sectores-------
insert into sectores (sector)
select distinct sector from traspaso;
--delete from sectores;

-------Paises-------
insert into paises(codigopais, pais)
select distinct trim(cast(case
    when traspaso.paisproveedor = 'NA' then 'NA'
    when traspaso.paisproveedor = 'Francia' then 'FR'
    when traspaso.paisproveedor = 'Alemania' then 'DE'
    when traspaso.paisproveedor = 'Colombia' then 'CO'
    when traspaso.paisproveedor = 'Irlanda' then 'IE'
    when traspaso.paisproveedor = 'Bélgica' then 'BE'
    when traspaso.paisproveedor = 'República Dominicana' then 'DO'
    when traspaso.paisproveedor = 'Argentina' then 'AR'
    when traspaso.paisproveedor = 'Cuba' then 'CU'
    when traspaso.paisproveedor = 'España' then 'ES'
    when traspaso.paisproveedor = 'Estados Unidos' then 'US'
    when traspaso.paisproveedor = 'Venezuela' then 'VE'
    when traspaso.paisproveedor = 'Reino Unido' then 'UK'
    when traspaso.paisproveedor = 'Eslovaquia' then 'SK'
    when traspaso.paisproveedor = 'India' then 'IN'
    when traspaso.paisproveedor = 'Chile' then 'CL'
    when traspaso.paisproveedor = 'Polonia' then 'PL'
    when traspaso.paisproveedor = 'Austria' then 'AT'
    when traspaso.paisproveedor = 'Canadá' then 'CA'
    else 'NA' end as varchar(5))), cast(case
        when traspaso.paisproveedor = '' then 'NA'
        when traspaso.paisproveedor = 'CL' then 'NA'
        else traspaso.paisproveedor end as varchar(100))
from traspaso
where traspaso.paisproveedor is not null;
--delete from paises;

-------ActividadesProveedores-------
insert into actividadesproveedores(actividadproveedor)
select distinct actividadproveedor
from traspaso;
--delete from actividadesproveedores;

-------Categorias-------
insert into categorias (codigocategoria,categoria)
select distinct codigocategoria::bigint, 
case when char_length(max(categoria)) > 255 then left(max(categoria), 255) else max(categoria) end as categoria
from traspaso
where codigocategoria <> 'NA'
group by codigocategoria;
--delete from categorias;

----------------------------------------------------------Parte 2----------------------------------------------------------
----Fix limpiar comunas-----

-- Creo tabla tamporal con comuna y region del proveedor

select distinct comunaproveedor, regionproveedor into tmpcomunas from traspaso;

-- De la tabla temporal listo las comunas que están en mas de 1 region

select comunaproveedor, count(regionproveedor) from tmpcomunas 
group by comunaproveedor
having count(regionproveedor) > 1;

-- Por cada comuna veo a que region esta asociada y reviso la correcta
-- La mayoria de los casos es por la region del Maule, aun siguen
-- en region de Biobio (como Maule se creo hace poco)

select distinct comunaproveedor, regionproveedor from traspaso
    where comunaproveedor like 'Coihueco';

-- Realizo el update de cada comuna a su region correspondiente
-- (son solo 20 errores)    

update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Chill%n';
update traspaso set regionproveedor = 'Región Metropolitana de Santiago' 
     where comunaproveedor like 'Santiago';
update traspaso set regionproveedor = 'Región de Valparaíso' 
     where comunaproveedor like 'La Ligua';
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Yungay';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'San Carlos'; 
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Pinto'; 
update traspaso set regionproveedor = 'Región de Arica y Parinacota' 
     where comunaproveedor like 'Arica'; 
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Ninhue'; 
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Quirihue';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Coelemu';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Bulnes';
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Quill%n';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Chill%Viejo';   
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Ranquil';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'San Fabi%n';  
update traspaso set regionproveedor = 'Región Metropolitana de Santiago' 
     where comunaproveedor like 'Las Condes';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'San Ignacio';
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Portezuelo'; 
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'El Carmen';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Coihueco';  




-- Lo mismo anterior para unidad de compra

select distinct ciudadunidadcompra, regionunidadcompra into tmpcomunas2 from traspaso;

select ciudadunidadcompra, count(regionunidadcompra) from tmpcomunas2 
group by ciudadunidadcompra
having count(regionunidadcompra) > 1;

select distinct ciudadunidadcompra, regionunidadcompra from traspaso
    where ciudadunidadcompra like '%*%';
 

update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Chill%n Viejo';
update traspaso set regionunidadcompra = 'Región Metropolitana de Santiago' 
     where ciudadunidadcompra like 'Santiago';
update traspaso set regionunidadcompra = 'Región de Valparaíso' 
     where ciudadunidadcompra like 'La Ligua';
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Yungay';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'San Carlos'; 
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Pinto'; 
update traspaso set regionunidadcompra = 'Región de Arica y Parinacota' 
     where ciudadunidadcompra like 'Arica'; 
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Ninhue'; 
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Quirihue';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Coelemu';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Bulnes';
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Quill%n';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Chilla%Viejo';   
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Ranquil';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'San Fabi%n';  
update traspaso set regionunidadcompra = 'Región Metropolitana de Santiago' 
     where ciudadunidadcompra like 'Las Condes';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'San Ignacio';
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Portezuelo'; 
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'El Carmen';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Coihueco';   
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like '%iqu%n'; 
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'San Nicol%s';

drop table tmpcomunas; 
drop table tmpcomunas2;

------Fix limpia proveedores con nombres distintos------

----  proveedores  ----
-- 1.- creo una tabla temporal con proveedores y rut 
select distinct codigoproveedor, nombreproveedor
into tmp_proveedores1
from traspaso;

-- 2.- creo otra tabla temporal desde la anterior
--     que tiene proveedores con rut y nombre inconsitente.
--     Uso un max para dejar un solo nombre por rut

select codigoproveedor, max(nombreproveedor) as nombremax
into tmp_proveedores2
from tmp_proveedores1
group by codigoproveedor
having count(nombreproveedor)>1;

-- 3.- uso los datos de la segunda temporal para modificar
--     los datos de la tabla traspaso

update traspaso as t set nombreproveedor = nombremax
from tmp_proveedores2 as p
where t.codigoproveedor = p.codigoproveedor;

-- 4.- Elimino las tablas temporales
drop table tmp_proveedores1;
drop table tmp_proveedores2;

------Fix modificar tabla proveedores------
-- PRoveedores actividad proveedor ---
--
--   OBS: Un proveedor PODRIA TENER MAS DE UNA ACTIVIDAD
--        lo cual seria valido. Por lo anterior, nuestro
--         modelo deberia cambiar a una relacion
--         muchos a muchos entre proveedores y 
--         actividadesproveedores
alter table proveedores 
   drop constraint fk_proveedores_activiadad;
alter table proveedores
   drop column actividad;
   
create table proveedores_actividadesproveedores (
codigoproveedor integer not null,
idactividadproveedor integer not null,
constraint pk_proveedores_actividadesproveedores
     primary key (codigoproveedor,idactividadproveedor),
constraint fk_proveedores_actividadesproveedores_actividadesproveedores 
     foreign key (idactividadproveedor)
                  references actividadesproveedores(idactividadproveedor),
constraint fk_proveedores_actividadesproveedores_proveedores 
     foreign key (codigoproveedor) references proveedores(codigoproveedor)
 );

------Fix Productos claves duplicadas------

-- Obtengo los distintos productos y codigos
-- en tabla tmp_productos

select distinct codigoproductoonu,nombreproductogenerico
into tmp_productos
from traspaso;

-- Obtengo los productos que tienen codigos repetidos
-- En tabla tmp_prodrepetidos con un campo nuevo
-- para agregar nuevo codigo

select distinct codigoproductoonu, nombreproductogenerico,0 as nuevocodigo
into tmp_prodrepetidos
from traspaso tr
where exists 
       (select * 
        from tmp_productos tp
        where tp.nombreproductogenerico <> tr.nombreproductogenerico
        and tp.codigoproductoonu =  tr.codigoproductoonu  );
        
-- creo sequence para obtener los valores de la clave
-- usare el 990090000 como valor inicial

create sequence sec_genera_claveprod
    start 990900000
    increment 1;

-- Agrego codigo nuevo desde la secuencia 

update tmp_prodrepetidos
set nuevocodigo = nextval('sec_genera_claveprod');

-- Modifico los datos de la tabla traspaso con los
-- codigos nuevos

update traspaso tr set codigoproductoonu = tp.nuevocodigo
from tmp_prodrepetidos tp
where tp.nombreproductogenerico = tr.nombreproductogenerico
  and tp.codigoproductoonu =  tr.codigoproductoonu ;


 -- elimino tablas temp
 
 drop table tmp_productos;
 drop table tmp_prodrepetidos;
 drop sequence sec_genera_claveprod;
 

-------OrganismosPublicos-------
insert into organismospublicos(codigoorganismopublico, organismopublico, sector)
select distinct traspaso.codigoorganismopublico::integer, traspaso.organismopublico, sectores.idsector
from traspaso
join sectores
on (traspaso.sector = sectores.sector);
--delete from organismospublicos;

-------Procedencias-------
insert into procedencias(procedencia, tipo)
select distinct traspaso.procedencia, tipos.tipo
from traspaso
join tipos
on (traspaso.tipo = tipos.tipo);
--delete from procedencias;

-------Regiones-------
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

-------Ciudades-------
insert into ciudades(ciudad, region)
select distinct traspaso.ciudadunidadcompra, regiones.idregion
from traspaso
join regiones
on (traspaso.regionunidadcompra = regiones.region);
--delete from ciudades;

-------UnidadesCompras-------
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

-------Rubros-------
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

-------Proveedores-------
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

-------proveedores_actividadesproveedores-------
--Relacion proveedores con actividades mucho a muchos
insert into proveedores_actividadesproveedores(codigoproveedor, idactividadproveedor)
select distinct proveedores.codigoproveedor, actividadesproveedores.idactividadproveedor
from traspaso
join actividadesproveedores
on (traspaso.actividadproveedor = actividadesproveedores.actividadproveedor)
join proveedores
on (proveedores.codigoproveedor = traspaso.codigoproveedor::integer);
--delete from proveedores_actividadesproveedores;

-------Sucursales-------
insert into sucursales(codigosucursal, rutsucursal, sucursal, proveedor)
select distinct codigosucursal::integer, rutsucursal, max(sucursal) as sucursal, max(proveedores.codigoproveedor) as codigoproveedor
from traspaso
join proveedores
on (proveedores.nombreproveedor = traspaso.nombreproveedor)
where rutsucursal <> 'NA'
group by codigosucursal, rutsucursal
--delete from sucursales;

-------Productos-------
alter table productos alter column nombreproducto drop not null;

select distinct traspaso.codigoproductoonu :: bigint ,traspaso.nombreproductogenerico, rubros.id_rubro
into tmp_productos
from traspaso
join rubros on traspaso.rubron3 = rubros.rubro
where traspaso.rubron3 <> 'NA';

insert into productos(codigoproducto,nombreproducto,rubro)
select tmp_productos.codigoproductoonu,max(tmp_productos.nombreproductogenerico),max(tmp_productos.id_rubro) as rubro
from tmp_productos
group by tmp_productos.codigoproductoonu;
--delete from productos;

-------Licitaciones-------
insert into licitaciones(idlicitacion,codlicitacion,link1,nombre,descripcion,procedencia,estratodirecto,escompraagil,codigotipo,idplandecompra,codigoestado,codigoestadoproveedor,fechacreacion,fechaenvio,fechasolicitudcancelacion,fechaultimamodificacion,fechaaceptacion,fechacancelacion,tieneitems,montototal,tipomoneda,montototalpesos,impuestos,tipoimpuesto,descuento,cargos,totalnetooc,codigounidadcompra,codigosucursal,financiamiento,porcentajeiva,pais,tipodespacho,formapago,codigolicitacion)
select distinct 
t.idt::bigint, 
t.codigo, 
t.linkt, 
t.nombre, 
t.descripcion, 
max(procedencias.idprocedencia), 
case when t.estratodirecto like '%Si%' then 'Si' when t.estratodirecto like '%No%' then 'No' else 'Na' end as estratodirecto, 
t.escompraagil, 
tipos.codigotipo, 
t.idplandecompra, 
estadoscompras.codigoestado, 
estadosproveedores.codigoestado,
case when t.fechacreacion = 'NA' then TO_DATE('01/01/1900', 'dd/mm/yyyy') else TO_DATE(translate(t.fechacreacion, '-', '/'), 'yyyy/mm/dd') end as fechacreacion, 
case when t.fechaenvio = 'NA' then TO_DATE('01/01/1900', 'dd/mm/yyyy') else TO_DATE(translate(t.fechaenvio, '-', '/'), 'yyyy/mm/dd') end as fechaenvio, 
case when t.fechasolicitudcancelacion = 'NA' then TO_DATE('01/01/1900', 'dd/mm/yyyy') else TO_DATE(translate(t.fechasolicitudcancelacion, '-', '/'), 'yyyy/mm/dd') end as fechasolicitudcancelacion, 
case when t.fechaultimamodificacion = 'NA' then TO_DATE('01/01/1900', 'dd/mm/yyyy') else TO_DATE(translate(t.fechaultimamodificacion, '-', '/'), 'yyyy/mm/dd') end as fechaultimamodificacion,
case when t.fechaaceptacion = 'NA' then TO_DATE('01/01/1900', 'dd/mm/yyyy') else TO_DATE(translate(t.fechaaceptacion, '-', '/'), 'yyyy/mm/dd') end as fechaaceptacion, 
case when t.fechacancelacion = 'NA' then TO_DATE('01/01/1900', 'dd/mm/yyyy') else TO_DATE(translate(t.fechacancelacion, '-', '/'), 'yyyy/mm/dd') end as fechacancelacion, 
t.tieneitems::integer, 
round(replace(t.montototal, ',','.')::numeric)::bigint, 
tiposmonedas.codigomoneda, 
case when replace(t.montototalpesos, ',','.')::numeric > 9999999.999::numeric(10,3) then 9999999.999::numeric else replace(t.montototalpesos, ',','.')::numeric end as montototalpesos, 
round(replace(t.impuestos, ',','.')::numeric)::bigint,
tiposimpuestos.tipoimpuesto, 
round(replace(t.descuentos, ',','.')::numeric)::bigint,
round(replace(t.cargos, ',','.')::numeric)::bigint, 
round(replace(t.totalnetooc, ',','.')::numeric)::bigint, 
unidadescompras.codigounidadcompra,
sucursales.codigosucursal, 
t.financiamiento, 
t.porcentajeiva::integer, 
paises.codigopais, 
tiposdespachos.idtipodespacho, 
formaspagos.idformapago, 
t.codigolicitacion
 
from traspaso t
join procedencias
on (procedencias.procedencia = t.procedencia)
join tipos
on (tipos.tipo = t.tipo)
join estadoscompras
on (estadoscompras.codigoestado = t.codigoestado::integer)
join estadosproveedores
on (estadosproveedores.codigoestado = t.codigoestadorpoveedor::integer)
join tiposmonedas
on (tiposmonedas.codigomoneda = t.tipomoneda)
join tiposimpuestos
on (tiposimpuestos.impuesto = t.tipoimpuesto)
join unidadescompras
on (unidadescompras.codigounidadcompra = t.codigounidadcompra::integer)
join sucursales
on (sucursales.codigosucursal = t.codigosucursal::integer)
join paises
on (paises.codigopais =t.pais)
join tiposdespachos
on (tiposdespachos.idtipodespacho = t.tipodespacho::integer)
join formaspagos
on (formaspagos.idformapago = t.formapago::int)
where t.codigolicitacion <> 'null' and t.formapago <> 'NA' --and t.idt = '37619077'
group by t.idt, t.codigo, t.linkt, t.nombre, t.descripcion, t.estratodirecto, t.escompraagil,
tipos.codigotipo,t.idplandecompra, estadoscompras.codigoestado, estadosproveedores.codigoestado,
t.fechacreacion, fechaenvio, fechasolicitudcancelacion, fechaultimamodificacion, fechaaceptacion,
fechacancelacion, t.tieneitems, t.montototal, tiposmonedas.codigomoneda,t.montototalpesos,t.impuestos, 
t.descuentos, t.cargos,t.totalnetooc, unidadescompras.codigounidadcompra, sucursales.codigosucursal, t.financiamiento, 
t.porcentajeiva, paises.codigopais, tiposdespachos.idtipodespacho, formaspagos.idformapago, 
t.codigolicitacion, tiposimpuestos.tipoimpuesto;
--delete from licitaciones;

-------ItemesLicitaciones-------
insert into itemeslicitaciones(iditem,idlicitacion,codigocategoria,codigoproducto,especificacioncomprados,especificacionproveedos,cantidad,unidadmedida,monedaitem,precioneto,totalcargo,totaldescuentos,totalimpuestos,totallineaneto,formapago)						   
select distinct 
t.iditem::bigint,
licitaciones.idlicitacion::bigint,
categorias.codigocategoria,
productos.codigoproducto,
t.especificacioncomprador,
t.especificacionproveedor,
round(replace(t.cantidad, ',','.')::numeric)::integer, 
unidadesmedidas.codigounidadmedida,
tiposmonedas.codigomoneda,
case when replace(t.precioneto, ',','.')::numeric > 9999999.999::numeric(10,3) then 9999999.999::numeric else replace(t.precioneto, ',','.')::numeric end as precioneto,
case when replace(t.totalcargos, ',','.')::numeric > 9999999.999::numeric(10,3) then 9999999.999::numeric else replace(t.totalcargos, ',','.')::numeric end as totalcargos,
round(replace(t.totaldescuentos, ',','.')::numeric)::integer, 
t.totalimpuestos::integer,
case when replace(t.totallineaneto, ',','.')::numeric > 9999999.999::numeric(10,3) then 9999999.999::numeric when replace(t.totallineaneto, ',','.')::numeric < 0 then 0 else replace(t.totallineaneto, ',','.')::numeric end as totallineaneto,
formaspagos.idformapago::integer

from traspaso t
join licitaciones on t.idt::bigint = licitaciones.idlicitacion
join categorias on t.codigocategoria::bigint = categorias.codigocategoria
join productos on t.codigoproductoonu::bigint = productos.codigoproducto
join unidadesmedidas on t.unidadmedida = unidadesmedidas.unidadmedida
join tiposmonedas on t.monedaitem = tiposmonedas.codigomoneda
join formaspagos on t.formapago::integer = formaspagos.idformapago
where t.iditem <> 'NA' and t.codigocategoria <> 'NA' and t.formapago <> 'NA';
--delete from itemeslicitaciones;