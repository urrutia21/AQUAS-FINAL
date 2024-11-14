% PROYECTO FIN DE CARRERA - Jorge L. Vega Valle
% Fichero  intercambiar_cerradas.m.m

% Intercambia los valores de dos nodos de la red cerrada


%vector_mu_cerradas
%vector_servidores_cerradas
%matriz_prob_cerradas

%Intercambia los valores de mu de las posiciones nodos_cerradas y
%nodo_intercambia

aux=vector_mu_cerradas(nodos_cerradas);

vector_mu_cerradas(nodos_cerradas)=vector_mu_cerradas(nodo_intercambia);

vector_mu_cerradas(nodo_intercambia)=aux;

%vector_mu_cerradas

%Intercambia los valores de servidores de las posiciones nodos_cerradas y
%nodo_intercambia

aux=vector_servidores_cerradas(nodos_cerradas);

vector_servidores_cerradas(nodos_cerradas)=vector_servidores_cerradas(nodo_intercambia);

vector_servidores_cerradas(nodo_intercambia)=aux;

%Intercambia los valores de matriz de probabilidades de las posiciones nodos_cerradas y
%nodo_intercambia

for i=1:nodos_cerradas
   
   aux=matriz_prob_cerradas(nodo_intercambia,i);
   
   if (i==nodo_intercambia)
      matriz_prob_cerradas(nodo_intercambia,i)=matriz_prob_cerradas(nodos_cerradas,nodos_cerradas);
   else        
      if (i==nodos_cerradas)
         matriz_prob_cerradas(nodo_intercambia,i)=matriz_prob_cerradas(nodos_cerradas,nodo_intercambia);
		else
         matriz_prob_cerradas(nodo_intercambia,i)=matriz_prob_cerradas(nodos_cerradas,i);
      end
      
   end
   
   if (i==nodo_intercambia)
   	matriz_prob_cerradas(nodos_cerradas,nodos_cerradas)=aux;
   else
      if (i==nodos_cerradas)
         matriz_prob_cerradas(nodos_cerradas,nodo_intercambia)=aux;
		else         
         matriz_prob_cerradas(nodos_cerradas,i)=aux;
      end      
   end      
end

for i=1:nodos_cerradas-1
   if (i~=nodo_intercambia)
      
      aux=matriz_prob_cerradas(i,nodos_cerradas);
      
      matriz_prob_cerradas(i,nodos_cerradas)=matriz_prob_cerradas(i,nodo_intercambia);
      
      matriz_prob_cerradas(i,nodo_intercambia)=aux;
   end
end




      
      
   
   