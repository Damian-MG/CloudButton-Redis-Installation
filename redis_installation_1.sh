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

# 2. LITHOPS
apt install -y python3-pip
pip install lithops
lithops test
# After restart (needed for .lithops/ to be created) we will configure lithops config

# 3. AWS dependencies (aws-cli and boto3)
apt install -y unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

python3 -m pip install boto3

echo "PLEASE RESTART THE VIRTUAL MACHINE AND EXECUTE redis_installation_2.sh"
# END


