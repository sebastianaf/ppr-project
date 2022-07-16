from flask import Flask, jsonify, request
from models import app
import numpy as np
import re

# Los datos que se deben enviar desde la Api hacia el backend deben tener el siguiente estilo: 
# key           value
# scenes        1 2 3 4; 1 2 3 4; 5 6 7 8; 4 2 1 3; 5 2 4 7
# actors        actor1, actor2, actor3, actor4  , actor5 
# duration      2,1,2,3,4

# El arreglo que se devolverá con la solución debe tener el siguiente estilo:
desenfreno = [    
        {"durations_scenes": [1, 2, 1, 3]},
        {"Actors": [{
            "Actor1": 
            {
                "scenes": 
                    [1, -1, 1, 0], 
                "price": 80
            }
        },
        {
            "Actor2": 
            {
                "scenes": 
                    [1, -1, 1, 0],
                "price": 95 
            }
        },]}    
]

@app.route('/')
def index():
    return '''<title>Api Desenfreno</title>
            <center><h1>Api Desenfreno</h1></center>'''


@app.route("/all")
def get_all_scenes():
    """Por medio de esta función se debe enviar 
        la solución al problema de restricciones"""
    return jsonify(scenes_desenfreno=desenfreno)


@app.route("/add", methods=["POST"])
def post_scene():
    """Aqui se ingresan los datos que van a ser 
        llevados al modelo"""
    actors = request.form.get("actors")
    actors = re.sub(r"\s+", "", actors).split(',')
    scenes = request.form.get("scenes")
    scenes = np.matrix(scenes)
    duration = request.form.get("duration")
    duration = re.sub(r"\s+", "", duration).split(',')

    availability = request.form.get("availability") # opcional
    avoid = request.form.get("avoid") # opcional

    if availability and avoid:
        availability = np.matrix(availability)
        avoid = np.matrix(avoid)

    print(f"{actors}\n{scenes}\n{duration}")

    return jsonify(response={"success": "Successfully added the new scenes."})






##Se empieza la ejecución de la aplicación
if __name__ == '__main__':
    app.run(debug=True)