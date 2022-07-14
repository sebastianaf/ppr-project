from flask import Flask, jsonify
from models import app

# El arreglo que se debe enviar debe tener este estilo
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
    """Aqui se ingresan los datos que van a ser """
    pass




##Se empieza la ejecución de la aplicación
if __name__ == '__main__':
    app.run(debug=True)