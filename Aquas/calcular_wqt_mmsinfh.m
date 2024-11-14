% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcular_wqt_mmsinfh.m

%Modelo M/M/s/inf/H

%Calcula el valor de Wq(t) en un tiempo instante t

%Recibe como parametros el instante de tiempo, el
%numero de servidores, el vector q, la poblacion
%potencial H y el valor de mu



function devolver=calcular_wqt_mmsinfh(instante, s_n, vector_q, h_n, mu_n)

variable_a_wt=1;
variable_s_wt=1;
variable_b_wt=vector_q(s_n+1);
      
for variable_n_wt=s_n+1:h_n-1
   variable_a_wt=variable_a_wt*s_n*mu_n.*instante/(variable_n_wt-s_n);
   variable_s_wt=variable_s_wt+variable_a_wt;
   variable_b_wt=variable_b_wt+vector_q(variable_n_wt+1)*variable_s_wt;
end
      
devolver=1-variable_b_wt.*exp(-mu_n*s_n*instante);
