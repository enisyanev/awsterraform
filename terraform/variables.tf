variable "region" {
  default = "us-east-1"
  description = "The region to launch the host"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "The CIDR block of the VPC"
}

variable "public_subnet_cidr" {
  default = ["10.0.0.0/24", "10.0.1.0/24"]
  description = "The CIDR block of the public subnet"
}

variable "allocated_storage" {
  default = "5"
  description = "The storage size in GB"
}

variable "db_instance_class" {
  default = "db.t2.micro"
  description = "Instance class of the RDS"
}

variable "db_port" {
  default = 3306
  description = "The port of the rds instance"
}

variable "db_name" {
  default = "dbwebapp"
  description = "The database name"
}

variable "db_username" {
  default = "admin"
  description = "The database username"
}

variable "db_password" {
  default = "adminadmin"
  description = "The database password"
}

variable "cluster_name" {
  default = "webapp-cluster"
  description = "Name of the cluster"
}

variable "desired_capacity" {
  default = 2
  description = "Desired count of ec2 instances"
}

variable "min_size" {
  default = 2
  description = "Min allowed number of instances"
}

variable "max_size" {
  default = 3
  description = "Max allowed number of instances"
}

variable "image_name" {
  default = "enisyanev/awswebapp:1.1"
  description = "Docker image name"
}

variable "container_name" {
  default = "web"
  description = "name of the container"
}

variable "key_path" {
  description = "SSH key name for EC2 instance"
}