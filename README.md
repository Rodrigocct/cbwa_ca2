##How to build a docker image to use as a container for a Web app
## Step 1
I Have created a new github repository called cbwa_ca2 as required 

##Create a Dockerfile

here follow the script for the docker file

##Here we are saying Docker to use node19 alpine from dockerhub to use as a base image
 which will allow us to run the commands related to npm. 


FROM node:19-alpine as build

##creating a work directory app and copying package and package-lock.json to app folder.

WORKDIR /app

RUN wget https://github.com/rodrigocct/mobdev_ca3/archive/main.tar.gz && tar xf main.tar.gz && rm main.tar.gz
 

WORKDIR /app/mobdev_ca3-main/

##Installing ionic globally

RUN npm install -g ionic
RUN npm install

## creating a www folder of our project,which we will be using to deploy to nginx.


RUN npm run-script build --prod

##telling Docker to use the nginx from dockerhub.

FROM nginx:alpine

##deleting anything on /usr/share/nginx/html/*

RUN rm -rf /usr/share/nginx/html/*

##coping files from www folder to html folder

COPY --from=build /app/mobdev_ca3-main/www /usr/share/nginx/html/

##the port number we are using in this case is 80

EXPOSE 80

## After getting clear what we have in the docker file script lets run mobdev_ca3 on this docker container

#Build the docker container

1 - in the terminal run: "docker build -t webapp ."

#Run docker image

2 - now run: "docker run -it --rm -p 80:80 webapp" 

now we should be able to see our webapp working


####### Hosting service providers recommended for your docker container #####

2.1.5	what to look for in a good hosting:
-  Monthly file transfer
- Storage space
- Operating system
-  Server location
- Price
- Services offered
After doing big research I end up choosing these 2 options that I can recommend to host docker containers:
2.2.5	Amazon Elastic Container Service (Amazon ECS)
Amazon Elastic Container Service (Amazon ECS) is a highly scalable container service with docker support. It is used to containerize your applications on AWS. It provides windows compatibility and supports the management of windows containers. (Geekflare, 2019) (Google Cloud, 2022)
Features
•	Provides security by using Amazon IAM and Amazon VPC
•	Runs Amazon EC2 spot instances for optimizing cost
•	It can easily containerize machine learning models for training and inference.
•	Easily integrated with AWS services

2.3.5	Google Cloud Run
It is one of the fastest growing platforms geographically speaking and also in terms of technology. He has developed “Kubernetes” a popular container orchestration tool that has been originally developed by google and which of course supports Docker.
It abstracts all the complexities involved in infrastructure management, and you can just focus on building your application. Using Cloud Run, you can deploy containers on production within seconds. You can also scale up or down your container infrastructure without any downtime. (Google Cloud, 2022)
2.4.5	Here are some of the advantages:
- New customers get $300 in free credits to spend on Cloud Run. All customers get 2 million requests free per month, not charged against your credits.
- Use the programming language of your choice, any language or operating system libraries, or even bring your own binaries.
 - Pay‐per‐use
- Only pay when your code is running, billed to the nearest 100 milliseconds.





###	References ###

in this proyect i have mainly used classes slides and the previous ca files to edit the commands lines

https://github.com/Rodrigocct/cbwa_ca1


### cloud providers references ###

Geekflare, 2019. 10 Best Docker Hosting Platforms for your Containers. [Online] Available at: https://geekflare.com/docker-hosting-platforms/ [Accessed 23 November 2022].
GitHub Docs, 2022. Quickstart for GitHub Actions - GitHub Docs. [Online] Available at: https://docs.github.com/en/actions/quickstart [Accessed 23 November 2022].
Google Cloud, 2022. Cloud Run: Container to production in seconds  |  Google Cloud. [Online] Available at: https://cloud.google.com [Accessed 23 November 2022].


