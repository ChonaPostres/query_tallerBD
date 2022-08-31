
-- Sectores
insert into sectores(sector)
select distinct sector
from traspaso;

-- TiposImpuestos
insert into tiposimpuestos(impuesto)
select distinct tipoimpuesto
from traspaso;

-- ActividadesProveedores
insert into actividadesproveedores(actividadproveedor)
select distinct actividadproveedor
from traspaso;

-- UnidadesMedidas
insert into unidadesmedidas(unidadmedida)
select distinct unidadmedida
from traspaso;

------------

-- Paises
insert into paises(codigopais, pais)
select distinct pais, 'Chile'
from traspaso
where pais = 'CL';

-- EstadosProveedores
insert into estadosproveedores(codigoestado, estado)
select distinct cast(codigoestadorpoveedor as integer), estadoproveedor
from traspaso;

-- EstadosCompras
insert into estadoscompras(codigoestado, estado)
select distinct cast(codigoestado as integer), estado
from traspaso;

-- FormasPagos
insert into formaspagos(idformapago, formapago)
select distinct cast(formapago as integer), formapago2
from traspaso;

-- Tipos
insert into tipos(tipo, codigoabreviatura,descripcion,codigotipo)
select distinct tipo, codigoabreviatura, 'descripcion', cast(codigotipo as integer)
from traspaso;

-- TiposMonedas
insert into tiposmonedas(codigomoneda, nombremoneda)
select distinct tipomoneda,  'nombremoneda'
from traspaso;

-- TiposDespachos
insert into tiposdespachos(idtipodespacho, tipodespacho)
select distinct cast(tipodespacho as integer), 'tipodespacho'
from traspaso;

-- Categorias
/*insert into categorias(codigocategoria, categoria)
select distinct cast(codigocategoria as bigint), categoria
from traspaso
where codigocategoria != 'NA'
;*/

/*
delete from actividadesproveedores;
delete from categorias;
delete from ciudades;
delete from estadoscompras;
delete from estadosproveedores;
delete from paises;
delete from sectores;
delete from formaspagos;
delete from unidadesmedidas;
delete from tiposimpuestos;
delete from tiposdespachos;
delete from tiposmonedas;
delete from tipos;
*/