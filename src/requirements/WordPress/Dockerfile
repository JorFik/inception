FROM alpine:3.19

RUN (apk add --no-cache php83-fpm php83-mysqli tini && \
	mkdir -p /var/www/html && \
	chown -R nobody:nobody /var/www/html) || \
	(echo "Failed to install dependencies" >&2 ; exit 1)

EXPOSE 9000

WORKDIR /var/www/html

ENTRYPOINT [ "/sbin/tini", "--" ]

CMD [ "/usr/sbin/php-fpm83", "-F" ]