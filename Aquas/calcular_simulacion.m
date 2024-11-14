% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcular_simulacion.m

% Implementa los bucles de estabilizacion y simulacion de los 
% distintos modelos

p=0;

clear p;


t1=cputime;

text_salida_l = uicontrol(gcf, 'Style', 'Text', ...
   'String', 'L =', ...
   'Units', 'normalized', ...
   'Position', [0.2 0.85 0.1 0.05], ...
   'BackgroundColor', [.6 .6 .6],...
   'FontUnits', 'normalized', ...
   'FontWeight', 'bold', ...
   'FontSize', 0.4, ...
   'HorizontalAlignment', 'Center');

text_salida_lq = uicontrol(gcf, 'Style', 'Text', ...
   'String', 'Lq =', ...
   'Units', 'normalized', ...
   'Position', [0.2 0.8 0.1 0.05], ...
   'BackgroundColor', [.6 .6 .6],...
   'FontUnits', 'normalized', ...
   'FontWeight', 'bold', ...
   'FontSize', 0.4, ...
   'HorizontalAlignment', 'Center');

text_salida_w = uicontrol(gcf, 'Style', 'Text', ...
   'String', 'W =', ...
   'Units', 'normalized', ...
   'Position', [0.4 0.85 0.1 0.05], ...
   'BackgroundColor', [.6 .6 .6],...
   'FontUnits', 'normalized', ...
   'FontWeight', 'bold', ...
   'FontSize', 0.4, ...
   'HorizontalAlignment', 'Center');


text_salida_wq = uicontrol(gcf, 'Style', 'Text', ...
   'String', 'Wq =', ...
   'Units', 'normalized', ...
   'Position', [0.4 0.8 0.1 0.05], ...
   'BackgroundColor', [.6 .6 .6],...
   'FontUnits', 'normalized', ...
   'FontWeight', 'bold', ...
   'FontSize', 0.4, ...
   'HorizontalAlignment', 'Center');

%La intensidad de trafico se corresponde con el ro_barra

text_salida_inten = uicontrol(gcf, 'Style', 'Text', ...
   'String', 'Intensidad =' , ...
   'Units', 'normalized', ...
   'Position', [0.6 0.85 0.1 0.05], ...
   'BackgroundColor', [.6 .6 .6],...
   'FontUnits', 'normalized', ...
   'FontWeight', 'bold', ...
   'FontSize', 0.3, ...
   'HorizontalAlignment', 'Center');

%La eficiencia se corresponde con W/Ws

text_salida_efec = uicontrol(gcf, 'Style', 'Text', ...
   'String', 'Eficiencia =', ...
   'Units', 'normalized', ...
   'Position', [0.6 0.8 0.1 0.05], ...
   'BackgroundColor', [.6 .6 .6],...
   'FontUnits', 'normalized', ...
   'FontWeight', 'bold', ...
   'FontSize', 0.3, ...
   'HorizontalAlignment', 'Center');



texto='Bucle establilizacion...';
   
   
text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
   'String', texto , ...
   'Units', 'normalized', ...
   'Position', [0.4 0.77 0.2 0.03], ...
   'BackgroundColor', [.6 .6 .6],...
   'FontUnits', 'normalized', ...
   'FontWeight', 'bold', ...
   'FontSize', 0.6, ...
   'ForegroundColor', 'r', ...
   'HorizontalAlignment', 'Center');


%Fuerza, a que se ponga en la pantalla todo lo que se le
%ha ejecutado hasta ahora
drawnow;


switch(eleccion)
    
case 1,  %G/G/1
   
    a=0;
	b=-1;
	n=0;			%Numero de clientes que hay en el sistema
	ntot=0;		    %Contabiliza el numero de clientes que han entrado hasta ese instante en el sistema


	while (ntot<estab_n)
   
   	   if (n>0)
      	  minimo=min(a,b);
	   else
   	      %Si n es 0, entoces b es -1, pero no puede ser el minimo
      	   minimo=a;
	   end
         
   	   if (minimo==a) 	%Hay una llegada
      	  ntot=ntot+1;	%Aumenta el numero de clientes que han entrado en el sistema
	      if (n==0)		%No hay clientes en el sistema
   	         n=n+1; 						%Aumenta n porque hay una llegada
      	     a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
        	 b=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);		%Tiempo que tarda en haber una nueva salida
	      else
   	         n=n+1; 						%Aumenta n porque hay una llegada
      	     a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
         	 b=b-minimo;					%Tiempo que tarda en haber una nueva salida
	   	 end
   	  else      
   		 n=n-1;		%Disminuye el numero de clientes del sistema
	     if (n==0)	%No quedan clientes en el sistema
   	   	    b=-1;
      	 else
      		b=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);	%Tiempo que tarda en haber una nueva salida
	     end
   	        a=a-minimo;					%Tiempo que tarda en haber una nueva entrada
	   end
	end


	ntot=0;
	t=0;			%Cronometro
	c=0;			%Acumula tiempo * nº clientes (sistema)
	d=0;			%Acumula tiempo * nº clientes (cola)


	p=zeros(1,n+1);

	i=0;

	salto_porcentaje=1;

	cien_entre_salto=100/salto_porcentaje;


	texto=num2str(salto_porcentaje*i);
    texto=strcat(texto, '% completado');
   
   
    text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
     'String', texto , ...
     'Units', 'normalized', ...
     'Position', [0.4 0.77 0.2 0.03], ...
     'BackgroundColor', [.6 .6 .6],...
     'FontUnits', 'normalized', ...
     'FontWeight', 'bold', ...
     'FontSize', 0.5, ...
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
   		    'Position', [0.4 0.77 0.2 0.03], ...
		    'BackgroundColor', [.6 .6 .6],...
            'FontUnits', 'normalized', ...
            'FontWeight', 'bold', ...
            'FontSize', 0.5, ...
            'ForegroundColor', 'r', ...
            'HorizontalAlignment', 'Center');
      
          drawnow;
                  
      	  i=i+1;
	   end   
   
   	   if (n>0)
      	  minimo=min(a,b);
	   else
   	      %Si n es 0, entoces b es -1, pero no puede ser el minimo
      	  minimo=a;
	   end
     
   	   if (minimo==a) 	%Hay una llegada
      	  ntot=ntot+1;	%Aumenta el numero de clientes que han entrado en el sistema
	      if (n==0)		%No hay clientes en el sistema
   	         t=t+minimo;
      	     p(1)=p(1)+minimo;
         	 n=n+1; %Aumenta n porque hay una llegada
	         a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
   	         b=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);		%Tiempo que tarda en haber una nueva salida
      	  else
         	 t=t+minimo;
	         if (n+1)>length(p)
   	            p=cat(2, p, zeros(1));
      	        p(n+1)=p(n+1)+minimo;           
         	 else
            	p(n+1)=p(n+1)+minimo;
			 end
   	         c=c+minimo*n;
      	     d=d+minimo*(n-1);
         	 n=n+1; 						%Aumenta n porque hay una llegada
	         a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
   	         b=b-minimo;					%Tiempo que tarda en haber una nueva salida
      	  end
	   else
   	      t=t+minimo;
      	  c=c+minimo*n;
	      d=d+minimo*(n-1);
   	      if (n+1)>length(p)
      	     p=cat(2, p, zeros(1));  
         	 p(n+1)=p(n+1)+minimo;
	      else
   	         p(n+1)=p(n+1)+minimo;
		  end
	      n=n-1;		%Disminuye el numero de clientes del sistema
   	      if (n==0)	%No quedan clientes en el sistema
      	     b=-1;
	      else
   	         b=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);	%Tiempo que tarda en haber una nueva salida
          end
	      a=a-minimo;					%Tiempo que tarda en haber una nueva entrada
	   end
    end
   
    
case 2, %G/G/s
      
     a=0;
     b=-1*ones(1,s_n);
     n=0;			%Numero de clientes que hay en el sistema
     ntot=0;		%Contabiliza el numero de clientes que han entrado hasta ese instante en el sistema


     while (ntot<estab_n)  
         
       indice_j=find(b~=-1);
   
       indice_j_menos_uno=find(b==-1);
      
       if (n>0)
          posibles_b=b(indice_j);
          minimo=min(cat(2,a,posibles_b));
       else
          %Si n es 0, entoces b es -1, pero no puede ser el minimo
          minimo=a;
       end
  
   
       if (minimo==a) 	%Hay una llegada
          ntot=ntot+1;	%Aumenta el numero de clientes que han entrado en el sistema
          if (n<s_n)				
             n=n+1; 						%Aumenta n porque hay una llegada
             a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
             b(indice_j)=b(indice_j)-minimo;
             b(indice_j_menos_uno(1))=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);         
          else
             n=n+1; 						%Aumenta n porque hay una llegada
             a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
             b(indice_j)=b(indice_j)-minimo;                  
          end
       else                        
          indice_minimo=find(b==minimo);
          n=n-1;		%Disminuye el numero de clientes del sistema
      
          b(indice_j)=b(indice_j)-minimo;
          if (n<s_n)	%No quedan clientes en el sistema
             b(indice_minimo)=-1;
          else
             b(indice_minimo)=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);	%Tiempo que tarda en haber una nueva salida
          end
          a=a-minimo;					%Tiempo que tarda en haber una nueva entrada
	   end
    end


    ntot=0;
    t=0;			%Cronometro
    c=0;			%Acumula tiempo * nº clientes (sistema)
    d=0;			%Acumula tiempo * nº clientes (cola)


    p=zeros(1,n+1);

    i=0;

    salto_porcentaje=1;

    cien_entre_salto=100/salto_porcentaje;


    texto=num2str(salto_porcentaje*i);
    texto=strcat(texto, '% completado');

    text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
     'String', texto , ...
     'Units', 'normalized', ...
     'Position', [0.4 0.77 0.2 0.03], ...
     'BackgroundColor', [.6 .6 .6],...
     'FontUnits', 'normalized', ...
     'FontWeight', 'bold', ...
     'FontSize', 0.5, ...
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
           'Position', [0.4 0.77 0.2 0.03], ...
           'BackgroundColor', [.6 .6 .6],...
           'FontUnits', 'normalized', ...
           'FontWeight', 'bold', ...
           'FontSize', 0.5, ...
           'ForegroundColor', 'r', ...
           'HorizontalAlignment', 'Center');

      	  drawnow;
      
          i=i+1;
       end   
   
       indice_j=find(b~=-1);
   
       indice_j_menos_uno=find(b==-1);   
   
       if (n>0)
          posibles_b=b(indice_j);
          minimo=min(cat(2,a,posibles_b));
       else
          %Si n es 0, entoces b es -1, pero no puede ser el minimo
          minimo=a;
       end
         
       if (minimo==a) 	%Hay una llegada
          ntot=ntot+1;	%Aumenta el numero de clientes que han entrado en el sistema
          if (n<s_n)				         
             t=t+minimo;
             if (n+1)>length(p)
                p=cat(2, p, zeros(1));
                p(n+1)=p(n+1)+minimo;           
             else
                p(n+1)=p(n+1)+minimo;
             end
             c=c+minimo*n;                           
             n=n+1; 						%Aumenta n porque hay una llegada
             a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
             b(indice_j)=b(indice_j)-minimo;
             b(indice_j_menos_uno(1))=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);                  
         else         
             t=t+minimo;
             if (n+1)>length(p)
                p=cat(2, p, zeros(1));
                p(n+1)=p(n+1)+minimo;           
             else
                p(n+1)=p(n+1)+minimo;
             end
             c=c+minimo*n;
             d=d+minimo*(n-s_n);         
         
             n=n+1; 						%Aumenta n porque hay una llegada
             a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
			 b(indice_j)=b(indice_j)-minimo;
          end
       else  
      
          indice_minimo=find(b==minimo);
      
          t=t+minimo;
          c=c+minimo*n;
          if (n>s_n)
             d=d+minimo*(n-s_n);
          end      
          if (n+1)>length(p)
             p=cat(2, p, zeros(1));  
             p(n+1)=p(n+1)+minimo;
          else
             p(n+1)=p(n+1)+minimo;
          end
      
      
          n=n-1;		%Disminuye el numero de clientes del sistema
          b(indice_j)=b(indice_j)-minimo;

          if (n<s_n)	
             b(indice_minimo)=-1;
          else
             b(indice_minimo)=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);	%Tiempo que tarda en haber una nueva salida
          end
          a=a-minimo;					%Tiempo que tarda en haber una nueva entrada
	   end
    end



case 3,  %G/G/1/K
   
     a=0;
     b=-1;
     n=0;			%Numero de clientes que hay en el sistema
     ntot=0;		%Contabiliza el numero de clientes que han entrado hasta ese instante en el sistema

     while (ntot<estab_n)
   
       if (n>0)
          minimo=min(a,b);
       else
          %Si n es 0, entoces b es -1, pero no puede ser el minimo
          minimo=a;
       end
   
      
       if (minimo==a) 	%Hay una llegada
          if (n==(k_n+1))
             a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
             b=b-minimo;
          else         
	         ntot=ntot+1;	%Aumenta el numero de clientes que han entrado en el sistema
   	         if (n==0)		%No hay clientes en el sistema
      	        n=n+1; 						%Aumenta n porque hay una llegada
         	    a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
	            b=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);		%Tiempo que tarda en haber una nueva salida
   	         else
      	        n=n+1; 						%Aumenta n porque hay una llegada
         	    a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
	            b=b-minimo;					%Tiempo que tarda en haber una nueva salida
             end
          end      
       else      
   	      n=n-1;		%Disminuye el numero de clientes del sistema
          if (n==0)	%No quedan clientes en el sistema
      	     b=-1;
          else
      	     b=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);	%Tiempo que tarda en haber una nueva salida
          end
          a=a-minimo;					%Tiempo que tarda en haber una nueva entrada
	   end
    end


    ntot=0;
    t=0;			%Cronometro
    c=0;			%Acumula tiempo * nº clientes (sistema)
    d=0;			%Acumula tiempo * nº clientes (cola)


    p=zeros(1,n+1);
 
    i=0;

    salto_porcentaje=1;

    cien_entre_salto=100/salto_porcentaje;


    texto=num2str(salto_porcentaje*i);
    texto=strcat(texto, '% completado');

    text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
	   	'String', texto , ...
	   	'Units', 'normalized', ...
   		'Position', [0.4 0.77 0.2 0.03], ...
		'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized', ...
        'FontWeight', 'bold', ...
        'FontSize', 0.5, ...
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
   		    'Position', [0.4 0.77 0.2 0.03], ...
		    'BackgroundColor', [.6 .6 .6],...
            'FontUnits', 'normalized', ...
            'FontWeight', 'bold', ...
            'FontSize', 0.5, ...
            'ForegroundColor', 'r', ...
		    'HorizontalAlignment', 'Center');
      
      
          drawnow;
      
          i=i+1;
       end   
   
       if (n>0)
          minimo=min(a,b);
       else
          %Si n es 0, entoces b es -1, pero no puede ser el minimo
          minimo=a;
       end
   
   
       if (minimo==a) 	%Hay una llegada o intento de llegada
          if (n==(k_n+1))	%Intento de llegada. El sistema esta lleno...
             a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
             b=b-minimo;
             t=t+minimo;
        	 c=c+minimo*n;
             d=d+minimo*(n-1);
			 if (n+1)>length(p)
                p=cat(2, p, zeros(1));
           	    p(n+1)=p(n+1)+minimo;           
	         else
   	            p(n+1)=p(n+1)+minimo;
			 end
          else
      	     ntot=ntot+1;	%Aumenta el numero de clientes que han entrado en el sistema
      	     if (n==0)		%No hay clientes en el sistema
         	    t=t+minimo;
	            p(1)=p(1)+minimo;
   	            n=n+1; %Aumenta n porque hay una llegada
      	        a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
         	    b=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);		%Tiempo que tarda en haber una nueva salida
	         else
   	            t=t+minimo;
      	        if (n+1)>length(p)
         	       p=cat(2, p, zeros(1));
            	   p(n+1)=p(n+1)+minimo;           
	            else
   	               p(n+1)=p(n+1)+minimo;
				end
         	    c=c+minimo*n;
	            d=d+minimo*(n-1);
   	            n=n+1; 						%Aumenta n porque hay una llegada
      	        a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
         	    b=b-minimo;					%Tiempo que tarda en haber una nueva salida
             end
          end      
       else
          t=t+minimo;
          c=c+minimo*n;
          d=d+minimo*(n-1);
          if (n+1)>length(p)
             p=cat(2, p, zeros(1));  
             p(n+1)=p(n+1)+minimo;
          else
            p(n+1)=p(n+1)+minimo;
		  end
          n=n-1;		%Disminuye el numero de clientes del sistema
          if (n==0)	%No quedan clientes en el sistema
             b=-1;
          else
             b=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);	%Tiempo que tarda en haber una nueva salida
          end
          a=a-minimo;					%Tiempo que tarda en haber una nueva entrada
	   end
    end

    
    
case 4,  %G/G/s/K
   
   
    a=0;
    b=-1*ones(1,s_n);
    n=0;			%Numero de clientes que hay en el sistema
    ntot=0;		%Contabiliza el numero de clientes que han entrado hasta ese instante en el sistema


    while (ntot<estab_n)  
      
       indice_j=find(b~=-1);
   
       indice_j_menos_uno=find(b==-1);
   
   
       if (n>0)
          posibles_b=b(indice_j);
          minimo=min(cat(2,a,posibles_b));
       else
          %Si n es 0, entoces b es -1, pero no puede ser el minimo
          minimo=a;
       end
         
       if (minimo==a) 	%Hay una llegada
          if (n==(k_n+s_n))
             a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
             b(indice_j)=b(indice_j)-minimo;
          else         
             ntot=ntot+1;	%Aumenta el numero de clientes que han entrado en el sistema
      	     if (n<s_n)				         
	            n=n+1; 						%Aumenta n porque hay una llegada
	            a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
   	            b(indice_j)=b(indice_j)-minimo;
     		    b(indice_j_menos_uno(1))=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);
              
			else                           
         	    n=n+1; 						%Aumenta n porque hay una llegada
         	    a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
				b(indice_j)=b(indice_j)-minimo;
             end
          end      
       else  
      
          indice_minimo=find(b==minimo);
                        
          n=n-1;		%Disminuye el numero de clientes del sistema
          b(indice_j)=b(indice_j)-minimo;

          if (n<s_n)	
             b(indice_minimo)=-1;
          else
             b(indice_minimo)=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);	%Tiempo que tarda en haber una nueva salida
          end
          a=a-minimo;					%Tiempo que tarda en haber una nueva entrada
	   end
    end


    ntot=0;
    t=0;			%Cronometro
    c=0;			%Acumula tiempo * nº clientes (sistema)
    d=0;			%Acumula tiempo * nº clientes (cola)


    p=zeros(1,n+1);

    i=0;

    salto_porcentaje=1;

    cien_entre_salto=100/salto_porcentaje;


    texto=num2str(salto_porcentaje*i);
    texto=strcat(texto, '% completado');


    text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
	   	'String', texto , ...
	   	'Units', 'normalized', ...
   		'Position', [0.4 0.77 0.2 0.03], ...
		'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized', ...
        'FontWeight', 'bold', ...
        'FontSize', 0.5, ...
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
   		    'Position', [0.4 0.77 0.2 0.03], ...
		    'BackgroundColor', [.6 .6 .6],...
            'FontUnits', 'normalized', ...
            'FontWeight', 'bold', ...
            'FontSize', 0.5, ...
            'ForegroundColor', 'r', ...
		    'HorizontalAlignment', 'Center');

	      drawnow;      
      
      
          i=i+1;
       end   
   
       indice_j=find(b~=-1);
   
       indice_j_menos_uno=find(b==-1);
   
   
       if (n>0)
          posibles_b=b(indice_j);
          minimo=min(cat(2,a,posibles_b));
       else
          %Si n es 0, entoces b es -1, pero no puede ser el minimo
          minimo=a;
       end
         
       if (minimo==a) 	%Hay una llegada
          if (n==(k_n+s_n))
             t=t+minimo;
             c=c+minimo*n;
             d=d+minimo*(n-s_n);
             if (n+1)>length(p)
                p=cat(2,p,zeros(1));
                p(n+1)=p(n+1)+minimo;
             else
                p(n+1)=p(n+1)+minimo;
             end
             a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
             b(indice_j)=b(indice_j)-minimo;
          else         
             ntot=ntot+1;	%Aumenta el numero de clientes que han entrado en el sistema
      	     if (n<s_n)				
	            t=t+minimo;
	            if (n+1)>length(p)
   	               p=cat(2, p, zeros(1));
      	           p(n+1)=p(n+1)+minimo;           
         	    else
            	   p(n+1)=p(n+1)+minimo;
	            end
   	            c=c+minimo*n;                  
         
         	    n=n+1; 						%Aumenta n porque hay una llegada
	            a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
   	            b(indice_j)=b(indice_j)-minimo;
     		    b(indice_j_menos_uno(1))=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);
              
			 else
         
         	    t=t+minimo;
         	    if (n+1)>length(p)
            	   p=cat(2, p, zeros(1));
	               p(n+1)=p(n+1)+minimo;           
   	            else
      	           p(n+1)=p(n+1)+minimo;
         	    end
         	    c=c+minimo*n;
         	    d=d+minimo*(n-s_n);         
         
         	    n=n+1; 						%Aumenta n porque hay una llegada
         	    a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
				b(indice_j)=b(indice_j)-minimo;
             end
          end      
       else  
      
          indice_minimo=find(b==minimo);
      
          t=t+minimo;
          c=c+minimo*n;
          if (n>s_n)
             d=d+minimo*(n-s_n);
          end      
          if (n+1)>length(p)
             p=cat(2, p, zeros(1));  
             p(n+1)=p(n+1)+minimo;
          else
             p(n+1)=p(n+1)+minimo;
          end
      
      
          n=n-1;		%Disminuye el numero de clientes del sistema
          b(indice_j)=b(indice_j)-minimo;

          if (n<s_n)	
             b(indice_minimo)=-1;
          else
             b(indice_minimo)=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);	%Tiempo que tarda en haber una nueva salida
          end
          a=a-minimo;					%Tiempo que tarda en haber una nueva entrada
	   end
    end


case 5,  %G/G/1/inf/H
   
    for i=1:h_n
       a(i)=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
    end
    b=-1;
    n=0;			%Numero de clientes que hay en el sistema
    ntot=0;		%Contabiliza el numero de clientes que han entrado hasta ese instante en el sistema



    while (ntot<estab_n)
   
	   indice_j=find(a~=-1);
   
       indice_j_menos_uno=find(a==-1);
   
       posibles_a=a(indice_j);
   
       if (n>0)   
          minimo=min(cat(2,posibles_a,b));
       else
          %Si n es 0, entoces b es -1, pero no puede ser el minimo
          minimo=min(posibles_a);
       end
   
   
	   if (minimo==b)
          n=n-1;		%Disminuye el numero de clientes del sistema
          if (n==0)	%No quedan clientes en el sistema
             b=-1;
          else
             b=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);	%Tiempo que tarda en haber una nueva salida
          end
             a(indice_j)=a(indice_j)-minimo;					%Tiempo que tarda en haber una nueva entrada
             a(indice_j_menos_uno(1))=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
       else
          ntot=ntot+1;		%Aumenta el numero de clientes que han entrado en el sistema
          indice_minimo=find(a==minimo);
                   	
     	  if (n==0)		%No hay clientes en el sistema
             n=n+1; %Aumenta n porque hay una llegada
             a(indice_j)=a(indice_j)-minimo;
     	     a(indice_minimo)=-1;	%Tiempo que tarda en haber una nueva llegada
        	 b=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);		%Tiempo que tarda en haber una nueva salida
          else         
             n=n+1;                      
             b=b-minimo;					%Tiempo que tarda en haber una nueva salida
             a(indice_j)=a(indice_j)-minimo;
             a(indice_minimo)=-1;
          end
       end
   

    end


    ntot=0;
    t=0;			%Cronometro
    c=0;			%Acumula tiempo * nº clientes (sistema)
    d=0;			%Acumula tiempo * nº clientes (cola)


    p=zeros(1,n+1);

    i=0;

    salto_porcentaje=1;

    cien_entre_salto=100/salto_porcentaje;


    texto=num2str(salto_porcentaje*i);
    texto=strcat(texto, '% completado');

    text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
	   	'String', texto , ...
	   	'Units', 'normalized', ...
   		'Position', [0.4 0.77 0.2 0.03], ...
		'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized', ...
        'FontWeight', 'bold', ...
        'FontSize', 0.5, ...
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
   		    'Position', [0.4 0.77 0.2 0.03], ...
		    'BackgroundColor', [.6 .6 .6],...
            'FontUnits', 'normalized', ...
            'FontWeight', 'bold', ...
            'FontSize', 0.5, ...
            'ForegroundColor', 'r', ...
		    'HorizontalAlignment', 'Center');
      
      
          drawnow;
      
          i=i+1;
       end   
   
       indice_j=find(a~=-1);
   
       indice_j_menos_uno=find(a==-1);
   
       posibles_a=a(indice_j);
   
       if (n>0)
          minimo=min(cat(2,posibles_a,b));
       else
          %Si n es 0, entoces b es -1, pero no puede ser el minimo
          minimo=min(posibles_a);
       end
   
   
       if (minimo==b)     
          t=t+minimo;
          c=c+minimo*n;
          d=d+minimo*(n-1);
          if (n+1)>length(p)
             p=cat(2, p, zeros(1));  
             p(n+1)=p(n+1)+minimo;
          else
             p(n+1)=p(n+1)+minimo;
		  end
          n=n-1;		%Disminuye el numero de clientes del sistema
          if (n==0)	%No quedan clientes en el sistema
             b=-1;
          else
             b=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);	%Tiempo que tarda en haber una nueva salida
          end
          a(indice_j)=a(indice_j)-minimo;					%Tiempo que tarda en haber una nueva entrada
          a(indice_j_menos_uno(1))=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
       else
          ntot=ntot+1;		%Aumenta el numero de clientes que han entrado en el sistema
          indice_minimo=find(a==minimo);
                   	
     	  if (n==0)		%No hay clientes en el sistema
        	 t=t+minimo;
	         p(1)=p(1)+minimo;
             n=n+1; %Aumenta n porque hay una llegada
             a(indice_j)=a(indice_j)-minimo;
     	     a(indice_minimo)=-1;	%Tiempo que tarda en haber una nueva llegada
         	 b=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);		%Tiempo que tarda en haber una nueva salida
          else
             t=t+minimo;
             if (n+1)>length(p)
       	        p=cat(2, p, zeros(1));
          	    p(n+1)=p(n+1)+minimo;           
		     else
   	            p(n+1)=p(n+1)+minimo;
			 end
        	 c=c+minimo*n;
             d=d+minimo*(n-1);
         
             n=n+1;                      
             b=b-minimo;					%Tiempo que tarda en haber una nueva salida
             a(indice_j)=a(indice_j)-minimo;
             a(indice_minimo)=-1;
          end
       end
    end


case 6,  %G/G/s/inh/H
   
    for i=1:h_n
       a(i)=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
    end
    b=-1*ones(1,s_n);
    n=0;			%Numero de clientes que hay en el sistema  
    ntot=0;		%Contabiliza el numero de clientes que han entrado hasta ese instante en el sistema



    while (ntot<estab_n)
   
       indice_a=find(a~=-1);
       indice_a_menos_uno=find(a==-1);
   
       indice_b=find(b~=-1);
       indice_b_menos_uno=find(b==-1);
   
       posibles_a=a(indice_a);
       posibles_b=b(indice_b);
   
       minimo_de_a=min(posibles_a);
       minimo_de_b=min(posibles_b);
   
       el_minimo_es_a=1;
   
       if(n>0)
          if (minimo_de_a<=minimo_de_b)
             minimo=minimo_de_a;
          else
             el_minimo_es_a=0;
             minimo=minimo_de_b;
          end
       else
          minimo=minimo_de_a;
       end
   
       if (el_minimo_es_a==1)
          ntot=ntot+1;
          indice_minimo_a=find(a==minimo);
          if (n<s_n)
             n=n+1;
             a(indice_a)=a(indice_a)-minimo;                
             a(indice_minimo_a)=-1; 
             b(indice_b)=b(indice_b)-minimo;
             b(indice_b_menos_uno(1))=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);
          else
             n=n+1;
             b(indice_b)=b(indice_b)-minimo;
             a(indice_a)=a(indice_a)-minimo;
             a(indice_minimo_a)=-1;
          end                      
       else
          indice_minimo_b=find(b==minimo);
          n=n-1;
          b(indice_b)=b(indice_b)-minimo;
          if (n<s_n)
             b(indice_minimo_b)=-1;
          else
             b(indice_minimo_b)=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);
          end
          a(indice_a)=a(indice_a)-minimo;
          a(indice_a_menos_uno(1))=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
       end
    end





    ntot=0;
    t=0;			%Cronometro
    c=0;			%Acumula tiempo * nº clientes (sistema)
    d=0;			%Acumula tiempo * nº clientes (cola)

    p=zeros(1,n+1);




    i=0;

    salto_porcentaje=1;

    cien_entre_salto=100/salto_porcentaje;


    texto=num2str(salto_porcentaje*i);
    texto=strcat(texto, '% completado');


    text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
	   	'String', texto , ...
	   	'Units', 'normalized', ...
   		'Position', [0.4 0.77 0.2 0.03], ...
		'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized', ...
        'FontWeight', 'bold', ...
        'FontSize', 0.5, ...
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
   		   'Position', [0.4 0.77 0.2 0.03], ...
		   'BackgroundColor', [.6 .6 .6],...
           'FontUnits', 'normalized', ...
           'FontWeight', 'bold', ...
           'FontSize', 0.5, ...
           'ForegroundColor', 'r', ...
		   'HorizontalAlignment', 'Center');
      
      
      
      
          drawnow;
      
          i=i+1;
      end   

   
      indice_a=find(a~=-1);
      indice_a_menos_uno=find(a==-1);
   
      indice_b=find(b~=-1);
      indice_b_menos_uno=find(b==-1);
   
      posibles_a=a(indice_a);
      posibles_b=b(indice_b);
   
      minimo_de_a=min(posibles_a);
      minimo_de_b=min(posibles_b);
   
      el_minimo_es_a=1;
   
      if(n>0)
          if (minimo_de_a<=minimo_de_b)
             minimo=minimo_de_a;
          else
             minimo=minimo_de_b;
             el_minimo_es_a=0;
          end
     else
        minimo=minimo_de_a;
     end
   
     if (el_minimo_es_a==1)
         ntot=ntot+1;
         indice_minimo_a=find(a==minimo);
         if (n<s_n)
             t=t+minimo;
             if (n+1)>length(p)
                p=cat(2,p,zeros(1));
                p(n+1)=p(n+1)+minimo;
             else
                p(n+1)=p(n+1)+minimo;
             end
             c=c+minimo*n;
             n=n+1;
             a(indice_a)=a(indice_a)-minimo;        
             a(indice_minimo_a)=-1;
             b(indice_b)=b(indice_b)-minimo;
             b(indice_b_menos_uno(1))=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);
         else
            t=t+minimo;
            if (n+1)>length(p)
               p=cat(2,p,zeros(1));
               p(n+1)=p(n+1)+minimo;
            else
               p(n+1)=p(n+1)+minimo;
            end
            c=c+minimo*n;
            d=d+minimo*(n-s_n);
            n=n+1;
            b(indice_b)=b(indice_b)-minimo;
            a(indice_a)=a(indice_a)-minimo;
            a(indice_minimo_a)=-1;
         end                      
      else
         indice_minimo_b=find(b==minimo);
         t=t+minimo;
         c=c+minimo*n;
         if (n>s_n)
            d=d+minimo*(n-s_n);
         end
         if (n+1)>length(p)
            p=cat(2,p,zeros(1));
            p(n+1)=p(n+1)+minimo;
         else
            p(n+1)=p(n+1)+minimo;
         end
         n=n-1;
         b(indice_b)=b(indice_b)-minimo;
         if (n<s_n)
            b(indice_minimo_b)=-1;
         else
            b(indice_minimo_b)=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);
         end
         a(indice_a)=a(indice_a)-minimo;
         a(indice_a_menos_uno(1))=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
      end
    end


case 7, %G/G/s/inf/H con Y repuestos
   
    for i=1:h_n
       a(i)=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
    end
    b=-1*ones(1,s_n);
    n=0;			%Numero de clientes que hay en el sistema
    ntot=0;		%Contabiliza el numero de clientes que han entrado hasta ese instante en el sistema




    while (ntot<estab_n)
   
       indice_a=find(a~=-1);
       indice_a_menos_uno=find(a==-1);
   
       indice_b=find(b~=-1);
       indice_b_menos_uno=find(b==-1);
   
       posibles_a=a(indice_a);
       posibles_b=b(indice_b);
   
        minimo_de_a=min(posibles_a);
        minimo_de_b=min(posibles_b);
   
        el_minimo_es_a=1;
   
        if(n>0)
          if (minimo_de_a<=minimo_de_b)
              minimo=minimo_de_a;
          else
             el_minimo_es_a=0;
             minimo=minimo_de_b;
          end
       else
          minimo=minimo_de_a;
       end
   
       if (el_minimo_es_a==1)
          ntot=ntot+1;
          indice_minimo_a=find(a==minimo);
          if (n<s_n)
             n=n+1;
             a(indice_a)=a(indice_a)-minimo;                
             a(indice_minimo_a)=-1; 
             b(indice_b)=b(indice_b)-minimo;
             b(indice_b_menos_uno(1))=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);
             if (n<=y_n)
                a(indice_minimo_a)=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
             end
         else
            n=n+1;
            b(indice_b)=b(indice_b)-minimo;
            a(indice_a)=a(indice_a)-minimo;
            a(indice_minimo_a)=-1;
            if (n<=y_n)
               a(indice_minimo_a)=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
            end
         end                      
      else
         indice_minimo_b=find(b==minimo);
         n=n-1;
         b(indice_b)=b(indice_b)-minimo;
         if (n<s_n)
            b(indice_minimo_b)=-1;
         else
            b(indice_minimo_b)=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);
         end
         a(indice_a)=a(indice_a)-minimo;
         if (n>=y_n)
            a(indice_a_menos_uno(1))=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
         end      
      end
    end





    ntot=0;
    t=0;			%Cronometro
    c=0;			%Acumula tiempo * nº clientes (sistema)
    d=0;			%Acumula tiempo * nº clientes (cola)

    p=zeros(1,n+1);




    i=0;

    salto_porcentaje=1;

    cien_entre_salto=100/salto_porcentaje;


    texto=num2str(salto_porcentaje*i);
    texto=strcat(texto, '% completado');


    text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
	   	'String', texto , ...
	   	'Units', 'normalized', ...
   		'Position', [0.4 0.77 0.2 0.03], ...
		'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized', ...
        'FontWeight', 'bold', ...
        'FontSize', 0.5, ...
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
   		   'Position', [0.4 0.77 0.2 0.03], ...
		   'BackgroundColor', [.6 .6 .6],...
           'FontUnits', 'normalized', ...
           'FontWeight', 'bold', ...
           'FontSize', 0.5, ...
           'ForegroundColor', 'r', ...
		   'HorizontalAlignment', 'Center');      
            
          drawnow;
      
          i=i+1;
       end   

   
       indice_a=find(a~=-1);
       indice_a_menos_uno=find(a==-1);
   
       indice_b=find(b~=-1);
       indice_b_menos_uno=find(b==-1);
   
       posibles_a=a(indice_a);
       posibles_b=b(indice_b);
   
       minimo_de_a=min(posibles_a);
       minimo_de_b=min(posibles_b);
   
       el_minimo_es_a=1;
   
       if(n>0)
          if (minimo_de_a<=minimo_de_b)
             minimo=minimo_de_a;
          else
             minimo=minimo_de_b;
             el_minimo_es_a=0;
          end
       else
          minimo=minimo_de_a;
       end
   
       if (el_minimo_es_a==1)
          ntot=ntot+1;
          indice_minimo_a=find(a==minimo);
          if (n<s_n)
             t=t+minimo;
             if (n+1)>length(p)
                p=cat(2,p,zeros(1));
                p(n+1)=p(n+1)+minimo;
             else
                p(n+1)=p(n+1)+minimo;
             end
             c=c+minimo*n;
             n=n+1;
             a(indice_a)=a(indice_a)-minimo;        
             a(indice_minimo_a)=-1;
             if (n<=y_n)
                a(indice_minimo_a)=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
             end         
             b(indice_b)=b(indice_b)-minimo;
             b(indice_b_menos_uno(1))=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);
          else
             t=t+minimo;
             if (n+1)>length(p)
                p=cat(2,p,zeros(1));
                p(n+1)=p(n+1)+minimo;
            else
               p(n+1)=p(n+1)+minimo;
            end
            c=c+minimo*n;
            d=d+minimo*(n-s_n);
            n=n+1;
            b(indice_b)=b(indice_b)-minimo;
            a(indice_a)=a(indice_a)-minimo;
            a(indice_minimo_a)=-1;
            if (n<=y_n)
               a(indice_minimo_a)=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
            end         
          end                      
      else
         indice_minimo_b=find(b==minimo);
         t=t+minimo;
         c=c+minimo*n;
         if (n>s_n)
            d=d+minimo*(n-s_n);
         end
         if (n+1)>length(p)
            p=cat(2,p,zeros(1));
            p(n+1)=p(n+1)+minimo;
         else
            p(n+1)=p(n+1)+minimo;
         end
         n=n-1;
         b(indice_b)=b(indice_b)-minimo;
         if (n<s_n)
            b(indice_minimo_b)=-1;
         else
            b(indice_minimo_b)=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);
         end
         a(indice_a)=a(indice_a)-minimo;
         if (n>=y_n)
            a(indice_a_menos_uno(1))=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);
         end      
      end
    end
   
    
case 8, %G/G/inf
   
    a=0;
    b=-1;
    n=0;			%Numero de clientes que hay en el sistema
    ntot=0;		%Contabiliza el numero de clientes que han entrado hasta ese instante en el sistema


    while (ntot<estab_n)  
   
      
       indice_j=find(b~=-1);
   
       indice_j_menos_uno=find(b==-1);
   
       if (isempty(indice_j_menos_uno)==1)
         b=cat(2,b,-1);
         indice_j_menos_uno=length(b);
       end
   
      
       if (n>0)
          posibles_b=b(indice_j);
          minimo=min(cat(2,a,posibles_b));
       else
          %Si n es 0, entoces b es -1, pero no puede ser el minimo
          minimo=a;
       end
         
       if (minimo==a) 	%Hay una llegada
          ntot=ntot+1;	%Aumenta el numero de clientes que han entrado en el sistema
                           
                  
          n=n+1; 						%Aumenta n porque hay una llegada
          a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
          b(indice_j)=b(indice_j)-minimo;
          b(indice_j_menos_uno(1))=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);
         
         
       else  
      
          indice_minimo=find(b==minimo);
      
            
          n=n-1;		%Disminuye el numero de clientes del sistema
          b(indice_j)=b(indice_j)-minimo;

          b(indice_minimo)=-1;

          a=a-minimo;					%Tiempo que tarda en haber una nueva entrada
	   end
    end




    ntot=0;
    t=0;			%Cronometro
    c=0;			%Acumula tiempo * nº clientes (sistema)
    d=0;			%Acumula tiempo * nº clientes (cola)


    p=zeros(1,n+1);

    i=0;

    salto_porcentaje=1;

    cien_entre_salto=100/salto_porcentaje;


    texto=num2str(salto_porcentaje*i);
    texto=strcat(texto, '% completado');

    text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
	   	'String', texto , ...
	   	'Units', 'normalized', ...
   		'Position', [0.4 0.77 0.2 0.03], ...
		'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized', ...
        'FontWeight', 'bold', ...
        'FontSize', 0.5, ...
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
   		   'Position', [0.4 0.77 0.2 0.03], ...
		   'BackgroundColor', [.6 .6 .6],...
           'FontUnits', 'normalized', ...
           'FontWeight', 'bold', ...
           'FontSize', 0.5, ...
           'ForegroundColor', 'r', ...
		   'HorizontalAlignment', 'Center');

      
      
      
          drawnow;
      
          i=i+1;
       end   
   
       indice_j=find(b~=-1);
   
       indice_j_menos_uno=find(b==-1);
   
       if (isempty(indice_j_menos_uno)==1)
          b=cat(2,b,-1);
          indice_j_menos_uno=length(b);
       end
   
      
       if (n>0)
          posibles_b=b(indice_j);
          minimo=min(cat(2,a,posibles_b));
       else
          %Si n es 0, entoces b es -1, pero no puede ser el minimo
          minimo=a;
       end
         
       if (minimo==a) 	%Hay una llegada
          ntot=ntot+1;	%Aumenta el numero de clientes que han entrado en el sistema
               
          t=t+minimo;
          if (n+1)>length(p)
             p=cat(2, p, zeros(1));
             p(n+1)=p(n+1)+minimo;           
          else
             p(n+1)=p(n+1)+minimo;
          end
          c=c+minimo*n;
         
         
         
          n=n+1; 						%Aumenta n porque hay una llegada
          a=generar_entrada(distrib_entrada, par_ent_1_n, par_ent_2_n, par_ent_3_n);	%Tiempo que tarda en haber una nueva llegada
          b(indice_j)=b(indice_j)-minimo;
          b(indice_j_menos_uno(1))=generar_salida(distrib_salida, par_sal_1_n, par_sal_2_n, par_sal_3_n);
         
         
       else  
      
          indice_minimo=find(b==minimo);
      
          t=t+minimo;
          c=c+minimo*n;
          if (n+1)>length(p)
             p=cat(2, p, zeros(1));  
             p(n+1)=p(n+1)+minimo;
          else
             p(n+1)=p(n+1)+minimo;
          end
      
      
          n=n-1;		%Disminuye el numero de clientes del sistema
          b(indice_j)=b(indice_j)-minimo;

          b(indice_minimo)=-1;

          a=a-minimo;					%Tiempo que tarda en haber una nueva entrada
	   end
    end
end


texto=num2str(100);
texto=strcat(texto, '% completado');
         
text_porcentaje = uicontrol(gcf, 'Style', 'Text', ...
	   	'String', texto , ...
	   	'Units', 'normalized', ...
   		'Position', [0.4 0.77 0.2 0.03], ...
 	    'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized', ...
        'FontWeight', 'bold', ...
        'FontSize', 0.5, ...
        'ForegroundColor', 'b', ...
		'HorizontalAlignment', 'Center');







%Mostramos los valores de L, Lq, W y Wq

l= uicontrol(gcf, 'Style', 'Text', ...
    'Units', 'normalized', ...
    'String', num2str(c/t), ...
    'Position', [0.3 0.85 0.1 0.05], ...
    'BackgroundColor', [.6 .6 .6],...
    'FontUnits', 'normalized', ...
    'FontSize', 0.4, ...
    'HorizontalAlignment', 'Center');


   
lq= uicontrol(gcf, 'Style', 'Text', ...
    'Units', 'normalized', ...
	'String', num2str(d/t), ...
    'Position', [0.3 0.8 0.1 0.05], ...
    'BackgroundColor', [.6 .6 .6],...
    'FontUnits', 'normalized', ...
    'FontSize', 0.4, ...
    'HorizontalAlignment', 'Center');

w= uicontrol(gcf, 'Style', 'Text', ...
    'Units', 'normalized', ...
	'String', num2str(c/cli_sim_n), ...
    'Position', [0.5 0.85 0.1 0.05], ...
    'BackgroundColor', [.6 .6 .6],...
    'FontUnits', 'normalized', ...
    'FontSize', 0.4, ...
    'HorizontalAlignment', 'Center', ...
    'Callback', 'valor_w');

wq= uicontrol(gcf, 'Style', 'Text', ...
    'Units', 'normalized', ...
	'String', num2str(d/cli_sim_n), ...
    'Position', [0.5 0.8 0.1 0.05], ...
    'BackgroundColor', [.6 .6 .6],...
    'FontUnits', 'normalized', ...
    'FontSize', 0.4, ...
    'HorizontalAlignment', 'Center');

if (eleccion == 1|eleccion==3 | eleccion==5 )

    intens = uicontrol(gcf, 'Style', 'Text', ...   %L-Lq
        'Units', 'normalized', ...
	    'String', num2str((c/t)-(d/t)), ...
        'Position', [0.7 0.85 0.1 0.05], ...
        'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized', ...
        'FontSize', 0.4, ...
        'HorizontalAlignment', 'Center');

end

if (eleccion == 2|eleccion==4 | eleccion==6 |eleccion==7)

    intens = uicontrol(gcf, 'Style', 'Text', ...   %L-Lq
        'Units', 'normalized', ...
	    'String', num2str(((c/t)-(d/t))/s_n), ...
        'Position', [0.7 0.85 0.1 0.05], ...
        'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized', ...
        'FontSize', 0.4, ...
        'HorizontalAlignment', 'Center');


end

if (eleccion == 8 )

    intens = uicontrol(gcf, 'Style', 'Text', ...   %L-Lq
        'Units', 'normalized', ...
	    'String', num2str(0), ...
        'Position', [0.7 0.85 0.1 0.05], ...
        'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized', ...
        'FontSize', 0.4, ...
        'HorizontalAlignment', 'Center');

end

efec = uicontrol(gcf, 'Style', 'Text', ...
    'Units', 'normalized', ...
	'String', num2str((c/cli_sim_n)/((c/cli_sim_n)-(d/cli_sim_n))), ... %W/(W-Wq)
    'Position', [0.7 0.8 0.1 0.05], ...
    'BackgroundColor', [.6 .6 .6],...
    'FontUnits', 'normalized', ...
    'FontSize', 0.4, ...
    'HorizontalAlignment', 'Center');


p=p/t;









text_salida_p_1= uicontrol(gcf, 'Style', 'Text', ...
    'Units', 'normalized', ...
	'String', 'p ', ...
    'Position', [0.155 0.61 0.05 0.05], ...
    'BackgroundColor', [.6 .6 .6],...
    'FontUnits', 'normalized', ...
    'FontSize', 0.4, ...
    'HorizontalAlignment', 'Center');

%Llama al fichero calcula_p, para calcular el valor
%de una determinada p(i), en funcion del valor de i y del
%modelo concreto que haya elegido el usuario.

indice_p= uicontrol(gcf, 'Style', 'Edit', ...
   'Units', 'normalized', ...
   'Position', [0.215 0.61 0.05 0.05], ...
   'BackgroundColor', [.702 .702 .702],...
   'FontUnits', 'normalized', ...
   'FontSize', 0.4, ...
   'HorizontalAlignment', 'Center', ...
   'Callback', 'calcula_p_simulacion');  

text_salida_p_2= uicontrol(gcf, 'Style', 'Text', ...
    'Units', 'normalized', ...
	'String', 'clientes ', ...
    'Position', [0.275 0.61 0.07 0.05], ...
    'BackgroundColor', [.6 .6 .6],...
    'FontUnits', 'normalized', ...
    'FontSize', 0.4, ...
    'HorizontalAlignment', 'Center');


valor_p = uicontrol(gcf, 'Style', 'Text', ...
   'Units', 'normalized', ...
   'Position', [0.355 0.61 0.11 0.05], ...
   'BackgroundColor', [.6 .6 .6],...
   'FontUnits', 'normalized', ...
   'FontSize', 0.4, ...
   'HorizontalAlignment', 'Center');



%Para los modelos G/G/1/k, G/G/s/k, G/G/1/inf/H, G/G/s/inf/H y
%G/G/s/inf/H con Y repuestos tenemos la posibilidad de hallar 
%los valores de q(i)


if (eleccion == 3 | eleccion == 4 | eleccion == 5 | eleccion == 6 | eleccion ==7)
   
   text_salida_q_1= uicontrol(gcf, 'Style', 'Text', ...
    'Units', 'normalized', ...
	'String', 'q ', ...
    'Position', [0.155 0.55 0.05 0.05], ...
    'BackgroundColor', [.6 .6 .6],...
    'FontUnits', 'normalized', ...
    'FontSize', 0.4, ...
    'HorizontalAlignment', 'Center');


%Llama al fichero calcula_q, para calcular el valor
%de una determinada q(i), en funcion del valor de i y del
%modelo concreto que haya elegido el usuario.

	indice_q= uicontrol(gcf, 'Style', 'Edit', ...
        'Units', 'normalized', ...
        'Position', [0.215 0.55 0.05 0.05], ...
        'BackgroundColor', [.702 .702 .702],...
        'FontUnits', 'normalized', ...
        'FontSize', 0.4, ...
        'HorizontalAlignment', 'Center', ...
	    'Callback', 'calcula_q_simulacion'); 

	text_salida_q_2= uicontrol(gcf, 'Style', 'Text', ...
        'Units', 'normalized', ...
	    'String', 'clientes ', ...
        'Position', [0.275 0.55 0.07 0.05], ...
        'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized', ...
        'FontSize', 0.4, ...
        'HorizontalAlignment', 'Center');


	valor_q = uicontrol(gcf, 'Style', 'Text', ...
        'Units', 'normalized', ...
        'Position', [0.355 0.55 0.11 0.05], ...
        'BackgroundColor', [.6 .6 .6],...
        'FontUnits', 'normalized', ...
        'FontSize', 0.4, ...
        'HorizontalAlignment', 'Center');

end


text_dibujar_3 = uicontrol(gcf, 'Style', 'Text', ...
   'Units', 'normalized', ...
   'String', 'Dibujar entre p ', ...
   'Position', [0.155 0.48 0.10 0.06], ...
   'BackgroundColor', [.6 .6 .6],...
   'FontUnits', 'normalized', ...
   'FontSize', 0.25, ...
   'HorizontalAlignment', 'Center');

indice_1 = uicontrol(gcf, 'Style', 'Edit', ...
   'Units', 'normalized', ...
   'Position', [0.265 0.49 0.04 0.05], ...
   'BackgroundColor', [.702 .702 .702],...
   'FontUnits', 'normalized', ...
   'FontSize', 0.4, ...
   'HorizontalAlignment', 'Center');

text_dibujar_4 = uicontrol(gcf, 'Style', 'Text', ...
   'Units', 'normalized', ...
   'String', ' y p ', ...
   'Position', [0.315 0.49 0.03 0.05], ...
   'BackgroundColor', [.6 .6 .6],...
   'FontUnits', 'normalized', ...
   'FontSize', 0.3, ...
   'HorizontalAlignment', 'Center');

indice_2 = uicontrol(gcf, 'Style', 'Edit', ...
   'Units', 'normalized', ...
   'Position', [0.355 0.49 0.04 0.05], ...
   'BackgroundColor', [.702 .702 .702],...
   'FontUnits', 'normalized', ...
   'FontSize', 0.4, ...
   'HorizontalAlignment', 'Center');

%Llama al fichero dibujar_p, para hacer una representacion
%del valor de los p(i) en un intervalo de i que seleccione
%el usuario. El resultado se muestra en un diagrama 
%de barras.

boton_dibujar_2 = uicontrol(gcf, 'Style', 'pushbutton', ...
   'Units', 'normalized', ...
   'String', 'OK', ...
   'Position', [0.405 0.49 0.05 0.05], ...
   'BackgroundColor', [.6 .6 .6],...
   'FontUnits', 'normalized', ...
   'FontSize', 0.4, ...
   'HorizontalAlignment', 'Center', ...
   'Callback', 'dibujar_p_simulacion');




t2=cputime;
%tiempo_ejecucion=t2-t1

if (estoy_en_redes_abiertas ~=1 )
		boton_salida_sig = uicontrol(gcf, 'Style', 'Pushbutton',...
	        'String', 'Menu Inicio >>', 'Value', 0, ...
   	        'Units', 'normalized', ...
	        'Position', [0.2 0.10 0.25 0.07], ...
   	        'FontUnits', 'normalized', ...
            'FontWeight', 'bold', ...
            'FontSize', 0.3, ...
            'Callback', 'aquas');
   
     boton_salida_cambiar_parametros  = uicontrol(gcf, 'Style', 'Pushbutton',...
            'String', 'Cambiar los parametros del problema >>', 'Value', 0, ...
            'Units', 'normalized', ...
	        'Position', [0.5 0.1 0.35 0.07], ...
	        'FontUnits', 'normalized', ...
            'FontWeight', 'bold', ...
            'FontSize', 0.25, ...
	        'Callback', 'cambiar_parametros_modelomm_sim');

else
   	boton_salida_sig = uicontrol(gcf, 'Style', 'Pushbutton',...
	        'String', 'Cerrar', 'Value', 0, ...
   	        'Units', 'normalized', ...
	        'Position', [0.38 0.05 0.2 0.1], ...
   	        'FontUnits', 'normalized', ...
            'FontWeight', 'bold', ...
            'FontSize', 0.3, ...
            'Callback', 'cerrar_ventana');   
end
