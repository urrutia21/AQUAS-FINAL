% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcula_q.m

%Calcula el valor de q(i) dado un determinado valor
%de i y un determinado modelo de colas de la forma M/M/...


%Recibe el valor del indice "i" del cual se desea averiguar
%su valor de q(i)

indice_q_n = get(indice_q, 'String');
indice_q_n = str2num(indice_q_n);

%Comprueba que el valor del indice es mayor o igual a cero.

if (indice_q_n>=0)
   
   %Comprueba que es un numero entero
   if (ceil(indice_q_n) == indice_q_n & floor(indice_q_n) == indice_q_n)
      
   %Comprueba que el indice no se sale de rango en funcion del 
   %modelo de colas que se desea resolver
   if((eleccion == 3 & indice_q_n<=k_n) | (eleccion == 4 & indice_q_n<=k_n+s_n-1) | ...
         (eleccion == 5 & indice_q_n<=h_n-1) | (eleccion==6 &indice_q_n<=h_n-1) | ...
         (eleccion == 7 & indice_q_n<=y_n+h_n-1))
   
   		switch (eleccion)
            
         case 3,
            
            %Modelo M/M/1/k, ya teniamos calculado previamente todos los
            %valores de q, con lo que su implementacion es muy sencilla
         
             valor_q_n =vector_q(indice_q_n+1);
            
         case 4,
             %Modelo M/M/s/k (idem M/M/1/k)            
            
             valor_q_n =vector_q(indice_q_n+1);
            
         case 5,
			 %Modelo M/M/1/inf/h (idem M/M/1/k)     
            
             valor_q_n =vector_q(indice_q_n+1);
            
         case 6,
            %Modelo M/M/s/inf/h (idem M/M/1/k)

            valor_q_n =vector_q(indice_q_n+1);
            
         case 7,
            %Modelo M/M/s/inf/h con y repuestos (idem M/M/1/k)

            valor_q_n =vector_q(indice_q_n+1);
         
         end
         
         %Mostramos por pantalla el valor de q(i) para un
         %valor de "i" determinado         
         
	   valor_q_n=num2str(valor_q_n);
      
   	   set(valor_q, 'String', valor_q_n);
         
      else
         
         %Si el indice se sale de rango, Error.
         
       valor_q_n='Error';   
      
   	   set(valor_q, 'String', valor_q_n);

      end
      
   else
      
      %Si el indice no es un numero entero, Error.
      
	valor_q_n='Error';      
      
   	set(valor_q, 'String', valor_q_n);
    
   end
   
else
   
   %Si el indice no es mayor o igual que cero, Error.
   
   valor_q_n='Error';
            
   set(valor_q, 'String', valor_q_n);

end
