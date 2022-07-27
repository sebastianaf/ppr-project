include "globals.mzn"; 

%Entradas
enum ACTORES;
int: n_actores = length(ACTORES);
array[int] of int: Duracion;
int: n_escenas = length(Duracion);
array[1..n_actores,1..n_escenas+1] of int: Escenas;

%Entradas adicionales
array[int,1..2] of int: Disponibilidad;
array[int,1..2] of int: Evitar;

%Variables
array[1..n_escenas] of var 1..n_escenas: orden_escenas;
array[1..n_actores,1..n_escenas] of var 0..1: Escenas_;
array[1..n_actores] of var int: costo_x_actor;
var int: costo_total = sum(costo_x_actor);
array[1..n_escenas] of var int: costo_x_escena;
array[1..n_escenas] of var int: costo_maximo_x_escena;
var  int: costo_maximo = sum(i in 1..n_escenas) (costo_maximo_x_escena[i]);

%Variables adicionales
array[1..n_actores] of var int:  tiempo_min_x_actor;
array[1..n_actores] of var int: cant_escenas_x_actor;
array[1..n_actores] of var 0..1: disponibilidad_x_actor_no_cumplida;
var  int: x;
array[1..m] of var 0..1: evitar_no_cumplibles; 

 

int: m = round (length(Evitar)/2);
int: n = round(length(Disponibilidad)/2);

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
constraint forall( i in 1..n_actores)( 
    sum(j in 1.. n_escenas)(
      Duracion[j] * Escenas[i,j]) = tiempo_min_x_actor[i]);
      
constraint forall( i in 1..n  )(
  if Disponibilidad[i,2] > 0 then 
    if tiempo_min_x_actor[i]  <= Disponibilidad[i,2] then 
      tiempo_min_x_actor[i] <= Disponibilidad[i,2]
    else disponibilidad_x_actor_no_cumplida[i] = 1 endif 
  endif);


constraint forall(j in 1..m, i in 1..n_escenas)(
  if Escenas[Evitar[j,1],i] == 1 /\ 
    Escenas[Evitar[j,1],i] ==  Escenas[Evitar[j,2],i] then
    evitar_no_cumplibles[j] = 1 endif);

% estrategias de busqueda ----------------
% indomain_min,indomain_median,indomain_random,ndomain_split
% input_order, first_fail,smallest,dom_w_deg
%solve :: int_search(orden_escenas, first_fail, indomain_min)  minimize f;

%solve :: int_search(orden_escenas, smallest, indomain_min)  minimize costo_total;
solve :: int_search(orden_escenas, dom_w_deg, indomain_min)  minimize costo_total;
output [ 
  "Costos por actor: \t\t\(costo_x_actor)\n" ++
  "Costos por escena: \t\(costo_x_escena)\n"++
  "Costo maximo(teoríco): \t\(costo_maximo)\n\n"++
  
  "Orden de las escenas: \t\(orden_escenas)\n"++
  "Costo minimo posible: \t\(costo_total)\n"
];
output [ "\n ESCENAS \n"];
output [ show_int(1,orden_escenas[i])++" " |i in 1..n_escenas ] ++[ "\n"];
output [ show_int(1,Escenas_[i,j]) ++ " " ++ 
         if j == n_escenas then
             if i != n_escenas then 
                 "\n" endif 
         else "" endif    
         | i in 1..n_actores,j in 1..n_escenas ] ++ ["\n"];

%Impresión de depuración
output [ 
  "\(tiempo_min_x_actor)\n"++
  "\(evitar_no_cumplibles)\n"
];

output ["\n"]++[ "ACTOR"++show_int(1,i)++ ": "  ++show(disponibilidad_x_actor_no_cumplida[i])++"\t" | i in 1..n_actores ] ++[ "\n"]; 

%Salida adicionales
% output [ "\n",show(evitar_no_cumplibles)," EVITAR  cumplibles\n"];

% output["\n \n los actores que tengan 1 a continuacion no se les cumplio la restriccion de disponibilidad: "];
% output ["\n"]++[ "ACTOR"++show_int(1,i)++ ": "  ++show(disponibilidad_x_actor_no_cumplida[i])++"\t" | i in 1..n_actores ] ++[ "\n"];   



%solve minimize f;
%solve maximize f;
%show(n_escenas) , show(n_actores), "\n"  , show( Escenas[8,1..n_escenas]),"\n primero:",  show( arg_max(Escenas[8,1..n_escenas])) , " ultimo: ", show( length(Escenas[8,1..n_escenas]) - arg_max(  reverse(Escenas[8,1..n_escenas])) +1 )   ,
 
 
 
%constraint symmetry_breaking_constraint(costo_total < costo_maximo);
%constraint f < costo_maximo; % - cota superior
%constraint symmetry_breaking_constraint(costo_total >= sum(costo_x_escena));
%constraint f >= sum(costo_x_escena); % - cota inferior 
 
%restricciones adicionales inicio----------------

 
%  show( Escenas_[2,1..n_escenas]),"\n primero:",  show( arg_max(Escenas_[2,1..n_escenas])) , " ultimo: ", show( length(Escenas_[2,1..n_escenas]) - arg_max(  reverse(Escenas_[2,1..n_escenas])) +1 ) , "\n" 
  % ,"\n tiempo minimo por actor" , show(tiempo_min_x_actor) , "\n\t disponibilidad_x_actor_cumplida", 
  %show(disponibilidad_x_actor_no_cumplida) , "\n\t ACTORES" , show(ACTORES)
  
  %, "\n cantidad escenas por actor: " , show(cant_escenas_x_actor)



%output[ "\( if disponibilidad_x_actor_no_cumplida[i] == 1 then ACTORES[i] endif | i in 1..n_actores  )" ];

%output [ "\n",show(length(Disponibilidad)/2)," ESCENAS \n"];
%output [ "\n",show(tiempo_x_actor)," tiempo x actor \n"];
%output [ "\n",show(n)," n \n"];

%output [ "\n",show(Evitar[1,2])," EVITAR  cumplibles\n"];