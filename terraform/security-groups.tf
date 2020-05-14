resource "aws_security_group" "lb" {
  name = "lb-security-group"
  description = "Controls access to the Load Balancer"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-security-group"
  }
}

resource "aws_security_group" "ecs_tasks" {
  name = "ecs-tasks-security-group"
  description = "Allow inbound access from the ALB only"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-security-group"
  }
}

resource "aws_security_group" "rds" {
  name = "rds-security-group"
  description = "Secourity group for RDS"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}