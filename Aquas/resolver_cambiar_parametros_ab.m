% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  resolver_cambiar_parametros_ab.m

clear vector_lambda_abiertas;
clear vector_mu_abiertas;
clear vector_servidores_abiertas;
clear matriz_prob_abiertas;


vector_lambda_abiertas=[];
vector_mu_abiertas=[];
vector_servidores_abiertas=[];
matriz_prob_abiertas = zeros(1,nodos_abiertas+1);

exito=0;

for i=1:nodos_abiertas
   
	%Recibe el valor de lambda para un nodo de la red
	lambda_abiertas_n = get(vector_lambda_comprobar(i), 'String');
    lambda_abiertas_n = str2num(lambda_abiertas_n);
   
    vector_lambda_abiertas=cat(2,vector_lambda_abiertas,lambda_abiertas_n);

	%Recibe el valor de mu para un nodo de la red
	mu_abiertas_n = get(vector_mu_comprobar(i), 'String');
    mu_abiertas_n = str2num(mu_abiertas_n);
   
    vector_mu_abiertas=cat(2,vector_mu_abiertas,mu_abiertas_n);

	%Recibe el valor del numero de servidores para un nodo de la red
	servidores_abiertas_n = get(vector_servidores_comprobar(i), 'String');
    servidores_abiertas_n = str2num(servidores_abiertas_n);
   
    vector_servidores_abiertas=cat(2,vector_servidores_abiertas,servidores_abiertas_n);
   
    vector_prob_abiertas = [];

	 for j=1:nodos_abiertas
		prob_abiertas_n = get(matriz_prob_abiertas_comprobar(i+1,j+1), 'String');
	    prob_abiertas_n = str2num(prob_abiertas_n);
   	    vector_prob_abiertas=cat(2,vector_prob_abiertas,prob_abiertas_n);
	 end

	 matriz_prob_abiertas=cat(1,matriz_prob_abiertas,cat(2,0,vector_prob_abiertas));


	 if (lambda_abiertas_n >=0 & mu_abiertas_n>=0 & servidores_abiertas_n>0 & ...
       ceil(servidores_abiertas_n)==servidores_abiertas_n & ...
       floor(servidores_abiertas_n)==servidores_abiertas_n & ...
       vector_prob_abiertas>=0 & sum(vector_prob_abiertas)<=1)
   
	   exito=exito+1;
   	
	 end

  

end


if (exito==nodos_abiertas)
 %Suma los valores de lambda de todos los nodos
 suma_lambda_abiertas=sum(vector_lambda_abiertas);
   
  %Rellena elementos de la matriz de probabilidades
  for i=1:nodos_abiertas
     matriz_prob_abiertas(1,i+1)=vector_lambda_abiertas(i)/suma_lambda_abiertas;
  end
   
   for i=1:nodos_abiertas
     matriz_prob_abiertas(i+1,1)=1-sum(matriz_prob_abiertas(i+1,2:nodos_abiertas+1));
   end
   
   %Calcula la matriz a
   a=matriz_prob_abiertas(2:(nodos_abiertas+1),2:(nodos_abiertas+1))'*(-1);
   
   for i=1:nodos_abiertas
      a(i,i)=1+a(i,i);
   end
   
   %Si la matriz "a" tiene un determinante igual a cero, la red de colas no es
   %estacionario. Llamamos al fichero redes_abiertas_no_estacionario que se lo
   %advierte al usuario.
   
   if (det(a) == 0)
      clear a;
      clear lambda_abiertas_n;
      clear mu_abiertas_n;
      clear servidores_abiertas_n;
      clear vector_prob_abiertas;
      clear prob_abiertas_n;

      
      redes_abiertas_no_estacionario;
   else           
     %El determinante de la matriz "a" es distinto de cero.
   
     %Calcula el valor de lambda_mayuscula
   
     lambda_mayuscula = inv(a)*vector_lambda_abiertas';
      
     clear lambda_abiertas_n;
     clear mu_abiertas_n;
     clear servidores_abiertas_n;
     clear vector_prob_abiertas;
     clear prob_abiertas_n;
     clear a;
      
     %Si lambda_mayuscula(i)<s(i)*mu(i) para todo i, entonces el
     %modelo es estacionario. Llamamos al fichero redes_abiertas_salida para
     %mostrar los valores
      
 	 if ((lambda_mayuscula)'<(vector_servidores_abiertas.*vector_mu_abiertas)) 
     	redes_abiertas_salida;
     else
         
       %Si no se da la condicion anteriormente comentada, el modelo no
       %es estacionario, con lo que llamamos al fichero 
       %redes_abiertas_no_estacionario
       redes_abiertas_no_estacionario;
     end
      
  end
else
   
   
   text_cambiar_parametros_error = uicontrol(gcf, 'Style', 'Text', ...
 	    'String', 'Error en los parametros', ...
   	    'Units', 'normalized', ...
	    'Position', [0.75 0.95 0.18 0.04], ...
   	    'BackgroundColor', [.702 .702 .702],...
        'FontUnits', 'normalized',...
        'FontWeight', 'bold', ...
        'FontSize', 0.4, ...
        'ForegroundColor', 'r',...
   	    'HorizontalAlignment', 'Center');

end
