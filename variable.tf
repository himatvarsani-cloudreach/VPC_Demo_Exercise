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

variable "private_cidr_a" {
    default = "10.10.2.0/24"
    description = "Private Subnet A Cidr Block"
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

variable "database_snapshot_identifier" {
    ### AWS Console --> Search for RDS --> Snapshot --> select the snapshot --> Copy the ARN
    default = # arn details from video 7:20 - RDS Snapshot
    description = "The Database Snapshot ARN"
    type = string
}

variable "database_instance_class" {
    default = "db.t2.micro"
    description = "The Database Instance Type"
    type = string
}

variable "database_instance_identifier" {
    default = # "mysql57db" -- the name on the snapshot - 13:35 
    description = "The Database Instance Identifier"
    type = string
}

variable "multi_az_deployment" {
    default = false
    description = "Create a Standby DB Instance"
    type = bool
}