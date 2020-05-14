//resource "aws_appautoscaling_target" "target" {
//  max_capacity = var.max_size
//  min_capacity = var.min_size
//  resource_id = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.web.name}"
//  scalable_dimension = "ecs:service:DesiredCount"
//  service_namespace = "ecs"
//  role_arn = ""
//}
//
//resource "aws_appautoscaling_policy" "up" {
//  name = "scale_up"
//  resource_id = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.web.name}"
//  scalable_dimension = "ecs:service:DesiredCount"
//  service_namespace = "ecs"
//
//  step_scaling_policy_configuration {
//    adjustment_type = "ChangeInCapacity"
//    cooldown = 60
//    metric_aggregation_type = "Maximum"
//
//    step_adjustment {
//      scaling_adjustment = 1
//      metric_interval_lower_bound = 0
//    }
//  }
//
//  depends_on = [aws_appautoscaling_target.target]
//}
//
//resource "aws_appautoscaling_policy" "down" {
//  name = "scale_down"
//  resource_id = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.web.name}"
//  scalable_dimension = "ecs:service:DesiredCount"
//  service_namespace = "ecs"
//
//  step_scaling_policy_configuration {
//    adjustment_type = "ChangeInCapacity"
//    cooldown = 60
//    metric_aggregation_type = "Maximum"
//
//    step_adjustment {
//      scaling_adjustment = -1
//      metric_interval_lower_bound = 0
//    }
//  }
//
//  depends_on = [aws_appautoscaling_target.target]
//}
//
//resource "aws_cloudwatch_metric_alarm" "service_cpu_high" {
//  alarm_name = "openjobs_web_cpu_utilization_high"
//  comparison_operator = "GreaterThanOrEqualToTreshold"
//  evaluation_periods = "2"
//  threshold = "85"
//  metric_name = "CPUUtilization"
//  namespace = "AWS/ECS"
//  period = "60"
//  statistic = "Maximum"
//
//  dimensions = {
//    ClusterName = aws_ecs_cluster.cluster.name
//    ServiceName = aws_ecs_service.web.name
//  }
//
//  alarm_actions = [aws_appautoscaling_policy.up.arn]
//  ok_actions = [aws_appautoscaling_policy.down.arn]
//}