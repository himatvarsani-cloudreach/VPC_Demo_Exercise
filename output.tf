output "my_vpc_id" {
    value = aws_vpc.vpc.id
}

output "public_subnet_a_id" {
    value = aws_subnet.public_subnet_a.id
}

output "private_subnet_a_id" {
    value = aws_subnet.private_subnet_a.id
}

output "elastic_ip_1" {
    value = aws_eip.eip_for_nat_gw_1.public_ip
}

output "elastic_ip_2" {
    value = aws_eip.eip_for_nat_gw_2.public_ip
}