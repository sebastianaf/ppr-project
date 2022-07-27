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

%Variables adicionales
array[1..n_actores] of var int:  tiempo_min_x_actor;
array[1..n_actores] of var 0..1: disponibilidad_x_actor_no_cumplida;
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

%Eliminación de simetrías
%constraint symmetry_breaking_constraint(costo_total < costo_maximo);
%constraint f < costo_maximo; % - cota superior
%constraint symmetry_breaking_constraint(costo_total >= sum(costo_x_escena));
%constraint f >= sum(costo_x_escena); % - cota inferior

%Estrategias de búsqueda
%indomain_min,indomain_median,indomain_random,ndomain_split
%input_order, first_fail,smallest,dom_w_deg
solve :: int_search(orden_escenas, dom_w_deg, indomain_min)  minimize costo_total;

output [ 
  "Costos por actor: \t\t\t\t\t\(costo_x_actor)\n" ++
  "Costo minimo posible: \t\t\t\t\(costo_total)\n\n" ++
  
  "Orden de las escenas: \t\t\t\t\(orden_escenas)\n" ++
  "Disponibilidad de Actores sin cumplir: \t\(disponibilidad_x_actor_no_cumplida)\n"++
  "Actores ha evitar sin cumplir: \t\t\(evitar_no_cumplibles)\n"
];
output [ "\n ESCENAS \n"];
output [ show_int(1,orden_escenas[i])++" " |i in 1..n_escenas ] ++[ "\n"];
output [ show_int(1,Escenas_[i,j]) ++ " " ++ 
         if j == n_escenas then
             if i != n_escenas then 
                 "\n" endif 
         else "" endif    
         | i in 1..n_actores,j in 1..n_escenas ] ++ ["\n"];