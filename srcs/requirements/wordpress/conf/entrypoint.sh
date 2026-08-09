#!/bin/sh

echo "Waiting Database..."
while ! mariadb -h$SQL_HOST -u$SQL_USER -p$SQL_PASSWORD $SQL_DATABASE &>/dev/null; do
    sleep 3
done

echo "Database connected."

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    echo "Configuration of WordPress..."

    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=$SQL_HOST \
        --path='/var/www/wordpress'

    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="$WP_TITLE" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --path='/var/www/wordpress'

    wp user create --allow-root \
        $WP_USER $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD \
        --role=author \
        --path='/var/www/wordpress'

    chown -R www-data:www-data /var/www/wordpress

    echo "WordPress already installed and configured!"
else
    echo "WordPress already configured."
fi

# -F Keep the container on
echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm84 -F
