# # ------------------dev -------------------
FROM node:18.13.0-alpine as build_dev
RUN npm install -g pnpm

WORKDIR /app

COPY package.json .
COPY pnpm-lock.yaml .

RUN pnpm install

COPY . .
COPY .env.dev .env

RUN npm run build

# # ------------------staging -------------------
FROM node:18.13.0-alpine as build_staging
RUN npm install -g pnpm

WORKDIR /app

COPY package.json .
COPY pnpm-lock.yaml .

RUN pnpm install

COPY . .
COPY .env.staging .env

RUN npm run build

# # ------------------deploy -------------------

FROM nginx:alpine as dev
COPY --from=build_dev /app/dist ./usr/share/nginx/html

FROM nginx:alpine as staging
COPY --from=build_staging /app/dist ./usr/share/nginx/html
