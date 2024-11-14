% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcular_f_cerradas.m

%Devuelve el valor de la funcion f, definida
%para las redes de colas cerradas

%Parametros que se le pasan:
%n:  parametro numerico
%ro: valor de ro de un determinado nodo
%s:  numero de servidores de un determinado nodo

function devolver_f=calcular_f_cerradas(n,ro,s)

%Asi f1(n) si el nodo 1 tiene 5 servidores y el
%valor de ro en el nodo 1 es de 3 se calcularia como:
%calcular_f(n,ro(1),s(1)) = calcular_f(n,3,5)

%NOTESE QUE EL ARGUMENTO 1 de f1, NO SE PASA!!!

devolver_f=power(ro,n)/calcular_a_cerradas(s,n);