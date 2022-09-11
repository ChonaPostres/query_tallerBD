-- PRoveedores actividad proveedor ---
--
--   OBS: Un proveedor PODRIA TENER MAS DE UNA ACTIVIDAD
--        lo cual seria valido. Por lo anterior, nuestro
--         modelo deberia cambiar a una relacion
--         muchos a muchos entre proveedores y 
--         actividadesproveedores
alter table proveedores 
   drop constraint proveedores_actividad_fkey;
alter table proveedores
   drop column actividad;
   
create table proveedores_actividadesproveedores (
codigoproveedor integer not null,
idactividadproveedor integer not null,
constraint pk_proveedores_actividadesproveedores
     primary key (codigoproveedor,idactividadproveedor),
constraint fk_proveedores_actividadesproveedores_actividadesproveedores 
     foreign key (idactividadproveedor)
                  references actividadesproveedores(idactividadproveedor),
constraint fk_proveedores_actividadesproveedores_proveedores 
     foreign key (codigoproveedor) references proveedores(codigoproveedor)
 );   
  