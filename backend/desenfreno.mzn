% aqui va el modelo

include "globals.mzn"; 
%entradas
enum ACTORES;
int: n_actores = length(ACTORES);

array[int] of  int: Duracion;

int: n_escenas = length(Duracion);

array[1..n_actores,1..n_escenas+1] of  int: Escenas;  %arreglo de las escenas con los costos

array[1..n_actores] of var int: costo_x_actor;
array[1..n_escenas] of var 1..n_escenas: orden_escenas;
array[1..n_escenas] of var int: costo_x_escena;
constraint alldifferent (orden_escenas );

%costo por actor y luego los sumo para minimizarlos.... 
constraint forall( i in 1..n_actores )(
 %encontrar la posicion del primer uno y del ultimo 1 
           % arg_max(Escenas[orden_escenas[i],1..n_escenas]) >= j % retorna la posicion del primer elemento con 1
           % length(Escenas[orden_escenas[i],1..n_escenas]) - arg_max(  reverse(Escenas[orden_escenas[i],1..n_escenas]) + 1) %  retorna la posicion del ultimo elemento con 1
           %en el where de acontinuacion estan ambas condiciones juntas...
 sum(j in 1.. n_escenas where  orden_escenas[j] >= arg_max(Escenas[ i,1..n_escenas])  /\  orden_escenas[j] <= (length(Escenas[i,1..n_escenas]) - arg_max(  reverse(Escenas[i,1..n_escenas]) )  + 1  )   )
 ( Duracion[ orden_escenas[j] ]) * Escenas[i,n_escenas+1] = costo_x_actor[i] 
);

constraint forall( i in 1..n_escenas )( 
    sum(j in 1.. n_actores) ( Escenas[j,i] * Escenas[j,n_escenas+1]  )* Duracion[i]   = costo_x_escena[i]  
);
var  int: costo_minimo;

constraint sum(i in 1..n_escenas) (costo_x_escena[i]  ) = costo_minimo;

var  int: f;

 f = sum(i in 1..n_actores ) (costo_x_actor[i] );
 
constraint f >= costo_minimo ;

 % indomain_min,indomain_median,indomain_random,indomain_split
 % input_order, first_fail,smallest,dom_w_deg
%solve :: int_search(orden_escenas, first_fail, indomain_min)  minimize f;

solve :: int_search(orden_escenas, dom_w_deg, indomain_random)  minimize f;
%solve minimize f;
%solve minimize f;
%show(n_escenas) , show(n_actores), "\n"  , show( Escenas[8,1..n_escenas]),"\n primero:",  show( arg_max(Escenas[8,1..n_escenas])) , " ultimo: ", show( length(Escenas[8,1..n_escenas]) - arg_max(  reverse(Escenas[8,1..n_escenas])) +1 )   ,
 
output [ "costo por actor: "  , show( costo_x_actor), "\norden escenas: " , show(orden_escenas)  ,"\n costo por escena: " , show(costo_x_escena),
 "\n" ,"Costo total: ", show(f) , "\n" ,"Costo minimo: ", show(costo_minimo)
   ] ;
