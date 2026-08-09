FROM alpine:3.23.5

RUN apk update && apk upgrade
RUN apk add --no-cache mariadb mariadb-client

COPY conf/50-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
