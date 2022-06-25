# PPR-03
This code project is a final project to Programming Restrictions Paradigm of Universidad del Valle.

This repo contains all about the project.

## Requirements
This code is built using Minizinc, NodeJS with ExpressJS, ReactJS with CoreUI and PostgreSQL all over containers, To run this project make sure to install [Docker compose](https://docs.docker.com/).

## Repository content

### 1. Minizinc source code
Inside `minizinc` folder you can the models in Minizinc to solve the project problem.

### 2. Report document Latex source code with the PDF
Inside `latex` folder you can find all the source code releated with the document's elaboration.

### 3. Backend services to run Minizinc
Inside `back` folder you can find a backend source code in NodeJS

### 4. Front service
Inside `front` folder is the source code of the Server Side Rendering to show a GUI to use the solutions.

## How to run in `locahost`
This project is configured to run over LAN, please follow the next steps to achieve it.

### 1. Make sure to install `docker compose`
Follow the instructions at [Docker's oficial web page](https://docs.docker.com/) depending of your platform.

### 2. Clone this project
Sure, to do this you need to install `git`, after clone, go in to the folder.
```
git clone https://github.com/sebastianaf/PPR-03
cd PPR-03
```

### 3. Go up the services
Check first if you have `docker` installed typing next:
```
docker compose --version
docker compose -p uv-ppr-03 -up -d --build
```
This commands wake up the web server access it thought `localhost:3000`

##Note
This project use a predefined `.env` file to preconfigure the project to agilize the first run, for that reason ALL THE KEYS ARE PUBLIC VISIBLE, DO NOT USE THIS PROJECT TO DEPLOY ON WEB.

## Folder contents
```
Pending to generate at the end.
```





