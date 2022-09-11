
-- Creo tabla tamporal con comuna y region del proveedor

select distinct comunaproveedor, regionproveedor into tmpcomunas from traspaso;

-- De la tabla temporal listo las comunas que están en mas de 1 region

select comunaproveedor, count(regionproveedor) from tmpcomunas 
group by comunaproveedor
having count(regionproveedor) > 1;

-- Por cada comuna veo a que region esta asociada y reviso la correcta
-- La mayoria de los casos es por la region del Maule, aun siguen
-- en region de Biobio (como Maule se creo hace poco)

select distinct comunaproveedor, regionproveedor from traspaso
    where comunaproveedor like 'Coihueco'

-- Realizo el update de cada comuna a su region correspondiente
-- (son solo 20 errores)    

update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Chill%n';
update traspaso set regionproveedor = 'Región Metropolitana de Santiago' 
     where comunaproveedor like 'Santiago';
update traspaso set regionproveedor = 'Región de Valparaíso' 
     where comunaproveedor like 'La Ligua';
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Yungay';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'San Carlos'; 
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Pinto'; 
update traspaso set regionproveedor = 'Región de Arica y Parinacota' 
     where comunaproveedor like 'Arica'; 
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Ninhue'; 
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Quirihue';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Coelemu';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Bulnes';
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Quill%n';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Chill%Viejo';   
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Ranquil';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'San Fabi%n';  
update traspaso set regionproveedor = 'Región Metropolitana de Santiago' 
     where comunaproveedor like 'Las Condes';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'San Ignacio';
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Portezuelo'; 
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'El Carmen';  
update traspaso set regionproveedor = 'Región de Ñuble' 
     where comunaproveedor like 'Coihueco';  




-- Lo mismo anterior para unidad de compra

select distinct ciudadunidadcompra, regionunidadcompra into tmpcomunas2 from traspaso;

select ciudadunidadcompra, count(regionunidadcompra) from tmpcomunas2 
group by ciudadunidadcompra
having count(regionunidadcompra) > 1;

select distinct ciudadunidadcompra, regionunidadcompra from traspaso
    where ciudadunidadcompra like '%*%'
 

update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Chill%n Viejo';
update traspaso set regionunidadcompra = 'Región Metropolitana de Santiago' 
     where ciudadunidadcompra like 'Santiago';
update traspaso set regionunidadcompra = 'Región de Valparaíso' 
     where ciudadunidadcompra like 'La Ligua';
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Yungay';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'San Carlos'; 
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Pinto'; 
update traspaso set regionunidadcompra = 'Región de Arica y Parinacota' 
     where ciudadunidadcompra like 'Arica'; 
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Ninhue'; 
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Quirihue';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Coelemu';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Bulnes';
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Quill%n';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Chilla%Viejo';   
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Ranquil';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'San Fabi%n';  
update traspaso set regionunidadcompra = 'Región Metropolitana de Santiago' 
     where ciudadunidadcompra like 'Las Condes';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'San Ignacio';
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Portezuelo'; 
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'El Carmen';  
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'Coihueco';   
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like '%iqu%n'; 
update traspaso set regionunidadcompra = 'Región de Ñuble' 
     where ciudadunidadcompra like 'San Nicol%s'; 
   