#!/bin/bash
# Second automated script for the Redis server set up in a VM
# @Parameters:
#	[1]: redis server password

# Parameters:
password=$1

# Superuser check
if [ $(id -u) != "0" ]; then
	echo "You must have superuser permissions to run the installation script" >&2
	exit
fi

lithops test

# 1. CREATE LITHOPS CONFIG FILE
echo "
lithops:
    backend: aws_lambda
    storage: aws_s3
    #data_cleaner: <True/False>
    #monitoring: storage
    #monitoring_interval: 2
    data_limit: False  # in MiB
    #execution_timeout: 1800
    #include_modules: <LIST_OF_MODULES>
    #exclude_modules: <LIST_OF_MODULES>
    #log_level: INFO
    #log_format: '%(asctime)s [%(levelname)s] %(name)s -- %(message)s'
    #log_stream: ext://sys.stdout
    #log_filename <path_to_a_file>
    #customized_runtime: <True/False>

aws:
    access_key_id:
    secret_access_key:
    account_id:

aws_s3:
    storage_bucket:
    region_name:

aws_lambda:
    execution_role:
    region_name:
    
redis:
    host: localhost
    port: 6379
    password: ${password}
" > .lithops/config

# 2. USER TASKS
echo "
PLEASE ACCESS LITHOPS CONFIG FILE AND FILL THE EMPTY FIELDS
In the command prompt:
cd .lithops/
vi config
(:wq to save and exit)

" 

echo "
PLEASE CONFIGURE NOW THE AWS CLIENT
In the command prompt:
aws configure
(fill the corresponding fields)
"
echo"
END
"

