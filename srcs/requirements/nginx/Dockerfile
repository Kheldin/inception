FROM alpine:3.23.5

RUN apk update && apk add --no-cache nginx openssl nginx

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=RHONE/L=Lyon/O=42/OU=42/CN=kacherch.42.fr/UID=kacherch"

RUN mkdir -p /var/www/wordpress

RUN chmod 755 /var/www/wordpress
RUN chown -R nginx:nginx /var/www/wordpress

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
