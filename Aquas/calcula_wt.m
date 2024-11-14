% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcula_wt.m

%Calcula el valor de la funcion de distribucion W(t)
%para un determinado instante del tiempo y para un
%determinado modelo: M/M/1, M/M/s, M/M/1/k o 
%M/M/1/inf/H

%Para los modelos: M/M/s/K, M/M/s/inf/H y M/M/s/inf/H
%con Y repuestos, se calcula evaluando una integral 
%utilizando un metodo numerico
%(ver calcular_wt_mmsk.m o calcular_wt_mmsinfh)


%Recibe el valor del instante de tiempo en el cual
%queremos calcular W(t)


tiempo_wt_n = get(tiempo_wt, 'String');
tiempo_wt_n = str2num(tiempo_wt_n);


%Realiza los calculos si el instante de tiempo es positivo

if(tiempo_wt_n>=0) 
   
   
   switch eleccion
   case 1,
      %Modelo M/M/1
            
      valor_wt_n=1-exp(-(mu_n-lambda_n)*tiempo_wt_n);
                  
   case 2,
      %Modelo M/M/s
      
      if (lambda_n/mu_n == (s_n-1))
         valor_wt_n = 1 -(1+c_mayor_s*p_cero*tiempo_wt_n*mu_n)*exp(-mu*tiempo_wt_n);
         
      else
         
         wq_cero = 1-c_mayor_s*p_cero;
         
         valor_wt_n = 1 + ...
         (lambda_n-s_n*mu_n+mu_n*wq_cero)/(s_n*mu_n-lambda_n-mu_n)*...
         exp(-(mu_n*tiempo_wt_n)) +...
         (c_mayor_s*mu_n*p_cero)/(s_n*mu_n-lambda_n-mu_n)*...
         exp(-(s_n*mu_n-lambda_n)*tiempo_wt_n);
      
   	end
      
   case 3,
      %Modelo M/M/1/k
      
      variable_a_wt=1;
      variable_s_wt=1;
      variable_b_wt=vector_q(1);
      
      for variable_n_wt=1:k_n
         variable_a_wt=variable_a_wt*mu_n*tiempo_wt_n/variable_n_wt;
         variable_s_wt=variable_s_wt+variable_a_wt;
         variable_b_wt=variable_b_wt+vector_q(variable_n_wt+1)*variable_s_wt;
      end
      
      valor_wt_n=1-variable_b_wt*exp(-mu_n*tiempo_wt_n);
      
      
      clear variable_a_wt;
      clear variable_s_wt;
      clear variable_b_wt;
      clear variable_n_wt; 
      
   case 4,
      %Modelo M/M/s/k
            
		valor_wt_n=quad('calcular_wt_mmsk',0,tiempo_wt_n, 0.001, [], tiempo_wt_n, s_n, vector_q, k_n, mu_n);
        if (valor_wt_n>1)
          valor_wt_n=1;
        end
      
            
   case 5,
      %Modelo M/M/1/inf/h
      
      variable_a_wt=1;
	  variable_s_wt=1;
	  variable_b_wt=vector_q(1);
      
	  for variable_n_wt=1:h_n-1
   	    variable_a_wt=variable_a_wt*(mu_n*tiempo_wt_n/variable_n_wt);
      	variable_s_wt=variable_s_wt+variable_a_wt;
      	variable_b_wt=variable_b_wt+vector_q(variable_n_wt+1)*variable_s_wt;
   	  end
      
      valor_wt_n =1-variable_b_wt*exp(-mu_n*tiempo_wt_n);
      
      clear variable_a_wt;
      clear variable_s_wt;
      clear variable_b_wt;
      clear variable_n_wt;
      
   case 6,      
      %Modelo M/M/s/inf/H
            
      valor_wt_n=quad('calcular_wt_mmsinfh',0,tiempo_wt_n, 0.001, [], tiempo_wt_n, s_n, vector_q, h_n, mu_n);
      if (valor_wt_n>1)
          valor_wt_n=1;
      end
      
   case 7,      
      %Modelo M/M/s/inf/H con Y repuestos
            
		valor_wt_n=quad('calcular_wt_mmsinfh',0,tiempo_wt_n, 0.001, [], tiempo_wt_n, s_n, vector_q, h_n, mu_n);
        if (valor_wt_n>1)
          valor_wt_n=1;
        end
   
   end
   
   %Mostramos por pantalla el valor de W(t), para un determinado instante de
   %tiempo y para un determinado modelo
   
   if (valor_wt_n<0)
       valor_wt_n=0;
   end
   
   if (tiempo_wt_n==0)
       valor_wt_n=0;
   end
   
   valor_wt_n=num2str(valor_wt_n);
      
   set(valor_wt, 'String', valor_wt_n);
   
else
   
   %Si no se ha introducido un numero mayor o igual que cero
   %mostramos por pantalla el mensaje de error.
   
   valor_wt_n = 'Error';
      
   set(valor_wt, 'String', valor_wt_n);


   
end
