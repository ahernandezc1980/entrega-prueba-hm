create or replace procedure	prc_in_up_de_inf_cliente		  (  p_acccion				 in varchar2
																,p_id_cliente            in	number
																,p_primer_nombre		 in varchar2 	
																,p_segundo_nombre        in varchar2 	
																,p_primer_apellido       in varchar2 	
																,p_segundo_apellido      in varchar2 	
																,p_tipo_identificacion   in varchar2 	
																,p_identificacion		 in number 		
																,p_no_celular			 in number 		
																,p_direccion			 in varchar2	
																,p_correo_electronico    in varchar2 											
																,o_cdgo_rspsta			out number
																,o_mnsje_rspsta			out varchar2 ) as 
							 
	 
	  v_id_persona			number(15);
	
	begin
		
		o_cdgo_rspsta :=	0;

		--Se consulta el id_persona
		/*begin
			select  a.id_persona
			into	v_id_persona					
			from    cliente  a
			where   a.id_cliente   =   p_id_cliente;
			exception
				when others then
					o_cdgo_rspsta	:= 10;										  
					o_mnsje_rspsta	:= 'no se pudo consultar';					
					return;
		end;*/

		begin
			case p_acccion
				when 'I' then						
					
						begin
							select  a.id_persona
							into	v_id_persona					
							from    clientes  a
							where   a.id_cliente   =   p_id_cliente;
						exception
							when no_data_found then
								begin
									insert into personas (  primer_nombre		
														   ,segundo_nombre      
														   ,primer_apellido     
														   ,segundo_apellido    
														   ,tipo_identificacion 
														   ,identificacion		
														   ,no_celular			
														   ,direccion
														   ,correo_electronico) 
												  values (	p_primer_nombre	
														   ,p_segundo_nombre    
														   ,p_primer_apellido   
														   ,p_segundo_apellido  
														   ,p_tipo_identificacion
														   ,p_identificacion	
														   ,p_no_celular		
														   ,p_direccion		
														   ,p_correo_electronico
												  
												  )	returning id_persona into v_id_persona;	
								exception
									when others then
									o_cdgo_rspsta	:= 20;	
									o_mnsje_rspsta	:= 'Error al crear la persona ' || sqlerrm;
								end;
							when others then
								o_cdgo_rspsta	:= 30;	
								o_mnsje_rspsta	:= 'Error al crear la persona ' || sqlerrm;
						end;
						begin
						
							insert into clientes (id_persona	) 
								        values (v_id_persona);				
						exception
							when others then
								o_cdgo_rspsta	:= 40;		
								o_mnsje_rspsta	:= 'Error al crear el cliente ' || sqlerrm;
								return;
						end;					
				when 'U' then
					begin
						select  a.id_persona
						into	v_id_persona					
						from    clientes  a
						where   a.id_cliente   =   p_id_cliente;
						exception
							when others then
								o_cdgo_rspsta	:= 50;										  
								o_mnsje_rspsta	:= 'no se pudo consultar el cliente';					
								return;
					end;
					begin
						update personas
						   set primer_nombre			= nvl(p_primer_nombre,primer_nombre)	
							 , segundo_nombre    		= nvl(p_segundo_nombre,segundo_nombre)    
							 , primer_apellido   		= nvl(p_primer_apellido,primer_apellido)   
							 , segundo_apellido  		= nvl(p_segundo_apellido,segundo_apellido)  
							 , tipo_identificacion		= nvl(p_tipo_identificacion,tipo_identificacion)
							 , identificacion			= nvl(p_identificacion,identificacion)	
							 , no_celular				= nvl(p_no_celular,no_celular)		
							 , direccion				= nvl(p_direccion,direccion)		
							 , correo_electronico		= nvl(p_correo_electronico,correo_electronico)
						 where id_persona				= v_id_persona;
					exception
						when others then
							o_cdgo_rspsta	:= 60;		
							o_mnsje_rspsta	:= 'Error al actualizar la informaciòn del cliente ' || sqlerrm;
							return;
					end;
				

				when 'D' then
				begin
						select  a.id_persona
						into	v_id_persona					
						from    clientes  a
						where   a.id_cliente   =   p_id_cliente;
				exception
					when others then
						o_cdgo_rspsta	:= 70;										  
						o_mnsje_rspsta	:= 'no se pudo consultar el cliente para ser borrado';					
						return;
				end;
				begin 
					delete clientes a
					where a.id_cliente   =   p_id_cliente;
				exception
					when others then
					    o_cdgo_rspsta	:= 80;		
						o_mnsje_rspsta	:= 'Error al crear el cliente ' || sqlerrm;
						return;	
				end;
				begin 
					delete personas
					where id_persona	= v_id_persona;
				exception
					when others then
						o_cdgo_rspsta	:= 90;		
						o_mnsje_rspsta	:= 'Error al crear el cliente ' || sqlerrm;
						return;	
				end;
			end case;
		end;
		
	end prc_in_up_de_inf_cliente;
/	
create or replace procedure prc_co_cliente		  (  p_id_cliente            in	number
													,p_primer_nombre		 out varchar2 	
													,p_segundo_nombre        out varchar2 	
													,p_primer_apellido       out varchar2 	
													,p_segundo_apellido      out varchar2 	
													,p_tipo_identificacion   out varchar2 	
													,p_identificacion		 out number 		
													,p_no_celular			 out number 		
													,p_direccion			 out varchar2	
													,p_correo_electronico    out varchar2
													,o_cdgo_rspsta			 out number
													,o_mnsje_rspsta			 out varchar2 ) as 
	 
	 
	v_id_persona			number(15);
	begin
		begin
			select  a.id_persona
			into	v_id_persona					
			from    clientes  a
			where   a.id_cliente   =   p_id_cliente;
			exception
				when others then
					o_cdgo_rspsta	:= 10;										  
					o_mnsje_rspsta	:= 'La declaración no pudo ser consultada';					
					return;
		end;

		begin 
			select 	
                primer_nombre		
			   ,segundo_nombre      
			   ,primer_apellido     
			   ,segundo_apellido    
			   ,tipo_identificacion 
			   ,identificacion		
			   ,no_celular			
			   ,direccion
			   ,correo_electronico
			into 
				 p_primer_nombre		 
				,p_segundo_nombre        
				,p_primer_apellido       
				,p_segundo_apellido      
				,p_tipo_identificacion    
				,p_identificacion		 
				,p_no_celular			 
				,p_direccion			 
				,p_correo_electronico 
			from personas
			where id_persona	= v_id_persona;
		exception
			when others then
				o_cdgo_rspsta	:= 70;		
				o_mnsje_rspsta	:= 'Error al consultar la informacion del cliente ' || sqlerrm;
				return;	
		end;
	
	end prc_co_cliente;  