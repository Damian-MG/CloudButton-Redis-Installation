# CloudButton-Redis-Installation

Clone this repository and start configuring your VM
After cloning the repository move all its content to your user directory

    ```bash
    $ mv CloudButton-Redis-Installation/* /home/user/
    ```

## 1. Execute redis_installation_1.sh
    ```bash
    $ sudo ./redis_server_installation.sh redis_password
    ```
## 2. Fill the the configs suggested by redis_server_installation.sh
    ```bash
    PLEASE ACCESS LITHOPS CONFIG FILE AND FILL THE EMPTY FIELDS
    In the command prompt:
    cd .lithops/
    vi config
    ('i' for insert mode, ':wq' to save and exit)
    ```
    
     ```bash
    PLEASE CONFIGURE NOW THE AWS CLIENT
    In the command prompt:
    aws configure
    (fill the corresponding fields)
    ```   
