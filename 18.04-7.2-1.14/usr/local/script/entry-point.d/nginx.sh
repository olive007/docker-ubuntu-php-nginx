#!/bin/sh

# Create a link into the home directory of the new user if no link is present
[ -L /home/$CONTAINER_USER_NAME/www ] || ln -s /var/www/html /home/$CONTAINER_USER_NAME/www

# Set the new user as the user who run apache
sed -i "s/^user.*$/user $CONTAINER_USER_NAME;/" /etc/nginx/nginx.conf

# Fix permision error
chown $CONTAINER_USER_NAME:$CONTAINER_USER_NAME /var/www/*
