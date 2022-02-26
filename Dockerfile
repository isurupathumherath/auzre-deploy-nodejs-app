FROM public.ecr.aws/docker/library/node:16.14.0-alpine3.14 AS build_image
RUN apk add --no-cache nodejs npm
WORKDIR /isuru
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

FROM public.ecr.aws/docker/library/node:16.14.0-alpine3.14
WORKDIR /webapp
COPY --from=build_image /isuru /webapp/
EXPOSE 3000
CMD [ "npm", "start" ]