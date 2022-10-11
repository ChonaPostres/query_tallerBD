------Parte 1------
select UC.unidadcompra, sum(IL.totallineaneto)
from itemeslicitaciones as IL
join licitaciones ON licitaciones.idlicitacion = IL.idlicitacion
join unidadescompras as UC ON UC.codigounidadcompra = licitaciones.codigounidadcompra
group by UC.unidadcompra
having sum(IL.totallineaneto) >  all (
	select sum(IL2.totallineaneto)
	from itemeslicitaciones as IL2
	join licitaciones ON licitaciones.idlicitacion = IL2.idlicitacion
	join unidadescompras as UC2 ON UC2.codigounidadcompra = licitaciones.codigounidadcompra
	where UC2.unidadcompra <> UC.unidadcompra
	group by UC2.unidadcompra
)

------Parte 2------
------Parte 3------
select P1.nombreproducto, count(*)
from itemeslicitaciones as IL
join licitaciones ON licitaciones.idlicitacion = IL.idlicitacion
join productos as P1 ON P1.codigoproductos = IL.codigoproducto
group by P1.nombreproducto
having count(*) > any (
	select avg(count_productos)
	from (
		select count(*) as count_productos
		from itemeslicitaciones as IL2
		join licitaciones ON licitaciones.idlicitacion = IL2.idlicitacion
		join productos as P2 ON P2.codigoproductos = IL2.codigoproducto
		group by P2.nombreproducto
	) as Z
)