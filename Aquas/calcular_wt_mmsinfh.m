% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcula_wt_mmsinfh.m

%Modelo M/M/s/inf/H

%Calcula el valor de W(t) en un tiempo instante t

%Recibe como parametros el instante de tiempo 
%(tiempo_wt_n), el numero de servidores, el 
%vector q, la poblacion potencial H y el valor de mu


function y=calcular_wt_mmsinfh(x, tiempo_wt_n, s_n, vector_q, h_n, mu_n)

a=calcular_wqt_mmsinfh(tiempo_wt_n-x, s_n, vector_q, h_n, mu_n)*mu_n;

b=(mu_n*x)*(-1);

y=a.*exp(b);