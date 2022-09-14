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

-- TiposDespachos --
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
insert into paises(codigopais, pais)
select distinct trim(cast(case
    when traspaso.paisproveedor = 'NA' then 'NA'
    when traspaso.paisproveedor = 'Francia' then 'FR'
    when traspaso.paisproveedor = 'Alemania' then 'DE'
    when traspaso.paisproveedor = 'Colombia' then 'CO'
    when traspaso.paisproveedor = 'Irlandia' then 'IE'
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
    when traspaso.paisproveedor = 'Canad ' then 'CA'
    else 'NA' end as varchar(5))), cast(case
        when traspaso.paisproveedor = '' then 'NA'
        when traspaso.paisproveedor = 'CL' then 'NA'
        else traspaso.paisproveedor end as varchar(100))
from traspaso
where traspaso.paisproveedor is not null;

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

