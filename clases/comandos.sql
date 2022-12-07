--
select * from paises;
insert into paises values('JA', 'japón');
update paises set pais = 'Japón' where codigopais = 'JA';
delete from paises where codigopais = 'JA';


--consultas
select nombreproveedor, promedioevaluacion, cantidadevaluacion 
from proveedores
where cantidadevaluacion > 0


-- between
select * from proveedores where cantidadevaluacion > 0;
select * from proveedores where cantidadevaluacion between 5 and 10;
select * from proveedores where cantidadevaluacion >= 5 and cantidadevaluacion <= 10;
-- like
select * from paises where pais like 'C%';
-- in
select * from paises where pais = 'Chile' or pais = 'Cuba'
select * from paises where pais in('Chile', 'Cuba');

--Agregación
select avg(cantidadevaluacion) from proveedores where cantidadevaluacion > 0;
select max(cantidadevaluacion) from proveedores;
select min(cantidadevaluacion) from proveedores;
select count(*) from proveedores;
select count(*) from proveedores where cantidadevaluacion > 300
-- group by and having
select nombreproveedor from proveedores group by nombreproveedor, cantidadevaluacion having cantidadevaluacion > 300;

-- top
select *
from paises
order by pais desc
limit 10