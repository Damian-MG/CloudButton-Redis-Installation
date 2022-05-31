# CloudButton-Redis-Installation

## 1. Configuration of the Virtual Machine

## 2. Installation and Configuration of software used in the Virtual Machine
Clone this repository and start configuring your VM
After cloning the repository move all its content to your user directory

    ```bash
    $ mv CloudButton-Redis-Installation/* /home/user/
    ```

 ### 2.1 Execute redis_server_installation_1.sh
    ```bash
    $ sudo ./redis_server_installation_1.sh redis_password
    ```
    
### 2.2 Execute redis_server_installation_2.sh
    ```bash
    $ ./redis_server_installation_2.sh redis_password
    ```
    
### 2.3 Fill the the configs suggested by redis_server_installation_2.sh
    PLEASE ACCESS LITHOPS CONFIG FILE AND FILL THE EMPTY FIELDS
    In the command prompt from /home/$(logname):
    ```bash
    $ vi .lithops/config
            (fill the corresponding fields)
    ('i' for insert mode, ':wq' to save and exit)
    ```
    
    PLEASE CONFIGURE NOW THE AWS CLIENT
    In the command prompt:
     ```bash
    $ aws configure
            AWS Access Key ID [None]: <Access Key ID>
            AWS Secret Access Key [None]: <Secret Access Key>
            Default region name [None]: <Region name>
            Default output format [None]: json
            (fill the corresponding fields)
    ```   
