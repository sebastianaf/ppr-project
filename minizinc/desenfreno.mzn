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

%Funciones
function var int: 
  primera_escena(int: actor) = 
    arg_max(Escenas_[actor,1..n_escenas]);

function var int: 
  ultima_escena(int: actor) = 
    length(Escenas_[actor,1..n_escenas]) - 
    arg_max(reverse(Escenas_[actor,1..n_escenas]))+1;

%Restricciones
constraint alldifferent (orden_escenas);

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
         
%indomain_min,indomain_median,indomain_random,indomain_split
%input_order, first_fail,smallest,dom_w_deg
%solve :: int_search(orden_escenas, first_fail, indomain_min)  minimize costo_total;

solve :: int_search(orden_escenas, dom_w_deg, indomain_min)  minimize costo_total;
 
output [ 
  "Costos mínimo por actor: \t\(costo_x_actor)\n" ++
  "Costo minimo total: \t\t\(costo_total)\n\n"++

  "Orden de las escenas: \t\t\(orden_escenas)\n"
];

output [ "\n ESCENAS \n"];
output [ show_int(1,orden_escenas[i])++" " |i in 1..n_escenas ] ++[ "\n"];
output [ show_int(1,Escenas_[i,j]) ++ " " ++ 
         if j == n_escenas then
             if i != n_escenas then 
                 "\n" endif 
         else "" endif    
         | i in 1..n_actores,j in 1..n_escenas ] ++ ["\n"];