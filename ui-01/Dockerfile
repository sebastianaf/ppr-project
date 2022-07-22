FROM node:16
COPY ["package.json","package-lock.json","/usr/org/app/"]
WORKDIR /usr/org/app
RUN npm install
COPY [".","/usr/org/app/"]
RUN npm run build
EXPOSE ${UI_PORT}
CMD ["npx", "serve", "-l", "$UI_PORT", "-s", "build"]