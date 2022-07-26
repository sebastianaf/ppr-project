include "globals.mzn"; 

%Entradas
enum ACTORES;
int: n_actores = length(ACTORES);
array[int] of int: Duracion;
int: n_escenas = length(Duracion);
array[1..n_actores,1..n_escenas+1] of int: Escenas;

%Variables
array[1..n_escenas] of var 1..n_escenas: orden_escenas;
array[1..n_actores,1..n_escenas] of var 0..1: Escenas_;
array[1..n_actores] of var int: costo_x_actor;
var int: costo_total = sum(costo_x_actor);
array[1..n_escenas] of var int: costo_x_escena;
array[1..n_escenas] of var int: costo_maximo_x_escena;
var  int: costo_maximo = sum(i in 1..n_escenas) (costo_maximo_x_escena[i]);

%Variables adicionales
array[1..n_actores] of var int: cant_escenas_x_actor;
array[int,1..2] of int: Disponibilidad;
array[int,1..2] of int: Evitar;
array[1..n_actores] of var int:  tiempo_x_actor;
array[1..n_actores] of var int:  tiempo_min_x_actor;
array[1..n_actores] of var 0..1: disponibilidad_x_actor_no_cumplida;

%Funciones
function var int: 
  primera_escena(int: actor) = 
    arg_max(Escenas_[actor,1..n_escenas]);

function var int: 
  ultima_escena(int: actor) = 
    length(Escenas_[actor,1..n_escenas]) - 
    arg_max(reverse(Escenas_[actor,1..n_escenas]))+1;

% Restricciones
constraint alldifferent (orden_escenas );

constraint  forall(i in 1..n_escenas)( 
    orden_escenas[i] >= 1  /\  orden_escenas[i] <= n_escenas 
);

constraint forall(i in 1..n_actores)( 
    forall(j in 1..n_escenas)(
      Escenas_[i,j] = Escenas[i,orden_escenas[j]]));

constraint forall( i in 1..n_actores )(
  sum(j in 1.. n_escenas where  
    j >= primera_escena(i)  /\  j <= ultima_escena(i))(
      Duracion[orden_escenas[j]] ) * 
      Escenas[i,n_escenas+1] = costo_x_actor[i]);

constraint forall( i in 1..n_escenas)(
    sum(j in 1.. n_actores)(
      Escenas_[j,orden_escenas[i]] *  
      Escenas[j,n_escenas+1]) *
      Duracion[orden_escenas[i]] = costo_x_escena[i]);

constraint forall( i in 1..n_escenas )( 
    sum(j in 1.. n_actores)( 
      Escenas[j,n_escenas+1])* Duracion[i] =
      costo_maximo_x_escena[i]);





%Restricciones adicionales

constraint symmetry_breaking_constraint(costo_total < costo_maximo);
%constraint f < costo_maximo; % - cota superior
constraint symmetry_breaking_constraint(costo_total >= sum(costo_x_escena));
%constraint f >= sum(costo_x_escena); % - cota inferior 
 
%restricciones adicionales inicio----------------

%calculamos el tiempo que estara cada actor 
constraint forall( i in 1..n_actores  )( 
    sum(j in 1.. n_escenas   ) 
    %( Escenas_[j,orden_escenas[i]] * Escenas[j,n_escenas+1]  )* Duracion[orden_escenas[i]]   = costo_x_escena[i] 
    ( Duracion[orden_escenas[j]] * Escenas_[i,j] )  = tiempo_x_actor[i]

);
%consultamos el tiempo minimo que debe ir cada actor 
constraint forall( i in 1..n_actores  )( 
    sum(j in 1.. n_escenas   ) 
    %( Escenas_[j,orden_escenas[i]] * Escenas[j,n_escenas+1]  )* Duracion[orden_escenas[i]]   = costo_x_escena[i] 
    ( Duracion[j] * Escenas[i,j] )  = tiempo_min_x_actor[i]

);

int: n = round(length(Disponibilidad)/2);
%restringimos el tiempo que estara cada actor - haciendo que solo se cumplan cuando cumple con el tiempo minimo...
% ej: en trivial2 hay un actor con disponibilidad 0 y eso es imposible :v

constraint forall( i in 1..n  )(  % exists or forall  or among
      if  tiempo_min_x_actor[i]  <= Disponibilidad[i,2]  then   tiempo_x_actor[i] <= Disponibilidad[i,2]    else disponibilidad_x_actor_no_cumplida[i] = 1 endif
);

%calculamos que evitar se pueden cumplir y cuales no teniendo en cuenta la entrada en Escenas
%calcula si la pareja de actores  se requieren para alguna escena

int: m = round (length(Evitar)/2);
var  int: x;
array[1..m] of var 0..1: evitar_no_cumplibles; % arreglo de 0 y unos donde los que tengan  1 es porque no se pueden cumplir  teniendo en cuenta la entrada en Escenas
%constraint forall(i in 1..n_escenas)(
%        forall(j in 1..m) ( if Escenas[Evitar[j,1],i] ==  Escenas[Evitar[j,2],i] then evitar_no_cumplibles[j] = 1   endif )
%);
constraint forall(j in 1..m, i in 1..n_escenas where Escenas[Evitar[j,1],i] == 1 /\ Escenas[Evitar[j,1],i] ==  Escenas[Evitar[j,2],i]) (
    evitar_no_cumplibles[j] = 1
);

constraint exists( i in 1..m, j in 1..n_escenas  where evitar_no_cumplibles[i] == 0   )(                      
            Escenas_[Evitar[i,1],j] !=  Escenas_[Evitar[i,2],j]       
);

%restricciones adicionales final----------------
% estrategias de busqueda ----------------
% indomain_min,indomain_median,indomain_random,ndomain_split
% input_order, first_fail,smallest,dom_w_deg
%solve :: int_search(orden_escenas, first_fail, indomain_min)  minimize f;

solve :: int_search(orden_escenas, smallest, indomain_min)  minimize costo_total;
   
output [ 
  "Costos por actor (1x10^5 $): \t\t\(costo_x_actor)\n" ++
  "Costo por escena (1x10^5 $): \t\t\(costo_x_escena)\n"++
  "Costo maximo(teoríco) (1x10^5 $): \t\(costo_maximo)\n\n"++
  
  "Orden de las escenas: \t\t\t\(orden_escenas)\n"++
  "Costo minimo posible (1x10^5 $): \t\(costo_total)\n"
];

output [ "\n ESCENAS \n"];
output [ show_int(1,orden_escenas[i])++" " |i in 1..n_escenas ] ++[ "\n"];
output [ show_int(1,Escenas_[i,j]) ++ " " ++ 
         if j == n_escenas then
             if i != n_escenas then 
                 "\n" endif 
         else "" endif    
         | i in 1..n_actores,j in 1..n_escenas ] ++ ["\n"];

output [ "\n",show(evitar_no_cumplibles)," EVITAR  cumplibles\n"];

output["\n \n los actores que tengan 1 a continuacion no se les cumplio la restriccion de disponibilidad: "];
output ["\n"]++[ "ACTOR"++show_int(1,i)++ ": "  ++show(disponibilidad_x_actor_no_cumplida[i])++"\t" | i in 1..n_actores ] ++[ "\n"];


%solve minimize f;
%solve maximize f;
%show(n_escenas) , show(n_actores), "\n"  , show( Escenas[8,1..n_escenas]),"\n primero:",  show( arg_max(Escenas[8,1..n_escenas])) , " ultimo: ", show( length(Escenas[8,1..n_escenas]) - arg_max(  reverse(Escenas[8,1..n_escenas])) +1 )   ,
 
 
 
%  show( Escenas_[2,1..n_escenas]),"\n primero:",  show( arg_max(Escenas_[2,1..n_escenas])) , " ultimo: ", show( length(Escenas_[2,1..n_escenas]) - arg_max(  reverse(Escenas_[2,1..n_escenas])) +1 ) , "\n" 
  % ,"\n tiempo minimo por actor" , show(tiempo_min_x_actor) , "\n\t disponibilidad_x_actor_cumplida", 
  %show(disponibilidad_x_actor_no_cumplida) , "\n\t ACTORES" , show(ACTORES)
  
  %, "\n cantidad escenas por actor: " , show(cant_escenas_x_actor)



%output[ "\( if disponibilidad_x_actor_no_cumplida[i] == 1 then ACTORES[i] endif | i in 1..n_actores  )" ];

%output [ "\n",show(length(Disponibilidad)/2)," ESCENAS \n"];
%output [ "\n",show(tiempo_x_actor)," tiempo x actor \n"];
%output [ "\n",show(n)," n \n"];

%output [ "\n",show(Evitar[1,2])," EVITAR  cumplibles\n"];