% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  redes_abiertas_salida.m

%Este fichero se encarga de mostrar los parametros de salida
%de la red:
%1.-El valor de L, Lq, W, Wq en cada nodo.
%2.-El valor de LT, LqT, WT y WqT.
%3.-La probabilidad de que haya un determinado numero de usuarios
%en la red


%Cerramos la ventana anterior y creamos una nueva.




estab_n = get(estab, 'String');
estab_n = str2num(estab_n);

cli_sim_n = get(cli_sim, 'String');
cli_sim_n = str2num(cli_sim_n);





if ((estab_n>0 & cli_sim_n>0 & floor(estab_n)==estab_n & ceil(estab_n)==estab_n & floor(cli_sim_n)==cli_sim_n & ceil(cli_sim_n)==cli_sim_n))
        



a=zeros(1,nodos_abiertas);

for i=1:nodos_abiertas
    if (distribuciones_entrada(i)==9)
        a(i)=-1;
    else
        a(i)=generar_entrada(distribuciones_entrada(i), parametros_entrada(i,1), parametros_entrada(i,2), parametros_entrada(i,3));
    end
end

b=-1*ones(max(vector_servidores_abiertas),nodos_abiertas);
n=zeros(1,nodos_abiertas);			%Numero de clientes que hay en cada nodo del sistema
ntot=0;		%Contabiliza el numero de clientes que han entrado hasta ese instante en el sistema


texto='Bucle establilizacion...';
   
   
   text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
   'String', texto , ...
   'Units', 'normalized', ...
   'Position', [0.43 0.80 0.2 0.03], ...
   'BackgroundColor', [.6 .6 .6],...
    'FontUnits', 'normalized', ...
   'FontWeight', 'bold', ...
   'FontSize', 0.7, ...
   'ForegroundColor', 'r', ...
   'HorizontalAlignment', 'Center');


drawnow;


while (ntot<estab_n)  
   
      
   [indice_fila_b_no_menos_uno, indice_columna_b_no_menos_uno]=find(b~=-1);
   
   [indice_fila_b_menos_uno, indice_columna_b_menos_uno]=find(b==-1);
   
   indice_a_no_menos_uno=find(a~=-1);
   
   indice_a_menos_uno=find(a==-1);
      
   if (sum(n)>0)
      posibles_b=[];
      for j=1:length(indice_fila_b_no_menos_uno)
          posibles_b=cat(2,posibles_b,b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j)));
      end
      minimo_de_b=min(posibles_b);
      
      [fila_minimo_b, columna_minimo_b]=find(b==minimo_de_b);
      
      
      posibles_a=a(indice_a_no_menos_uno);
      minimo_de_a=min(posibles_a);
      indice_minimo_a=find(a==minimo_de_a);
      

      minimo=min(minimo_de_a, minimo_de_b);

   else
      %Si n es 0, entoces b es -1, pero no puede ser el minimo
      posibles_a=a(indice_a_no_menos_uno);
      minimo_de_a=min(posibles_a);

      indice_minimo_a=find(a==minimo_de_a);
      minimo=minimo_de_a;

   end
   
     
   if (minimo==minimo_de_a) 	%Hay una llegada
      ntot=ntot+1;	%Aumenta el numero de clientes que han entrado en el sistema
      if (n(indice_minimo_a)<vector_servidores_abiertas(indice_minimo_a))				
         n(indice_minimo_a)=n(indice_minimo_a)+1; 						%Aumenta n porque hay una llegada
         
         a(indice_a_no_menos_uno)=a(indice_a_no_menos_uno)-minimo;
         
         a(indice_minimo_a)=generar_entrada(distribuciones_entrada(indice_minimo_a), parametros_entrada(indice_minimo_a,1), parametros_entrada(indice_minimo_a,2), parametros_entrada(indice_minimo_a,3));
         
         
         for j=1:length(indice_fila_b_no_menos_uno)         
             b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j))=b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j))-minimo;
         end
                  
         indice_minimo_nodo_minimo=find(b(:,indice_minimo_a)==-1);
         
         b(indice_minimo_nodo_minimo(1), indice_minimo_a)=generar_salida(distribuciones_salida(indice_minimo_a), parametros_salida(indice_minimo_a,1), parametros_salida(indice_minimo_a,2), parametros_salida(indice_minimo_a,3));

       
      else
         n(indice_minimo_a)=n(indice_minimo_a)+1; 						%Aumenta n porque hay una llegada
         
         a(indice_a_no_menos_uno)=a(indice_a_no_menos_uno)-minimo;
         a(indice_minimo_a)=generar_entrada(distribuciones_entrada(indice_minimo_a), parametros_entrada(indice_minimo_a,1), parametros_entrada(indice_minimo_a,2), parametros_entrada(indice_minimo_a,3));
         
         for j=1:length(indice_fila_b_no_menos_uno)         
             b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j))=b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j))-minimo;
         end
         
                 
      end
   else                        %minimo=minimo_de_b
      n(columna_minimo_b)=n(columna_minimo_b)-1;		%Disminuye el numero de clientes del sistema
      
      for j=1:length(indice_fila_b_no_menos_uno)         
          b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j))=b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j))-minimo;
      end
      
      if (n(columna_minimo_b)<vector_servidores_abiertas(columna_minimo_b))	%No quedan clientes en el sistema
         b(fila_minimo_b,columna_minimo_b)=-1;
      else
         b(fila_minimo_b,columna_minimo_b)=generar_salida(distribuciones_salida(columna_minimo_b), parametros_salida(columna_minimo_b,1), parametros_salida(columna_minimo_b,2), parametros_salida(columna_minimo_b,3));	%Tiempo que tarda en haber una nueva salida
      end
      a(indice_a_no_menos_uno)=a(indice_a_no_menos_uno)-minimo;					%Tiempo que tarda en haber una nueva entrada
      
      numero_simulado=rand;
      acumulador=0;
      j=0;
      while(acumulador<numero_simulado)
          acumulador=acumulador+matriz_prob_abiertas(j+1,columna_minimo_b);
          j=j+1;
      end
      j=j-1;
      

      
      if (j>0) %No hemos caido en el intervalo 0, que se corresponde con salir del sistema      
          n(j)=n(j)+1;
          if (n(j)<=vector_servidores_abiertas(j))
              indice_minimo_nodo_minimo=find(b(:,j)==-1);              
              b(indice_minimo_nodo_minimo(1), j)=generar_salida(distribuciones_salida(j), parametros_salida(j,1), parametros_salida(j,2), parametros_salida(j,3));
          end
      end           
      
	end
    
end








ntot=0;
t=0;			%Cronometro
c=zeros(1,nodos_abiertas);			%Acumula tiempo * nº clientes (sistema)
d=zeros(1,nodos_abiertas);			%Acumula tiempo * nº clientes (cola)
entradas_nodo=zeros(1,nodos_abiertas);


p=zeros(max(n)+1,nodos_abiertas);



i=0;

salto_porcentaje=1;

cien_entre_salto=100/salto_porcentaje;


	texto=num2str(salto_porcentaje*i);
   texto=strcat(texto, '% completado');
   
   
   text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
   'String', texto , ...
   'Units', 'normalized', ...
   'Position', [0.43 0.80 0.2 0.03], ...
   'BackgroundColor', [.6 .6 .6],...
   'FontUnits', 'normalized', ...
   'FontWeight', 'bold', ...
   'FontSize', 0.7, ...
   'ForegroundColor', 'r', ...
   'HorizontalAlignment', 'Center');

	drawnow;


i=i+1;




      
while (ntot<cli_sim_n)  
   
   if((ntot*cien_entre_salto/i)>cli_sim_n)
      texto=num2str(salto_porcentaje*i);
      texto=strcat(texto, '% completado');
      
		text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
    	   	'String', texto , ...
	    	'Units', 'normalized', ...
   		    'Position', [0.43 0.80 0.2 0.03], ...
		    'BackgroundColor', [.6 .6 .6],...
           'FontUnits', 'normalized', ...
           'FontWeight', 'bold', ...
            'FontSize', 0.7, ...
            'ForegroundColor', 'r', ...
            'HorizontalAlignment', 'Center');
      
      	drawnow;
      i=i+1;
   end   
   
   
   [indice_fila_b_no_menos_uno, indice_columna_b_no_menos_uno]=find(b~=-1);
   
   [indice_fila_b_menos_uno, indice_columna_b_menos_uno]=find(b==-1);
   
   indice_a_no_menos_uno=find(a~=-1);
   
   indice_a_menos_uno=find(a==-1);
      
   if (sum(n)>0)
      posibles_b=[];
      for j=1:length(indice_fila_b_no_menos_uno)
          posibles_b=cat(2,posibles_b,b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j)));
      end
      minimo_de_b=min(posibles_b);
      if (isempty(minimo_de_b)==0) %Si no esta vacio el minimo de b (todos=-1)
          [fila_minimo_b, columna_minimo_b]=find(b==minimo_de_b);
      end
      
      posibles_a=a(indice_a_no_menos_uno);
      minimo_de_a=min(posibles_a);
      indice_minimo_a=find(a==minimo_de_a);
      
      if (isempty(minimo_de_b)==0)
          minimo=min(minimo_de_a, minimo_de_b);
      else %Todos  los valores de b == -1
          minimo=minimo_de_a;
      end
   else
      %Si n es 0, entoces b es -1, pero no puede ser el minimo
      posibles_a=a(indice_a_no_menos_uno);
      minimo_de_a=min(posibles_a);

      indice_minimo_a=find(a==minimo_de_a);
      minimo=minimo_de_a;

   end
   
     
   if (minimo==minimo_de_a) 	%Hay una llegada
      ntot=ntot+1;	%Aumenta el numero de clientes que han entrado en el sistema
      entradas_nodo(indice_minimo_a)=entradas_nodo(indice_minimo_a)+1;
      if (n(indice_minimo_a)<vector_servidores_abiertas(indice_minimo_a))				
         n(indice_minimo_a)=n(indice_minimo_a)+1; 						%Aumenta n porque hay una llegada
         
         a(indice_a_no_menos_uno)=a(indice_a_no_menos_uno)-minimo;
         
         a(indice_minimo_a)=generar_entrada(distribuciones_entrada(indice_minimo_a), parametros_entrada(indice_minimo_a,1), parametros_entrada(indice_minimo_a,2), parametros_entrada(indice_minimo_a,3));
        
         
         for j=1:length(indice_fila_b_no_menos_uno)         
             b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j))=b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j))-minimo;
         end         
         
         indice_minimo_nodo_minimo=find(b(:,indice_minimo_a)==-1);
         
         b(indice_minimo_nodo_minimo(1), indice_minimo_a)=generar_salida(distribuciones_salida(indice_minimo_a), parametros_salida(indice_minimo_a,1), parametros_salida(indice_minimo_a,2), parametros_salida(indice_minimo_a,3));         
                  
        
         
      else
         n(indice_minimo_a)=n(indice_minimo_a)+1; 						%Aumenta n porque hay una llegada
         
         a(indice_a_no_menos_uno)=a(indice_a_no_menos_uno)-minimo;
        a(indice_minimo_a)=generar_entrada(distribuciones_entrada(indice_minimo_a), parametros_entrada(indice_minimo_a,1), parametros_entrada(indice_minimo_a,2), parametros_entrada(indice_minimo_a,3));
         
         for j=1:length(indice_fila_b_no_menos_uno)         
             b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j))=b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j))-minimo;
         end
         
                 
      end
      
    t=t+minimo;
    for j=1:nodos_abiertas
        if (j==indice_minimo_a)
            c(j)=c(j)+minimo*(n(j)-1);
            if ((n(j)-1)>vector_servidores_abiertas(j))
                d(j)=d(j)+minimo*(n(j)-1-vector_servidores_abiertas(j));
            end
            
            [filas_p, columnas_p]=size(p);
            if (n(j))>filas_p
                p=cat(1,p,zeros(1,nodos_abiertas));
            end
            p(n(j),j)=p(n(j),j)+minimo;
            
        else            
            c(j)=c(j)+minimo*n(j);
            if (n(j)>vector_servidores_abiertas(j))
                d(j)=d(j)+minimo*(n(j)-vector_servidores_abiertas(j));
            end
            [filas_p, columnas_p]=size(p);
            if (n(j)+1)>filas_p
                p=cat(1,p,zeros(1,nodos_abiertas));
            end
            p(n(j)+1,j)=p(n(j)+1,j)+minimo;
        end
    end

      
      
   else                        %minimo=minimo_de_b
      n(columna_minimo_b)=n(columna_minimo_b)-1;		%Disminuye el numero de clientes del sistema
      
      for j=1:length(indice_fila_b_no_menos_uno)         
          b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j))=b(indice_fila_b_no_menos_uno(j), indice_columna_b_no_menos_uno(j))-minimo;
      end
      
      if (n(columna_minimo_b)<vector_servidores_abiertas(columna_minimo_b))	%No quedan clientes en el sistema
        b(fila_minimo_b,columna_minimo_b)=-1;
      else
        b(fila_minimo_b,columna_minimo_b)=generar_salida(distribuciones_salida(columna_minimo_b), parametros_salida(columna_minimo_b,1), parametros_salida(columna_minimo_b,2), parametros_salida(columna_minimo_b,3));	%Tiempo que tarda en haber una nueva salida                             
      end
      a(indice_a_no_menos_uno)=a(indice_a_no_menos_uno)-minimo;					%Tiempo que tarda en haber una nueva entrada
      
      numero_simulado=rand;
      acumulador=0;
      j=0;
      while(acumulador<numero_simulado)
          acumulador=acumulador+matriz_prob_abiertas(j+1,columna_minimo_b);
          j=j+1;
      end
      j=j-1;
      
      nodo_transicion=j;
      
      if (j>0) %No hemos caido en el intervalo 0, que se corresponde con salir del sistema      
          n(j)=n(j)+1;
          entradas_nodo(j)=entradas_nodo(j)+1;
          if (n(j)<=vector_servidores_abiertas(j))
              indice_minimo_nodo_minimo=find(b(:,j)==-1);                      
              b(indice_minimo_nodo_minimo(1), j)=generar_salida(distribuciones_salida(j), parametros_salida(j,1), parametros_salida(j,2), parametros_salida(j,3));
          end
      end                 
      
    t=t+minimo;
    for j=1:nodos_abiertas
        if ((j==columna_minimo_b) & (j~=nodo_transicion))
            c(j)=c(j)+minimo*(n(j)+1);
            if ((n(j)+1)>vector_servidores_abiertas(j))
                d(j)=d(j)+minimo*(n(j)+1-vector_servidores_abiertas(j));
            end
            
            [filas_p, columnas_p]=size(p);
            if (n(j)+2)>filas_p
                p=cat(1,p,zeros(1,nodos_abiertas));
            end
            p(n(j)+2,j)=p(n(j)+2,j)+minimo;
            
        else      
            if ((j==nodo_transicion) & (j~=columna_minimo_b))
                c(j)=c(j)+minimo*(n(j)-1);
                if ((n(j)-1)>vector_servidores_abiertas(j))
                    d(j)=d(j)+minimo*(n(j)-1-vector_servidores_abiertas(j));
                end
            
                [filas_p, columnas_p]=size(p);
                if (n(j))>filas_p
                    p=cat(1,p,zeros(1,nodos_abiertas));
                end
                p(n(j),j)=p(n(j),j)+minimo;
                
            else                
                c(j)=c(j)+minimo*n(j);
                if (n(j)>vector_servidores_abiertas(j))
                    d(j)=d(j)+minimo*(n(j)-vector_servidores_abiertas(j));
                end
                [filas_p, columnas_p]=size(p);
                if (n(j)+1)>filas_p
                    p=cat(1,p,zeros(1,nodos_abiertas));
                end
                p(n(j)+1,j)=p(n(j)+1,j)+minimo;
            end
        end
    end
      
      
	end          
            
   
   
end

texto=num2str(100);
texto=strcat(texto, '% completado');
         
text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
	   	'String', texto , ...
	   	'Units', 'normalized', ...
   		'Position', [0.43 0.80 0.2 0.03], ...
		'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized', ...
        'FontWeight', 'bold', ...
        'FontSize', 0.7, ...
        'ForegroundColor', 'b', ...
		'HorizontalAlignment', 'Center');


lt=sum(c/t);

lqt=sum(d/t);

wt=lt/(cli_sim_n/t);

wqt=lqt/(cli_sim_n/t);

l=c/t;
lq=d/t;

w=c./entradas_nodo;
wq=d./entradas_nodo;

p=p/t;









































close(1)

figure('Units', 'normalized',...
		  'Position', [0.05 0.05 0.9 0.9],...
          'MenuBar', 'none', ...
          'name', 'Resolucion por simulacion: Resultados de la red de Jackson abierta', ...
          'NumberTitle', 'off', ...
          'resize','off');
     
frame_redes_abiertas_salida_1 = uicontrol(gcf, 'Style', 'Frame', ...
   'Units', 'normalized', ...
   'BackgroundColor', [.6 .6 .6],...
   'Position', [0.1 0.85 0.82 0.13]);     
     
frame_redes_abiertas_salida_2 = uicontrol(gcf, 'Style', 'Frame', ...
   'Units', 'normalized', ...
   'BackgroundColor', [.6 .6 .6],...
   'Position', [0.1 0.35 0.82 0.48]);

frame_redes_abiertas_salida_3 = uicontrol(gcf, 'Style', 'Frame', ...
   'Units', 'normalized', ...
   'BackgroundColor', [.6 .6 .6],...
   'Position', [0.1 0.16 0.82 0.17]);

texto_cabecera_redes_abiertas='Resultados globales ( ';
texto_cabecera_redes_abiertas=strcat(texto_cabecera_redes_abiertas, num2str(nodos_abiertas), ' Nodos)');

text_redes_abiertas_salida_1 = uicontrol(gcf, 'Style', 'Text', ...
 	    'String', texto_cabecera_redes_abiertas, ...
   	    'Units', 'normalized', ...
	    'Position', [0.35 0.92 0.3 0.05], ...
   	    'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
        'FontWeight', 'bold', ...
	    'FontSize', 0.4, ...
     	'HorizontalAlignment', 'Center');
   
text_redes_abiertas_salida_lt_1 = uicontrol(gcf, 'Style', 'Text', ...
       'String', 'LT = ', ...
   	   'Units', 'normalized', ...
	   'Position', [0.12 0.86 0.08 0.05], ...
   	   'BackgroundColor', [.6 .6 .6],...
       'FontUnits', 'normalized',...
       'FontWeight', 'bold', ...
	   'FontSize', 0.3, ...
       'HorizontalAlignment', 'Center');   
   
text_redes_abiertas_salida_lqt_1 = uicontrol(gcf, 'Style', 'Text', ...
      'String', 'LqT = ', ...
   	  'Units', 'normalized', ...
	  'Position', [0.32 0.86 0.08 0.05], ...
   	  'BackgroundColor', [.6 .6 .6],...
      'FontUnits', 'normalized',...
      'FontWeight', 'bold', ...
	  'FontSize', 0.3, ...
   	  'HorizontalAlignment', 'Center');   
   
text_redes_abiertas_salida_wt_1 = uicontrol(gcf, 'Style', 'Text', ...
      'String', 'WT = ', ...
   	  'Units', 'normalized', ...
	  'Position', [0.52 0.86 0.08 0.05], ...
   	  'BackgroundColor', [.6 .6 .6],...
      'FontUnits', 'normalized',...
      'FontWeight', 'bold', ...
	  'FontSize', 0.3, ...
   	  'HorizontalAlignment', 'Center');   

text_redes_abiertas_salida_wqt_1 = uicontrol(gcf, 'Style', 'Text', ...
      'String', 'WqT = ', ...
   	  'Units', 'normalized', ...
	  'Position', [0.72 0.86 0.08 0.05], ...
      'BackgroundColor', [.6 .6 .6],...
      'FontUnits', 'normalized',...
      'FontWeight', 'bold', ...
	  'FontSize', 0.3, ...
      'HorizontalAlignment', 'Center');  
   
%Calcula el valor de Lq en cada nodo, asi como el valor de L en cada nodo
for i=1:nodos_abiertas
   
   %La funcion resolver_mms, se encarga de averiguar cual es el valor de L,
   %en un modelo M/M/s, y se le pasan como parametros el numero de servidores,
   %el valor de lambda y el valor de mu
   lq_abiertos(i)=lq(i);
   
   l_abiertos(i)=l(i);
end


%Muestra los valores de L, Lq, W y Wq en cada nodo

for i=1:nodos_abiertas
         
   texto_abiertas=strcat('Nodo nº ',' ',num2str(i));

	text_redes_abiertas_salida = uicontrol(gcf, 'Style', 'Text', ...
   	    'String', texto_abiertas, ...
   	    'Units', 'normalized', ...
		'Position', [0.12 0.83-0.48*i/(nodos_abiertas+1) 0.1 0.05], ...
        'FontUnits', 'normalized',...
        'FontWeight', 'bold', ...
	    'FontSize', 0.3, ...
		'BackgroundColor', [.6 .6 .6],...
        'HorizontalAlignment', 'Center');   
         
	text_redes_abiertas_salida_l_1 = uicontrol(gcf, 'Style', 'Text', ...
        'String', 'L = ', ...
   	    'Units', 'normalized', ...
	    'Position', [0.25 0.83-0.48*i/(nodos_abiertas+1) 0.05 0.05], ...
   	    'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
	    'FontSize', 0.3, ...
        'HorizontalAlignment', 'Center');   
   
   aux=num2str(l_abiertos(i));
   
  	text_redes_abiertas_salida_l_2 = uicontrol(gcf, 'Style', 'Text', ...
        'String', aux, ...
   	    'Units', 'normalized', ...
	    'Position', [0.30 0.83-0.48*i/(nodos_abiertas+1) 0.10 0.05], ...
   	    'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
	    'FontSize', 0.3, ...
   	    'HorizontalAlignment', 'Center');   
   
   
   
	text_redes_abiertas_salida_lq_1 = uicontrol(gcf, 'Style', 'Text', ...
        'String', 'Lq = ', ...
   	    'Units', 'normalized', ...
	    'Position', [0.4 0.83-0.48*i/(nodos_abiertas+1) 0.05 0.05], ...
   	    'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
	    'FontSize', 0.3, ...
   	    'HorizontalAlignment', 'Center');   
   
   aux=num2str(lq_abiertos(i));
   
  	text_redes_abiertas_salida_lq_2 = uicontrol(gcf, 'Style', 'Text', ...
        'String', aux, ...
   	    'Units', 'normalized', ...
	    'Position', [0.45 0.83-0.48*i/(nodos_abiertas+1) 0.10 0.05], ...
   	    'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
	    'FontSize', 0.3, ...
        'HorizontalAlignment', 'Center');   
   
   
	text_redes_abiertas_salida_w_1 = uicontrol(gcf, 'Style', 'Text', ...
        'String', 'W = ', ...
   	    'Units', 'normalized', ...
	    'Position', [0.55 0.83-0.48*i/(nodos_abiertas+1) 0.05 0.05], ...
   	    'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
	    'FontSize', 0.3, ...
        'HorizontalAlignment', 'Center');   
   
   aux=num2str(w(i));
   
  	text_redes_abiertas_salida_w_2 = uicontrol(gcf, 'Style', 'Text', ...
        'String', aux, ...
   	    'Units', 'normalized', ...
	    'Position', [0.6 0.83-0.48*i/(nodos_abiertas+1) 0.10 0.05], ...
   	    'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
	    'FontSize', 0.3, ...
        'HorizontalAlignment', 'Center');   


   
	text_redes_abiertas_salida_wq_1 = uicontrol(gcf, 'Style', 'Text', ...
        'String', 'Wq = ', ...
   	    'Units', 'normalized', ...
	    'Position', [0.7 0.83-0.48*i/(nodos_abiertas+1) 0.05 0.05], ...
        'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
	    'FontSize', 0.3, ...
        'HorizontalAlignment', 'Center');  
   
   aux=num2str(wq(i));
   
  	text_redes_abiertas_salida_wq_2 = uicontrol(gcf, 'Style', 'Text', ...
        'String', aux, ...
   	    'Units', 'normalized', ...
	    'Position', [0.75 0.83-0.48*i/(nodos_abiertas+1) 0.10 0.05], ...
   	    'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
	    'FontSize', 0.3, ...
        'HorizontalAlignment', 'Center');   
   
   
  


end

      

   



aux=lt;

%Muestra el valor de LT, LqT, WT, WqT

text_redes_abiertas_salida_lt_2 = uicontrol(gcf, 'Style', 'Text', ...
        'String', num2str(aux), ...
   	    'Units', 'normalized', ...
	    'Position', [0.2 0.86 0.12 0.05], ...
   	    'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
	    'FontSize', 0.3, ...
        'HorizontalAlignment', 'Center');   
   
aux=lqt;
   
text_redes_abiertas_salida_lqt_2 = uicontrol(gcf, 'Style', 'Text', ...
        'String', num2str(aux), ...
   	    'Units', 'normalized', ...
	    'Position', [0.4 0.86 0.12 0.05], ...
    	'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
	    'FontSize', 0.3, ...
   	    'HorizontalAlignment', 'Center');   
   
aux=wt;   
   
text_redes_abiertas_salida_wt_2 = uicontrol(gcf, 'Style', 'Text', ...
        'String', num2str(aux), ...
   	    'Units', 'normalized', ...
	    'Position', [0.6 0.86 0.12 0.05], ...
   	    'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
	    'FontSize', 0.3, ...
   	    'HorizontalAlignment', 'Center');   
   
aux=wqt;   
   
text_redes_abiertas_salida_wqt_2 = uicontrol(gcf, 'Style', 'Text', ...
        'String', num2str(wqt), ...
   	    'Units', 'normalized', ...
	    'Position', [0.8 0.86 0.11 0.05], ...
        'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
	    'FontSize', 0.3, ...
        'HorizontalAlignment', 'Center');  
  
  
   
 text_probabilidad = uicontrol(gcf, 'Style', 'Text', ...
        'String', 'Probabilidad de un determinado numero de clientes en un nodo:', ...
   	    'Units', 'normalized', ...
	    'Position', [0.2 0.29 0.65 0.03], ...
        'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
        'FontWeight', 'bold', ...
	    'FontSize', 0.5, ...
        'HorizontalAlignment', 'Center');  
  
 text_numero_clientes= uicontrol(gcf, 'Style', 'Text', ...
        'String', 'Nº clientes = ', ...
   	    'Units', 'normalized', ...
	    'Position', [0.2 0.25 0.1 0.03], ...
        'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
        'FontWeight', 'bold', ...
	    'FontSize', 0.5, ...
        'HorizontalAlignment', 'Center');  
  
numero_clientes = uicontrol(gcf, 'Style', 'Edit', ...
   	'Units', 'normalized', ...
	'Position',[0.35 0.25   0.05 0.04], ...
    'FontUnits', 'normalized',...
	'FontSize', 0.5, ...
    'BackgroundColor', [.702 .702 .702],...
    'HorizontalAlignment', 'Center');  
  
text_numero_nodo=uicontrol(gcf, 'Style', 'Text', ...
        'String', 'Nodo =', ...
   	    'Units', 'normalized', ...
	   'Position', [0.6 0.25 0.1 0.03], ...
        'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized',...
        'FontWeight', 'bold', ...
	    'FontSize', 0.5, ...
        'HorizontalAlignment', 'Center');  
     
numero_nodo = uicontrol(gcf, 'Style', 'Edit', ...
   	'Units', 'normalized', ...
	'Position',[0.75 0.25   0.05 0.04], ...
    'FontUnits', 'normalized',...
	'FontSize', 0.5, ...
    'BackgroundColor', [.702 .702 .702],...
    'HorizontalAlignment', 'Center');       
     
 
   
   


clear lq_abiertos;
clear l_abiertos;
clear texto_abiertas;
clear aux;

%Una vez leido el valor del numero de elementos en cada nodo de la red, para
%calcular la probabilidad se llama al fichero calcular_p_abiertas

boton_redes_abiertas_salida_calcular = uicontrol(gcf, 'Style', 'Pushbutton',...
  'String', 'Calcular', 'Value', 0, ...
  'Units', 'normalized', ...
  'Position', [0.43 0.18 0.1 0.04], ...
  'FontUnits', 'normalized',...
  'FontSize', 0.4, ...
  'Callback', 'calcular_p_abiertas_simulacion'); 

%Si se hace click en siguiente, se ejecuta el contenido del fichero llamado
%aquas

cambiar_parametros_mm=cambiar_parametros_mm+1;
pasos=0;

boton_redes_abiertas_salida_sig = uicontrol(gcf, 'Style', 'Pushbutton',...
  'String', 'Menu Inicio >>', 'Value', 0, ...
  'Units', 'normalized', ...
  'Position', [0.2 0.05 0.2 0.07], ...
  'FontUnits', 'normalized',...
  'FontSize', 0.3, ...
  'Callback', 'aquas');

boton_redes_abiertas_salida_cambiar_parametros = uicontrol(gcf, 'Style', 'Pushbutton',...
  'String', 'Cambiar los parametros del problema >>', 'Value', 0, ...
  'Units', 'normalized', ...
  'Position', [0.5 0.05 0.3 0.07], ...
  'FontUnits', 'normalized',...
  'FontSize', 0.3, ...
  'Callback', 'redes_abiertas_simulacion');

else 
   
   text_errores = uicontrol(gcf, 'Style', 'Text', ...
		   'Units', 'normalized', ...
		   'String', 'ERROR EN LOS PARAMETROS', ...
           'Position', [0.43 0.80 0.2 0.03], ...
           'BackgroundColor', [.6 .6 .6],...
           'ForegroundColor', 'r',...
           'FontUnits', 'normalized',...
           'FontWeight', 'bold', ...
           'FontSize', 0.5, ...
		   'HorizontalAlignment', 'Center');


end

