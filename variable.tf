variable "vpc_cidr" {
    default = "10.10.0.0/16"
    description = "VPC CIDR Block"
    type = string
}

variable "region" {
    default = "eu-west-1"
    description = "The default region for the VPC"
    type = string
}

variable "public_cidr_a" {
    default = "10.10.1.0/24"
    description = "Public Subnet A Cidr Block"
    type = string
}

variable "public_cidr_b" {
    default = "10.10.2.0/24"
    description = "Public Subnet B Cidr Block"
    type = string
}

variable "private_cidr_a" {
    default = "10.10.3.0/24"
    description = "Private Subnet A Cidr Block"
    type = string
}

variable "private_cidr_b" {
    default = "10.10.4.0/24"
    description = "Private Subnet B Cidr Block"
    type = string
}

variable "rt_public_cidr" {
    default = "0.0.0.0/0"
    description = "The cidr block for the public route table"
    type = string
}

variable "rt_private_cidr" {
    default = "0.0.0.0/0"
    description = "The cidr block for the private route table"
    type = string
}

variable "ssh_location" {
    ### My IP Address
    default = "0.0.0.0/0"
    description = "IP Address that can SSH Into the EC2 Instance"
    type = string
}