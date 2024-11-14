% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  dibujar_p.m

%Calcula el valor de p(i) en un intervalo de valores
% y lo muesta en un diagrama de barras

%Recibe el valor de los indices que forman el intervalo

indice_1_n = get(indice_1, 'String');
indice_1_n = str2num(indice_1_n);

indice_2_n = get(indice_2, 'String');
indice_2_n = str2num(indice_2_n);



%Comprueba que el valor de los indices es mayor o igual a cero y
%que el segundo indice es mayor que el primero

if (indice_1_n>=0 & indice_2_n>0 & indice_2_n>indice_1_n)
   
   %Comprueba que los indices son numeros enteros

	if (ceil(indice_1_n) == indice_1_n & floor(indice_1_n) == indice_1_n & ...
       ceil(indice_2_n) == indice_2_n & floor(indice_2_n) == indice_2_n)
    
    %Comprueba que los indices no se salen de rango en funcion del 
    %modelo de colas que se desea resolver

    if(eleccion == 1 | eleccion == 2 | (eleccion == 3 & indice_2_n<=k_n+1) | ...
          (eleccion ==4 & indice_2_n<=k_n+s_n) | ...
          (eleccion ==5 & indice_2_n<=h_n) | ...
          (eleccion ==6 & indice_2_n<=h_n) | ...
          (eleccion ==7 & indice_2_n<=y_n+h_n) | ...
          eleccion ==8)
       
        
      if (eleccion==8)
         text_dibujar_p_error = uicontrol(gcf, 'Style', 'Text', ...
 		     'String', '', ...
       		 'Units', 'normalized', ...
             'Position', [0.33 0.535 0.3 0.03], ...
             'ForegroundColor', 'r', ...
             'BackgroundColor', [0.6 0.6 0.6], ...
    	   	 'FontUnits', 'normalized', ...
    	   	 'FontSize', 0.2, ...
             'HorizontalAlignment', 'Center');
      else
              text_dibujar_p_error = uicontrol(gcf, 'Style', 'Text', ...
     		     'String', '', ...
           		 'Units', 'normalized', ...
                 'Position', [0.53 0.535 0.3 0.03], ...
                 'ForegroundColor', 'r', ...
                 'BackgroundColor', [0.6 0.6 0.6], ...
        	   	 'FontUnits', 'normalized', ...
        	   	 'FontSize', 0.2, ...
                 'HorizontalAlignment', 'Center');
       end
      
        
	   global dibujo2;

                   
                  
         %Borra el dibujo anterior (en caso de que exista), para crear uno 
         %nuevo que no sobreescriba el anterior
                 
 		if (cambiar_parametros_mm==2)      
             delete(dibujo2)
        end
         
        cambiar_parametros_mm=2;
         
         
         %indices es un vector indice1, indice1+1, ..., indice2
		 indices=linspace(indice_1_n,indice_2_n,indice_2_n-indice_1_n+1);
   
   		switch eleccion
      
         case 1,
      	   %Modelo M/M/1
                  
   	   	   p_varios=(1-lambda_n/mu_n)*power(lambda_n/mu_n, indices);
      
         case 2,
            %Modelo M/M/s
         
	      	if indice_1_n>=s_n %indice_1 es mayor o igual que s
   	      	   p_max=c(s_n)*p_cero;
               p_varios=power(lambda_n/(s_n*mu_n), indices-s_n+1)*p_max;
               
               clear p_max;
         
	      	elseif indice_2_n<s_n %indice_2 es menor o igual que s
   	   	        p_varios = c(indices+1)*p_cero;
         
      		else  %indice_1 e indice_2 tienen a s en el medio
         		rango1=indice_1_n:(s_n-1);
         		p_varios_1 = c(rango1+1)*p_cero;
         
         		rango2=s_n:indice_2_n;
         		p_max=c(s_n)*p_cero;
	         	p_varios_2 = power(lambda_n/(s_n*mu_n),rango2-s_n+1)*p_max;         
         
               p_varios=cat(2,p_varios_1,p_varios_2);
               
               clear rango1;
               clear p_varios_1;
               clear rango2;
               clear p_max;
               clear p_varios_2;

			end

			case 3,      		 
            %Modelo M/M/1/k, ya teniamos calculado previamente todos los
            %valores de p, con lo que su implementacion es muy sencilla

            p_varios=vector_p(indices+1);
            
         case 4,
            %Modelo M/M/s/k (idem M/M/1/k)
            
            p_varios=vector_p(indices+1);
            
         case 5,
            %Modelo M/M/1/inf/h (idem M/M/1/k)
            
            p_varios=vector_p(indices+1);
            
         case 6,
            %Modelo M/M/s/inf/h (idem M/M/1/k)
            
            p_varios=vector_p(indices+1);
            
         case 7,
            %Modelo M/M/s/inf/h con y repuestos (idem M/M/1/k)

            p_varios=vector_p(indices+1);
            
         case 8,
            %Modelo M/M/inf
            
            %factorial=ones(1,length(indices));
            %for i=1:length(indices)
            %   factorial(i)=prod(1:i+indice_1_n-1); %factorial de i+indice1-1
            %end
            
            %p_varios=power(lambda_n, indices)*exp(-(lambda_n/mu_n));
            %p_varios=p_varios./(factorial.*(power(mu_n,indices)));
            
            p_varios=[];
            for j=indice_1_n:indice_2_n
                i=0;
                valor_comienzo=exp(-(lambda_n/mu_n));
                while (i<j)
                    valor_comienzo=(lambda_n/mu_n)/(i+1)*valor_comienzo;
                    i=i+1;
                end
                p_varios=cat(2,p_varios,valor_comienzo);
            end
                            
            
            
            %clear factorial;
            %clear i;
            
      	end
         
      %Dibuja el diagrama de barras correspondiente
      
      
        if (eleccion==8)          
    		dibujo2=axes('Position', [0.34 0.19 0.3 0.3]);
        else
            dibujo2=axes('Position', [0.54 0.19 0.3 0.3]);
        end
        
        
		bar(indice_1_n:indice_2_n,p_varios)
        title('Grafica de p(i)')           
      
  	 else
         
        if (eleccion==8)              
        text_dibujar_p_error = uicontrol(gcf, 'Style', 'Text', ...
     		 'String', 'Error en los parametros', ...
         	 'Units', 'normalized', ...
             'Position', [0.33 0.535 0.3 0.03], ...
             'BackgroundColor', [0.6 0.6 0.6], ...
             'ForegroundColor', 'r', ...
    	   	 'FontUnits', 'normalized', ...
             'FontWeight', 'bold', ...
    	   	 'FontSize', 0.5, ...
             'HorizontalAlignment', 'Center');
        else
             text_dibujar_p_error = uicontrol(gcf, 'Style', 'Text', ...
     		 'String', 'Error en los parametros', ...
       		 'Units', 'normalized', ...
             'Position', [0.53 0.535 0.3 0.03], ...
             'BackgroundColor', [0.6 0.6 0.6], ...
             'ForegroundColor', 'r', ...
	   	     'FontUnits', 'normalized', ...
             'FontWeight', 'bold', ...
    	   	 'FontSize', 0.5, ...
             'HorizontalAlignment', 'Center');
         end
      
   
		end

	else
                             
        if (eleccion==8)
            text_dibujar_p_error = uicontrol(gcf, 'Style', 'Text', ...
     		      'String', 'Error en los parametros', ...
            	  'Units', 'normalized', ...
                  'Position', [0.33 0.535 0.3 0.03], ...
                  'BackgroundColor', [0.6 0.6 0.6], ...
                  'ForegroundColor', 'r', ...
                  'FontUnits', 'normalized', ...
                  'FontWeight', 'bold', ...
        	   	  'FontSize', 0.5, ...
                  'HorizontalAlignment', 'Center');
         else
             text_dibujar_p_error = uicontrol(gcf, 'Style', 'Text', ...
 		         'String', 'Error en los parametros', ...
           		 'Units', 'normalized', ...
                 'Position', [0.53 0.535 0.3 0.03], ...
                 'BackgroundColor', [0.6 0.6 0.6], ...
                 'ForegroundColor', 'r', ...
                 'FontUnits', 'normalized', ...
                 'FontWeight', 'bold', ...
        	   	 'FontSize', 0.5, ...
                 'HorizontalAlignment', 'Center');
        end

	end

else
        
     if (eleccion==8)
    	  text_dibujar_p_error = uicontrol(gcf, 'Style', 'Text', ...
     		      'String', 'Error en los parametros', ...
           		  'Units', 'normalized', ...
                  'Position', [0.33 0.535 0.3 0.03], ...
                  'BackgroundColor', [0.6 0.6 0.6], ...
                  'ForegroundColor', 'r', ...
                  'FontUnits', 'normalized', ...
                  'FontWeight', 'bold', ...
        	   	  'FontSize', 0.5, ...
                  'HorizontalAlignment', 'Center');
     else
     	  text_dibujar_p_error = uicontrol(gcf, 'Style', 'Text', ...
 		         'String', 'Error en los parametros', ...
           		 'Units', 'normalized', ...
                 'Position', [0.53 0.535 0.3 0.03], ...
                 'BackgroundColor', [0.6 0.6 0.6], ...
                 'ForegroundColor', 'r', ...
                 'FontUnits', 'normalized', ...
                 'FontWeight', 'bold', ...
        	   	 'FontSize', 0.5, ...
                 'HorizontalAlignment', 'Center');
     end

end


