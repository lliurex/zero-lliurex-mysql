#!/bin/bash

# Initialize MySQL
echo "Initializing MySQL data directory..."
docker-entrypoint.sh --initialize-insecure

# Start MySQL in the background
echo "Starting MySQL in temporary mode..."
docker-entrypoint.sh mysqld --skip-networking --daemonize
sleep 5

# Grant root access from any host
echo "Granting root access from any host..."
mysql -u root -p12345 -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '12345';"
mysql -u root -p12345 -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
mysql -u root -p12345 -e "FLUSH PRIVILEGES;"

# Kill the temporary MySQL instance
echo "Stopping temporary MySQL instance..."
pkill mysqld

# Start MySQL normally
echo "Starting MySQL in normal mode..."
exec docker-entrypoint.sh mysqld

