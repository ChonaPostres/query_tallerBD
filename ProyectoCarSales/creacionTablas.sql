create table empresas(
id_empresa serial not null,
empresa varchar(100) not null,
constraint pk_empresas primary key (id_empresa)
);

create table condicion_cuerpos(
id_condicion_cuerpo serial not null,
condicion_cuerpo varchar(100) not null,
constraint pk_condicion_cuerpos primary key (id_condicion_cuerpo)
);

create table condicion_mecanicas(
id_condicion_mecanica serial not null,
condicion_mecanica varchar(100) not null,
constraint pk_condicion_mecanicas primary key (id_condicion_mecanica)
);

create table tipo_vendedores(
id_tipo_vendedor serial not null,
tipo_vendedor varchar(100) not null,
constraint pk_tipo_vendedores primary key (id_tipo_vendedor)
);

create table tipo_cuerpos(
id_tipo_cuerpo serial not null,
tipo_cuerpo varchar(100) not null,
constraint pk_tipo_cuerpos primary key (id_tipo_cuerpo)
);

create table colores(
id_color serial not null,
color varchar(100) not null,
constraint pk_colores primary key (id_color)
);

create table cilindros(
id_cilindro serial not null,
cilindro varchar(100) not null,
constraint pk_cilindros primary key (id_cilindro)
);

create table specs_regionales(
id_specs_regional serial not null,
specs_regional varchar(100) not null,
constraint pk_specs_regionales primary key (id_specs_regional)
);

create table horse_powers(
id_horse_power serial not null,
horse_power varchar(100) not null,
constraint pk_horse_powers primary key (id_horse_power)
);

create table costados_manubrio(
id_costado_manubrio serial not null,
costado_manubrio varchar(100) not null,
constraint pk_costados_manubrio primary key (id_costado_manubrio)
);

create table tipo_transmisiones(
id_tipo_transmision serial not null,
tipo_transmision varchar(50) not null,
constraint pk_tipo_transmisiones primary key (id_tipo_transmision)
);

create table tipo_combustibles(
id_tipo_combustible serial not null,
tipo_combustible varchar(50) not null,
constraint pk_tipo_combustibles primary key (id_tipo_combustible)
);

create table motores(
id_motor serial not null,
motor varchar(50) not null,
combustible int not null,
horse_power int not null,
cilindros int not null,
constraint pk_motores primary key (id_motor),
constraint fk_motores_tipo_combustibles
   foreign key (combustible) references tipo_combustibles(id_tipo_combustible),
constraint fk_motores_horse_powers
   foreign key (horse_power) references horse_powers(id_horse_power), 
constraint fk_motores_cilindros
   foreign key (cilindros) references cilindros(id_cilindro) 
);

create table estados(
id_estado serial not null,
kilometros int not null,
condicion_cuerpo int not null,
condicion_mecanica int not null,
constraint pk_estados primary key (id_estado),
constraint fk_estados_condicion_cuerpos
   foreign key (condicion_cuerpo) references condicion_cuerpos(id_condicion_cuerpo),
constraint fk_estados_condicion_mecanicas
   foreign key (condicion_mecanica) references condicion_mecanicas(id_condicion_mecanica)
);

create table caracteristicas(
id_caracteristica serial not null,
color int not null,
specs_regional int not null,
costado_manubrio int not null,
tipo_transmision int not null,
constraint pk_caracteristicas primary key (id_caracteristica),
constraint fk_caracteristicas_specs_regionales
   foreign key (specs_regional) references specs_regionales(id_specs_regional),
constraint fk_caracteristicas_costados_manubrio
   foreign key (costado_manubrio) references costados_manubrio(id_costado_manubrio),
constraint fk_caracteristicas_colores
   foreign key (color) references colores(id_color),
constraint fk_caracteristicas_tipo_transmisiones
   foreign key (tipo_transmision) references tipo_transmisiones(id_tipo_transmision)
);

create table anios(
id_anio serial not null,
anio varchar(10) not null,
constraint pk_anio primary key (id_anio)
);

create table modelos(
id_modelo serial not null,
modelo varchar(100) not null,
empresa int not null,
constraint pk_modelos primary key (id_modelo),
constraint fk_modelos_empresas
   foreign key (empresa) references empresas(id_empresa) 
);

create table vehiculos(
id_vehiculo serial not null,
modelo int not null,
tipo_cuerpo int not null,
anio int not null,
caracteristica integer not null,
estado integer not null,
motor integer not null,
constraint pk_vehiculos primary key (id_vehiculo),
constraint fk_vehiculos_modelos
   foreign key (modelo) references modelos(id_modelo),
constraint fk_vehiculos_tipo_cuerpos
   foreign key (tipo_cuerpo) references tipo_cuerpos(id_tipo_cuerpo),
constraint fk_vehiculos_anios
   foreign key (anio) references anios(id_anio),
constraint fk_vehiculos_caracteristicas
   foreign key (caracteristica) references caracteristicas(id_caracteristica),
constraint fk_vehiculos_estados
   foreign key (estado) references estados(id_estado),
constraint fk_vehiculos_motores
   foreign key (motor) references motores(id_motor)
);

create table ofertas(
id_oferta serial not null,
oferta varchar(255) not null,
precio_aed int not null,
vehiculo int not null,
tipo_vendedor int not null,
fecha_publicacion date default to_date('1/1/1900','DD/MM/YYYY'),
ciudad_emirato varchar(30) not null,
constraint pk_ofertas primary key (id_oferta),
constraint fk_ofertas_vehiculos
   foreign key (vehiculo) references vehiculos(id_vehiculo),
constraint fk_ofertas_tipo_vendedores
   foreign key (tipo_vendedor) references tipo_vendedores(id_tipo_vendedor) 
);