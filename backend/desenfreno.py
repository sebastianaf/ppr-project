import enum
from minizinc import Instance, Model, Solver


# Load desenfreno model from file
desenfreno = Model("./desenfreno.mzn")
# Find the MiniZinc solver configuration for Gecode
gecode = Solver.lookup("gecode")
# Create an Instance of the n-Queens model for Gecode
instance = Instance(gecode, desenfreno)


# aqui se ingresan los datos para el modelo