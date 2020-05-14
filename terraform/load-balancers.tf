resource "aws_alb" "alb" {
  name = "load-balancer"
  subnets = module.vpc.public_subnets
  security_groups = [aws_security_group.lb.id]

  tags = {
    Name = "load-balancer"
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name = "alb-target-group"
  port = 8080
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = module.vpc.vpc_id

  health_check {
    healthy_threshold   = 3
    interval            = 30
    protocol            = "HTTP"
    path                = "/"
    timeout             = 5
    matcher             = 200
    unhealthy_threshold = 3
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_alb.alb]

  tags = {
    Name = "alb-target-group"
  }
}

resource "aws_alb_listener" "openjobs" {
  load_balancer_arn = aws_alb.alb.arn
  port = 8080
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    type = "forward"
  }
}