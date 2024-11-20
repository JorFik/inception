#!/bin/sh

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --path=/var/www/html --allow-root
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

if [ -f /run/secrets/credentials ]; then
    source /run/secrets/credentials
else
    echo "Credentials file not found"
    exit 1
fi

# Change placeholders in wp-config.php
sed -i -r "s/wordpress_name_here/$DB_NAME/1" 	wp-config.php
sed -i -r "s/username_here/$DB_USR/1" 			wp-config.php
sed -i -r "s/password_here/$DB_PWD/1" 			wp-config.php
sed -i -r "s/localhost/mariadb/1" 				wp-config.php

# Set up Admin user
wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
# Set up Author user
wp user create $WP_USR $WP_USR_EMAIL --role=author --user_pass=$WP_USR_PWD --allow-root

# Set theme
wp theme install twentytwentytwo --activate --allow-root

# Set up plugins
wp plugin install redis-cache --activate --allow-root

sed -i 's/listen = \/run\/php\/php82-fpm.sock/listen = 9000/g' /etc/php82/php-fpm.d/www.conf

# Enable Redis
wp redis enable --allow-root

/usr/sbin/php-fpm82 -F