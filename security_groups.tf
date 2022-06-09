### Create a Security Group for the Application Load Balancer
### terraform aws security group
resource "aws_security_group" "alb_security_group" {
    name = "ALB Security Group"
    description = "Enable HTTP/HTTPS access on Port 80/443"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "HTTP Access"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTPS Access"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0 
        to_port = 0
        ### -1 is to allow all traffic
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "ALB_Security_Group"
    }
}


### Create a Security Group for the SSH/Bastion Host
### terraform aws security group
resource "aws_security_group" "ssh_security_group" {
    name = "ssh Security Group"
    description = "Enable SSH access on port 22"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "ssh Access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.ssh_location}"]
    }

    egress {
        from_port = 0 
        to_port = 0
        ### -1 is to allow all traffic
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "SSH_Security_Group"
    }
}


### Create a Security Group for the Webserver
### terraform aws security group
resource "aws_security_group" "webserver_security_group" {
    name = "Web Server Security Group"
    description = "Enable HTTP/HTTPS access on Port 80/443 via ALB and SSH on Port 22 via SSH SG"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "HTTP Access"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = ["${aws_security_group.alb_security_group.id}"]
    }

    ingress {
        description = "HTTPS Access"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        security_groups = ["${aws_security_group.alb_security_group.id}"]
    }

    ingress {
        description = "SSH Access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = ["${aws_security_group.ssh_security_group.id}"]
    }

    egress {
        from_port = 0 
        to_port = 0
        ### -1 is to allow all traffic
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "WebServer_Security_Group"
    }
}


### Create a Security Group for the Database
### terraform aws security group
resource "aws_security_group" "database_security_group" {
    name = "Databse Security Group"
    description = "Enable MYSQL Aurora access on Port 3306"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "MYSQL/Aurora Access"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = ["${aws_security_group.webserver_security_group.id}"]
    }

    egress {
        from_port = 0 
        to_port = 0
        ### -1 is to allow all traffic
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "Database_Security_Group"
    }
}