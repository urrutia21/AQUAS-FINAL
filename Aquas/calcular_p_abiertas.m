% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcular_p_abiertas.m

%Este fichero se encarga de calcular el valor de 
%la probabilidad de que exista un determinado numero de
%elementos en cada nodo de la red abierta.

%P(N)=p(n1)*p(n2)*p(n3)*...

vector_elementos = [];

texto_probabilidad='No Error';

for i=1:nodos_abiertas
   %Leemos el valor del numero de elementos para cada nodo
   
   elementos_n = get(elementos(i), 'String');
   elementos_n = str2num(elementos_n);
   
   %Comprobamos que el numero de elementos en cada nodos es un numero 
   %mayor o igual que cero y entero.
   if (elementos_n >=0 & floor(elementos_n)==elementos_n & ceil(elementos_n)==elementos_n)
      
      %Construye el vector que tiene el numero de elementos que hay
      %en todos los nodos de la red.
      vector_elementos=cat(2,vector_elementos,elementos_n);
   else
      texto_probabilidad = 'Error';
   end   
end

clear elementos_n;

if (strcmp(texto_probabilidad,'No Error')==1)
   resultado = 1;
   for i=1:nodos_abiertas
      
      %Calcula el valor llamando a la funcion calcula_p_nodo que dado
      %un numero de servidores, lambda, mu y un numero de elementos, 
      %devuelve la probabilidad de que haya dicho numero de elementos
      %en ese nodo
      
      resultado=resultado*calcula_p_nodo(vector_servidores_abiertas(i),...
         lambda_mayuscula(i),vector_mu_abiertas(i),vector_elementos(i));
   end
   texto_probabilidad=num2str(resultado);
   clear resultado;
end

text_redes_abiertas_salida_probabilidad = uicontrol(gcf, 'Style', 'Text', ...
    'String', texto_probabilidad, ...
    'Units', 'normalized', ...
	'Position', [0.55 0.18  0.2 0.04], ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.5, ...
	'BackgroundColor', [.6 .6 .6],...
    'HorizontalAlignment', 'Center');

