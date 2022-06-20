### This is why testing it on the AWS management console is important because 
### you are following the step in the console with the steps in Terraform

### FOR EXAMPLE: Creating the subnet, if you see it on the console, you will need
### to follow the same steps i.e. Vpc, cidr id, and the availability zone, etc 

# Create a VPC
# terraform aws vpc
resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    # small n in name will only show on the tag name and not on the Name in the VPC table
    # capital N in Name will show on the table Name and the tags
    Name = "vpc_demo_terraform"
  }
}

### INTERNET GATEWAY
### terraform aws internet gateway
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "VPC-Demo-Internet-Gateway"
  }
}

### Public Subnet A
### terraform aws subnet
resource "aws_subnet" "public_subnet_a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "${var.public_cidr_a}"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "VPC-Demo-Public-A"
  }
}

### Public Subnet B
### terraform aws subnet
resource "aws_subnet" "public_subnet_b" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "${var.public_cidr_b}"
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "VPC-Demo-Public-B"
  }
}

### Private Subnet A
### terraform aws subnet
resource "aws_subnet" "private_subnet_a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_cidr_a
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = false

  tags = {
    Name = "VPC-Demo-Private-A"
  }
}

### Private Subnet B
### terraform aws subnet
resource "aws_subnet" "private_subnet_b" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_cidr_b
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = false

  tags = {
    Name = "VPC-Demo-Private-B"
  }
}