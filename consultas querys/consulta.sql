-------Parte 1-------
select rubros.id_rubro, rubros.rubro, rubros.rubropadre, rubros2.id_rubro, rubros2.rubro, rubros2.rubropadre
from rubros
join rubros rubros2 
on (rubros2.id_rubro = rubros.rubropadre);

-------Parte 2-------
select rubros.id_rubro, rubros.rubro, 
case when rubros.rubropadre is NULL then 'no posee rubro padre' else 'si posee rubro padre' end, 
rubros2.id_rubro, rubros2.rubro, 
case when rubros2.rubropadre is NULL then 'no posee rubro padre' else 'si posee rubro padre' end
from rubros
join rubros rubros2 
on (rubros2.id_rubro = rubros.rubropadre);

-------Parte 3-------
select * from sucursales
where rutsucursal not like '%.___.___-k' 
and rutsucursal not like '%.___.___-0' 
and rutsucursal not like '%.___.___-1' 
and rutsucursal not like '%.___.___-2' 
and rutsucursal not like '%.___.___-3' 
and rutsucursal not like '%.___.___-4' 
and rutsucursal not like '%.___.___-5'
and rutsucursal not like '%.___.___-6'
and rutsucursal not like '%.___.___-7'
and rutsucursal not like '%.___.___-8'
and rutsucursal not like '%.___.___-9';

-------Parte 4-------
select licitaciones.codlicitacion, licitaciones.link1, licitaciones.descripcion, regiones.region, sectores.sector, rubros.rubro, rubros2.rubro as rubro2, licitaciones.fechaultimamodificacion 
from itemeslicitaciones
join licitaciones
on (licitaciones.idlicitacion = itemeslicitaciones.idlicitacion)
join sucursales
on (licitaciones.codigosucursal = sucursales.codigosucursal)
join proveedores
on (sucursales.proveedor = proveedores.codigoproveedor)
join ciudades
on (proveedores.comuna = ciudades.idciudad)
join regiones
on (ciudades.region = regiones.idregion)
join unidadescompras 
on (licitaciones.codigounidadcompra = unidadescompras.codigounidadcompra)
join organismospublicos 
on (organismospublicos.codigoorganismopublico = unidadescompras.codigoorganismopublico)
join sectores 
on (sectores.idsector = organismospublicos.sector)
join productos 
on (productos.codigoproducto = itemeslicitaciones.codigoproducto)
join rubros 
on (rubros.id_rubro = productos.rubro)
join rubros as rubros2 
on (rubros2.id_rubro = rubros.rubropadre)
where regiones.region = 'Región de Valparaíso' 
and sectores.sector = 'Municipalidades'
and (rubros.rubro = 'Productos de papel' or rubros2.rubro = 'Productos de papel')
and licitaciones.fechaultimamodificacion >= date '20-03-2019' 
and licitaciones.fechaultimamodificacion <= date '30-03-2019';

