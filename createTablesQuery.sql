Create table tipos (
tipo char(2) not null,
codigoabreviatura char(10) not null,
descripcion varchar(400) not null,
codigotipo int not null,
constraint pk_tipos primary key (tipo),
constraint un_codigotipo unique (codigotipo)
);

create table estadoscompras
(
codigoestado int not null, 
estado varchar(200) not null,
constraint pk_estadoscompras primary key (codigoestado)
);

create table estadosproveedores
(
codigoestado int not null,
estado varchar(200) not null,
constraint pk_estadosproveedores primary key (codigoestado)
);

create table tiposimpuestos(
tipoimpuesto serial not null,
impuesto varchar(100) not null,
constraint pk_tiposimpuestos primary key (tipoimpuesto)
);

create table tiposdespachos(
idtipodespacho int not null,
tipodespacho varchar(255) not null,
constraint pk_tiposdespachos primary key (idtipodespacho)
);

create table tiposmonedas(
codigomoneda char(3) not null,
nombremoneda varchar(100) not null,
constraint pk_tiposmonedas primary key (codigomoneda)
);

create table unidadesmedidas(
codigounidadmedida serial not null, 
unidadmedida varchar(255) not null,
constraint pk_unidadesmedidas primary key (codigounidadmedida)
);

create table formaspagos(
idformapago int not null,
formapago varchar(255),
constraint pk_formaspagos primary key (idformapago)
);

create table sectores(
idsector serial,
sector varchar(255) not null,
constraint pk_sectores primary key (idsector)
);

create table paises(
codigopais varchar(5) not null,
pais varchar(100) not null,
constraint pk_paises primary key (codigopais)
);

create table actividadesproveedores (
idactividadproveedor serial,
actividadproveedor varchar(255), 
constraint pk_actividadesproveedores primary key (idactividadproveedor)
);

create table categorias(
codigocategoria bigint not null,
categoria varchar(255) not null,
constraint pk_categorias primary key (codigocategoria)
);
--  tabla autodependiente   --

create table rubros(
id_rubro serial not null,
rubro varchar(255) not null,
rubropadre int,
constraint pk_rubros primary key (id_rubro),
constraint fk_rubros_rubros
   foreign key (rubropadre) references rubros(id_rubro) 
   on delete set null  on update cascade 
);

--  tablas dependientes 1 nivel   --

create table procedencias(
idprocedencia serial not null,
procedencia varchar(255) not null,
tipo char(2) not null,
constraint pk_procedencias primary key (idprocedencia),
constraint fk_procedencias_tipo
   foreign key (tipo) references tipos(tipo) 
);

create table regiones(
idregion int not null,
region varchar(100) not null,
pais varchar(5) not null,
constraint pk_regiones primary key (idregion),
constraint fk_regiones_paises  foreign key (pais) 
       references paises(codigopais)
);

create table organismospublicos(
codigoorganismopublico int not null,
organismopublico  varchar(255) not null,
sector int not null,
constraint pk_organismospublicos primary key (codigoorganismopublico ),
constraint fk_organismopublicos_sectores foreign key  (sector) references sectores(idsector)
);
--  tablas dependientes 2 nivel   --

create table ciudades(
idciudad serial not null,
region int not null, 
ciudad varchar(255) not null,
constraint pk_ciudades primary key (idciudad),
constraint fk_ciudades_regiones foreign key (region) 
         references regiones(idregion)
);


create table productos(
codigoproducto bigint not null,
nombreproducto varchar(255) not null,
rubro bigint not null,
constraint pk_productos primary key (codigoproducto),
constraint fk_productos_rubros foreign key (rubro) 
         references rubros(id_rubro)
);

--  tablas dependientes 3 nivel   --

create table proveedores (
codigoproveedor integer not null,
nombreproveedor varchar(255) not null,
actividad integer not null,
comuna integer not null,
promedioevalaucion numeric(10,3) not null default 0,
cantidadevalaucion numeric(10,3) not null default 0,
constraint pk_proveedores primary key (codigoproveedor),
constraint fk_proveedores_activiadad foreign key (actividad) 
         references actividadesproveedores(idactividadproveedor),
constraint fk_proveedores_comunas foreign key (comuna) 
         references ciudades(idciudad)
);

create table unidadescompras(
codigounidadcompra int not null,
rutunidadcompra varchar(12) not null,
unidadcompra varchar(255),
codigoorganismopublico int not null,
ciudad int not null,
constraint pk_unidadescompras primary key (codigounidadcompra),
constraint fk_unidadescompra_organismospublicos    
          foreign key (codigoorganismopublico) references organismospublicos(codigoorganismopublico),
constraint fk_unidadescompra_ciudades    
          foreign key (ciudad) references ciudades(idciudad)    
);


--  tablas dependientes 4 nivel   --

create table sucursales (
codigosucursal int not null,
rutsucursal varchar(12) not null,
sucursal varchar(255) not null,
proveedor int not null,
constraint pk_sucursales primary key (codigosucursal),
constraint fk_sucursales_proveedores    
          foreign key (proveedor) references proveedores(codigoproveedor)
);

--  Licitaciones -----------
       
               
         
create table licitaciones(
idlicitacion bigint not null,
codlicitacion varchar(255) not null,
link1 varchar(255) not null,
nombre text not null,
descripcion text not null,
procedencia int not null ,
estratodirecto varchar(3) not null,
escompraagil varchar(3) not null,
codigotipo int not null,
idplandecompra varchar(20),
codigoestado int not null, 
codigoestadoproveedor int not null,
fechacreacion date default to_date('1/1/1900','DD/MM/YYYY'),
fechaenvio date default to_date('1/1/1900','DD/MM/YYYY'),
fechasolicitudcancelacion date default to_date('1/1/1900','DD/MM/YYYY'),
fechaultimamodificacion date default to_date('1/1/1900','DD/MM/YYYY'),
fechaaceptacion date default to_date('1/1/1900','DD/MM/YYYY'),
fechacancelacion date default to_date('1/1/1900','DD/MM/YYYY'),
tieneitems int not null,
montototal bigint not null,
tipomoneda char(3) not null,
montototalpesos numeric(10,3) not null,
impuestos bigint not null default 0,
tipoimpuesto int not null default 0, 
descuento bigint not null default 0,
cargos bigint not null default 0,
totalnetooc bigint not null default 0,
codigounidadcompra int not null, 
codigosucursal int not null, 
financiamiento varchar(255),
porcentajeiva int not null,
pais varchar(5) not null, 
tipodespacho int not null, 
formapago int not null, 
codigolicitacion varchar(255),
constraint pk_licitaciones primary key (idlicitacion),
constraint fk_licitaciones_procedencia   
            foreign key (procedencia) 
               references procedencias(idprocedencia),
constraint ck_estratodireto check (estratodirecto in ('Si','No','Na')),
constraint ck_escomrpaagil check (escompraagil in ('Si','No')),
constraint fk_licitaciones_tipos  
            foreign key (codigotipo) 
               references tipos(codigotipo),
constraint fk_licitaciones_estadoscompras 
            foreign key (codigoestado) 
               references estadoscompras(codigoestado),
constraint fk_licitaciones_estadosproveedor
            foreign key (codigoestadoproveedor) 
               references estadosproveedores(codigoestado),
constraint ck_tieneitems check (tieneitems between 0 and 1 ),
constraint ck_montototal check (montototal >= 0 ),
constraint fk_licitaciones_tipomonedas
            foreign key (tipomoneda) 
            references tiposmonedas(codigomoneda),
constraint ck_montototalpesos check (montototalpesos >= 0 ),
constraint ck_impuestos check (impuestos >= 0 ),
constraint fk_licitaciones_tipoimpuestos
            foreign key (tipoimpuesto) 
           references tiposimpuestos(tipoimpuesto),
constraint ck_desceunto check (descuento >= 0 ),
constraint ck_cargos check (cargos >= 0 ),
constraint ck_totalnetooc check (totalnetooc >= 0 ),
constraint fk_licitaciones_unidadescompras
            foreign key (codigounidadcompra) 
            references unidadescompras(codigounidadcompra),
constraint fk_licitaciones_sucursales
            foreign key (codigosucursal) 
           references sucursales(codigosucursal),
constraint fk_licitaciones_paises
            foreign key (pais) 
            references paises(codigopais),
constraint fk_licitaciones_tiposdespachos
            foreign key (tipodespacho) 
            references tiposdespachos(idtipodespacho),
constraint fk_licitaciones_formaspago
            foreign key (formapago) 
            references formaspagos(idformapago)
);

--  Item Licitaciones ---------------

create table itemeslicitaciones(
iditem bigint not null,
idlicitacion bigint not null,
codigocategoria bigint not null,
codigoproducto bigint not null, 
especificacioncomprados text,
especificacionproveedos text,
cantidad float not null,
unidadmedida int not null, 
monedaitem char(3) not null, 
precioneto numeric(10,3) not null default 0,
totalcargo numeric(10,3) not null default 0,
totaldescuentos int not null default 0,
totalimpuestos int,
totallineaneto numeric(10,3)  default 0,
formapago int not null, 
constraint itemes primary key (iditem),
constraint fk_itemeslicitaciones_licitaciones   
            foreign key (idlicitacion) 
            references licitaciones(idlicitacion),
constraint fk_itemeslicitaciones_categorias   
            foreign key (codigocategoria) 
            references categorias(codigocategoria),
constraint fk_itemeslicitaciones_productos   
            foreign key (codigoproducto) 
            references productos(codigoproducto),
constraint ck_cantidad check (cantidad >= 0 ),
constraint fk_itemeslicitaciones_unidadesmedidas  
            foreign key (unidadmedida) 
            references unidadesmedidas(codigounidadmedida),
constraint fk_itemeslicitaciones_monedas  
            foreign key (monedaitem) 
            references tiposmonedas(codigomoneda),
constraint ck_precioneto check (precioneto >= 0 ),
constraint ck_totalcargos check (totalcargo >= 0 ),
constraint ck_totaldescuentos check (totaldescuentos >= 0 ),
constraint ck_totallineaneto check (totallineaneto >= 0 ),
constraint fk_itemeslicitaciones_formaspago 
            foreign key (formapago)  
            references formaspagos(idformapago)
);
              