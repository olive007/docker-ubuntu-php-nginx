#!/bin/sh

XDEBUG_HOST=`hostname -i | cut -d. -f1-3`.1
PHP_VERSION=`php -r "echo PHP_VERSION;" | cut -c 1,3 --output-delimiter="."`

# Set configuration for XDEBUG
echo "xdebug.remote_enable=on" >> /etc/php/$PHP_VERSION/mods-available/xdebug.ini
echo "xdebug.idekey=$CONTAINER_XDEBUG_IDEKEY" >> /etc/php/$PHP_VERSION/mods-available/xdebug.ini
echo "xdebug.remote_host=$XDEBUG_HOST" >> /etc/php/$PHP_VERSION/mods-available/xdebug.ini
echo "xdebug.remote_port=9000" >> /etc/php/$PHP_VERSION/mods-available/xdebug.ini


# Configure the user for PHP FPM
sed -i "s/^user =.*$/user = $CONTAINER_USER_NAME/" /etc/php/$PHP_VERSION/fpm/pool.d/www.conf
sed -i "s/^group =.*$/group = $CONTAINER_USER_NAME/" /etc/php/$PHP_VERSION/fpm/pool.d/www.conf

sed -i "s/^listen.owner =.*$/listen.owner = $CONTAINER_USER_NAME/" /etc/php/$PHP_VERSION/fpm/pool.d/www.conf
sed -i "s/^listen.group =.*$/listen.group = $CONTAINER_USER_NAME/" /etc/php/$PHP_VERSION/fpm/pool.d/www.conf


echo PHP_IDE_CONFIG=\"serverName=`hostname -i`\" >> /etc/environment
