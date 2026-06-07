resource "aws_db_subnet_group" "db_subnet_group" {
    name = "my-db-subnet-group"
    subnet_ids = var.private_subnet_ids

    tags = {
      Name = "My DB Subnet Group"
    }
}

resource "aws_db_instance" "mysql_db" {
    allocated_storage = 20
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    db_name = "appdb"
    username = var.username_db
    password = var.password_db

    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    vpc_security_group_ids = [var.rds_sg_id]
    skip_final_snapshot = true
}

