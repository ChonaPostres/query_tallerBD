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
select codlicitacion, link1, descripcion, regiones.region from licitaciones
join sucursales
on (licitaciones.codigosucursal = sucursales.codigosucursal)
join proveedores
on (sucursales.proveedor = proveedores.codigoproveedor)
join ciudades
on (proveedores.comuna = ciudades.idciudad)
join regiones
on (ciudades.region = regiones.idregion)
where regiones.region = 'Región de Valparaíso'

