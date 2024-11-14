% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  calcula_p_nodo.m

%Esta funcion se encarga de recibir como parametros
%los valores de s, lambda, mu y numero de elementos
%de un determinado modelo M/M/s y devuelve el valor 
%de la probabilidad de que haya ese numero de 
%elementos en dicho nodo

function prob=calcula_p_nodo(s,lambda,mu,n)
%Suposicion de modelo M/M/s en el nodo

%Calculamos el vector c
c=ones(1,s);
for i=2:s
   c(i)=c(i-1)*lambda/((i-1)*mu);
end

c_mayor_s = c(s)*lambda/(s*mu-lambda);

%Calcula el valor de p(0)
p_cero = 1/(sum(c)+c_mayor_s);

%Calcula el valor de p(n)
if(n<s)
   prob=c(n+1)*p_cero;
else
   p_max=c(s)*p_cero;
   prob=power(lambda/(s*mu),n-s+1)*p_max;
end
