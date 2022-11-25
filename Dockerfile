FROM node:19-alpine as build
#RUN get the files from the github repository
WORKDIR /app
RUN wget https://github.com/rodrigocct/mobdev_ca3/archive/main.tar.gz && tar xf main.tar.gz && rm main.tar.gz
 
#dining the working directory

WORKDIR /app/mobdev_ca3-main/

# installing ionic globally
RUN npm install -g ionic
RUN npm install

# Running the script
RUN npm run-script build --prod

# Set up the environment: use Alpine, Node.js and Ngnix. Install Ionic: globally and install all of its dependencies

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/mobdev_ca3-main/www /usr/share/nginx/html/

#Expose port 80

EXPOSE 80
