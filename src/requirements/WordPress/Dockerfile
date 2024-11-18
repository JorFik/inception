FROM alpine:3.19

RUN (apk add --no-cache wordpress php-fpm tini && \
	mkdir -p /var/www/html && \
	chown -R nobody:nobody /var/www/html) || \
	(echo "Failed to install WordPress" >&2 ; exit 1)

EXPOSE 9000 3306

ENTRYPOINT [ "/sbin/tini", "--" ]

CMD [ "/usr/sbin/php-fpm7", "-F" ]