FROM node:16
COPY ["package.json","package-lock.json","/org/app/"]
WORKDIR /org/app
RUN npm install
COPY [".","/org/app/"]
RUN npm run build
EXPOSE ${APP_PORT}
CMD ["npm", "start"]
