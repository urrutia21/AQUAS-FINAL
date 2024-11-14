% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  redes_abiertas_simulacion_param.m

%Este fichero se encarga de comprobar si los valores 
%introducidos en redes_abiertas son correctos. Si es asi,
%los almacena para su posterior procesamiento, mientras
%que si hay algun tipo de error, vuelve a llamar al
%fichero redes_abiertas para que el usuario los introduzca
%correctamente.






%Recibe el valor del numero de servidores para un nodo de la red
servidores_abiertas_n = get(servidores_abiertas, 'String');
servidores_abiertas_n = str2num(servidores_abiertas_n);

vector_prob_abiertas = [];

for i=1:nodos_abiertas
	prob_abiertas_n = get(prob_abiertas(i), 'String');
   prob_abiertas_n = str2num(prob_abiertas_n);
   vector_prob_abiertas=cat(2,vector_prob_abiertas,prob_abiertas_n);
end

%Si nos encontramos en el primer nodo, creamos unos vectores que 
%almacenaran los valores de lambda, mu y numero de servidores para todos los nodos.
%Tambien creamos una matriz que va a almacenar todas las probabilidades
%posibles entre los distintos nodos

if (pasos == 1 & cambiar_parametros_mm==0)
   vector_servidores_abiertas = [];
   matriz_prob_abiertas = [];
end

%Comprobamos si los parametros son correctos:
%lambda debe ser mayor o igual que cero, mu debe ser mayor o igual que cero,
%el numero de servidores debe ser entero y mayor o igual que cero.
%Cada elemento de las probabilidades de un nodo debe ser mayor o igual que
%cero y la suma de todos ellos debe ser menor o igual que uno.

if (servidores_abiertas_n>0 & ...
      ceil(servidores_abiertas_n)==servidores_abiertas_n & ...
      floor(servidores_abiertas_n)==servidores_abiertas_n & ...
      vector_prob_abiertas>=0 & sum(vector_prob_abiertas)<=1)
   
   if (cambiar_parametros_mm==0)
      %Va construyendo un vector con los valores del numero de servidores de todos los nodos
       vector_servidores_abiertas=cat(2,vector_servidores_abiertas,servidores_abiertas_n);
   else
       vector_servidores_abiertas(pasos)=servidores_abiertas_n;
   end
   
   %Va construyendo una matriz con los valores de las probabilidades de ir de un
   %determinado nodo a todos los restantes
   
   if (cambiar_parametros_mm==0)
       vector_columna=cat(2,0,vector_prob_abiertas)';
   
       matriz_prob_abiertas=cat(2,matriz_prob_abiertas,vector_columna);
       
   else
       matriz_prob_abiertas(2:nodos_abiertas+1,pasos)=vector_prob_abiertas';
   end
   
   
   
   
   leer_parametros_simulacion_abiertas;   


   
   else
      
      %Hay algun tipo de Error: Disminuye el numero de pasos y llama a redes_abiertas
      %para que se introduzcan los valores de forma correcta
    
      pasos=pasos-1;
      redes_abiertas_simulacion;
end


