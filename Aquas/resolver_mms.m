% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  resolver_mms.m

%Esta funcion se encarga de recibir como parametros
%los valores de s, lambda y mu de un determinado
%modelo M/M/s y devuelve el valor de lq de dicho
%modelo

function lq=resolver_mms(s, lambda, mu)

c=ones(1,s);
for i=2:s
   c(i)=c(i-1)*lambda/((i-1)*mu);
end

c_mayor_s = c(s)*lambda/(s*mu-lambda);

p_cero = 1/(sum(c)+c_mayor_s);

lq = c_mayor_s*lambda*p_cero/(s*mu-lambda);