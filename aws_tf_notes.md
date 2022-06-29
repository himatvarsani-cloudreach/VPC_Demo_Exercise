## AWS Documentation
**VPC with a single public subnet - Amazon Virtual Private Cloud**

[Link to AWS Documentation on VPC](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario1.html)

* Ssh on security group - your personal ip address - on google - whats my ip - i.e. 86.9.85.73
    * *Note: Don't use the Amazon version* 

![sg group](images/sg-group.png)
<br/>
<br/>
<br/>
## 1. The Architectural Diagram
![diagram](images/The-Architectural-Diagram.png)
<br/>
<br/>
<br/>
## 2. AWS Management Console 
- Management Console - create each * section - Do not use 'Default'
* Log in to AWS Management Console
* Change region to eu-west-1

#### **Creating a VPC**
* Go to the service and search for VPC
* Click on VPC - DO NOT CLICK ON VPC WIZARD
    * On the left hand panel --> click on Your VPC 
    * Click on 'Create VPC'
	* Under the VPC Settings
	    * Select VPC only
		* Give a name to your VPC - i.e. vpc_demo
		* IPv4 CIDR Block - i.e. 10.10.0.0/16
		* No IPv6 CIDR block
	* Choose Create VPC

#### **Creating the Internet Gateway**
* On the left hand panel click on Internet Gateways
* Click on Create internet gateway
* Under the internet gateway settings
	* Give it a name - i.e. Internet_gw
* Create internet gateway
* Once created - on the top right hand corner with a green banner --> Attach to a VPC --> Select your VPC name from the drop down list (i.e. vpc_demo)
* Click on Attach internet gateway

#### **Creating the Public Subnet**
* On the left hand panel click on Subnet
* Click on Create subnet
	* VPC ID --> Select your VPC i.e. vpc_demo
	* Subnet name i.e. public_cidr_a
	* Select the Availability Zone - i.e. Europe(Ireland) / eu-west-1a
	* IPv4 CIDR block - i.e. 10.10.1.0/24
* Click on Create subnet

#### **Creating the Public Route Table**
* On the left hand panel click on Route Table
* Click on Create route table
*VPC --> Select your VPC i.e. vpc_demo
* Click on Create route table

* Click on the Routes --> Edit routes
    * Add Route
	* 0.0.0.0/0
	* Type internet gateway
* Save changes 

* Click on the Subnet associate tab 
	* Edit subnet associations
	* Select the public subnet - i.e. public_cidr_a
* Save associations 

#### **Auto assign Public IP - SSH access**
* On the left hand panel click on Subnet
* Select the public subnet -i.e. public_cidr_a
* Action --> Edit subnet settings
* Under Auto-assign IP settings --> Check (Tick) Enable auto-assign public IPv4 address
* Save 

#### **Create a Key Value Pair**
* On the AWS Icon on the left hand side, right-click and open link in new tab
* Go to the service and search for EC2
* On the left hand panel scroll down to Network & Security --> Key Pairs
* Create key pairs
	* Name - i.e. vpc_demo_kp
	* Key pair type - RSA
	* Private key file format - .pem
* Create key pair
* The key pair file will download 
* Go to your user hidden files --> command + Shift + . --> It will show all the hidden files, search for ssh folder and paste your key pair file in this folder

#### **Creating an EC2 machine with t2.micro**
* Search for IAM
* Click on Roles --> Create role
    * AWS Service
    * Use case: EC2
    * Permission --> search for AmazonS3FullAccess
    * Role name --> VPC-EC2-S3-Role
* Create role

* **Go back to the EC2  - Make sure the region is correct - eu-west-1**
* On the left hand panel click on Instances
* Launch instances
	* Give it a name - i.e. webserver
	* Instance type - t2.micro
	* Select the key pair -- vpc_demo_kp
	* Network settings
		* Create security group
		* Security group Name - vpc_public_sg 
		* Security group --> ssh 0.0.0.0/0
* Launch instance

#### **SSH into the instance**
* Select the instance - select webserver
* Copy the public IPv4 -- i.e. 34.252.69.240
* Open the terminal
* Go to the path where the key pair is stored and change permission by typing the command
	* chmod 400 vpc_demo_kp.pem
* i.e. ~/.shh --> you can type ll -al
* Type the above command -- chmod 400 vpc_demo_kp.pem
* Type - ssh -i vpc_demo_kp.pem ec2-user@34.252.69.240  --> yes
	* You can type hostname -- to check host --> ip-10-10-1-142.eu-west-1.compute.internal -- this is the private ip address
* Now check if we can connect to the internet by ping google.com
    * Type ping google.com

    ![sg group](images/ping.png)

* When you type aws s3 ls --> you will get an error -- Unable to locate credentials. You can configure credentials by running "aws configure".

#### **Select the private_instance - Assigning IAM Role**
* Go back to the EC2 instance --> Security -- you will see that the IAM Role is blank
* Go to Action --> Security --> Modify IAM role --> IAM Role -- select VPC-EC2-S3-Role 
* Update 
* Go back to the terminal --> type aws s3 ls

#### **Creating the Private Subnet**
* Go to your VPC -- search for VPC
* On the left hand panel click on Subnet
* Create subnet
	* VPC ID --> Select your VPC i.e. vpc_demo
	* Subnet name i.e. private_cidr_a
	* Select the Availability Zone - i.e. Europe(Ireland) / eu-west-1a
	* IPv4 CIDR block - i.e. 10.10.2.0/24
* Click on Create subnet

#### **Creating the Private Route Table**
* On the left hand panel click on Route Table
* Click on Create route table
	* Name i.e. private_nat_gw_rt
	* VPC --> Select your VPC i.e. vpc_demo
* Click on Create route table
* Click on the Subnet associate tab 
	* Edit subnet associations
	* Select the public subnet - i.e. private_cidr_a
* Save associations 

* **Go back to the EC2  - Make sure the region is correct - eu-west-1**
* On the left hand panel click on Instances
* Launch instances
	* Give it a name - i.e. private_instance
	* Instance type - t2.micro
	* Select the key pair -- vpc_demo_kp
	* Network settings
	* By default the vpc and the private subnet should be automatically selected.
		* Create security group
		* Security group Name - vpc_private_sg 
		* Security group --> ssh, source type: custom, select the public sg from the list
* Launch instance

#### **Go back to the terminal**
* i.e. ~/.shh --> if you already in a connection, you can close the connection by typing exit 
* Type more vpc_demo_kp.pem
* Copy the key -- example
			
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAnjxlhiU8oUmgKXoTz5J59kq7qcWlxESqVbyFi1ZDQAA6astpzQFwqECGX6jy0ZDRXZD7PUdos0ojXl8L+BN74xaJ0Uoq9X57+mF9OFwXCC1R2K/n25gzX+/KPR8MpGpAPZcg416pjYMPXsZWuYZ88VDW+CXVK6Sk5mfbRCg6BVvhcQHrvFz5U4rGZMPfNHXW/7VO76QmNGi7dYVTJB+blaPdfjBkdFvYeonNWRc2N5uy+o04XM3ehKP37lcH/PpHW3HpHYlaxGTwPeORdCtpmeF1d8M9+zIfoy7NzkDihfOtTVRj4QvZypsXYTu426klEfQTxz8hHdCtrkb8vwIDAQABAoIBAB6YjwjhKlgGmwtFCSZJZQDvfN2ocTXEl1cm+KhRHGbnGUYVUz6BUJvRhhZn5kPn0hocRAYNXy2bfbvdQaXFMFjAxFlykAtlyDg1BgVwaCkLc/m82xyluJfC5ABTZmD523jHYjLMBDGvQIf1Vj+AMbeuknu13hSdPBq0Oy5R5pPG5I9ULItrD83+TN8gCrAwh3pxcCaq1nSbV6tI616vO3oXohAsCU/kWmza0UVLTEuhfvZJ3Y3I6+Vq49IdPbtBhvfPOhnLp4EjMYPDJUZkE5PdHaU2sAtoDgglx5xWHbWy+7hrPyuJjKJ1mzSRi7pnGAgt5/K8zbrDTbI1hIkBAECgYEA7R9+Pfymf4uGLsu5Hp8SrroA5EysiMCXrOajS3oms1ZXWzwETnuhnfsCwf7T+Ec+hrRXdqtPzYZir0J/njhAhI/ebdDxOFYoKZ44TeMEuWrnKUloHahJLbUNvu8+yuBa7srqe5V8F2yaQhK8Exl2vOcWZbpvPeQN/N0IU63Zwv0CgYEAqtU0WR6MAUqKot1cP4t929F9Ry01I4HXUYYf5RnJFKOnrUROQfX1GvlAGTh4DImHaNatit4jCRXoDOVLDXDgRS+WLW1URBFV++y5L9jOkrSVplV1HTQn9FwbBOynyoWCVyvkbd9gpQGyDttAP7sq5cdhIuMabmpWjZb2oydVgWsCgYByaOCbffzDy4kpqQgf2zbDcWGexdP1g59rQDkH4N8tZnptvc6CI6q+M++HtLGHuLBVhEwzKMMvcijJUTeMGq4eh+AVclwBB6kHM50ND30nDYqNZCrFLH5qfFIujvboIkodr3BlwqGGF9NyD+IJAR9GU+V9ne+wmAmbuPYckeRg7QKBgFHCtMkqa4t6p5uHIk1vb48zVigopNQXonvsG3vEuY5dPTUaCfJbyzFbtafcdOhbMimlBW3/HvmMOIFjhGYsbcnvGosnVjs1qNdn1sHlnAhu0WjIYcLWYYD8TBoxQaUV/OnHog5L6K9Qfm3J1Zgq9j7/C6hs1QufbUlaxTQU8UF9AoGBAOCWaKdRbH4c+rrE18GD5S7g8HeeUaNxhe7ZdMNQyu/1Q1pHbZhOc3nFppBDgXqRyaP49CHzwcLwwUdInL3TSDl6bI9uLGnB90rDezLZWMXngsxJMjT4JZoi62IScdeH3NqaqHKvHgAhGy9z2fdPd2vT7E/msiduncXfdUK7MnpZ
-----END RSA PRIVATE KEY-----
* Go back to the public ec2 instance -- ssh -i vpc_demo_kp.pem ec2-user@34.252.69.240
* Type vi vpc_demo_kp.pem
	* Paste the above private key to this file -- save and exit
	* chmod 400 vpc_demo_kp.pem
	* Type ping google.com
	* You can list the bucket --> aws s3 ls

* **Go back to the EC2  - Make sure the region is correct - eu-west-1**
    * Left hand side --> instances
    * Select private_instance
	    * Note there's no public IPv4 
	    * Copy Private IPv4 addresses --> i.e. 10.10.2.86

* **Go back to the terminal**
    * Go to the private ec2 instance -- ssh -i vpc_demo_kp.pem ec2-user@10.10.2.86

* **Select the private_instance - Assigning IAM Role**
    * Go to Action --> Security --> Modify IAM role --> IAM Role -- select VPC-EC2-S3-Role 

#### **Creating a NAT Gateway**
* Go back to the VPC
* On the left hand panel --> select NAT Gateway
* Create NAT gateway
	* Name --> i.e. nat_gw
	* Subnet --> public subnet -- i.e. public_cidr_a
	* Connectivity type: Public
	* Click on Allocate Elastic IP
* Create NAT gateway --> *may take a couple of minutes to create*

* Go to the Route Table
* Select the privates route table --> private_nat_gw_rt
* Go to the Route tab --> Edit routes
* Add route
	* 0.0.0.0/0
	* Select the NAT Gateway from the list
* Save changes

* **Go back to the terminal**
	* Type ping google.com
    * You can list the bucket --> aws s3 ls

* **Clean up - Delete the <u>Elastic IP</u> and <u>NAT Gateway</u> -- It will cost money**

* **Deleting the NAT Gateway**
* NAT Gateway - select the NAT Gateway --> Action, Delete NAT gateway --> delete
* Click on the Elastic IP --> Action, Release Elastic IP address

#### **Creating RDS**
* Go back to the RDS
* Subnet group --> Create DB subnet group
* Subnet group details
	* Name: my-db-subnet-group
	* Description: my-db-subnet-group
	* VPC: Select the VPC
	* Add subnets
		* Availability Zones: eu-west-1a and eu-wesst-1b
	* Subnets: Select the private subnet for the RDS i.e. 10.10.2.0/24
* Click on Create

### Creating VPC on the Management Console using the VPC and  more settings 
* Log in to AWS Management Console
* Change region to eu-west-1

#### **Creating a VPC**
* Go to the service and search for VPC
* Click on Create VPC
	* Select VPC and more
	* Name: call it --> manual_vpc_project
	* IPv4 CIDR Block: is auto generated but can be changed --> 10.0.0.0/16
	* No IPv6 block
	* Tenancy: Default
	* Number of Availability Zone: Default to 2
		* Click on Customize Azs
			* First: eu-west-1a
			* Second: eu-west-1b
	* Number of public subnet: Default to 2
	* Number of private subnet: Default to 2
		* Click on Customize Subnet CIDR blocks
			* 2x public subnet - you can leave it as default
			* 2x private subnet - you can leave it as default
			* NAT Gateway: 1 per AZ 
* Create VPC

![vpc workflow](images/vpc-workflow.png)

* **VPC: vpc-09e477f1977044903 / manual_vpc_project-vpc**
	* VPC ID: vpc-09e477f1977044903
	* IPv4 CIDR: 10.0.0.0/16

* **Subnet:**
	* Public Subnet 1: **subnet-0bb5968b3028cd9c4 / manual_vpc_project-subnet-public1-eu-west-1a**
		* Subnet ID: subnet-0bb5968b3028cd9c4
		* IPv4 CIDR: 10.0.0.0/20
        	* Availability Zone: eu-west-1a 
    	* **Route Table: rtb-09c279757ad429a7a / manual_vpc_project-rtb-public**
        	* Internet Gateway: 0.0.0.0/0  igw-022b92eba028b412b

    	* Public Subnet 2: **subnet-0a75ab2a8116b98be / manual_vpc_project-subnet-public2-eu-west-1b**
		* Subnet ID: subnet-0a75ab2a8116b98be
		* IPv4 CIDR: 10.0.16.0/20
	        * Availability Zone: eu-west-1b
    	* **Route Table: rtb-09c279757ad429a7a / manual_vpc_project-rtb-public**
        	* Internet Gateway: 0.0.0.0/0  igw-022b92eba028b412b

    	* Private Subnet 1: **subnet-05a3cb87b83da649b / manual_vpc_project-subnet-private1-eu-west-1a**
		* Subnet ID: subnet-05a3cb87b83da649b
		* IPv4 CIDR: 10.0.128.0/20
		* Availability Zone: eu-west-1a
	* **Route Table: rtb-05a2ae2b4b3a762bb / manual_vpc_project-rtb-private1-eu-west-1a**
		* NAT Gateway: 0.0.0.0/0  nat-0aad76494d1a4b490

	* Private Subnet 2: **subnet-0a3d2b4671685860d / manual_vpc_project-subnet-private2-eu-west-1b**
		* Subnet ID: subnet-0a3d2b4671685860d
		* IPv4 CIDR: 10.0.144.0/20
		* Availability Zone: eu-west-1b
	* **Route Table: rtb-02bcd46b91cc38f93 / manual_vpc_project-rtb-private2-eu-west-1b**
		* NAT Gateway: 0.0.0.0/0  nat-0fe4640b4817674

* **NAT gateways:**
	* **nat-0aad76494d1a4b490 / manual_vpc_project-nat-public1-eu-west-1a**
		* **Elastic IP:** 46.51.179.239
		* **Private IP address:** 10.0.1.162
		
	* **nat-0fe4640bcb4817674 / manual_vpc_project-nat-public2-eu-west-1b** 
		* **Elastic IP:** 79.125.84.131
		* **Private IP address:** 10.0.29.238

* **Security:**
* **NACLs**
* **Inbound Rules**
	* Rule Number: 100
	* Type: All Traffic
	* Protocol: All
	* Port Range: All
	* Allow/Deny: Allow
	* Rule Number: *
	* Type: All Traffic
	* Protocol: All
	* Port Range: All
	* Allow/Deny: Deny
* **Outbound Rules**
	* Rule Number: 100
	* Type: All Traffic
	* Protocol: All
	* Port Range: All
	* Allow/Deny: Allow
	* Rule Number: *
	* Type: All Traffic
	* Protocol: All
	* Port Range: All
	* Allow/Deny: Deny
	
* **Security Groups: <u>sg-0809c466aae533f19</u>**
* **Inbound Rules**
	* Security group rule: sgr-00c1718044b8ac0d1
	* Type: All traffic
	* Protocol: All
	* Port Range: All
	* Source: sg-0809c466aae533f19 / default

* **Outbound Rules**
	* Security group rule: sgr-06307bed604f5acb3
	* Type: All traffic
	* Protocol: All
	* Port Range: All
	* Destination: 0.0.0.0/0
	
## 3. Terraform
Github: [Terraform GitHub Link](https://github.com/himatvarsani-cloudreach/VPC_Demo_Exercise)

export AWS_PROFILE="cloudreach-ta-lab"

export AWS_DEFAULT_REGION="eu-west-1"

### Resource Blockresource-block


![resource block](images/Resource-Block.png)

* Resource - type the word resource
* Resource type - the name provided by aws i.e. "aws_vpc"
* Resource name - a local name - you can give it any name i.e. "vpc"

### Terraform Files
<p>	If you add the tag name in a small letter i.e. name = - this will not show the name on the resource table only on the tags section.<br/>
If you add the tag name in a capital letter i.e. Name = - this will will populate the name on the resource table and the tags</p>


### backend.tf 
* s3 --> you have to create the bucket manually from the AWS management console
###  provider.tf
* required provider (optional) - source and version of hashicorp
* region
### main.tf
* vpc - main cidr block 
* internet gateway
* 2x  public and 2x private subnets
### nat_gateway.tf
* elastic ip
* 2x nat gateway
### route_table.tf
* Route table for public and private subnet
* Route table association for public and private subnet
* All your security groups
### Security_groups.tf
* All your security rules
### output.tf
### rds.tf
* RDS database

## Useful links:

* [AWS Architectural Lucid Diagram](https://lucid.app/lucidchart/6cfffd9f-62da-4f98-aa67-ac73d7414f6b/edit?beaconFlowId=DDC1FA11BA541A3E&invitationId=inv_599cf846-672b-4344-b2d9-4eb346ca283d&page=0_0#)
<br/>

* [AWS VPC with a single public subnet](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario1.html#VPC_Scenario1_Security)
<br/>

* [Tutorial: Creating a VPC with public and private subnets for Your compute environments](https://docs.aws.amazon.com/batch/latest/userguide/create-public-private-vpc.html)
<br/>

* [Youtube link: Amazon VPC And Networking - Hands-On Demo](https://www.youtube.com/watch?v=4z_-VkRg_Bs)
<br/>

* [Youtube Link - creating an app with myphp and RDS: Demo | Three-tier web app in AWS with VPC, ALB, EC2 & RDS](https://www.youtube.com/watch?v=sCBTeMd0Jj4)
<br/>

* [Github Repo](https://github.com/mycloudtutorials/aws-demos/tree/master/aws-vpc-and-networking)
<br/>

* [Youtube link: How to Authenticate Terraform with AWS Provider](https://www.youtube.com/watch?v=_TPIs6iG71I&list=PL184oVW5ERMDGN0a7yowSQiH4qjsTeE5g&index=9)
<br/>

* [Youtube link (Creating an RDS): Create a MySQL RDS Instance using Terraform](https://www.youtube.com/watch?v=WFFxqJOLh5I)
<br/>

* [LAMP STACK](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-lamp-amazon-linux-2.html)
<br/>

* [Terraform aws db instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance)
