FROM node:11-alpine

ARG TURTL_SERVER_PLUGIN_REPO
ARG TURTL_SERVER_PLUGIN_LOCATION

RUN apk add -U bash git 

EXPOSE 8181
WORKDIR /app
RUN git clone https://github.com/turtl/server .
COPY config.yaml config/config.yaml

RUN npm install --production &&\
  ./scripts/install-plugins.sh &&\
  mkdir -p /plugins /uploads

ENTRYPOINT ["/app/entrypoint.sh"]