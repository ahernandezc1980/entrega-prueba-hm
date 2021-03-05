/* 5.	Consulta de Clientes que han comprado un acumulado $100.000 en los últimos 60 días */
select a.id_cliente
	  ,c.primer_nombre || ' ' || c.primer_apellido  nombre_cliente
      ,sum(a.valor_total_factura)   valor_acumulado
from facturas              a
join clientes              b on a.id_cliente   = b.id_cliente
join personas              c on b.id_persona   = c.id_persona
where trunc(a.fecha)        >= trunc(sysdate - 60)
group by a.id_cliente,c.primer_nombre,c.primer_apellido
having sum(a.valor_total_factura)      >= 100000;

/* 6.	Consulta de los 100 productos más vendidos en los últimos 30 días */
 select a.id_repuestos
        ,d.descripcion
        ,sum(a.cantidad_x_orden) cantidad_productos
 from  orden_mantenimiento_repuestos a
 join  orden_mantenimiento           b on a.id_orden_mantenimiento = b.id_orden_mantenimiento
 join  facturas                      c on b.id_orden_mantenimiento = c.id_orden_mantenimiento
 join  repuestos                     d on a.id_repuestos           = d.id_repuestos
 where trunc(c.fecha)       	>= trunc(sysdate - 30)
 group by a.id_repuestos,d.descripcion
 order by cantidad_productos
 fetch first 100 rows only;
 
/* 7.	Consulta de las tiendas que han vendido más de 100 UND del producto 100 en los últimos 60 días. */

 select b.id_sucursal
        ,a.nombre_sucursal
        ,sum(c.cantidad_x_orden) cantidad_producto
 from sucursales a
 join orden_mantenimiento           b on a.id_sucursal             = b.id_sucursal
 join orden_mantenimiento_repuestos c on b.id_orden_mantenimiento  = c.id_orden_mantenimiento
 join repuestos                     d on  c.id_repuestos           = d.id_repuestos
 join facturas                      f on  b.id_orden_mantenimiento = f.id_orden_mantenimiento
 where d.id_repuestos = 100
 and trunc(f.fecha)        		>= trunc(sysdate - 60)
 group by b.id_sucursal,c.id_repuestos,a.nombre_sucursal;
 
/* 8.	Consulta de todos los clientes que han tenido más de un(1) mantenimento en los últimos 30 días */
  select a.id_cliente
        , e.primer_nombre || ' ' || e.primer_apellido  nombre_cliente
        ,count(d.id_orden_mantenimiento) numero_mantenimientos
 from clientes a
 join cliente_vehiculo      b  on a.id_cliente = b.id_cliente
 join vehiculo              c  on b.id_vehiculo = c.id_vehiculo
 join orden_mantenimiento   d  on c.id_vehiculo = d.id_vehiculo 
 join personas              e on a.id_persona   = e.id_persona
 where  trunc(d.fecha_fin)        		>= trunc(sysdate - 30)
 and   d.estado = 'Terminado'
 group by a.id_cliente,e.primer_nombre,e.primer_apellido
 having count(d.id_orden_mantenimiento)	> 1;
 
/* 9. Procedimiento que reste la cantidad de productos del inventario de las tiendas cada que se presente una venta. */
create or replace procedure prc_actualizar_inventario( p_id_repuesto	        in number
                                                      ,p_id_sucursal            in number
                                                      ,p_cantidad		        in number
                                                      ,o_mensaje_respuesta	    out varchar2) as
	begin
		update repuestos
		   set cantidad_bodega	= cantidad_bodega - p_cantidad
		where id_repuestos	= p_id_repuesto
        and   id_sucursal   = p_id_sucursal ;
		o_mensaje_respuesta	:= 'Cantidad en inventario del repuesto identificado '||p_id_repuesto||
                       ' Actulizado Exitosamente en Inventario: ';
		commit;
	exception
		when others then
			o_mensaje_respuesta	:= 'Ocurrio un problema al actulizar el inventario Error: ' || sqlerrm;
end;
/ 