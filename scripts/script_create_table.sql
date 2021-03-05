--creacion de secuencia  para cada tabla
/
create sequence sq_personas  start with     1000  increment by   1  nocache  nocycle;
/

create table personas ( id_persona				number(15) 				default    sq_personas.nextval
																		constraint personas_id_persona_pk			primary key
																		constraint personas_id_persona_nn 			not null,												
						primer_nombre			varchar2(100)			constraint personas_primer_nombre			not null,
						segundo_nombre          varchar2(100),
						primer_apellido         varchar2(100)           constraint personas_primer_apellido         not null,
						segundo_apellido        varchar2(100),
						tipo_identificacion     varchar2(30)            constraint personas_tipo_identificacion     not null,
						identificacion			number(15)              constraint personas_identificacion		    not null,
						no_celular				number(15)              constraint personas_no_celular			    not null,
						direccion				varchar2(50)            constraint personas_direccion			    not null,
						correo_electronico		varchar2(30)			constraint personas_correo_electronico		not null);
/

create sequence sq_cliente  start with     1000  increment by   1  nocache  nocycle;

/						
create table cliente  ( id_cliente              number(15)				default    sq_cliente.nextval
																		constraint cliente_id_cliente_pk			primary key
																		constraint cliente_id_cliente_nn 			not null,
						id_persona				number(15)				constraint cliente_id_persona_fk			references personas(id_persona)
																		constraint cliente_id_persona_nn 			not null);
/

create sequence sq_vehiculo  start with     1000  increment by   1  nocache  nocycle;

/																		
create table vehiculo( id_vehiculo       		number(15)				default    sq_vehiculo.nextval
																		constraint vehiculo_id_vehiculo_pk			primary key
												 						constraint vehiculo_id_vehiculo_nn 			not null,
					    placa					varchar2(6)				constraint vehiculo_placa_nn 				not null,
						modelo					number(4)				constraint vehiculo_modelo_nn 				not null,
						marca					varchar2(15)            constraint vehiculo_marca_nn 				not null);
/
create sequence sq_mecanico  start with     1000  increment by   1  nocache  nocycle;
/						
create table mecanico  ( id_mecanico            number(15)				default    sq_mecanico.nextval
																		constraint mecanico_id_mecanico_pk			primary key
																		constraint mecanico_id_mecanico_nn 			not null,
						id_persona				number(15)				constraint mecanico_id_persona_fk			references personas(id_persona)
																		constraint mecanico_id_persona_nn 			not null,
						estado					varchar2(10)			constraint mecanico_estado_nn            	not null);	
/
create sequence sq_cliente_vehiculo  start with     1000  increment by   1  nocache  nocycle;						
/						
create table cliente_vehiculo  (id_cliente_vehiculo     number(15)		default    sq_cliente_vehiculo.nextval
																		constraint clnte_vhclo_id_clnte_vhclo_pk			primary key
												 						constraint clnte_vhclo_id_clnte_vhclo_nn 			not null,
								id_cliente              number(15)		constraint clnte_vhclo_id_cliente_fk				references cliente(id_cliente)
																		constraint clnte_vhclo_id_cliente_nn 				not null,
								id_vehiculo             number(15)		constraint clnte_vhclo_id_vehiculo_fk				references vehiculo(id_vehiculo)
																		constraint clnte_vhclo_id_vehiculo_nn 				not null,
																		constraint clnte_vhclo_id_vehiculo_un 				unique (id_cliente, id_vehiculo));
/
create sequence sq_sucursales  start with     1000  increment by   1  nocache  nocycle;	
/	
create table sucursales      (id_sucursal        	number(15)		default    sq_sucursales.nextval
																	constraint sucursales_id_sucursal_pk			primary key
																	constraint sucursales_id_sucursal_nn 			not null, 
							  nombre_sucursal		varchar2(30) 	constraint sucursales_nombre_sucursal           not null,
							  ciudad				varchar2(30) 	constraint sucursales_ciudad                    not null,
							  direccion				varchar2(50)    constraint sucursales_direccion	    		    not null,
									
							);

/
create sequence sq_orden_mantenimiento  start with     1000  increment by   1  nocache  nocycle;	
/																	 
create table orden_mantenimiento  ( id_orden_mantenimiento 	 number(15)		default    sq_orden_mantenimiento.nextval
																			constraint orden_mntnmnto_id_ordn_mnto_pk			primary key
																			constraint orden_mntnmnto_id_ordn_mnto_nn 			not null,
									id_vehiculo              number(15)		constraint orden_mntnmnto_id_vehiculo_fk			references vehiculo(id_vehiculo)
																			constraint orden_mntnmnto_id_vehiculo_nn 			not null,
									id_mecanico				 number(15)		constraint orden_mntnmnto_id_mecanico_fk			references mecanico(id_mecanico)
																			constraint orden_mntnmnto_id_mecanico_nn 			not null,
									id_sucursal  			 number(15)		constraint orden_mntnmnto_id_sucursal_fk			references sucursales(id_sucursal)
																			constraint orden_mntnmnto_id_sucursal_nn 			not null,
									presupuesto_cliente		 number(10),
									fecha_inicio			 timestamp		default systimestamp,
									fecha_fin				 timestamp,
									estado					 varchar2(12)   default	'valoración');
/
create sequence sq_adjuntos_vehiculo  start with     1000  increment by   1  nocache  nocycle;	
/								
create table adjuntos_vehiculo  (id_adjunto_vehiculo  		number(15)		default    sq_adjuntos_vehiculo.nextval
																			constraint adjntos_vhclo_id_adjnt_vhcl_pk			primary key
																			constraint adjntos_vhclo_id_adjnt_vhcl_nn	 		not null,
								 id_orden_mantenimiento		number(15)		constraint adjntos_vhclo_id_ordn_mnto_fk			references orden_mantenimiento(id_orden_mantenimiento)
																			constraint adjntos_vhclo_id_ordn_mnto_nn 			not null,
								 descripcion		  		varchar2(30),
								 foto				  		blob);
/
create sequence sq_repuestos  start with     1000  increment by   1  nocache  nocycle;	
/								 
create table repuestos         ( id_repuestos   	number(15)		default    sq_repuestos.nextval
																	constraint repuestos_id_repuestos_pk			primary key
																	constraint repuestos_id_repuestos_nn 		    not null,
								 descripcion		varchar2(50)    constraint repuestos_descripcion_nn 		    not null,									
								 precio_unidad		number(10)		constraint repuestos_precio_unidad_nn 		    not null,						
								 descuento_unidad	number(10)		constraint repuestos_descuento_unidad_nn 		not null,
								 cantidad_bodega	number(10)		constraint repuestos_cantidad_bodega_nn 		not null,
								 id_sucursal        number(10)      constraint repuestos_id_sucursal_fk			    references sucursales(id_sucursal)
																	constraint repuestos_id_sucursal_nn 			not null, 
								 );
/
create sequence sq_ordn_mntnmnto_rpsto  start with     1000  increment by   1  nocache  nocycle;	
/								 
create table orden_mantenimiento_repuestos      (id_orden_mantenimiento_repuestos		number(15)		default    sq_ordn_mntnmnto_rpsto.nextval
																										constraint ordn_mntn_rpst_id_pk							primary key
																										constraint ordn_mntn_rpst_id_nn 		    			not null,
												 id_orden_mantenimiento					number(15)		constraint ordn_mntn_rpst_id_ordn_mnto_fk			    references orden_mantenimiento(id_orden_mantenimiento)
																										constraint ordn_mntn_rpst_id_ordn_mnto_nn 			    not null,
												 id_repuestos							number(15)		constraint ordn_mntn_rpst_id_repuestos_fk			    references repuestos(id_repuestos)
																										constraint ordn_mntn_rpst_id_repuestos_nn 			    not null,														
												 cantidad_x_orden						number(10)		constraint ordn_mntn_rpst_aplica_dscnto_nn 		        not null,
												 aplica_descuento						varchar2(1)     default 'N'	);
/
create sequence sq_servicios  start with     1000  increment by   1  nocache  nocycle;	
/
create table servicios                          (id_servicios 							number(15)		default    sq_servicios.nextval
																										constraint servicios_id_servicios_pk				primary key
																										constraint servicios_id_servicios_nn 		        not null,
												 descripcion							varchar2(50)    constraint servicios_descripcion_nn 		        not null,
												 valor_minimo							number(10)		constraint servicios_valor_minimo_nn 		        not null,
												 valor_maximo							number(10)      constraint servicios_valor_maximo_nn 		        not null);
/
create sequence sq_orden_mnt_srv  start with     1000  increment by   1  nocache  nocycle;	
/									
create table orden_mantenimineto_servicios      ( id_orden_mantenimineto_servicios		number(15)		default    sq_orden_mnt_srv.nextval
																										constraint orden_mnt_srv_id_pk						primary key
																										constraint orden_mnt_srv_id_nn						not null,
												  id_orden_mantenimiento				number(15)		constraint orden_mnt_srv_id_ordn_mnto_fk			references orden_mantenimiento(id_orden_mantenimiento)
																										constraint orden_mnt_srv_id_ordn_mnto_nn 			not null,
												  id_servicios							number(15)		constraint orden_mnt_srv_id_servicios_fk			references servicios(id_servicios)
																										constraint orden_mnt_srv_id_servicios_nn 			not null,
												  valor_servicio						number(15)		constraint orden_mnt_srv_vlor_srvicio_nn 			not null);
/
create sequence sq_factura  start with     1000  increment by   1  nocache  nocycle;	
/												  
create table facturas                            (id_factura   							number(15)		default    sq_factura.nextval
																										constraint factura_id_factura_pk			primary key
																										constraint factura_id_factura_nn			not null,
												 id_orden_mantenimiento					number(15)		constraint factura_id_ordn_mnto_fk			references orden_mantenimiento(id_orden_mantenimiento)
																										constraint factura_id_ordn_mnto_nn 			not null,	
												id_cliente              				number(15)		constraint factura_id_cliente_fk			references cliente(id_cliente)
																										constraint factura_id_cliente_nn			not null,
												valor_total_factura						number(15) ,
												fecha									timestamp 		not null)	;
												
/*ALTER TABLE facturas ADD id_cliente number(15);
ALTER TABLE facturas ADD CONSTRAINT factura_id_cliente_fk FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);
ALTER TABLE repuestos ADD  ( descripcion varchar2(50) constraint repuestos_descripcion_nn  not null) ;		*/										











