output "vpc_id" {
  value = module.vpc.vpc_id
}

output "dns_name" {
  value = aws_alb.alb.dns_name
}