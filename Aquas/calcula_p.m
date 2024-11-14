% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcula_p.m

%Calcula el valor de p(i) dado un determinado valor
%de i y un determinado modelo de colas de la forma M/M/...

%Recibe el valor del indice "i" del cual se desea averiguar
%su valor de p(i)

indice_p_n = get(indice_p, 'String');
indice_p_n = str2num(indice_p_n);

%Comprueba que el valor del indice es mayor o igual a cero.

if (indice_p_n>=0)
   
   %Comprueba que es un numero entero
   if(ceil(indice_p_n) == indice_p_n & floor(indice_p_n) == indice_p_n)
      
      %Comprueba que el indice no se sale de rango en funcion del 
      %modelo de colas que se desea resolver
      if(eleccion == 1 | eleccion == 2 | (eleccion == 3 & indice_p_n<=k_n+1) | ...
            (eleccion ==4 & indice_p_n<=k_n+s_n) | ...
            (eleccion ==5 & indice_p_n<=h_n) | ...
            (eleccion ==6 & indice_p_n<=h_n) | ...
            (eleccion ==7 & indice_p_n<=y_n+h_n) | ...
            eleccion ==8)
   
   		switch (eleccion)
      
         case 1,
            %Modelo M/M/1
            
   	   	    valor_p_n  = (1-lambda_n/mu_n)*power(lambda_n/mu_n, indice_p_n);
      
         case 2,
            %Modelo M/M/s
      
   		   if (indice_p_n<s_n)          %indice < s
      		   valor_p_n = c(indice_p_n+1)*p_cero;
		   else 						%indice >= s
   		      p_max=c(s_n)*p_cero;
              valor_p_n = power(lambda_n/(s_n*mu_n), indice_p_n-s_n+1)*p_max;
               
               clear p_max;
     	   end      
      
	   	case 3,      	
            %Modelo M/M/1/k, ya teniamos calculado previamente todos los
            %valores de p, con lo que su implementacion es muy sencilla
            
            valor_p_n = vector_p(indice_p_n+1);
            
         case 4,
            %Modelo M/M/s/k (idem M/M/1/k)
            
            valor_p_n = vector_p(indice_p_n+1);
            
         case 5,
            %Modelo M/M/1/inf/h (idem M/M/1/k)
            
            valor_p_n = vector_p(indice_p_n+1);
            
         case 6,
            %Modelo M/M/s/inf/h (idem M/M/1/k)
            
            valor_p_n = vector_p(indice_p_n+1);
            
         case 7,
            %Modelo M/M/s/inf/h con y repuestos (idem M/M/1/k)
            
            valor_p_n = vector_p(indice_p_n+1);

                        
         case 8,
			%Modelo M/M/inf
            
            %valor_p_n = power(lambda_n, indice_p_n) / ((prod(1:indice_p_n)*power(mu_n, indice_p_n))) * exp(-(lambda_n/mu_n));
            i=0;
            valor_p_n=exp(-(lambda_n/mu_n));
            while (i<indice_p_n)
                valor_p_n=(lambda_n/mu_n)/(i+1)*valor_p_n;
                i=i+1;
            end
      
         end
         
         %Mostramos por pantalla el valor de p(i) para un
         %valor de "i" determinado
         
	   	valor_p_n=num2str(valor_p_n);
      
      	set(valor_p, 'String', valor_p_n);
      
      else
         
         %Si el indice se sale de rango, Error.
         
         valor_p_n = 'Error';
               
         set(valor_p, 'String', valor_p_n);
         
		end
   
	else
      
      	%Si el indice no es un numero entero, Error.
			      
		 valor_p_n = 'Error';
      
         set(valor_p, 'String', valor_p_n);

   end
   
else
   
   %Si el indice no es mayor o igual que cero, Error.
      
   valor_p_n = 'Error';       
      
   set(valor_p, 'String', valor_p_n);
   
end

