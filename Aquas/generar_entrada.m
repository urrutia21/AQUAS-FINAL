% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  generar_entrada.m

%Devuelve el valor que obtiene la funcion de distribucion de entrada en funcion de
%los parametros que se hallan elegido

function devolver=generar_entrada(distrib_entrada,par_ent_1_n,par_ent_2_n,par_ent_3_n)

switch(distrib_entrada)
case 1,  %Exponencial
   
   l=-1/par_ent_1_n;

	aux=rand;

	devolver=l*log(aux);

case 2, %Uniforme
   
   devolver=unifrnd(par_ent_1_n,par_ent_2_n);
   
case 3, %Deterministica
    
    devolver=par_ent_1_n;
    
case 4, %Gamma
    
    devolver=gamrnd(par_ent_2_n,1/par_ent_1_n);
    
case 5, %Beta
    
    devolver=par_ent_3_n*betarnd(par_ent_1_n,par_ent_2_n);
    
case 6, %Lognormal
    
    devolver=lognrnd(par_ent_1_n,par_ent_2_n);
    
case 7, %Normal, repetimos el calculo hasta que sea >0
    
    aux=-1;
    
    while (aux<0)
        aux=normrnd(par_ent_1_n,par_ent_2_n);
    end
    
    devolver=aux;
    
case 8, %De Weibull
    
    devolver=weibrnd(power(par_ent_1_n,par_ent_2_n),par_ent_2_n);
        
	
end


   