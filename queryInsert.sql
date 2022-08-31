
insert into sectores(sector)
select DISTINCT sector
from traspaso;

/*insert into paises(pais)
select distinct pais
from traspaso;*/

insert into actividadesproveedores(actividadproveedor)
select distinct actividadproveedor
from traspaso;

/*insert into estadosproveedores(codigoestado, estado)
select distinct cast(codigoestado as integer), estadoproveedor
from traspaso;*/

insert into unidadesmedidas(unidadmedida)
select distinct unidadmedida
from traspaso;

/*insert into categorias(codigocategoria, categoria)
select distinct cast(codigocategoria as bigint), categoria
from traspaso
where codigocategoria is not 'NA'
;*/