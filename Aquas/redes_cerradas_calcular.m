% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  redes_cerradas_calcular.m

%Ya hemos leido los datos de todos los nodos que forman la red.

if (pasos > nodos_cerradas)
   
   
   if(nodo_intercambia==1 & intercambio_cerradas==0)
      vector_l_cerradas= [];
      vector_w_cerradas= [];
      matriz_p_clientes_cerradas= [];
   end
   
   
   %Crea la matriz a
   
   a=matriz_prob_cerradas(2:nodos_cerradas,1:(nodos_cerradas-1))'*(-1);
     
   
   if (nodos_cerradas>=3)
	  for i=1:(nodos_cerradas-2)
   	     a(i+1,i)=1+a(i+1,i);
      end
   end
   
   
   
   %Si el determinante de "a" es igual a cero, el sistema no es estacionario
   if (det(a) == 0)
      clear a;   
      clear mu_cerradas_n;
      clear servidores_cerradas_n;
      clear vector_prob_cerradas;
      clear vector_mu_cerradas;
      clear vector_servidores_cerradas;
      clear prob_cerradas_n;
      clear pasos;
      clear matriz_prob_cerradas;
      
      redes_cerradas_no_estacionario;
   else           
      
      %El determinante de a es distinto de cero
      
      %Calcula el valor de lambda_mayuscula(i)
      %Se asume lambda_mayuscula(1)=1
      
      lambda_mayuscula=ones(1,nodos_cerradas);
      lambda_mayuscula(1)=1;
                 
      for i=1:(nodos_cerradas-1)
         b(i)=matriz_prob_cerradas(1,i);
      end
      b(1)=-1+b(1);
      
      
      
      lambda_mayuscula(2:nodos_cerradas)=inv(a)*b(1:(nodos_cerradas-1))';
      
      ro=lambda_mayuscula./vector_mu_cerradas;
      
      %Calcula los valores de la matriz g, apoyandose en la funcion
      %calcular_f_cerradas
      for i=1:nodos_cerradas
         g(i,1)=1;
      end
      
      for i=2:(clientes_cerradas)  %OJO!! clientes_cerradas vale 1 si son 0 clientes
            							  %vale 2 si es 1 cliente, vale 3 si son 2 ...

         g(1,i)=calcular_f_cerradas((i-1),ro(1),vector_servidores_cerradas(1));
      end
      
      for i=2:nodos_cerradas
         for j=2:(clientes_cerradas) %OJO!! clientes_cerradas vale 1 si son 0 clientes
            								 %vale 2 si es 1 cliente, vale 3 si son 2 ...
            suma=0;
            for indice=0:(j-1)
               suma=suma+calcular_f_cerradas(indice,ro(i),vector_servidores_cerradas(i))...
                  *g(i-1,j-indice);
            end
            g(i,j)=suma;
         end
      end
      
      l_cerradas=0;
      suma=0;
      
      %Calcula la probabilidad de que haya un determinado numero de clientes en el 
      %ultimo nodo de la red, por termino medio (nummedio).
      
      %Tambien calcula el valor de L en el ultimo nodo (l_cerradas)
      for i=0:(clientes_cerradas-1)
         nummedio(i+1)=(1/g(nodos_cerradas,clientes_cerradas))*...
            calcular_f_cerradas(i,ro(nodos_cerradas),vector_servidores_cerradas(nodos_cerradas))...
            *g(nodos_cerradas-1,clientes_cerradas-i);
         if(i>=1)
            l_cerradas=l_cerradas+nummedio(i+1)*(i);
            suma=suma+nummedio(i+1);
         end
      end
      
      %Calcula el valor de lambda_mayuscula_barra
      lambda_mayuscula_barra(nodos_cerradas)=0;
      for i=1:(clientes_cerradas-1)
          if (i<=vector_servidores_cerradas(nodos_cerradas))
              lambda_mayuscula_barra(nodos_cerradas)=lambda_mayuscula_barra(nodos_cerradas)+vector_mu_cerradas(nodos_cerradas)*i*nummedio(i+1);
          else
              lambda_mayuscula_barra(nodos_cerradas)=lambda_mayuscula_barra(nodos_cerradas)+vector_mu_cerradas(nodos_cerradas)*vector_servidores_cerradas(nodos_cerradas)*nummedio(i+1);
          end
      end
          
                    
     % lambda_mayuscula_barra(nodos_cerradas)=vector_mu_cerradas(nodos_cerradas)*suma;
      
      c=lambda_mayuscula_barra(nodos_cerradas)/lambda_mayuscula(nodos_cerradas);
      
      lambda_mayuscula_barra(1:(nodos_cerradas-1))=c*...
         lambda_mayuscula_barra(1:(nodos_cerradas-1));
      
      %Calcula el valor de W en el ultimo nodo
      w_cerradas=l_cerradas/lambda_mayuscula_barra(nodos_cerradas);
      
      
      if (nodo_intercambia==1)      
      	vector_l_cerradas(nodos_cerradas)=l_cerradas;
         vector_w_cerradas(nodos_cerradas)=w_cerradas;
         matriz_p_clientes_cerradas(nodos_cerradas,:)=nummedio;
      else
         vector_l_cerradas(nodo_intercambia-1)=l_cerradas;
         vector_w_cerradas(nodo_intercambia-1)=w_cerradas;
         matriz_p_clientes_cerradas(nodo_intercambia-1,:)=nummedio;
		end
      
      if(nodo_intercambia==nodos_cerradas)
         %En este caso, guardamos g_K(N).
         %Tendremos que intercambiar los dos ultimos valores de ro 
         %(en calcular_p_cerradas), para que las cuentas salgan
         %como queremos
         cte_cerradas=g(nodos_cerradas,clientes_cerradas);
      end
      
      
      
     	clear mu_cerradas_n;
      clear servidores_cerradas_n;
      clear vector_prob_cerradas;
      clear prob_cerradas_n;
      %clear pasos;
      %clear a;
      %clear matriz_prob_cerradas;
      %clear vector_mu_cerradas;
      %clear b;
      clear c;
      %clear lambda_mayuscula;
      clear suma;
      clear lambda_mayuscula_barra;
      
      
           
   	%Llamamos al fichero redes_abiertas_salida para mostrar los valores
      
      if (nodo_intercambia == 1)
         intercambiar_cerradas;
         nodo_intercambia=nodo_intercambia+1;
         redes_cerradas_calcular;
      else
         if (nodo_intercambia >= nodos_cerradas)
            nodo_intercambia=nodo_intercambia-1;
            intercambiar_cerradas; %Para asi que el ultimo nodo sea el que habiamos previsto en un principio
            redes_cerradas_salida;
         else
            nodo_intercambia=nodo_intercambia-1;
            intercambiar_cerradas;
            nodo_intercambia=nodo_intercambia+1;
            intercambiar_cerradas;            
            nodo_intercambia=nodo_intercambia+1;
            redes_cerradas_calcular;
         end
      end
      
      
  end
      
end