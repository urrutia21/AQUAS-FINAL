% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  resolver_cambiar_parametros_ce.m

clear vector_mu_cerradas;
clear vector_servidores_cerradas;
clear matriz_prob_cerradas;


vector_mu_cerradas=[];
vector_servidores_cerradas=[];
matriz_prob_cerradas = [];

clear a;
clear b;
clear ro;
clear g;

exito=0;



for i=1:nodos_cerradas
   
	%Recibe el valor de mu para un nodo de la red
	mu_cerradas_n = get(vector_mu_comprobar(i), 'String');
    mu_cerradas_n = str2num(mu_cerradas_n);
   
    
    vector_mu_cerradas=cat(2,vector_mu_cerradas,mu_cerradas_n);

	%Recibe el valor del numero de servidores para un nodo de la red
	servidores_cerradas_n = get(vector_servidores_comprobar(i), 'String');
    servidores_cerradas_n = str2num(servidores_cerradas_n);
   
    vector_servidores_cerradas=cat(2,vector_servidores_cerradas,servidores_cerradas_n);
   
    vector_prob_cerradas = [];

	for j=1:nodos_cerradas
		prob_cerradas_n = get(matriz_prob_cerradas_comprobar(i,j), 'String');
	    prob_cerradas_n = str2num(prob_cerradas_n);
   	    vector_prob_cerradas=cat(2,vector_prob_cerradas,prob_cerradas_n);
	end

	matriz_prob_cerradas=cat(1,matriz_prob_cerradas,vector_prob_cerradas);


	if (mu_cerradas_n>=0 & servidores_cerradas_n>0 & ...
      ceil(servidores_cerradas_n)==servidores_cerradas_n & ...
      floor(servidores_cerradas_n)==servidores_cerradas_n & ...
      vector_prob_cerradas>=0 & sum(vector_prob_cerradas)>0.99999 & sum(vector_prob_cerradas)<1.0000001)
   
	   exito=exito+1;
   	
	end
 

end


if (exito==nodos_cerradas)
   intercambio_cerradas=1;
   redes_cerradas_calcular;
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
