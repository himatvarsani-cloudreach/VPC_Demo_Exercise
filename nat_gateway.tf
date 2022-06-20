### Allocate Elastic IP Address 1
### terraform aws allocate elastic ip
resource "aws_eip" "eip_for_nat_gw_1" {
    vpc = true 

    tags = {
        Name = "Elastic IP for nat_gw_1"
    }
}

### Allocate Elastic IP Address 2
### terraform aws allocate elastic ip
resource "aws_eip" "eip_for_nat_gw_2" {
    vpc = true 

    tags = {
        Name = "Elastic IP for nat_gw_2"
    }
}

### Better to create multiple NAT gateway for each subnets

### Create a NAT Gateway in the public subnet 1
### terraform aws nat gateway
resource "aws_nat_gateway" "nat_gw_1" {
    allocation_id = aws_eip.eip_for_nat_gw_1.id
    subnet_id = aws_subnet.public_subnet_a.id

    tags = {
      Name = "Nat Gateway Public Subnet A"
    }
}

### Create a NAT Gateway in the public subnet 2
### terraform aws nat gateway
resource "aws_nat_gateway" "nat_gw_2" {
    allocation_id = aws_eip.eip_for_nat_gw_2.id
    subnet_id = aws_subnet.public_subnet_b.id

    tags = {
      Name = "Nat Gateway Public Subnet B"
    }
}
