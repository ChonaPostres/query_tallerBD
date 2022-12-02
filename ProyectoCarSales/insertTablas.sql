-- Tabla empresas
insert into empresas(empresa)
select distinct company
from traspaso order by company;

-- Tabla condicion_cuerpos
insert into condicion_cuerpos(condicion_cuerpo)
select distinct body_condition
from traspaso order by body_condition;

-- Tabla condicion_mecanicas
insert into condicion_mecanicas(condicion_mecanica)
select distinct body_condition
from traspaso order by body_condition;

-- Tabla tipo_vendedores
insert into tipo_vendedores(tipo_vendedor)
select distinct seller_type
from traspaso order by seller_type;

-- Tabla tipo_cuerpos
insert into tipo_cuerpos(tipo_cuerpo)
select distinct body_type
from traspaso order by body_type;

-- Tabla colores
insert into colores(color)
select distinct color
from traspaso order by color;

-- Tabla cilindros
insert into cilindros(cilindro)
select distinct case when no_of_cylinders is null then 'Unknown' else no_of_cylinders end
from traspaso order by no_of_cylinders;

-- Tabla specs_regionales
insert into specs_regionales(specs_regional)
select distinct regional_specs
from traspaso order by regional_specs;

-- Tabla horse_powers
insert into horse_powers(horse_power)
select distinct horsepower
from traspaso order by horsepower;

-- Tabla costados_manubrio
insert into costados_manubrio(costado_manubrio)
select distinct steering_side
from traspaso order by steering_side;

-- Tabla anios
insert into anios(anio)
select distinct case when "year" is null then 'Unknown' else "year" end 
from traspaso order by "year";

-- Tabla costados_manubrio
insert into costados_manubrio(costado_manubrio)
select distinct steering_side
from traspaso order by steering_side;

-- Tabla tipo_transmisiones
insert into tipo_transmisiones(tipo_transmision)
select distinct transmission_type
from traspaso order by transmission_type;

-- Tabla tipo_combustibles
insert into tipo_combustibles(tipo_combustible)
select distinct fuel_type 
from traspaso order by fuel_type;

-- Tabla motores
insert into motores(motor, combustible, horse_power, cilindros)
select distinct case when motors_trim is null then 'Other' else motors_trim end, tipo_combustibles.id_tipo_combustible, horse_powers.id_horse_power, cilindros.id_cilindro
from traspaso 
join tipo_combustibles on (tipo_combustibles.tipo_combustible = fuel_type)
join horse_powers on (horse_powers.horse_power = horsepower)
join cilindros on (cilindros.cilindro = no_of_cylinders)
order by motors_trim;
--delete from motores;

-- Tabla modelos
insert into modelos(modelo, empresa)
select distinct model, empresas.id_empresa
from traspaso 
join empresas on empresas.empresa = traspaso.company
order by model;

-- Tabla estados
insert into estados(kilometros, condicion_cuerpo, condicion_mecanica)
select distinct kilometers::integer, condicion_cuerpos.id_condicion_cuerpo, condicion_mecanicas.id_condicion_mecanica
from traspaso 
join condicion_cuerpos on (condicion_cuerpos.condicion_cuerpo = body_condition)
join condicion_mecanicas on (condicion_mecanicas.condicion_mecanica = mechanical_condition)
order by kilometers;

-- Tabla caracteristicas
insert into caracteristicas(color, specs_regional, costado_manubrio, tipo_transmision)
select distinct colores.id_color, specs_regionales.id_specs_regional, costados_manubrio.id_costado_manubrio, tipo_transmisiones.id_tipo_transmision
from traspaso 
join colores on (colores.color = traspaso.color)
join specs_regionales on (specs_regionales.specs_regional = traspaso.regional_specs)
join costados_manubrio on (costados_manubrio.costado_manubrio = traspaso.steering_side)
join tipo_transmisiones on (tipo_transmisiones.tipo_transmision = traspaso.transmission_type);

-- Tabla vehiculos
insert into vehiculos(modelo, tipo_cuerpo, anio, caracteristica, estado, motor)
select modelos.id_modelo, tipo_cuerpos.id_tipo_cuerpo, anios.id_anio, caracteristicas.id_caracteristica, estados.id_estado, motores.id_motor
from traspaso as t
join modelos on (modelos.modelo = t.model)
join tipo_cuerpos on (tipo_cuerpos.tipo_cuerpo = t.body_type)
join anios on (anios.anio = t."year")
join colores on (colores.color = t.color)
join specs_regionales on (specs_regionales.specs_regional = t.regional_specs)
join costados_manubrio on (costados_manubrio.costado_manubrio = t.steering_side)
join tipo_transmisiones on (tipo_transmisiones.tipo_transmision = t.transmission_type)
join caracteristicas on (caracteristicas.color = colores.id_color and caracteristicas.specs_regional = specs_regionales.id_specs_regional and
caracteristicas.costado_manubrio = costados_manubrio.id_costado_manubrio and caracteristicas.tipo_transmision = tipo_transmisiones.id_tipo_transmision)
join condicion_cuerpos on (condicion_cuerpos.condicion_cuerpo = t.body_condition)
join condicion_mecanicas on (condicion_mecanicas.condicion_mecanica = t.mechanical_condition)
join estados on (estados.kilometros = t.kilometers::integer and estados.condicion_cuerpo = condicion_cuerpos.id_condicion_cuerpo and 
estados.condicion_mecanica = condicion_mecanicas.id_condicion_mecanica)
join tipo_combustibles on (tipo_combustibles.tipo_combustible = t.fuel_type)
join horse_powers on (horse_powers.horse_power = t.horsepower)
join cilindros on (cilindros.cilindro = t.no_of_cylinders)
join motores on (motores.motor = (case when t.motors_trim is null then 'Other' else t.motors_trim end) and motores.combustible = tipo_combustibles.id_tipo_combustible
and motores.horse_power = horse_powers.id_horse_power and motores.cilindros = cilindros.id_cilindro);

-- Tabla ofertas
insert into ofertas(oferta, precio_aed, vehiculo, tipo_vendedor, fecha_publicacion, ciudad_emirato)
select case when t.title is null then 'Unknown' else t.title end, (replace(price_in_aed, ',','')::integer), vehiculos.id_vehiculo, tipo_vendedores.id_tipo_vendedor, TO_DATE(t.date_posted, 'dd/mm/yyyy'), t.emirate
from traspaso as t
join tipo_vendedores on (tipo_vendedores.tipo_vendedor = t.seller_type)
join modelos on (modelos.modelo = t.model)
join tipo_cuerpos on (tipo_cuerpos.tipo_cuerpo = t.body_type)
join anios on (anios.anio = t."year")
join colores on (colores.color = t.color)
join specs_regionales on (specs_regionales.specs_regional = t.regional_specs)
join costados_manubrio on (costados_manubrio.costado_manubrio = t.steering_side)
join tipo_transmisiones on (tipo_transmisiones.tipo_transmision = t.transmission_type)
join caracteristicas on (caracteristicas.color = colores.id_color and caracteristicas.specs_regional = specs_regionales.id_specs_regional and
caracteristicas.costado_manubrio = costados_manubrio.id_costado_manubrio and caracteristicas.tipo_transmision = tipo_transmisiones.id_tipo_transmision)
join condicion_cuerpos on (condicion_cuerpos.condicion_cuerpo = t.body_condition)
join condicion_mecanicas on (condicion_mecanicas.condicion_mecanica = t.mechanical_condition)
join estados on (estados.kilometros = t.kilometers::integer and estados.condicion_cuerpo = condicion_cuerpos.id_condicion_cuerpo and 
estados.condicion_mecanica = condicion_mecanicas.id_condicion_mecanica)
join tipo_combustibles on (tipo_combustibles.tipo_combustible = t.fuel_type)
join horse_powers on (horse_powers.horse_power = t.horsepower)
join cilindros on (cilindros.cilindro = t.no_of_cylinders)
join motores on (motores.motor = (case when t.motors_trim is null then 'Other' else t.motors_trim end) and motores.combustible = tipo_combustibles.id_tipo_combustible
and motores.horse_power = horse_powers.id_horse_power and motores.cilindros = cilindros.id_cilindro)
join vehiculos on (vehiculos.modelo = modelos.id_modelo and vehiculos.tipo_cuerpo = tipo_cuerpos.id_tipo_cuerpo and vehiculos.anio = anios.id_anio and
vehiculos.caracteristica = caracteristicas.id_caracteristica and vehiculos.estado = estados.id_estado and vehiculos.motor = motores.id_motor);

