#!/bin/bash

source /run/secrets/credentials

echo "CREATE DATABASE IF NOT EXISTS $db_name ;" > wp_db.sql
echo "CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_pwd' ;" >> wp_db.sql
echo "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%' ;" >> wp_db.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$root_pass' ;" >> wp_db.sql
echo "FLUSH PRIVILEGES;" >> wp_db.sql

mysql < wp_db.sql

rm wp_db.sql