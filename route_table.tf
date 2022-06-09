### Create Route Table and add Public Route
### terraform aws route table
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "${var.rt_public_cidr}"
        gateway_id = aws_internet_gateway.internet_gw.id
    }

    tags = {
        Name = "internet-gateway-route-table"
    }
}

### Associate Public Subnet A to a Public Route Table
### terraform aws association subnet to route table
resource "aws_route_table_association" "public_subnet_a_rt_association" {
    subnet_id = aws_subnet.public_subnet_a.id
    route_table_id = aws_route_table.public_route_table.id
}

### Associate Private Subnet A to a Private Route table
### terraform aws association subnet to route table
resource "aws_route_table_association" "private_subnet_a_rt_association" {
    subnet_id = aws_subnet.private_subnet_a.id
    route_table_id = aws_route_table.private_route_table.id
}