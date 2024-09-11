FROM alpine:3.17.4

RUN apk --no-cache --upgrade add \
    nginx \
    gcc \
    fcgi-dev \
    spawn-fcgi \
    libc-dev && \
    mkdir /www && \
    adduser -D -s /bin/sh -g 'www' www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /var/log/nginx && \
    chown -R www:www /run && \
    chown -R www:www /www && \
    rm -rf /var/cache/apk/*

USER www
WORKDIR /www/
COPY /server/main.c .
RUN gcc -o server main.c -lfcgi && \
    rm main.c

COPY nginx/nginx.conf /etc/nginx/nginx.conf

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD wget --quiet --tries=1 --spider http://127.0.0.1:80 || exit 1

EXPOSE 81

CMD spawn-fcgi -p 8080 ./server && nginx -g "daemon off;"