FROM alpine:3.23.5

RUN apk update && apk upgrade
RUN apk add --no-cache mariadb mariadb-client

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
