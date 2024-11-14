% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  dibujar.m

%Dibuja el valor de la funcion de distribucion Wq(t)
%y de la funcion de distribucion W(t) para un determinado 
%instervalo del tiempo y para un determinado modelo: 

%M/M/1 (funcion de distribucion de W(t) y Wq(t))
%M/M/s (funcion de distribucion de W(t) y Wq(t))
%M/M/1/k (funcion de distribucion de W(t) y Wq(t))
%M/M/s/k (funcion de distribucion de W(t) y Wq(t))
%M/M/1/inf/H (funcion de distribucion de W(t) y Wq(t))
%M/M/s/inf/H (funcion de distribucion de W(t) y Wq(t))
%M/M/s/inf/H con Y repuestos (funcion de distribucion de W(t) y Wq(t))

%Recibe el valor de los instantes de tiempo (intervalo) en el cual
%queremos calcular Wq(t) y W(t)

tiempo_1_n=get(tiempo_1,'String');
tiempo_1_n=str2num(tiempo_1_n);

tiempo_2_n=get(tiempo_2, 'String');
tiempo_2_n=str2num(tiempo_2_n);


%Realiza los calculos si los instantes de tiempo son positivos y
%el segundo instante de tiempo es mas tardio que el primero

if (tiempo_2_n > tiempo_1_n & (tiempo_2_n>0) & (tiempo_1_n>=0))
   
   %x es un vector formado por 100 puntos equiespaciados entre los dos instantes
   %de tiempo, esto quiere decir que vamos a hallar el valor en
   %100 puntos que se encuentran entre t1 y t2 de W(t) y Wq(t).
   
   
   text_dibujar_error = uicontrol(gcf, 'Style', 'Text', ...
 		 'String', '', ...
   		 'Units', 'normalized', ...
         'Position', [0.2 0.535 0.3 0.03], ...
         'BackgroundColor', [0.6 0.6 0.6], ...
         'ForegroundColor', 'r', ...
         'FontUnits', 'normalized', ...
	   	 'FontSize', 0.2, ...
         'HorizontalAlignment', 'Center');
   
   x=linspace(tiempo_1_n, tiempo_2_n, 100);
   
      
   switch eleccion
      
   case 1,
       %Modelo M/M/1
      
       w_t=1-exp(-(mu_n-lambda_n)*x);
       wq_t=1-(lambda_n/mu_n)*exp(-(mu_n-lambda_n)*x);
       
    case 2,
       %Modelo M/M/s
       
       %Calcula Wq(t)
    	wq_t = 1-c_mayor_s*p_cero*exp(-(s_n*mu_n-lambda_n)*x);
   
   	    wq_cero = 1-c_mayor_s*p_cero;
      
        %Calcula W(t)
   	    if (lambda_n/mu_n == (s_n-1))
      	  w_t = 1-(1+c_mayor_s*p_cero*x*mu_n)*exp(-mu*x);
   	    else
          w_t = 1+...
            (lambda_n-s_n*mu_n+mu_n*wq_cero)/(s_n*mu_n-lambda_n-mu_n)*...
            exp(-(mu_n*x))+...
            (c_mayor_s*mu_n*p_cero)/(s_n*mu_n-lambda_n-mu_n)*...
            exp(-(s_n*mu_n-lambda_n)*x);
        end
      
        clear wq_cero;
      
   case 3,
      %Modelo M/M/1/k
            
      variable_a_wqt=ones(1,length(x));
      variable_s_wqt=ones(1,length(x));
      
      if (k_n==0)
      	variable_b_wqt=0;
	   else
         variable_b_wqt=vector_q(2)*ones(1,length(x));
      end
      
      
      for variable_n_wqt=2:k_n
         variable_a_wqt=variable_a_wqt.*(mu_n*x/variable_n_wqt);
         variable_s_wqt=variable_s_wqt+variable_a_wqt;
         variable_b_wqt=variable_b_wqt+vector_q(variable_n_wqt+1)*variable_s_wqt;
      end
      
      %Calcula Wq(t)
      wq_t=1-variable_b_wqt.*exp(-mu_n*x);
      
      
      variable_a_wt=ones(1,length(x));
	  variable_s_wt=ones(1,length(x));
	  variable_b_wt=vector_q(1)*ones(1,length(x));

      
      for variable_n_wt=1:k_n
         variable_a_wt=variable_a_wt.*(mu_n*x/variable_n_wt);
         variable_s_wt=variable_s_wt+variable_a_wt;
         variable_b_wt=variable_b_wt+vector_q(variable_n_wt+1)*variable_s_wt;
      end
      
      %Calcula W(t)
      w_t =1-variable_b_wt.*exp(-mu_n*x);
      
      clear variable_a_wqt;
      clear variable_a_wt;
      clear variable_s_wqt;
      clear variable_s_wt;
      clear variable_b_wqt;
      clear variable_b_wt;
      clear variable_n_wqt;
      clear variable_n_wt;         
      
   case 4,
      
      %Modelo M/M/s/k
      variable_a_wqt=ones(1,length(x));
      variable_s_wqt=ones(1,length(x));
      if (k_n==0)
      	variable_b_wqt=0;
	   else
         variable_b_wqt=vector_q(s_n+1)*ones(1,length(x));
      end
      
      
	for variable_n_wqt=s_n+1:k_n+s_n-1
   	    variable_a_wqt=variable_a_wqt.*(mu_n*x*s_n/(variable_n_wqt-s_n));
      	variable_s_wqt=variable_s_wqt+variable_a_wqt;
      	variable_b_wqt=variable_b_wqt+vector_q(variable_n_wqt+1)*variable_s_wqt;
   	end
      
      %Calcula Wq(t)
      wq_t=1-variable_b_wqt.*exp(-mu_n*x*s_n);
      
      
      %%Ojo, esto es necesario, ya que si no hay problemas con las dimensiones de las matrices
      clear w_t;
      
      for i=1:length(x)         
   	    w_t(i)=quad('calcular_wt_mmsk', 0, x(i), 0.001, [], x(i), s_n, vector_q, k_n, mu_n);
        if (w_t(i)>1)
           w_t(i)=1;
        end       
      end
                  
      
      
	clear variable_a_wqt;
   	clear variable_b_wqt;
   	clear variable_s_wqt;
    clear variable_n_wqt;
      
      
   case 5,
      
      %Modelo M/M/1/inf/h
      variable_a_wqt=ones(1,length(x));
      variable_s_wqt=ones(1,length(x));
      if (h_n==1)
         variable_b_wqt=0;
      else              
         variable_b_wqt=vector_q(2)*ones(1,length(x));
      end      
      
      for variable_n_wqt=2:h_n-1
         variable_a_wqt=variable_a_wqt.*(mu_n*x/variable_n_wqt);
         variable_s_wqt=variable_s_wqt+variable_a_wqt;
         variable_b_wqt=variable_b_wqt+vector_q(variable_n_wqt+1)*variable_s_wqt;
      end
      
      %Calcula Wq(t)
      wq_t=1-variable_b_wqt.*exp(-mu_n*x);
      
      
      variable_a_wt=ones(1,length(x));
	  variable_s_wt=ones(1,length(x));
	  variable_b_wt=vector_q(1)*ones(1,length(x));

      
      for variable_n_wt=1:h_n-1
         variable_a_wt=variable_a_wt.*(mu_n*x/variable_n_wt);
         variable_s_wt=variable_s_wt+variable_a_wt;
         variable_b_wt=variable_b_wt+vector_q(variable_n_wt+1)*variable_s_wt;
      end
      
      %Calcula W(t)
      w_t=1-variable_b_wt.*exp(-mu_n*x);
      
      clear variable_a_wqt;
      clear variable_a_wt;
      clear variable_s_wqt;
      clear variable_s_wt;
      clear variable_b_wqt;
      clear variable_b_wt;
      clear variable_n_wqt;
      clear variable_n_wt;   
      
   case 6,
      
      %Modelo M/M/s/inf/h
      variable_a_wqt=ones(1,length(x));
	  variable_s_wqt=ones(1,length(x));
	  variable_b_wqt=vector_q(s_n+1)*ones(1,length(x));
      
	  for variable_n_wqt=s_n+1:h_n-1
   	     variable_a_wqt=variable_a_wqt.*(mu_n*x*s_n/(variable_n_wqt-s_n));
      	 variable_s_wqt=variable_s_wqt+variable_a_wqt;
      	 variable_b_wqt=variable_b_wqt+vector_q(variable_n_wqt+1)*variable_s_wqt;
   	  end
      
      %Calcula Wq(t)
      wq_t =1-variable_b_wqt.*exp(-mu_n*x*s_n);
      
      %%Ojo, esto es necesario, ya que si no hay problemas con las dimensiones de las matrices
      clear w_t;
      
      for i=1:length(x)         
   	    w_t(i)=quad('calcular_wt_mmsinfh', 0, x(i), 0.001, [], x(i), s_n, vector_q, h_n, mu_n);
        if (w_t(i)>1)
           w_t(i)=1;
        end       
      end

      
      
	  clear variable_a_wqt;
   	  clear variable_b_wqt;
   	  clear variable_s_wqt;
      clear variable_n_wqt;
      
   case 7,
      
      %Modelo M/M/s/inf/h con Y repuestos
       variable_a_wqt=ones(1,length(x));
	   variable_s_wqt=ones(1,length(x));
	   variable_b_wqt=vector_q(s_n+1)*ones(1,length(x));
      
	   for variable_n_wqt=s_n+1:h_n-1
   	     variable_a_wqt=variable_a_wqt.*(mu_n*x*s_n/(variable_n_wqt-s_n));
      	 variable_s_wqt=variable_s_wqt+variable_a_wqt;
      	 variable_b_wqt=variable_b_wqt+vector_q(variable_n_wqt+1)*variable_s_wqt;
   	   end
      
      %Calcula Wq(t)
      wq_t =1-variable_b_wqt.*exp(-mu_n*x*s_n);
      
      
      
      %%Ojo, esto es necesario, ya que si no hay problemas con las dimensiones de las matrices
      clear w_t;
      
      for i=1:length(x)         
   	    w_t(i)=quad('calcular_wt_mmsinfh', 0, x(i), 0.001, [], x(i), s_n, vector_q, h_n, mu_n);
        if (w_t(i)>1)
           w_t(i)=1;
        end       
      end
      
	   clear variable_a_wqt;
   	   clear variable_b_wqt;
   	   clear variable_s_wqt;
       clear variable_n_wqt;


	end


   %Elimina la grafica que habia por defecto y que mostraba el valor
   %de las funciones Wq(t) y W(t) en el intervalo [0..1]
   
	delete(dibujo1)

	dibujo1=axes('Position', [0.17 0.19 0.3 0.3]);
    
    for i=1:length(w_t)
        if (w_t(i)<0)
            w_t(i)=0;
        end
    end
    
    for i=1:length(wq_t)
        if (wq_t(i)<0)
            wq_t(i)=0;
        end
    end
   
    plot(x,w_t,'r-',x,wq_t,'b');
    title('Grafica de W(t) en rojo y Wq(t) en azul');
      
    %clear x;
   
else
                                      
	text_dibujar_error = uicontrol(gcf, 'Style', 'Text', ...
 		 'String', 'Error en los parametros', ...
   		 'Units', 'normalized', ...
         'Position', [0.2 0.535 0.3 0.03], ...
         'BackgroundColor', [0.6 0.6 0.6], ...
         'ForegroundColor', 'r', ...
         'FontUnits', 'normalized', ...
         'FontWeight', 'bold', ...
	   	 'FontSize', 0.5, ...
         'HorizontalAlignment', 'Center');
   
end

  
      
  
      
      