#!/bin/sh

if [ -f /run/secrets/credentials ]; then
	source /run/secrets/credentials
else
    echo "Credentials file not found"
	cat /run/secrets/credentials
    exit 1
fi

(mkdir -p /var/lib/mysql /var/log/mysql && \
chown -R mysql:mysql /var/lib/mysql && \
chown -R mysql:mysql /var/log/mysql && \
mysql_install_db --user=mysql --datadir=/var/lib/mysql) || \
	(echo "Failed to install MariaDB" >&2 ; exit 1)

mv /tmp/my.cnf /etc/my.cnf

/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

i=30
while [ $i -gt 0 ]; do
    if mysqladmin ping &>/dev/null; then
        break
    fi
    echo 'Esperando a que MariaDB se inicie...'
    sleep 1
    i=$((i-1))
done

# Verificar que MariaDB esté corriendo
if ! pgrep mysqld > /dev/null; then
    echo "MariaDB no se está ejecutando"
    cat /var/lib/mysql/*.err
    exit 1
fi

echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > wp_db.sql
echo "CREATE USER IF NOT EXISTS '$DB_USR'@'%' IDENTIFIED BY '$DB_PWD' ;" >> wp_db.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USR'@'%' ;" >> wp_db.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PWD' ;" >> wp_db.sql
echo "FLUSH PRIVILEGES;" >> wp_db.sql

mysql -u root -p"$ROOT_PWD" < wp_db.sql

mysqladmin -u root -p"$ROOT_PWD" shutdown

rm wp_db.sql

exec /usr/bin/mysqld_safe --datadir=/var/lib/mysql