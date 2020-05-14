module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "VPC for Cluster ${var.cluster_name}"
  cidr = var.vpc_cidr

  azs = [data.aws_availability_zones.availability_zones.names[0], data.aws_availability_zones.availability_zones.names[1]]
  public_subnets = var.public_subnet_cidr

  map_public_ip_on_launch = true
  enable_dns_hostnames = true
  enable_dns_support = true
}