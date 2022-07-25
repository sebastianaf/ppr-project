include "globals.mzn"; 

%Entradas
enum ACTORES;
int: n_actores = length(ACTORES);
array[int] of int: Duracion;
int: n_escenas = length(Duracion);
array[1..n_actores,1..n_escenas+1] of  int:    Escenas;  %arreglo de las escenas con los costos

%Variables
var int: costo_total;
array[1..n_escenas] of var 1..n_escenas: orden_escenas;
array[1..n_actores,1..n_escenas] of var 0..1: Escenas_;  %variable arreglo de las escenas sin los costos
array[1..n_actores] of var int: costo_x_actor;
array[1..n_actores] of var int: cant_escenas_x_actor;
array[1..n_escenas] of var int: costo_x_escena;
var int: costo_maximo;
array[1..n_escenas] of var int: costo_costo_maximo_x_escena;

%Escenas_ = Escenas[1..n_actores,1..n_escenas];

%Restricciones
constraint alldifferent (orden_escenas );

constraint  forall(i in 1..n_escenas)( 
    orden_escenas[i] >= 1  /\  orden_escenas[i] <= n_escenas 
);


constraint forall(i in 1..n_actores) ( 
    forall(j in 1..n_escenas) ( Escenas_[i, j ] = Escenas[i, orden_escenas[j] ]  )
);


function var int: 
  primera_escena(int: actor) = 
    arg_max(Escenas_[actor,1..n_escenas]);

function var int: 
  ultima_escena(int: actor) = 
    length(Escenas_[actor,1..n_escenas]) - 
    arg_max(reverse(Escenas_[actor,1..n_escenas]))+1;

%costo por actor 
constraint forall( i in 1..n_actores )(
  sum(j in 1.. n_escenas where  
    j >= primera_escena(i)  /\  j <= ultima_escena(i))(
      Duracion[orden_escenas[j]] ) * 
      Escenas[i,n_escenas+1] = costo_x_actor[i]);

%costo por actor continuacion
%constraint forall( i in 1..n_actores )(
% forall(j in 1.. n_escenas where  orden_escenas[j] >= arg_max(Escenas_[ i,1..n_escenas])  /\  orden_escenas[j] <= (length(Escenas_[i,1..n_escenas]) - arg_max(  reverse(Escenas_[i,1..n_escenas]) ) +1  )   )
% (  Escenas_[i, orden_escenas[j] ] =  Escenas[i, orden_escenas[j] ]  )     
%);


constraint forall( i in 1..n_escenas  )( 
    sum(j in 1.. n_actores   ) 
    ( Escenas_[j,orden_escenas[i]] * Escenas[j,n_escenas+1]  )* Duracion[orden_escenas[i]]   = costo_x_escena[i] 
);

constraint forall( i in 1..n_escenas )( 
    sum(j in 1.. n_actores) (  Escenas[j,n_escenas+1]  )* Duracion[i]   = costo_costo_maximo_x_escena[i]  
);

% peor caso es que los actores vayan a todas las escenas   - cota superior
constraint sum(i in 1..n_escenas) (costo_costo_maximo_x_escena[i]  ) = costo_maximo;

%constraint sum(costo_x_escena) = costo_total;
constraint sum(costo_x_actor)= costo_total;

 % indomain_min,indomain_median,indomain_random,indomain_split
 % input_order, first_fail,smallest,dom_w_deg
%solve :: int_search(orden_escenas, first_fail, indomain_min)  minimize costo_total;

solve :: int_search(orden_escenas, dom_w_deg, indomain_min)  minimize costo_total;


%solve minimize f;
%solve maximize f;
%show(n_escenas) , show(n_actores), "\n"  , show( Escenas[8,1..n_escenas]),"\n primero:",  show( arg_max(Escenas[8,1..n_escenas])) , " ultimo: ", show( length(Escenas[8,1..n_escenas]) - arg_max(  reverse(Escenas[8,1..n_escenas])) +1 )   ,
 
output [ "costo por actor: "  , show( costo_x_actor), "\norden escenas: " , show(orden_escenas)  ,"\ncosto por escena: " , show(costo_x_escena),
 "\n" ,"Costo total: ", show(costo_total) , "\n" ,"Costo minimo posible: ", show(costo_total) , "\n" ,"Costo maximo posible: ", show(costo_maximo) ,"\n",
  show( Escenas_[2,1..n_escenas]),"\n primero:",  show( arg_max(Escenas_[2,1..n_escenas])) , " ultimo: ", show( length(Escenas_[2,1..n_escenas]) - arg_max(  reverse(Escenas_[2,1..n_escenas])) +1 ) ,"\n"  %, "\n cantidad escenas por actor: " , show(cant_escenas_x_actor)

   ] ;
%n_escenas

output [ "\n ESCENAS \n"];
output [ show_int(1,orden_escenas[i])++" " |i in 1..n_escenas ] ++[ "\n"];
output  [ show_int(1,Escenas_[i,j]) ++ " " ++ 
         if j == n_escenas then
             if i != n_escenas then 
                 "\n" endif 
         else "" endif    
         | i in 1..n_actores,j in 1..n_escenas ] ++ ["\n"];
