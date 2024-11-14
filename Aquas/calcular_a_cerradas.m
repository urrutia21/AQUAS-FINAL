% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcular_a_cerradas.m


%Devuelve el valor de la funcion a, definida
%para las redes de colas cerradas

%Parametros que se le pasan:
%s: numero de servidores del nodo
%n: parametro numerico


function devolver_a=calcular_a_cerradas(s,n)

%El primer argumento, s corresponde a los servidores que tiene el nodo

%Asi a1(n) si el nodo 1 tiene 5 servidores se calcularia como:
%calcular_a(5,n)

%NOTESE QUE EL ARGUMENTO 1 de a1, NO SE PASA!!!


if(n<=s)
   devolver_a=prod(1:n);
else
   devolver_a=prod(1:s)*power(s,(n-s));
end
