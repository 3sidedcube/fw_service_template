FROM node:16.14.2-alpine3.15
MAINTAINER server@3sidedcube.com

ENV NAME fw-service-template
ENV USER fw-service-template

RUN addgroup $USER && adduser -S -G $USER $USER
USER $USER

WORKDIR /opt/$NAME

COPY package.json ./
COPY yarn.lock ./
RUN yarn install

COPY ./app ./app
COPY ./config ./config
COPY ./.babelrc ./
COPY ./tsconfig.json ./
RUN yarn build

EXPOSE 3000

CMD ["node", "dist/app.js"]
