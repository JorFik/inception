#!/bin/sh

# Start the PHP built-in web server
php -S 0.0.0.0:80 -t /var/www/html &

# Wait for the PHP built-in web server to start
sleep 5

# Check if WordPress is running correctly
if curl -f http://localhost:80; then
    echo "WordPress is running correctly"
	kill %1
else
    echo "Failed to start WordPress"
	kill %1
    exit 1
fi
