FROM alpine:3.19

WORKDIR /var/www/html

COPY tools/config_wordpress.sh tools/wp-config.php /tmp/

RUN (apk add --no-cache curl php82 php82-fpm php82-mysqli php82-phar php82-iconv tini && \
	mkdir -p /var/www/html && \
	chown -R nobody:nobody /var/www/html) \
	|| (echo "Failed to install dependencies" >&2 ; exit 1);\
	(chmod +x /tmp/config_wordpress.sh) \
	|| (echo "Failed to prepare script for WordPress" >&2 ; exit 0)

EXPOSE 9000

# Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 CMD curl -f https://jfikents.42.fr:9000 || exit 1

ENTRYPOINT [ "/sbin/tini", "--" ]

CMD [ "/tmp/config_wordpress.sh" ]