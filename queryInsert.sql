
insert into sectores(sector)
select distinct sector
from traspaso;

/*insert into paises(codigopais, pais)
select distinct pais, 'Chile'
from traspaso
where pais is not null;*/

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

/*insert into tipos(tipo, codigoabreviatura,descripcion,codigotipo)
select distinct cast (tipo as character varying (10)), codigoabreviatura,descripcion,cast (codigotipo as integer)
from traspaso;*/

/*insert into formaspagos(idformapago, formapago)
select distinct cast (formapago as integer), formapago2
from traspaso;*/

insert into tiposimpuestos(impuesto)
select distinct tipoimpuesto
from traspaso;

insert into tiposmonedas(codigomoneda, nombremoneda)
select distinct monedaitem,  tipomoneda
from traspaso
