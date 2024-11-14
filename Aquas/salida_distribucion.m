% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  salida_distribucion.m

%Recepcion de los parametros

if(estoy_en_redes_abiertas ~= 1)
   
   
   par_ent_1_n=0;
   par_ent_2_n=0;
   par_ent_3_n=0;
   par_sal_1_n=0;
   par_sal_2_n=0;
   par_sal_3_n=0;
   
   
   switch(distrib_entrada)
   case 1,
      par_ent_1_n = get(par_ent_1, 'String');
      par_ent_1_n = str2num(par_ent_1_n);
   case 2,
      par_ent_1_n = get(par_ent_1, 'String');
      par_ent_1_n = str2num(par_ent_1_n);
      par_ent_2_n = get(par_ent_2, 'String');
      par_ent_2_n = str2num(par_ent_2_n);
  case 3,
      par_ent_1_n = get(par_ent_1, 'String');
      par_ent_1_n = str2num(par_ent_1_n);
  case 4,
      par_ent_1_n = get(par_ent_1, 'String');
      par_ent_1_n = str2num(par_ent_1_n);
      par_ent_2_n = get(par_ent_2, 'String');
      par_ent_2_n = str2num(par_ent_2_n);
  case 5,
      par_ent_1_n = get(par_ent_1, 'String');
      par_ent_1_n = str2num(par_ent_1_n);
      par_ent_2_n = get(par_ent_2, 'String');
      par_ent_2_n = str2num(par_ent_2_n);
      par_ent_3_n = get(par_ent_3, 'String');
      par_ent_3_n = str2num(par_ent_3_n);
  case 6,
      par_ent_1_n = get(par_ent_1, 'String');
      par_ent_1_n = str2num(par_ent_1_n);
      par_ent_2_n = get(par_ent_2, 'String');
      par_ent_2_n = str2num(par_ent_2_n);      
  case 7,
      par_ent_1_n = get(par_ent_1, 'String');
      par_ent_1_n = str2num(par_ent_1_n);
      par_ent_2_n = get(par_ent_2, 'String');
      par_ent_2_n = str2num(par_ent_2_n);
  case 8,
      par_ent_1_n = get(par_ent_1, 'String');
      par_ent_1_n = str2num(par_ent_1_n);
      par_ent_2_n = get(par_ent_2, 'String');
      par_ent_2_n = str2num(par_ent_2_n);
   end
   
      
      
      
   switch(distrib_salida)
   case 1,
      par_sal_1_n = get(par_sal_1, 'String');
      par_sal_1_n = str2num(par_sal_1_n);
   case 2,
      par_sal_1_n = get(par_sal_1, 'String');
      par_sal_1_n = str2num(par_sal_1_n);
      par_sal_2_n = get(par_sal_2, 'String');
      par_sal_2_n = str2num(par_sal_2_n);
  case 3,
      par_sal_1_n = get(par_sal_1, 'String');
      par_sal_1_n = str2num(par_sal_1_n);
  case 4,
      par_sal_1_n = get(par_sal_1, 'String');
      par_sal_1_n = str2num(par_sal_1_n);
      par_sal_2_n = get(par_sal_2, 'String');
      par_sal_2_n = str2num(par_sal_2_n);
  case 5,
      par_sal_1_n = get(par_sal_1, 'String');
      par_sal_1_n = str2num(par_sal_1_n);
      par_sal_2_n = get(par_sal_2, 'String');
      par_sal_2_n = str2num(par_sal_2_n);
      par_sal_3_n = get(par_sal_3, 'String');
      par_sal_3_n = str2num(par_sal_3_n);
  case 6,
      par_sal_1_n = get(par_sal_1, 'String');
      par_sal_1_n = str2num(par_sal_1_n);
      par_sal_2_n = get(par_sal_2, 'String');
      par_sal_2_n = str2num(par_sal_2_n);
  case 7,
      par_sal_1_n = get(par_sal_1, 'String');
      par_sal_1_n = str2num(par_sal_1_n);
      par_sal_2_n = get(par_sal_2, 'String');
      par_sal_2_n = str2num(par_sal_2_n);
  case 8,
      par_sal_1_n = get(par_sal_1, 'String');
      par_sal_1_n = str2num(par_sal_1_n);
      par_sal_2_n = get(par_sal_2, 'String');
      par_sal_2_n = str2num(par_sal_2_n);
   end
      


end



%Si los parametros son correctos se abre una nueva ventana con
%los parametros de salida

if (((distrib_entrada==1 & par_ent_1_n>0 ) | ...
      (distrib_entrada==2 & par_ent_1_n>=0 & par_ent_2_n>par_ent_1_n) | ...
      (distrib_entrada==3 & par_ent_1_n>0) | ...
      (distrib_entrada==4 & par_ent_1_n>0 & par_ent_2_n>0) | ...
      (distrib_entrada==5 & par_ent_1_n>0 & par_ent_2_n>0 & par_ent_3_n>0) | ...
      (distrib_entrada==6 & par_ent_1_n<realmax & par_ent_2_n>0) | ...
      (distrib_entrada==7 & par_ent_1_n>0 & par_ent_2_n>0) | ...
      (distrib_entrada==8 & par_ent_1_n>0 & par_ent_2_n>0)) &...
      ((distrib_salida==1 & par_sal_1_n>0) | ...
      (distrib_salida==2 & par_sal_1_n>=0 & par_sal_2_n>par_sal_1_n) | ...
      (distrib_salida==3 & par_sal_1_n>0) | ...
      (distrib_salida==4 & par_sal_1_n>0 & par_sal_2_n>0) | ...
      (distrib_salida==5 & par_sal_1_n>0 & par_sal_2_n>0 & par_sal_3_n>0) | ...
      (distrib_salida==6 & par_sal_1_n<realmax & par_sal_2_n>0) | ...
      (distrib_salida==7 & par_sal_1_n>0 & par_sal_2_n>0) | ...
      (distrib_salida==8 & par_sal_1_n>0 & par_sal_2_n>0)))


if (estoy_en_redes_abiertas ~= 1)  
   close(1)
end


if (estoy_en_redes_abiertas ~=1)
	figure('Units', 'normalized',...
		  'Position', [0.05 0.05 0.9 0.9],...
          'MenuBar', 'none', ...
          'name', 'Resolucion por simulacion: Parametros de salida', ...
          'NumberTitle', 'off', ...
          'resize','off');
  else
     	figure('Units', 'normalized',...
		  'Position', [0.1 0.1 0.8 0.8],...
          'resize','off');
end
     
     
frame_salida_1 = uicontrol(gcf, 'Style', 'Frame', ...
   'Units', 'normalized', ...
   'BackgroundColor', [.6 .6 .6],...
   'Position', [0.15 0.76 0.7 0.22]);


frame_salida_2 = uicontrol(gcf, 'Style', 'Frame', ...
   'Units', 'normalized', ...
	'BackgroundColor', [.6 .6 .6],...
   'Position', [0.15 0.45 0.325 0.22]);



text_salida_parametros = uicontrol(gcf, 'Style', 'Text', ...
   'String', 'Parametros de salida', ...
   'Units', 'normalized', ...
   'Position', [0.3 0.92 0.36 0.05], ...
   'BackgroundColor', [.6 .6 .6],...
    'FontUnits', 'normalized',...
   'FontWeight', 'bold', ...
   'FontSize', 0.4, ...
   'HorizontalAlignment', 'Center');

switch(eleccion)
case 1,
   modelo='Modelo G/G/1 con ';
case 2,
   modelo='Modelo G/G/s con ';
case 3,
   modelo='Modelo G/G/1/K con ';
case 4,
   modelo='Modelo G/G/s/K con ';
case 5,
   modelo='Modelo G/G/1/inf/H con ';
case 6,
   modelo='Modelo G/G/s/inf/H con ';
case 7,
   modelo='Modelo G/G/s/inf/H con Y repuestos con ';
case 8,
   modelo='Modelo G/G/inf con ';
end

if (estoy_en_redes_abiertas == 1)
   modelo=strcat(modelo, ' Lambda Mayuscula = ');
end



%Modelos que incluyen un numero de servidores
if(eleccion==2|eleccion==4|eleccion==6|eleccion==7)
   modelo=strcat(modelo,' s = ');
   modelo=strcat(modelo,num2str(s_n));
end

%Modelos que incluyen un tamanho de cola K
if(eleccion==3|eleccion==4)
   modelo=strcat(modelo,' , k = ');
   modelo=strcat(modelo,num2str(k_n));
end

%Modelos que incluyen una poblacion potencial finita H
if(eleccion==5|eleccion==6|eleccion==7)
   modelo=strcat(modelo,' , H= ');
   modelo=strcat(modelo,num2str(h_n));
end

%Modelos que incluyen un numero de repuestos Y
if(eleccion==7)
   modelo=strcat(modelo,' , Y= ');
   modelo=strcat(modelo,num2str(y_n));
end

modelo=strcat(modelo,', Nº clientes= ');
modelo=strcat(modelo, num2str(cli_sim_n));

modelo=strcat(modelo,', Param estabilizacion= ');
modelo=strcat(modelo, num2str(estab_n));



%Mostramos en la pantalla de salida las caracteristicas del modelo

text_salida_modelo = uicontrol(gcf, 'Style', 'Text', ...
   'String', modelo, ...
   'Units', 'normalized', ...
   'Position', [0.2 0.885 0.56 0.05], ...
   'BackgroundColor', [.6 .6 .6],...
   'FontUnits', 'normalized',...
   'FontSize', 0.3, ...
   'HorizontalAlignment', 'Center');


%Realizamos los bucles de estabilizacion y simulacion
calcular_simulacion;



 
 
%Este else se corresponde con el if grande de arriba del todo
%que comprueba si los parametros son correctos
 
else 
   
   text_errores = uicontrol(gcf, 'Style', 'Text', ...
		   'Units', 'normalized', ...
		   'String', 'ERROR EN LOS PARAMETROS', ...
           'Position', [0.35 0.74 0.30 0.04], ...
		   'BackgroundColor', [.702 .702 .702],...   
           'ForegroundColor', 'r',...
           'FontUnits', 'normalized',...
           'FontWeight', 'bold', ...
           'FontSize', 0.4, ...
		   'HorizontalAlignment', 'Center');


end