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
Inside `api-01` folder you can find the main API Rest source code in NodeJS

### 4. Front service
Inside `ui-01` folder is the source code of the Web GUI to show a GUI to use the solutions.

## How to run in `locahost`
This project is configured to run over LAN, please follow the next steps to achieve it.

### 1. Make sure to install `docker compose`
Follow the instructions at [Docker's oficial web page](https://docs.docker.com/) depending of your platform.

### 2. Clone this project
Sure, to do this you need to install `git`, after clone, go in to the folder.
```
git clone https://github.com/sebastianaf/ppr-project
cd ppr-project
```

### 3. Deploy the services
Check first if you have `docker` installed typing next and deploy app:
```
docker compose --version
docker compose -p uv-ppr-project -up -d --build
```
This commands will wake up the services access it thought port specified in $UI_PORT,$API_PORT environment variables. All the services will expose the ports 9010, 9020, 9030, and 9040 for api-01, db-01, ui-01 and pgadmin respectively, Nevertheless is recomended to use a docker private network with a reverse proxy.

## Folder contents
```
Pending to generate at the end.
```





