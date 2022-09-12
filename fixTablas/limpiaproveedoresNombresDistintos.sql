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


