% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  comprobar_parametros_abiertas.m


% Mira si los parametros de la distribucion de entrada
% y de la de servicio son correctos, en funcion del tipo de distribucion

     
   
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
      





%Si los parametros son correctos se abre una nueva ventana con
%los parametros de salida

if (((distrib_entrada==1 & par_ent_1_n>0 ) | ...
      (distrib_entrada==2 & par_ent_1_n>=0 & par_ent_2_n>par_ent_1_n) | ...
      (distrib_entrada==3 & par_ent_1_n>0) | ...
      (distrib_entrada==4 & par_ent_1_n>0 & par_ent_2_n>0) | ...
      (distrib_entrada==5 & par_ent_1_n>0 & par_ent_2_n>0 & par_ent_3_n>0) | ...
      (distrib_entrada==6 & par_ent_1_n<realmax & par_ent_2_n>0) | ...
      (distrib_entrada==7 & par_ent_1_n>0 & par_ent_2_n>0) | ...
      (distrib_entrada==8 & par_ent_1_n>0 & par_ent_2_n>0) | ...
      (distrib_entrada==9)) &...
      ((distrib_salida==1 & par_sal_1_n>0) | ...
      (distrib_salida==2 & par_sal_1_n>=0 & par_sal_2_n>par_sal_1_n) | ...
      (distrib_salida==3 & par_sal_1_n>0) | ...
      (distrib_salida==4 & par_sal_1_n>0 & par_sal_2_n>0) | ...
      (distrib_salida==5 & par_sal_1_n>0 & par_sal_2_n>0 & par_sal_3_n>0) | ...
      (distrib_salida==6 & par_sal_1_n<realmax & par_sal_2_n>0) | ...
      (distrib_salida==7 & par_sal_1_n>0 & par_sal_2_n>0) | ...
      (distrib_salida==8 & par_sal_1_n>0 & par_sal_2_n>0)))
  
    
    if (pasos==1 & cambiar_parametros_mm==0)
        parametros_entrada=[];
        parametros_salida=[];
        distribuciones_entrada=[];
        distribuciones_salida=[];
    end
    
    if (cambiar_parametros_mm==0)
    
        parametros_entrada=cat(1, parametros_entrada, [par_ent_1_n par_ent_2_n par_ent_3_n]);
        parametros_salida=cat(1, parametros_salida, [par_sal_1_n par_sal_2_n par_sal_3_n]);
    
        distribuciones_entrada=cat(2,distribuciones_entrada,distrib_entrada);
        distribuciones_salida=cat(2,distribuciones_salida,distrib_salida);
    else
        parametros_entrada(pasos,1)=par_ent_1_n;
        parametros_entrada(pasos,2)=par_ent_2_n;
        parametros_entrada(pasos,3)=par_ent_3_n;
        
        parametros_salida(pasos,1)=par_sal_1_n;
        parametros_salida(pasos,2)=par_sal_2_n;
        parametros_salida(pasos,3)=par_sal_3_n;
        
        distribuciones_entrada(pasos)=distrib_entrada;
        distribuciones_salida(pasos)=distrib_salida;
    end
  
    
    redes_abiertas_simulacion;

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
