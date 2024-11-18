FROM alpine:3.19


COPY config_db.sh /tmp/config_db.sh

RUN (apk add --no-cache mariadb-server tini && \
	mkdir -p /var/lib/mysql && \
	chown -R mysql:mysql /var/lib/mysql) || \
	(echo "Failed to install MariaDB" >&2 ; exit 1) && \
	(mysql_install_db --user=mysql --datadir=/var/lib/mysql && \
	chmod +x /tmp/config_db.sh && \
	/tmp/config_db.sh && \
	rm /tmp/config_db.sh) || \
	(echo "Failed to configure MariaDB" >&2 ; exit 1)

VOLUME [ "/var/lib/mysql" ]

HEALTHCHECK CMD ["mysqladmin", "ping", "--silent"]

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/mysqld_safe"]

CMD ["--datadir=/var/lib/mysql"]