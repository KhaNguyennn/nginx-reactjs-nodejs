FROM node:12-alpine
WORKDIR /src/app
COPY ./package*.json .
RUN npm ci

COPY . .
WORKDIR /src/app

CMD ["npm", "start"]