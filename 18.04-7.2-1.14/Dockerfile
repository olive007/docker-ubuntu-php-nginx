FROM olive007/ubuntu:18.04
MAINTAINER SECRET Olivier (olivier@devolive.be)

ARG PHP_VERSION=7.2

# Install php7.2 and apache2
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
						   nginx \
						   php-xdebug \
						   php${PHP_VERSION} \
						   php${PHP_VERSION}-bcmath \
						   php${PHP_VERSION}-bz2 \
						   php${PHP_VERSION}-cgi \
						   php${PHP_VERSION}-cli \
						   php${PHP_VERSION}-common \
						   php${PHP_VERSION}-curl \
						   php${PHP_VERSION}-dba \
						   php${PHP_VERSION}-enchant \
						   php${PHP_VERSION}-fpm \
						   php${PHP_VERSION}-gd \
						   php${PHP_VERSION}-gmp \
						   php${PHP_VERSION}-imap \
						   php${PHP_VERSION}-interbase \
						   php${PHP_VERSION}-intl \
						   php${PHP_VERSION}-json \
						   php${PHP_VERSION}-ldap \
						   php${PHP_VERSION}-mbstring \
						   php${PHP_VERSION}-mysql \
						   php${PHP_VERSION}-odbc \
						   php${PHP_VERSION}-opcache \
						   php${PHP_VERSION}-pgsql \
						   php${PHP_VERSION}-phpdbg \
						   php${PHP_VERSION}-pspell \
						   php${PHP_VERSION}-readline \
						   php${PHP_VERSION}-recode \
						   php${PHP_VERSION}-snmp \
						   php${PHP_VERSION}-soap \
						   php${PHP_VERSION}-sqlite3 \
						   php${PHP_VERSION}-sybase \
						   php${PHP_VERSION}-tidy \
						   php${PHP_VERSION}-xml \
						   php${PHP_VERSION}-xmlrpc \
						   php${PHP_VERSION}-xsl \
						   php${PHP_VERSION}-zip \
						   snmp-mibs-downloader # php-snmp dependency

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


RUN rm -rf /var/www/*
# Here the user have to define a volume into /var/www/html
VOLUME /var/www/html

# Add file to get server information
RUN mkdir /var/www/info
ADD var/www/info/index.php /var/www/info/index.php



# Display the php error on the web page
RUN sed -i 's/^display_errors = .*$/display_errors = On/' /etc/php/7.2/fpm/php.ini

# Fix PHP-FPM Error (unable to connect to Unix domain socket /run/php/php7.2-fpm.sock)
RUN mkdir /run/php


# Add Nginx configuration file
ADD etc/nginx/sites-available/default /etc/nginx/sites-available/default
ADD etc/nginx/sites-available/info /etc/nginx/sites-available/info
RUN ln -s /etc/nginx/sites-available/info /etc/nginx/sites-enabled/info


# Add script configuration for nginx and php
ADD usr/local/script/entry-point.d/nginx.sh /usr/local/script/entry-point.d/nginx.sh
ADD usr/local/script/entry-point.d/php.sh /usr/local/script/entry-point.d/php.sh


# Enable services
RUN echo "service php$PHP_VERSION-fpm start" >> /usr/local/script/startup.sh
RUN echo "service nginx start" >> /usr/local/script/startup.sh


# Stop services at shutdown
RUN echo "service php$PHP_VERSION-fpm stop" >> /usr/local/script/container-stopped.sh
RUN echo "service nginx stop" >> /usr/local/script/container-stopped.sh


# Define Environment variable
ENV XDEBUG_IDEKEY=PHPSTORM
