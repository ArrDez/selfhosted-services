FROM node:11-alpine

ARG TURTL_SERVER_PLUGIN_REPO
ARG TURTL_SERVER_PLUGIN_LOCATION

RUN apk add -U bash git nginx make &&\
    mkdir /run/nginx

EXPOSE 80

WORKDIR /var/www/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN git clone https://github.com/turtl/js.git .

COPY config.js config/config.js

RUN npm install && make

CMD ["nginx", "-g", "daemon off;"]