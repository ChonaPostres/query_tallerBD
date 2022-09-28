------Parte 1------
select unidadescompras.unidadcompra, sum(round(totallineaneto)) from itemeslicitaciones
join licitaciones ON licitaciones.idlicitacion = itemeslicitaciones.idlicitacion
join unidadescompras ON unidadescompras.codigounidadcompra = licitaciones.codigounidadcompra
group by unidadescompras.unidadcompra
having sum(round(totallineaneto)) > 1000000000;
------Parte 2------
select unidadescompras.unidadcompra, rubros3.rubro, sum(round(totallineaneto)) from itemeslicitaciones
join licitaciones ON licitaciones.idlicitacion = itemeslicitaciones.idlicitacion
join unidadescompras ON unidadescompras.codigounidadcompra = licitaciones.codigounidadcompra
join productos ON productos.codigoproducto = itemeslicitaciones.codigoproducto
join rubros ON rubros.id_rubro = productos.rubro
join rubros rubros2 ON rubros2.id_rubro = rubros.rubropadre
join rubros rubros3 ON rubros3.id_rubro = rubros2.rubropadre
group by unidadescompras.unidadcompra, rubros3.rubro;
------Parte 3------