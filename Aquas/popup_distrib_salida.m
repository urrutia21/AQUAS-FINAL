% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  popup_distrib_salida.m


% La variable distrib_salida se encarga de almacenar
% el valor numerico asociado a la distribucion 
% elegida para la salida del modelo de colas (entre 1-8)

%1=Exponencial, 2=Uniforme, 3=Determinista, 4=Gamma, 5=Beta, 6=Lognormal,
%7=Normal, 8=De Weibull

distrib_salida = get(popup_distribucion_salida, 'Value');

