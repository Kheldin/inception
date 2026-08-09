FROM alpine:3.23.5


RUN apk update && apk upgrade && \
    apk add --no-cache \
    wget \
    php \
    php-fpm \
    php-mysqli \
    php-phar \
    php-mbstring \
    mariadb-client

# WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

# -S create a system user, -G add it to the group
RUN adduser -S www-data -G www-data

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf wordpress-6.0-fr_FR.tar.gz && \
    rm wordpress-6.0-fr_FR.tar.gz

RUN chown -R www-data:www-data /var/www/wordpress

# Allow the container to listen to port 9000 on all IPs adressing requests
# And read env vataible in .env
# -i = in-place, s/ = substitute, /g = global (all occurences)
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php8*/php-fpm.d/www.conf && \
    sed -i 's/;clear_env = no/clear_env = no/g' /etc/php8*/php-fpm.d/www.conf

COPY ./conf/entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/wordpress

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
