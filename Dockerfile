FROM node:20.12.2-alpine AS appbuild

WORKDIR /home/app

COPY package.json yarn.lock ./

RUN yarn install --production --frozen-lockfile

COPY . .

RUN yarn build
FROM node:20.12.2-alpine

WORKDIR /home/app

COPY --from=appbuild /home/app/package.json ./package.json
COPY --from=appbuild /home/app/yarn.lock ./yarn.lock
COPY --from=appbuild /home/app/node_modules ./node_modules
COPY --from=appbuild /home/app/build ./build

CMD yarn start