import enum
from minizinc import Instance, Model, Solver


# Load desenfreno model from file
desenfreno = Model("./desenfreno.mzn")
# Find the MiniZinc solver configuration for Gecode
gecode = Solver.lookup("gecode")
# Create an Instance of the n-Queens model for Gecode
instance = Instance(gecode, desenfreno)

# ACTORES = {Actor1, Actor2, Actor3, Actor4, Actor5} ;
# aqui se ingresan los datos para el modelo
class Data:

    def __init__(self, actors, scenes, durations) -> None:
        self.actors = actors
        self.scenes = scenes
        self.durations = durations
        self.result = None

    def __str__(self) -> str:
        return f"""costo por actor: {self.result['costo_x_actor']} \norden escenas:  {self.result['orden_escenas']} \ncosto por escena: {self.result['costo_x_escena']}
          \nCosto total: {self.result['f']} \nCosto minimo {self.result['costo_minimo']}"""


    def add_data(self):
        instance["ACTORES"] = enum.Enum("ACTORES", self.actors)
        instance["Escenas"] = self.scenes
        instance["Duracion"] = self.durations  

        # self.result = instance.solve() # Se comenta porque está arrojando un error, debido a que no obtiene una solución
        return True



'''
instance["ACTORES"] = enum.Enum("ACTORES", ['Actor1', 'Actor2', 'Actor3', 'Actor4', 'Actor5'])
    instance["Escenas"] = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,  5], 
        [0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0,   5],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,   40 ],
        [0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0,   4 ],
        [0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0,  20],
        ]
    instance["Duracion"] = [2 , 1 , 1, 1, 1, 3, 1, 1, 1, 2, 1, 1, 2] 
'''