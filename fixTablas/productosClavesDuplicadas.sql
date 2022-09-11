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
 
 