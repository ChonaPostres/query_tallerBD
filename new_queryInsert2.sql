-- Tipos --
insert into tipos(tipo,codigoabreviatura,descripcion,codigotipo)
select distinct tipo, codigoabreviatura, descripciontipooc, codigotipo::integer
from traspaso;

-- EstadosCompras --
insert into estadoscompras(codigoestado,estado)
select distinct codigoestado::integer,estado from traspaso;

-- EstadosProveedores --
insert into estadosproveedores(codigoestado, estado)
select distinct cast(codigoestadorpoveedor as integer), estadoproveedor
from traspaso;

-- TiposImpuestos -- 
insert into tiposimpuestos(impuesto)
select distinct tipoimpuesto from traspaso;

-- TipoDespacho --
insert into tiposdespachos(idtipodespacho, tipodespacho)
select distinct cast(tipodespacho as integer), 'tipodespacho'
from traspaso;

-- TipoMoneda --

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

-- unidadesmedidas ---

insert into unidadesmedidas(unidadmedida)
select distinct unidadmedida from traspaso;

-- formaspagos --
insert into formaspagos(idformapago,formapago)
select distinct formapago::int, formapago2 from traspaso
where formapago <> 'NA' and (formapago<>'39' or formapago2<>'NA');

-- Sectores --
insert into sectores (sector)
select distinct sector from traspaso;

-- Paises --
select distinct pais from traspaso
where pais is not null and trim(pais) <>''
union
Select distinct  paisproveedor from traspaso
where paisproveedor is not null and trim(paisproveedor) <>'';

-- ActividadesProveedores --
insert into actividadesproveedores(actividadproveedor)
select distinct actividadproveedor
from traspaso;

-- Categoria --
insert into categorias (codigocategoria,categoria)
select distinct codigocategoria::bigint, max(categoria) 
from traspaso
where codigocategoria <> 'NA'
group by codigocategoria;

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

