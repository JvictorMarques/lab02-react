FROM node:20.12.2-alpine

WORKDIR /home/app

COPY package.json yarn.lock ./
COPY node_modules ./node_modules
COPY build ./build

CMD yarn start