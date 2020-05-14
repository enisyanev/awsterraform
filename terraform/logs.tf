resource "aws_cloudwatch_log_group" "log_group" {
  name = "/ecs/web"
  retention_in_days = 30

  tags = {
    Name = "web-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name = "web-log-stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}