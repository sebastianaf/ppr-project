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
var int: costo_maximo = sum(i in 1..n_escenas)(costo_maximo_x_escena[i]);

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
      
constraint forall( i in 1..n_escenas)(
    sum(j in 1.. n_actores)(
      Escenas_[j,orden_escenas[i]] *  
      Escenas[j,n_escenas+1]) *
      Duracion[orden_escenas[i]] = costo_x_escena[i]);

constraint forall( i in 1..n_escenas )( 
    sum(j in 1.. n_actores)( 
      Escenas[j,n_escenas+1])* Duracion[i] =
      costo_maximo_x_escena[i]);
      
%indomain_min,indomain_median,indomain_random,indomain_split
%input_order, first_fail,smallest,dom_w_deg
%solve :: int_search(orden_escenas, first_fail, indomain_min)  minimize costo_total;

solve :: int_search(orden_escenas, dom_w_deg, indomain_min)  minimize costo_total;
 
output [ 
  "Costos por actor (1x10^5 $): \t\t\(costo_x_actor)\n" ++
  "Costo por escena (1x10^5 $): \t\t\(costo_x_escena)\n"++
  "Costo maximo(teoríco) (1x10^5 $): \t\(costo_maximo)\n\n"++
  
  "Orden de las escenas: \t\t\t\(orden_escenas)\n"++
  "Costo minimo posible (1x10^5 $): \t\(costo_total)\n"
] ;

output [ "\n ESCENAS \n"];
output [ show_int(1,orden_escenas[i])++" " |i in 1..n_escenas ] ++[ "\n"];
output [ show_int(1,Escenas_[i,j]) ++ " " ++ 
         if j == n_escenas then
             if i != n_escenas then 
                 "\n" endif 
         else "" endif    
         | i in 1..n_actores,j in 1..n_escenas ] ++ ["\n"];
