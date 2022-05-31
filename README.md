# CloudButton-Redis-Installation

Clone this repository and start configuring your VM
After cloning the repository move all its content to your user directory

    ```bash
    $ mv CloudButton-Redis-Installation/* /home/user/
    ```

## 1. Execute redis_server_installation_1.sh
    ```bash
    $ sudo ./redis_server_installation_1.sh redis_password
    ```
    
## 2. Execute redis_server_installation_2.sh
    ```bash
    $ ./redis_server_installation_2.sh redis_password
    ```
    
## 3. Fill the the configs suggested by redis_server_installation_2.sh
    ```bash
    PLEASE ACCESS LITHOPS CONFIG FILE AND FILL THE EMPTY FIELDS
    In the command prompt from /home/$(logname):
    $ vi .lithops/config
            (fill the corresponding fields)
    ('i' for insert mode, ':wq' to save and exit)
    ```
    
     ```bash
    PLEASE CONFIGURE NOW THE AWS CLIENT
    In the command prompt:
    $ aws configure
            AWS Access Key ID [None]: <Access Key ID>
            AWS Secret Access Key [None]: <Secret Access Key>
            Default region name [None]: <Region name>
            Default output format [None]: json
            (fill the corresponding fields)
    ```   
