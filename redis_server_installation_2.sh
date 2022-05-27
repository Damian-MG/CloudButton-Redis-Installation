#!/bin/bash
# Second automated script for the Redis server set up in a VM
# @Parameters:
# 	[1]: redis server password

# Parameters:
password=$1

# Superuser check
if [ $(id -u) != "0" ]; then
	# 1. Lithops installation and test
	python3 -m pip install lithops
	lithops test

	# 2. AWS dependencies (aws-cli and boto3)
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	./aws/install

	#python3 -m pip install boto3

	# 3. Lithops test again in case .lithops/ folder hasn't been created
	lithops test
	mkdir .lithops/

	# 4. Create Lithops config file
	echo "lithops:
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
	    password: ${password}" > .lithops/config

	 # 5. User tasks
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

	echo "
	End of the installation script, please read carefully the previous lines to end the configuration of the Virtual Machine
	"
else
	echo "You mustn't have superuser permissions to run the installation script" >&2
	exit
fi



