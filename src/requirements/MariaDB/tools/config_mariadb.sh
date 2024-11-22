#!/bin/sh

if [ -f /run/secrets/credentials ]; then
	source /run/secrets/credentials
else
    echo "Credentials file not found"
	cat /run/secrets/credentials
    exit 1
fi

mv /tmp/my.cnf /etc/my.cnf

/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

# Esperar a que MariaDB se inicie
sleep 5

# Verificar que MariaDB esté corriendo
if ! pgrep mysqld > /dev/null; then
    echo "MariaDB no se está ejecutando"
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