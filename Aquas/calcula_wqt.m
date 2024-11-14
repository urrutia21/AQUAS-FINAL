% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcula_wqt.m

%Calcula el valor de la funcion de distribucion Wq(t)
%para un determinado instante del tiempo y para un
%determinado modelo: M/M/1, M/M/s, M/M/1/k, M/M/s/k, 
%M/M/1/inf/H, M/M/s/inf/H o M/M/s/inf/H con Y repuestos


%Recibe el valor del instante de tiempo en el cual
%queremos calcular Wq(t)

tiempo_wqt_n = get(tiempo_wqt, 'String');
tiempo_wqt_n = str2num(tiempo_wqt_n);


%Realiza los calculos si el instante de tiempo es positivo

if(tiempo_wqt_n>=0)
   
   switch eleccion
	case 1,
      %Modelo M/M/1
  
      valor_wqt_n=1-(lambda_n/mu_n)*exp(-(mu_n-lambda_n)*tiempo_wqt_n);
      
   case 2,
      %Modelo M/M/s
      
      valor_wqt_n = 1 - c_mayor_s*p_cero*exp(-(s_n*mu_n-lambda_n)*tiempo_wqt_n);
      
   case 3,
      %Modelo M/M/1/k
            
      variable_a_wqt=1;
      variable_s_wqt=1;
      if (k_n==0)
      	variable_b_wqt=0;
   	  else
         variable_b_wqt=vector_q(2);
      end
      
      
      for variable_n_wqt=2:k_n
         variable_a_wqt=variable_a_wqt*mu_n*tiempo_wqt_n/variable_n_wqt;
         variable_s_wqt=variable_s_wqt+variable_a_wqt;
         variable_b_wqt=variable_b_wqt+vector_q(variable_n_wqt+1)*variable_s_wqt;
      end
      
      valor_wqt_n=1-variable_b_wqt*exp(-mu_n*tiempo_wqt_n);
      
            
      clear variable_a_wqt;
      clear variable_s_wqt;
      clear variable_b_wqt;
      clear variable_n_wqt;
      
   case 4,
      %Modelo M/M/s/k
      
      variable_a_wqt=1;
      variable_s_wqt=1;
      if (k_n==0)
      	variable_b_wqt=0;
   	  else
         variable_b_wqt=vector_q(s_n+1);
      end
      
      
	  for variable_n_wqt=s_n+1:k_n+s_n-1
   	    variable_a_wqt=variable_a_wqt*(mu_n*tiempo_wqt_n*s_n/(variable_n_wqt-s_n));
      	variable_s_wqt=variable_s_wqt+variable_a_wqt;
      	variable_b_wqt=variable_b_wqt+vector_q(variable_n_wqt+1)*variable_s_wqt;
      end
      
   	  valor_wqt_n =1-variable_b_wqt*exp(-mu_n*tiempo_wqt_n*s_n);

      clear variable_a_wqt;
      clear variable_s_wqt;
      clear variable_b_wqt;
      clear variable_n_wqt;
      
   case 5,
      %Modelo M/M/1/inf/h
      
      variable_a_wqt=1;
      variable_s_wqt=1;
      if (h_n==1)
         variable_b_wqt=0;
      else         
         variable_b_wqt=vector_q(2);
      end
      
      
	  for variable_n_wqt=2:h_n-1
   	    variable_a_wqt=variable_a_wqt*(mu_n*tiempo_wqt_n/variable_n_wqt);
      	variable_s_wqt=variable_s_wqt+variable_a_wqt;
      	variable_b_wqt=variable_b_wqt+vector_q(variable_n_wqt+1)*variable_s_wqt;
      end
      
      valor_wqt_n =1-variable_b_wqt*exp(-mu_n*tiempo_wqt_n);

      clear variable_a_wqt;
      clear variable_s_wqt;
      clear variable_b_wqt;
      clear variable_n_wqt;
      
   case 6,
      %Modelo M/M/s/inf/H
      
      variable_a_wqt=1;
   	  variable_s_wqt=1;
	  variable_b_wqt=vector_q(s_n+1);

      
	  for variable_n_wqt=s_n+1:h_n-1
   	    variable_a_wqt=variable_a_wqt*(mu_n*tiempo_wqt_n*s_n/(variable_n_wqt-s_n));
      	variable_s_wqt=variable_s_wqt+variable_a_wqt;
      	variable_b_wqt=variable_b_wqt+vector_q(variable_n_wqt+1)*variable_s_wqt;
      end
      
   	  valor_wqt_n =1-variable_b_wqt*exp(-mu_n*tiempo_wqt_n*s_n);

      clear variable_a_wqt;
      clear variable_s_wqt;
      clear variable_b_wqt;
      clear variable_n_wqt;
      
   case 7,
      %Modelo M/M/s/inf/H con Y repuestos
      
      variable_a_wqt=1;
   	  variable_s_wqt=1;
	  variable_b_wqt=vector_q(s_n+1);

      
	  for variable_n_wqt=s_n+1:h_n-1
   	    variable_a_wqt=variable_a_wqt*(mu_n*tiempo_wqt_n*s_n/(variable_n_wqt-s_n));
      	variable_s_wqt=variable_s_wqt+variable_a_wqt;
      	variable_b_wqt=variable_b_wqt+vector_q(variable_n_wqt+1)*variable_s_wqt;
      end
      
   	  valor_wqt_n =1-variable_b_wqt*exp(-mu_n*tiempo_wqt_n*s_n);

      clear variable_a_wqt;
      clear variable_s_wqt;
      clear variable_b_wqt;
      clear variable_n_wqt;

      
	end


   %Mostramos por pantalla el valor de Wq(t), para un determinado instante de
   %tiempo y para un determinado modelo
   
   if valor_wqt_n<0
       valor_wqt_n=0;
   end

   valor_wqt_n=num2str(valor_wqt_n);
      
   set(valor_wqt, 'String', valor_wqt_n);
   
else
   
   %Si no se ha introducido un numero mayor o igual que cero
   %mostramos por pantalla el mensaje de error.

   
   valor_wqt_n='Error';
      
   set(valor_wqt, 'String', valor_wqt_n);

end
