# VPC
vpc_cidr = "10.10.0.0/16"
vpc_name = "VPC-DEMO"
region = "eu-west-1"

# INTERNET GATEWAY
internet_gw_name = "VPC-Demo-Internet-Gateway"

# NAT GATEWAY
nat_gw_name = "VPC-Demo-NAT-Gateway"

# SUBNET
# PUBLIC
public_cidr_a = "10.10.1.0/24"
public_name = "VPC-Demo-Public-A"

# PRIVATE
private_cidr_a = "10.10.2.0/24"
private_a_name = "VPC-Demo-Private-A"
private_cidr_b = "10.10.3.0/24"
private_b_name = "VPC-Demo-Private-B"

# ROUTE TABLE
rt_public_cidr = "0.0.0.0/0"
rt_private_cidr = "0.0.0.0/0"
internet_gw_rt_name = "internet-gateway-route-table"
nat_gw_rt_name = "public-rt"