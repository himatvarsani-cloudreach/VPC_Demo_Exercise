# VPC
variable "vpc_cidr" {
    description = "The cidr for the VPC"
    type = string
}

variable "vpc_name" {
    description = "The name of the vpc"
    type = string
}

# REGION
variable "region" {
    description = "The default region for the VPC"
    type = string
}


# INTERNET GATEWAY
variable "internet_gw_name" {
    description = "The name of the Internet Gateway"
    type = string
}


# NAT GATEWAY
variable "nat_gw_name" {
    description = "The name of the NAT Gateway"
    type = string
}


# INSTANCE TYPE
variable "instance_type" {
    description = "The type of instance for the server"
    type = string
    default = "t2.medium"
}


# SUBNET
# PUBLIC SUBNET
variable "public_cidr_a" {
    description = "CIDR of the public subnet A"
    type = string
}

variable "public_name" {
    description = "The name of the public subnet"
    type = string
}


# PRIVATE
variable "private_cidr_a" {
    description = "The CIDR of the private subnet A"
    type = string
}

variable "private_a_name" {
    description = "The name of the private subnet A"
    type = string
}

variable "private_cidr_b" {
    description = "the CIDR of the private subnet B"
    type = string
}

variable "private_b_name" {
    description = "The name of the private subnet B"
    type = string
}

# ROUTE TABLE
variable "rt_public_cidr" {
    description = "The CIDR route table of the public to internet gateway"
    type = string
}

variable "rt_private_cidr" {
    description = "The CIDR route table of the private to NAT gateway"
    type = string
}

variable "internet_gw_rt_name" {
    description = "The name for the internet gateway and the route table"
    type = string
}

variable "nat_gw_rt_name" {
    description = "The name for the NAT gateway and the private subnet route table"
    type = string
}