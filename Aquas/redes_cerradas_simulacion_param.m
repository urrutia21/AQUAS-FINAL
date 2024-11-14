% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  redes_cerradas_simulacion_param.m

%Este fichero se encarga de comprobar si los valores 
%introducidos en redes_cerradas son correctos. Si es asi,
%los almacena para su posterior procesamiento, mientras
%que si hay algun tipo de error, vuelve a llamar al
%fichero redes_cerradas para que el usuario los introduzca
%correctamente.




%Recibe el valor del numero de servidores para un nodo de la red
servidores_cerradas_n = get(servidores_cerradas, 'String');
servidores_cerradas_n = str2num(servidores_cerradas_n);

vector_prob_cerradas = [];

for i=1:nodos_cerradas
   prob_cerradas_n = get(prob_cerradas(i), 'String');
   prob_cerradas_n = str2num(prob_cerradas_n);
   vector_prob_cerradas=cat(2,vector_prob_cerradas,prob_cerradas_n);
end

%Si nos encontramos en el primer nodo, creamos unos vectores que 
%almacenaran los valores de numero de servidores para todos los nodos.
%Tambien creamos una matriz que va a almacenar todas las probabilidades
%posibles entre los distintos nodos

if (pasos == 1 & cambiar_parametros_mm==0)
   vector_servidores_cerradas = [];
   matriz_prob_cerradas = [];
end

%Comprobamos si los parametros son correctos:
%el numero de servidores debe ser entero y mayor o igual que cero.
%Cada elemento de las probabilidades de un nodo debe ser mayor o igual que
%cero y la suma de todos ellos debe ser igual que uno.

if (servidores_cerradas_n>0 & ...
      ceil(servidores_cerradas_n)==servidores_cerradas_n & ...
      floor(servidores_cerradas_n)==servidores_cerradas_n & ...
      vector_prob_cerradas>=0 & sum(vector_prob_cerradas)<1.000001 & sum(vector_prob_cerradas)>0.999999)
   
   if (cambiar_parametros_mm==0)
      %Va construyendo un vector con los valores del numero de servidores de todos los nodos
       vector_servidores_cerradas=cat(2,vector_servidores_cerradas,servidores_cerradas_n);
   else
       vector_servidores_cerradas(pasos)=servidores_cerradas_n;
   end
   
   %Va construyendo una matriz con los valores de las probabilidades de ir de un
   %determinado nodo a todos los restantes
   
   if (cambiar_parametros_mm==0)
   
       matriz_prob_cerradas=cat(2,matriz_prob_cerradas,vector_prob_cerradas');
       
   else
       matriz_prob_cerradas(1:nodos_cerradas,pasos)=vector_prob_cerradas';
   end
   
   
   
   
   leer_parametros_simulacion_cerradas;   


   
   else
      
      %Hay algun tipo de Error: Disminuye el numero de pasos y llama a redes_cerradas
      %para que se introduzcan los valores de forma correcta
    
      pasos=pasos-1;
      redes_cerradas_simulacion;
end


