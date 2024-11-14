% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  generar_salida.m

%Devuelve el valor obtenido por la funcion de distribucion de servicio en funcion de
%los parametros de la distribucion

function devolver=generar_salida(distrib_salida,par_sal_1_n,par_sal_2_n,par_sal_3_n)

switch(distrib_salida)
case 1,  %Exponencial
   
   l=-1/par_sal_1_n;

	aux=rand;

	devolver=l*log(aux);

case 2, %Uniforme
   
   devolver=unifrnd(par_sal_1_n,par_sal_2_n);
   
case 3, %Deterministica
    
    devolver=par_sal_1_n;
    
case 4, %Gamma
    
    devolver=gamrnd(par_sal_2_n,1/par_sal_1_n);
    
case 5, %Beta
    
    devolver=par_sal_3_n*betarnd(par_sal_1_n,par_sal_2_n);
    
case 6, %Lognormal
    
    devolver=lognrnd(par_sal_1_n,par_sal_2_n);
    
case 7, %Normal, repetimos el calculo hasta ser >0
    
    aux=-1;
    
    while (aux<0)
        aux=normrnd(par_sal_1_n,par_sal_2_n);
    end
    
    devolver=aux;
    
case 8, %De Weibull
    
    devolver=weibrnd(power(par_sal_1_n,par_sal_2_n),par_sal_2_n);	
end
