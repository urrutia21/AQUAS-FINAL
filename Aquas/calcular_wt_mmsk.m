% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcula_wt_mmsk.m

%Modelo M/M/s/K

%Calcula el valor de W(t) en un tiempo instante t

%Recibe como parametros el instante de tiempo 
%(tiempo_wt_n), el numero de servidores, el 
%vector q, el tamanho de la cola K y el valor de mu


function y=calcular_wt_mmsk(x, tiempo_wt_n, s_n, vector_q, k_n, mu_n)

a=calcular_wqt_mmsk(tiempo_wt_n-x, s_n, vector_q, k_n, mu_n)*mu_n;

b=(mu_n*x)*(-1);

y=a.*exp(b);
