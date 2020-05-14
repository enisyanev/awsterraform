data "template_file" "web_task" {
  template = file("web_task_definition.json")

  vars = {
    name      = var.container_name
    image     = var.image_name
    region    = var.region
    hostname  = aws_db_instance.rds.endpoint
    port      = var.db_port
    rds_name  = var.db_name
    username  = var.db_username
    password  = var.db_password
  }
}

resource "aws_ecs_task_definition" "web" {
  family = "web-task"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = "512"
  memory = "1024"
  container_definitions = data.template_file.web_task.rendered
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "web" {
  name = "web"
  cluster = aws_ecs_cluster.cluster.id
  task_definition = "${aws_ecs_task_definition.web.family}:${aws_ecs_task_definition.web.revision}"
  desired_count = var.desired_capacity
  launch_type = "FARGATE"

  network_configuration {
    subnets = module.vpc.public_subnets
    security_groups = [aws_security_group.ecs_tasks.id]
    assign_public_ip = true
  }

  load_balancer {
    container_name = var.container_name
    container_port = 8080
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_task_execution_role,
    aws_alb_target_group.alb_target_group]
}
