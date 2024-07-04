# FROM ubuntu:18.04

# RUN apt update -y \
#     && apt install nginx curl vim -y \
#     && apt-get install software-properties-common -y \
#     && add-apt-repository ppa:certbot/certbot -y \
#     && apt-get update -y \
#     && apt-get install python-certbot-nginx -y \
#     && apt-get clean

# EXPOSE 90

# STOPSIGNAL SIGTERM

# CMD ["nginx", "-g", "daemon off;"]

FROM node:12-alpine as build
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

FROM nginx
RUN rm /etc/nginx/nginx.conf
COPY deploy/nginx.conf /etc/nginx/nginx.conf

WORKDIR /usr/share/nginx/html
COPY --from=build /app/build .
EXPOSE 80

ENTRYPOINT [ "nginx", "-g", "daemon off;"]