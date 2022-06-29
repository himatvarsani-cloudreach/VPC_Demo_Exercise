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
