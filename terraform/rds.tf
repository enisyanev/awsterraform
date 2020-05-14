## subnet used by rds
resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "rds-subnet-group"
  description = "RDS subnet group"
  subnet_ids = module.vpc.public_subnets
}

resource "aws_db_instance" "rds" {
  identifier = "database"
  allocated_storage = var.allocated_storage
  engine = "mysql"
  engine_version = "5.7"
  instance_class = var.db_instance_class
  multi_az = true
  name = var.db_name
  username = var.db_username
  password = var.db_password
  port = var.db_port
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.id
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot = true
  publicly_accessible = true
}