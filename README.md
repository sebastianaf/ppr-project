# ppr-project
This code project is a final project to Programming Restrictions Paradigm of Universidad del Valle.

This repo contains all about the project.

## Requirements
This code is built using Minizinc, NodeJS with ExpressJS, ReactJS with Tailwindcss and PostgreSQL all over containers, To run this project make sure to install [Docker compose](https://docs.docker.com/).

## Repository content

### 1. Minizinc source code.
Inside `minizinc` folder you can the models in Minizinc to solve the project problem.

### 2. Report document Latex source code with the PDF.
Inside `latex` folder you can find all the source code releated with the document's elaboration.

### 3. API Rest service to use the app.
Inside `api-01` folder you can find the main API Rest source code in NodeJS

### 4. API Rest service to run Minizinc.
Inside `api-02` folder you can find the main API Rest source code in NodeJS

### 4. Web ui service
Inside `ui-01` folder is the source code of the Web GUI to use the solutions.

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
Check first if you have `docker` installed typing `docker compose --version` and next deploy the app with:
```
docker compose -p uv-ppr -up -d --build
```
This commands will wake up the services in the ports 9010, 9020, 9030, and 9040 for api-01, db-01, ui-01 and pgadmin respectively, Nevertheless is recomended to use a docker private network with a reverse proxy.

### 4. Access the app in the browser

[http://localhost:9030](http://localhost:9030)


## Folder contents
```
Pending to generate at the end.
```





