% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcula_q_simulacion.m

%Calcula el valor de q(i) dado un determinado valor
%de i y un determinado modelo de colas de la forma G/G/...


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
            
            %Modelo G/G/1/k, ya teniamos calculado previamente todos los
            %valores de q, con lo que su implementacion es muy sencilla
            
            if (length(p)<(k_n+2))
               p(k_n+2)=0;
            end

         
            valor_q_n =p(indice_q_n+1)/(1-p(k_n+1+1));
            
         case 4,
            %Modelo G/G/s/k (idem G/G/1/k)
            
            if (length(p)<(k_n+s_n+1))
               p(k_n+s_n+1)=0;
            end
            
            
            valor_q_n =p(indice_q_n+1)/(1-p(k_n+s_n+1));
            
         case 5,
		     %Modelo G/G/1/inf/h (idem G/G/1/k)     
            
             valor_q_n =p(indice_q_n+1)*(h_n-indice_q_n)/(h_n-c/t);
            
         case 6,
            %Modelo G/G/s/inf/h (idem G/G/1/k)

             valor_q_n =p(indice_q_n+1)*(h_n-indice_q_n)/(h_n-c/t);
            
         case 7,
            %Modelo G/G/s/inf/h con y repuestos (idem G/G/1/k)
            
            if(indice_q_n<y_n)
               suma=0;
               for i=y_n:y_n+h_n
                  suma=suma+(i-y_n)*p(i+1);
               end
               valor_q_n=h_n*p(indice_q_n+1)/(h_n-suma);
            else
               suma=0;
               for i=y_n:y_n+h_n
                  suma=suma+(i-y_n)*p(i+1);
               end
               valor_q_n=(h_n+y_n-indice_q_n)*p(indice_q_n+1)/(h_n-suma);
			end
            
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
