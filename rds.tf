### Create Database Subnet Group
### terraform aws db subnet group
resource "aws_db_subnet_group" "database_subnet_group" {
    name = "database subnet"
    ## How do I simplify this
    subnet_ids = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id, aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
    description = "Subnet for Databse Instance"

    tags = {
      Name = "Database_Subnets"
    }
}


resource "aws_db_instance" "demo-mysql-db" {
    identifier = "mysqldatabase-terraform"
    storage_type = "gp2"
    allocated_storage = 20
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t2.micro"
    port = "3306"
    username = "admin"
    password = "terraform1234"
    db_subnet_group_name = aws_db_subnet_group.database_subnet_group.id
    name = "mydb"
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot = true # if false is specified, a DB snapshot is created before the DB instance is deleted

    tags = {
        Name= "Demo MySQL RDS Instance"
    }
#   allocated_storage    = 10
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t3.micro"
#   name                 = "mydb"
#   username             = "foo"
#   password             = "foobarbaz"
#   parameter_group_name = "default.mysql5.7"
#   skip_final_snapshot  = true
}


# ### Get the Latest DB Snapshot
# ### terraform aws data db snapshot
# data "aws_db_snapshot" "latest_db_sanpshot" {
#     db_snapshot_identifier = var.database_snapshot_identifier
#     most_recent = true
#     snapshot_type = "manual"
# }

# ### Create Database Instance Restored from DB Snapshots
# ### terraform aws db instance
# resource "aws_db_instance" "database_instance" {
#     instance_class = var.database_instance_class
#     skip_final_snapshot = true
#     availability_zone = "${var.region}a"
#     identifier = var.database_instance_identifier
#     snapshot_identifier = data.aws_db_snapshot.latest_db_sanpshot.id
#     db_subnet_group_name = aws_db_subnet_group.database_subnet_group.name
#     multi_az = var.multi_az_deployment
#     vpc_security_group_ids = [aws_security_group.database_security_group.id]
# }