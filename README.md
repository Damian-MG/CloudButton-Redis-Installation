# CloudButton-Redis-Installation

## 1. Virtual Machine configuration

### 1.1 Virtual Machine Image (OS)
Cloud providers offer a wide variety of images depending on the needs of the user. The operating system that is recommended for Hutton's genomic use case is ubuntu, and more specifically we recommend the Ubuntu Server version.

* Currently (June 2022) Lithops does not support python 3.10, as AWS lambda functions do not support this version of python, so we recommend using Ubuntu Server 20.04 (which includes Python 3.8)
* Even so, it is possible to use Lithops with Python 3.10 which is included in Ubuntu Server 22.04, but in this case the default runtime provided by Lithops cannot be used and a specific runtime that includes Python 3.10 will have to be created using Docker.

*Both operating systems are included in the AWS Free Tier*

### 1.2 Instance type
The choice of the type of virtual machine to use depends on the requirements of your application and your experiment. We recommend using the machines included in the AWS free tier, and if necessary, use a more powerful machine (family, cpu, memory).

* To start getting familiar with these virtual machines you can use the t2.micro machine from the t2 family (general purpose), featuring 1 virtual CPU and 1 GiB of memory

### 1.3 Login Key Pair
To access the virtual machine and control it from your personal computer, you need to generate a unique pair of keys that will authenticate you when connecting to the machine via the ssh protocol. This key pair can be generated using the AWS console, and you will need to carefully safeguard your private key on your computer.

*In order to connect to the Virtual Machine from your personal computer*

```bash
$ ssh -i private_key.pem ubuntu@<VirtualMachine_IP>
```

### 1.4 Network configuration
Network configuration is crucial to keep our virtual machine secure and functional. This configuration will depend on the needs of our application. Below we will detail the configuration used for Hutton's genomic use case.

We will allow all outgoing traffic and control all incoming traffic

#### Outgoing traffic rules
<table>
<tr>
<th align="center">
<img width="250" height="1px">
<p>
<small>
Type</a>
</small>
</p>
</th>
<th align="center">
<img width="250" height="1px">
<p>
<small>
Protocol</a>
</small>
<small>
</small>
</p>
</th>
<th align="center">
<img width="250" height="1px">
<p>
<small>
Port Interval</a>
</small>
<small>
</small>
</p>
</th>
<th align="center">
<img width="250" height="1px">
<p>
<small>
Destination</a>
</small>
</p>
</th>
</tr>
<tr>
<td align="center">
All the traffic
</td>

<td align="center">
All
</td>    
    
<td align="center">
All
</td>

<td align="center">
0.0.0.0/0 (All)
</td>
</tr>
</table>


#### Incoming traffic rules
<table>
<tr>
<th align="center">
<img width="250" height="1px">
<p>
<small>
Type</a>
</small>
</p>
</th>
<th align="center">
<img width="100" height="1px">
<p>
<small>
Protocol</a>
</small>
<small>
</small>
</p>
</th>
<th align="center">
<img width="100" height="1px">
<p>
<small>
Port Interval</a>
</small>
<small>
</small>
</p>
</th>
<th align="center">
<img width="200" height="1px">
<p>
<small>
Origin</a>
</small>
<small>
</small>
</p>
</th>
<th align="center">
<img width="250" height="1px">
<p>
<small>
Description</a>
</small>
</p>
</th>
</tr>

<tr>
<td align="center">
SSH
</td>
<td align="center">
TCP
</td>    
<td align="center">
22
</td>    
<td align="center">
0.0.0.0/0 (All)
</td>
<td align="center">
SSH for admin Desktop
</td>
</tr>

<tr>
<td align="center">
TCP customized
</td>
<td align="center">
TCP
</td>    
<td align="center">
6379
</td>    
<td align="center">
0.0.0.0/0 (All)
</td>
<td align="center">
Redis (protected with password)
</td>
</tr>

<tr>
<td align="center">
TCP customized
</td>
<td align="center">
TCP
</td>    
<td align="center">
11222
</td>    
<td align="center">
0.0.0.0/0 (All)
</td>
<td align="center">
Infinispan (alternative to redis)
</td>
</tr>

<tr>
<td align="center">
TCP customized
</td>
<td align="center">
TCP
</td>    
<td align="center">
2375
</td>    
<td align="center">
0.0.0.0/0 (All)
</td>
<td align="center">
Docker daemon
</td>
</tr>

<tr>
<td align="center">
TCP customized
</td>
<td align="center">
TCP
</td>    
<td align="center">
2376
</td>    
<td align="center">
0.0.0.0/0 (All)
</td>
<td align="center">
Docker daemon encrypted
</td>
</tr>

</table>

### 1.5 Storage configuration
In the event that disk storage is needed, the necessary gigabytes of storage can be allocated thanks to a virtual disk (EBS in the case of AWS). We recommend using the minimum necessary disk, and increasing its size depending on the user's needs.
```bash
1 x * GiB gp2 root volume (Example for AWS EC2)
```

### 1.6 Static IP
If you want your virtual machine to have a fixed/static IP, you can create a new elastic IP (in the case of AWS) and assign it to your recently created virtual machine.


## 2. Installation and Configuration of software used in the Virtual Machine
Clone this repository and start configuring your VM
After cloning the repository move all its content to your user directory
```bash
In the command prompt:
$ mv CloudButton-Redis-Installation/* /home/user_name/
```

 ### 2.1 Execute redis_server_installation_1.sh
```bash
In the command prompt:
$ sudo ./redis_server_installation_1.sh redis_password
```
    
### 2.2 Execute redis_server_installation_2.sh
```bash
In the command prompt:
$ ./redis_server_installation_2.sh redis_password
```
   
### 2.3 Fill the the configs suggested by redis_server_installation_2.sh
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

## 3. Testing correct installation
Close the terminal where you performed the installation, and open a new one, so you are using the uptdated $PATH. Test lithops with the following command, or use the snippets of the official [Lithops' repository](https://github.com/lithops-cloud/lithops) to implement your own program. 
```bash
$ lithops test
```
