#!/bin/sh

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/C=DE/L=Heilbronn/O=42 Heilbronn/CN=JFikents"

sed -i -r 's/DOMAIN_NAME/'$DOMAIN_NAME'/g' /etc/nginx/http.d/default.conf

chown -R nobody:nobody /var/www/html

exec nginx -g 'daemon off;'