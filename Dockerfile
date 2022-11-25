FROM node:19-alpine as build
#RUN adduser -D static
WORKDIR /app
RUN wget https://github.com/rodrigocct/mobdev_ca3/archive/main.tar.gz && tar xf main.tar.gz && rm main.tar.gz
  #&& mv /mobdev_ca3-main /home/static

WORKDIR /app/mobdev_ca3-main/

# COPY package*.json /app
RUN npm install -g ionic
RUN npm install
# COPY ./ /app/
RUN npm run-script build --prod

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/mobdev_ca3-main/www /usr/share/nginx/html/

EXPOSE 80
