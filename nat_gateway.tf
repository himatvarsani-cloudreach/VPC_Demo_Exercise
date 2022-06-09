### Allocate Elastic IP Address 
### terraform aws allocate elastic ip
resource "aws_eip" "eip_for_nat_gw" {
    vpc = true 

    tags = {
        Name = "Elastic IP for nat_gw"
    }
}

### Create a NAT Gateway in the public subnet 1
### terraform aws nat gateway
resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.eip_for_nat_gw.id
    subnet_id = aws_subnet.public_subnet_a.id

    tags = {
      Name = "Nat Gateway Public Subnet"
    }
}


### Create a Private Route Table and add Route through NAT Gateway
### terraform aws route table
resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = var.rt_private_cidr
        nat_gateway_id = aws_nat_gateway.nat_gw.id
    }

    tags = {
      Name = "Route table to a NAT Gateway for Private Subnet"
    }
}