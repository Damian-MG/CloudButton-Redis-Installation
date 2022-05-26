#!/bin/bash
# First automated script for the Redis server set up in a VM
# @Parameters:
# 	[1]: redis server password

# Parameters:
password=$1

# Superuser check
if [ $(id -u) != "0" ]; then
	echo "You must have superuser permissions to run the installation script" >&2
	exit
fi

# Update package information from all configured sources
apt-get update

# 1. REDIS
# Install Redis
apt install -y redis-server
# Modify Redis configuration file
sed -i "s/# requirepass foobared/requirepass ${password}/" /etc/redis/redis.conf
sed -i "s/^supervised no/supervised systemd/" /etc/redis/redis.conf
sed -i "s/^bind 127.0.0.1/# bind 127.0.0.1/" /etc/redis/redis.conf
# Restart the service
systemctl restart redis.service
systemctl status --no-pager redis

# 2. Dependencies installation
apt install -y python3-pip
apt install -y unzip

echo "
End of the installation script 1, continue by executing the installation script 2
"

