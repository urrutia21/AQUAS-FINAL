% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcula_p_simulacion.m

%Calcula el valor de p(i) dado un determinado valor
%de i y de un determinado modelo de la forma G/G/..

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
         
         if (indice_p_n>=length(p))
            p(indice_p_n+1)=0;
         end
         
                 
         valor_p_n = p(indice_p_n+1);
         
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

