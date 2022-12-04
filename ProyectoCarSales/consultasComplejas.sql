-- Indices para optimizar el plan de busqueda
create index color on colores(color);
create index anio on anios(anio);
create index horse_power on horse_powers(horse_power);

-- Consulta compleja
select o.oferta, o.precio_aed, modelos.modelo, empresas.empresa, tipo_cuerpos.tipo_cuerpo, anios.anio, colores.color, specs_regionales.specs_regional, 
costados_manubrio.costado_manubrio, tipo_transmisiones.tipo_transmision, estados.kilometros, condicion_cuerpos.condicion_cuerpo, 
condicion_mecanicas.condicion_mecanica, motores.motor, tipo_combustibles.tipo_combustible, horse_powers.horse_power, cilindros.cilindro, 
tipo_vendedores.tipo_vendedor, o.fecha_publicacion, o.ciudad_emirato  from ofertas as o
join tipo_vendedores on (tipo_vendedores.id_tipo_vendedor = o.tipo_vendedor)
-- Vehiculos
join vehiculos on (vehiculos.id_vehiculo = o.vehiculo)
join modelos on (modelos.id_modelo = vehiculos.modelo)
join empresas on (modelos.empresa = empresas.id_empresa)
join tipo_cuerpos on (tipo_cuerpos.id_tipo_cuerpo = vehiculos.tipo_cuerpo)
join anios on (anios.id_anio = vehiculos.anio)
-- Caracteristicas
join caracteristicas on (caracteristicas.id_caracteristica = vehiculos.caracteristica)
join colores on (colores.id_color = caracteristicas.color)
join specs_regionales on (specs_regionales.id_specs_regional = caracteristicas.specs_regional)
join costados_manubrio on (costados_manubrio.id_costado_manubrio = caracteristicas.costado_manubrio)
join tipo_transmisiones on (tipo_transmisiones.id_tipo_transmision = caracteristicas.tipo_transmision)
-- Estados
join estados on (estados.id_estado = vehiculos.estado)
join condicion_cuerpos on (condicion_cuerpos.id_condicion_cuerpo = estados.condicion_cuerpo)
join condicion_mecanicas on (condicion_mecanicas.id_condicion_mecanica = estados.condicion_mecanica)
-- Motores
join motores on (motores.id_motor = vehiculos.motor)
join tipo_combustibles on (tipo_combustibles.id_tipo_combustible = motores.combustible)
join horse_powers on (horse_powers.id_horse_power = motores.horse_power)
join cilindros on (cilindros.id_cilindro = motores.cilindros)
where colores.color = 'Blue' and anios.anio = '2011' and (horse_powers.horse_power = '150 - 200 HP' or horse_powers.horse_power = '200 - 300 HP');
