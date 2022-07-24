#!flask/bin/python
from flask_cors import CORS, cross_origin
import os
from flask import Flask, flash, request, redirect, url_for, jsonify
from werkzeug.utils import secure_filename
from os import system, getcwd
import subprocess

ALLOWED_EXTENSIONS = {'dzn'}

app = Flask(__name__)

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/solve', methods=['POST'])
def upload_file():
    result = "" 
    target = os.path.join(getcwd(), 'uploads') 
    data = request.form['dznfile']
    if data != '':
        with open(os.path.join(target,'data.dzn'),'w') as dznfile : dznfile.write(data)
        command = "./minizinc/bin/minizinc --solver COIN-BC " + os.path.join(getcwd(),'models', 'Desenfreno.mzn') + " " + os.path.join(target, 'data.dzn') + '>' + os.path.join(target, 'result.txt')
        result = subprocess.Popen(command, shell=True)
        result.wait()
        f = open(os.path.join(target, 'result.txt'))
        result = f.read()
        resp = flask.Response(result)
        resp.headers['Access-Control-Allow-Origin'] = '*'
        return resp
    resp = flask.Response("Archivo vacio")
    resp.headers['Access-Control-Allow-Origin'] = '*'
    return resp        

@app.route('/', methods=['GET'])
def test():
    return "uv-ppr"

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
