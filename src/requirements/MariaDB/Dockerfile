FROM alpine:3.19

COPY tools/config_mariadb.sh tools/my.cnf /tmp/

VOLUME [ "/var/lib/mysql" ]

RUN apk add --no-cache mariadb mariadb-client tini || \
	(echo "Failed to install MariaDB" >&2 ; exit 1) && \
	chmod +x /tmp/config_mariadb.sh || \
	(echo "Failed to prepare script for MariaDB" >&2 ; exit 1)

HEALTHCHECK --interval=5s --timeout=10s --start-period=10s --retries=3 CMD ["mysqladmin", "ping", "--silent"]

EXPOSE 3306

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/tmp/config_mariadb.sh"]