include "globals.mzn"; 
%entradas
enum ACTORES;
int: n_actores = length(ACTORES);

array[int]              of  int: Duracion;

int: n_escenas = length(Duracion);

array[1..n_actores,1..n_escenas+1] of  int: Escenas;  %arreglo de las escenas con los costos

array[1..n_actores] of var int: costo_x_actor;
array[1..n_escenas] of var 1..n_escenas: orden_escenas;

constraint alldifferent (orden_escenas );

%costo por actor y luego los sumo para minimizarlos.... 
constraint forall( i in 1..n_actores )(
 %encontrar la posicion del primer uno y del ultimo 1 
           % arg_max(Escenas[orden_escenas[i],1..n_escenas]) >= j % retorna la posicion del primer elemento con 1
           % length(Escenas[orden_escenas[i],1..n_escenas]) - arg_max(  reverse(Escenas[orden_escenas[i],1..n_escenas]) + 1) %  retorna la posicion del ultimo elemento con 1
           %en el where de acontinuacion estan ambas condiciones juntas...
 sum(j in 1.. n_escenas where  orden_escenas[j] >= arg_max(Escenas[ i,1..n_escenas])  /\  orden_escenas[j] <= (length(Escenas[i,1..n_escenas]) - arg_max(  reverse(Escenas[i,1..n_escenas]) )  + 1  )   )
                        % Escenas[orden_escenas[i],j] == 1
 ( Duracion[ orden_escenas[j] ]) * Escenas[i,n_escenas+1] = costo_x_actor[i] 
 %sum(j in 1.. n_escenas where Escenas[i,j] == 1  ) (  Duracion[j] )*Escenas[i,n_escenas+1] = costo_x_actor[i] 
 %https://www.minizinc.org/doc-2.4.3/en/lib-builtins.html 
 % arg_max(arreglo) arg_min(arreglo)
 %\/ arg_max()
);


%sum(i in 1..n_escenas, j in 1.. n_actores ) ( Escenas[i][j] )
var  int: f;
 f = sum(i in 1..n_actores ) (costo_x_actor[i] );
solve minimize f;

%show(n_escenas) , show(n_actores), "\n"  , show( Escenas[8,1..n_escenas]),"\n primero:",  show( arg_max(Escenas[8,1..n_escenas])) , " ultimo: ", show( length(Escenas[8,1..n_escenas]) - arg_max(  reverse(Escenas[8,1..n_escenas])) +1 )   ,
 
output [ "costo por actor: "  , show( costo_x_actor), "\norden escenas: " , show(orden_escenas)  ,
 "\n" ,"Costo total: ", show(f) , "\n actor 7" , show( Escenas[7,1..n_escenas]),
 "\n primero:",  show( arg_max(Escenas[7,1..n_escenas])) , " ultimo: ", show( length(Escenas[7,1..n_escenas]) - arg_max(  reverse(Escenas[7,1..n_escenas])) +1 ) 
   ] ;