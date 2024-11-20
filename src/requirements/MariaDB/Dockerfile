FROM alpine:3.19

COPY config_db.sh /tmp/config_db.sh

VOLUME [ "/var/lib/mysql" ]

RUN (apk add --no-cache mariadb mariadb-client tini && \
	mkdir -p /var/lib/mysql && \
	chown -R mysql:mysql /var/lib/mysql) || \
	(echo "Failed to install MariaDB" >&2 ; exit 1) && \
	(mysql_install_db --user=mysql --datadir=/var/lib/mysql && \
	chmod +x /tmp/config_db.sh) || \
	(echo "Failed to prepare script for MariaDB" >&2 ; exit 1)

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 CMD ["mysqladmin", "ping", "--silent"]

EXPOSE 3306

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/tmp/config_db.sh"]