% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcular_p_abiertas_simulacion.m

%Este fichero se encarga de calcular el valor de 
%la probabilidad de que exista un determinado numero de
%elementos en un nodo de la red abierta.

%El valor de esta probabilidad ha sido ya previamente
%calculado tras la realizacion del bulce de simulacion


texto_probabilidad='No Error';


numero_clientes_n = get(numero_clientes, 'String');
numero_clientes_n = str2num(numero_clientes_n);

numero_nodo_n = get(numero_nodo, 'String');
numero_nodo_n = str2num(numero_nodo_n);
   
%Comprobamos que el numero de elementos en cada nodos es un numero 
%mayor o igual que cero y entero.
if (numero_clientes_n >=0 & floor(numero_clientes_n)==numero_clientes_n & ceil(numero_clientes_n)==numero_clientes_n &...
        numero_nodo_n>0 & floor(numero_nodo_n)==numero_nodo_n & ceil(numero_nodo_n)==numero_nodo_n & numero_nodo_n<=nodos_abiertas)
      
    [filas_p, columnas_p]=size(p);
    
    if (numero_clientes_n+1)>filas_p
        resultado=0;
    else
        resultado=p(numero_clientes_n+1,numero_nodo_n);
    end
    
    texto_probabilidad=num2str(resultado);
   
else
   texto_probabilidad = 'Error';
end   


text_redes_abiertas_salida_probabilidad = uicontrol(gcf, 'Style', 'Text', ...
    'String', texto_probabilidad, ...
    'Units', 'normalized', ...
	'Position', [0.55 0.18  0.2 0.04], ...
    'FontUnits', 'normalized', ...
    'FontSize', 0.5, ...
	'BackgroundColor', [.6 .6 .6],...
    'HorizontalAlignment', 'Center');

