### Route Table for the Internet Gateway Public Subnet
resource "aws_route_table" "public_to_internet_rt" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = var.rt_public_cidr
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
      name = var.internet_gw_rt_name
    }
}

### NAT GATEWAY ROUTE TABLE FOR PRIVATE GATEWAY
resource "aws_route_table" "public_subnet_rt" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = var.rt_private_cidr
        nat_gateway_id = aws_nat_gateway.nat_a.id
    }

    tags = {
      name = var.nat_gw_rt_name
    }
}

### ROUTE TABLE ASSOCIATION TO SUBNET PUBLIC A
resource "aws_route_table_association" "igw_for_public_a" {
    subnet_id = aws_subnet.public_a.id
    route_table_id = aws_route_table.public_to_internet_rt.id
}

### ROUTE TABLE ASSOCIATION TO SUBNET PRIVATE A
resource "aws_route_table_association" "private_a_rt" {
    subnet_id = aws_subnet.private_a.id
    route_table_id = aws_route_table.public_subnet_rt.id
}

### ROUTE TABLE ASSOCIATION TO SUBNET PRIVATE B
resource "aws_route_table_association" "private_b_rt" {
    subnet_id = aws_subnet.private_b.id
    route_table_id = aws_route_table.public_subnet_rt.id
}