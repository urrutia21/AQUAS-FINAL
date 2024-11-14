% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcular_p_cerradas.m

%Este fichero se encarga de calcular el valor de 
%la probabilidad de que exista un determinado numero de
%elementos en cada nodo de la red cerrada.

vector_elementos = [];

texto_probabilidad='No Error';

error_p_cerradas=0;

for i=1:nodos_cerradas
   %Leemos el valor del numero de elementos para cada nodo

   elementos_n = get(elementos(i), 'String');
   elementos_n = str2num(elementos_n);
   %Comprobamos que el numero de elementos en cada nodos es un numero 
   %mayor o igual que cero y entero.

   if (elementos_n >=0 & floor(elementos_n)==elementos_n & ceil(elementos_n)==elementos_n)
      vector_elementos=cat(2,vector_elementos,elementos_n);
   else
      texto_probabilidad = 'Error';
      error_p_cerradas=1;
   end   
end

clear elementos_n;

%Comprobamos que hay tantos elementos en todos los nodos como habiamos
%dicho en un principio (fichero entrada.m)

if (sum(vector_elementos)~=(clientes_cerradas-1))
   texto_probabilidad = 'Error';
   error_p_cerradas=1;
else
	if (strcmp(texto_probabilidad,'No Error')==1)
      resultado = 1;
      
      %Calcula la probabilidad
	   a=ones(1,nodos_cerradas);
	   for i=1:nodos_cerradas
      	  a(i)=calcular_a_cerradas(vector_servidores_cerradas(i),vector_elementos(i));
       end
      
      %Intercambiar los dos ultimos valores del vector ro, para que coincida
      aux=ro(nodos_cerradas);
      
      ro(nodos_cerradas)=ro(nodos_cerradas-1);
      
      ro(nodos_cerradas-1)=aux;           
         
   	  aux=prod(power(ro,vector_elementos)./a);
   
   	  resultado=aux/cte_cerradas;
      
      
      %Deshace el intercambio
      aux=ro(nodos_cerradas);
      
      ro(nodos_cerradas)=ro(nodos_cerradas-1);
      
      ro(nodos_cerradas-1)=aux;
   
	  texto_probabilidad=num2str(resultado);
   
      
      %clear a;
      clear aux;
	  clear resultado;
   end
end

if(error_p_cerradas==1)
	text_redes_abiertas_salida_probabilidad = uicontrol(gcf, 'Style', 'Text', ...
    'String', texto_probabilidad, ...
    'Units', 'normalized', ...
	'Position', [0.55 0.18  0.2 0.04], ...
    'FontUnits', 'normalized', ...
    'FontWeight', 'bold', ...
    'FontSize', 0.5, ...
    'ForegroundColor', 'r', ...
	'BackgroundColor', [.6 .6 .6],...
    'HorizontalAlignment', 'Center');
else
	text_redes_abiertas_salida_probabilidad = uicontrol(gcf, 'Style', 'Text', ...
    'String', texto_probabilidad, ...
    'Units', 'normalized', ...
	'Position', [0.55 0.18  0.2 0.04], ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.5, ...
	'BackgroundColor', [.6 .6 .6],...
    'HorizontalAlignment', 'Center');
end
