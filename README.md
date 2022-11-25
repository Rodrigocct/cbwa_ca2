# docker-static-website
Cloud-based Web Application
CA1: Dockerfile Composition

By following these simple steps i managed to create the minimalistic Docker container locally hosted and show a simple page hosted on github repository
as it was required for this assignment

## Steps to be follow

it can be seen on the docker file that it has been utized the latest version of alpine wich is 3.16.2 and latest verision of busybox 1.35.0

```sh
FROM alpine:3.16.2 AS builder

RUN apk add gcc musl-dev make perl

```


# Download busybox sources

in this part busybox is downloaded, uncompressed and moved to busybox

```sh

RUN wget https://busybox.net/downloads/busybox-1.35.0.tar.bz2 \
  && tar xf busybox-1.35.0.tar.bz2 \
  && mv /busybox-1.35.0 /busybox

```

# A new user is created to basically protect the running commands

```sh

RUN adduser -D static

```


#Get the content of webdevca1.1 from GitHub

to get the content it was provided the github repository link

```sh

RUN wget https://github.com/Rodrigocct/webdevca1.1/archive/main.tar.gz \
  && tar xf main.tar.gz \
  && rm main.tar.gz \
  && mv /webdevca1.1-main /home/static
```

# Change working directory



```sh

WORKDIR /busybox

```

# Install a custom version of BusyBox
COPY .config .
RUN make && make install

# Switch to the scratch image
FROM scratch

EXPOSE 8080

# Copy user and BusyBox
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /busybox/_install/bin/busybox /

# Copy the content of webdevca1.1 to the scratch image
COPY --from=builder /home/static /home/static

# Switch to our non-root user and their work directory
USER static

WORKDIR /home/static/webdevca1.1-main

# Uploads a blank default httpd.conf
# This is only needed in order to set the `-c` argument in this base file
# and save the developer the need to override the CMD line in case they ever
# want to use a httpd.conf

# httpd.conf
COPY httpd.conf .


# Issuing commands to run when container is created
CMD ["/busybox", "httpd", "-f", "-v", "-p", "8080", "-c", "httpd.conf"]

# After setting all

by running the command below on the cmd comand prompt it is possible to Build the image:

```sh
docker build -t my-ca1-webdev .
```
before running the command line make sure you are in the correct directory. 
To access the directory where your file is located you can use cd followed by the address where your files are located

# Run the image:

it can be done by running the next command line and providing the port number in this case is 8080

```sh
docker run -it --rm -p 8080:8080 my-ca1-webdev
```
# to check if everyting went throug:

Browse to `http://localhost:8080`.


