#!/bin/bash

# # Wait for MariaDB to be ready
# until mysql -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1" &> /dev/null; do
#     echo "Waiting for MariaDB..."
#     sleep 3
# done

# Navigate to WordPress directory
cd /var/www/html

# Download WordPress if not exists
if [ ! -f wp-config.php ]; then
    wp core download --allow-root
    
    # Configure WordPress
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --allow-root
    
    # Install WordPress
    wp core install --url=https://$DOMAIN_NAME --title="Inception WordPress" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
    
    # Create additional user
    wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=author --allow-root
fi

# Change ownership
chown -R www-data:www-data /var/www/html

# Start PHP-FPM
php-fpm7.4 -F
