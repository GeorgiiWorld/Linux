FROM nginx:latest

WORKDIR /part_4/

COPY ./server/main.c .
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

RUN apt-get update && \
    apt-get -y install gcc libfcgi-dev spawn-fcgi && \
    gcc -o server main.c -lfcgi && \
    rm -rf /var/lib/apt/lists

CMD spawn-fcgi -p 8080 ./server && nginx -g "daemon off;"
