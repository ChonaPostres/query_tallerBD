------Parte 1------
select unidadescompras.unidadcompra, sum(totallineaneto) from itemeslicitaciones
join licitaciones ON licitaciones.idlicitacion = itemeslicitaciones.idlicitacion
join unidadescompras ON unidadescompras.codigounidadcompra = licitaciones.codigounidadcompra
group by unidadescompras.unidadcompra
having sum(totallineaneto) > 1000000000;
------Parte 2------
------Parte 3------