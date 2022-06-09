### Create Database Subnet Group
### terraform aws db subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
    name = "database subnet"
    subnet_ids = [aws_subnet.private_subnet_a.id]
    description = "Subnet for Databse Instance"

    tags = {
      Name = "Database_Subnets"
    }
}

### Get the Latest DB Snapshot
### terraform aws data db snapshot
data "aws_db_snapshot" "latest_db_sanpshot" {
    db_snapshot_identifier = var.database_snapshot_identifier
    most_recent = true
    snapshot_type = "manual"
}

### Create Database Instance Restored from DB Snapshots
### terraform aws db instance
resource "aws_db_instance" "database_instance" {
    instance_class = var.database_instance_class
    skip_final_snapshot = true
    availability_zone = "${var.region}a"
    identifier = var.database_instance_identifier
    snapshot_identifier = data.aws_db_snapshot.latest_db_sanpshot.id
    db_subnet_group_name = aws_db_subnet_group.database_subnet_group.name
    multi_az = var.multi_az_deployment
    vpc_security_group_ids = [aws_security_group.database_security_group.id]
}