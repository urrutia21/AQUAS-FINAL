% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  redes_abiertas_comprobar.m

%Este fichero se encarga de comprobar si los valores 
%introducidos en redes_abiertas son correctos. Si es asi,
%los almacena para su posterior procesamiento, mientras
%que si hay algun tipo de error, vuelve a llamar al
%fichero redes_abiertas para que el usuario los introduzca
%correctamente.


%Recibe el valor de lambda para un nodo de la red
lambda_abiertas_n = get(lambda_abiertas, 'String');
lambda_abiertas_n = str2num(lambda_abiertas_n);

%Recibe el valor de mu para un nodo de la red
mu_abiertas_n = get(mu_abiertas, 'String');
mu_abiertas_n = str2num(mu_abiertas_n);

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

if (pasos == 1)
   vector_lambda_abiertas = [];
   vector_mu_abiertas = [];
   vector_servidores_abiertas = [];
   matriz_prob_abiertas = zeros(1,nodos_abiertas+1);
end

%Comprobamos si los parametros son correctos:
%lambda debe ser mayor o igual que cero, mu debe ser mayor o igual que cero,
%el numero de servidores debe ser entero y mayor o igual que cero.
%Cada elemento de las probabilidades de un nodo debe ser mayor o igual que
%cero y la suma de todos ellos debe ser menor o igual que uno.

if (lambda_abiertas_n >=0 & mu_abiertas_n>=0 & servidores_abiertas_n>0 & ...
      ceil(servidores_abiertas_n)==servidores_abiertas_n & ...
      floor(servidores_abiertas_n)==servidores_abiertas_n & ...
      vector_prob_abiertas>=0 & sum(vector_prob_abiertas)<=1)
   
   %Va construyendo un vector con los valores de lambda de todos los nodos
   vector_lambda_abiertas=cat(2,vector_lambda_abiertas,lambda_abiertas_n);
   
   %Va construyendo un vector con los valores de mu de todos los nodos
   vector_mu_abiertas=cat(2,vector_mu_abiertas,mu_abiertas_n);
   
   %Va construyendo un vector con los valores del numero de servidores de todos los nodos
   vector_servidores_abiertas=cat(2,vector_servidores_abiertas,servidores_abiertas_n);
   
   %Va construyendo una matriz con los valores de las probabilidades de ir de un
   %determinado nodo a todos los restantes
   matriz_prob_abiertas=cat(1,matriz_prob_abiertas,cat(2,0,vector_prob_abiertas));

	%Llama a redes_abiertas para leer los parametros de otro nodo de la red   
   redes_abiertas;
   
   else
      
      %Hay algun tipo de Error: Disminuye el numero de pasos y llama a redes_abiertas
      %para que se introduzcan los valores de forma correcta
    
      pasos=pasos-1;
      redes_abiertas;
end


%Ya hemos leido los datos de todos los nodos que forman la red.
if (pasos > nodos_abiertas)
   
   %Suma los valores de lambda de todos los nodos
   suma_lambda_abiertas=sum(vector_lambda_abiertas);
   
   %Rellena elementos de la matriz de probabilidades
   for i=1:nodos_abiertas
      matriz_prob_abiertas(1,i+1)=vector_lambda_abiertas(i)/suma_lambda_abiertas;
   end
   
   for i=1:nodos_abiertas
      matriz_prob_abiertas(i+1,1)=1-sum(matriz_prob_abiertas(i+1,2:nodos_abiertas+1));
   end
   
   %Calcula la matriz a
   a=matriz_prob_abiertas(2:(nodos_abiertas+1),2:(nodos_abiertas+1))'*(-1);
   
   for i=1:nodos_abiertas
      a(i,i)=1+a(i,i);
   end
   
   %Si la matriz "a" tiene un determinante igual a cero, la red de colas no es
   %estacionario. Llamamos al fichero redes_abiertas_no_estacionario que se lo
   %advierte al usuario.
   
   if (det(a) == 0)
      clear a;
      clear lambda_abiertas_n;
      clear mu_abiertas_n;
      clear servidores_abiertas_n;
      clear vector_prob_abiertas;
      clear prob_abiertas_n;
      clear pasos;

      
      redes_abiertas_no_estacionario;
   else           
      %El determinante de la matriz "a" es distinto de cero.
      
      %Calcula el valor de lambda_mayuscula
      
      lambda_mayuscula = inv(a)*vector_lambda_abiertas';
      
      clear lambda_abiertas_n;
      clear mu_abiertas_n;
      clear servidores_abiertas_n;
      clear vector_prob_abiertas;
      clear prob_abiertas_n;
      clear pasos;
      clear a;
      
      %Si lambda_mayuscula(i)<s(i)*mu(i) para todo i, entonces el
      %modelo es estacionario. Llamamos al fichero redes_abiertas_salida para
      %mostrar los valores
      
   	if ((lambda_mayuscula)'<(vector_servidores_abiertas.*vector_mu_abiertas)) 
      	redes_abiertas_salida;
      else
         
         %Si no se da la condicion anteriormente comentada, el modelo no
         %es estacionario, con lo que llamamos al fichero 
         %redes_abiertas_no_estacionario
   	   redes_abiertas_no_estacionario;
      end
      
   end
      
end