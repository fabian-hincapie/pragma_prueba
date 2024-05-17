#######Cluster

resource "aws_cloudwatch_log_group" "ecs-cluster" {
  name              = "/ecs/cluster"
  retention_in_days = 150
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_cluster" {
  alarm_name          = "cluster-${var.project}-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CpuUtilized"
  namespace           = "ECS/ContainerInsights"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "This metric monitors ECS CLUSTER CPU utilization"
  dimensions = {
    ClusterName = aws_ecs_cluster.ecs-cluster.name
  }

  alarm_actions = [aws_sns_topic.monitoreo.arn]
}

resource "aws_cloudwatch_metric_alarm" "ram_alarm_cluster" {
  alarm_name          = "cluster-${var.project}-ram-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MemoryUtilized"
  namespace           = "ECS/ContainerInsights"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "This metric monitors ECS CLUSTER CPU utilization"
  dimensions = {
    ClusterName = aws_ecs_cluster.ecs-cluster.name
  }

  alarm_actions = [aws_sns_topic.monitoreo.arn]
}


######frontend#######

resource "aws_cloudwatch_log_group" "log-front" {
  name              = "/ecs/front"
  retention_in_days = 150
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_fargate" {
  alarm_name          = "front-${var.project}-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "This metric monitors task CPU utilization"
  dimensions = {
    ClusterName = aws_ecs_cluster.ecs-cluster.name
    ServiceName = aws_ecs_service.front.name
  }

  alarm_actions = [aws_sns_topic.monitoreo.arn]
}

resource "aws_cloudwatch_metric_alarm" "ram_alarm_fargate" {
  alarm_name          = "front-${var.project}-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "This metric monitors task CPU utilization"
  dimensions = {
    ClusterName = aws_ecs_cluster.ecs-cluster.name
    ServiceName = aws_ecs_service.front.name
  }

  alarm_actions = [aws_sns_topic.monitoreo.arn]
}

########Backend#######

resource "aws_cloudwatch_log_group" "log-back" {
  name              = "/ecs/back"
  retention_in_days = 150
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_back" {
  alarm_name          = "back-${var.project}-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "This metric monitors task CPU utilization"
  dimensions = {
    ClusterName = aws_ecs_cluster.ecs-cluster.name
    ServiceName = aws_ecs_service.front.name
  }

  alarm_actions = [aws_sns_topic.monitoreo.arn]
}

resource "aws_cloudwatch_metric_alarm" "ram_alarm_back" {
  alarm_name          = "back-${var.project}-ram-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "This metric monitors task CPU utilization"
  dimensions = {
    ClusterName = aws_ecs_cluster.ecs-cluster.name
    ServiceName = aws_ecs_service.front.name
  }

  alarm_actions = [aws_sns_topic.monitoreo.arn]
}


########RDS################

resource "aws_cloudwatch_log_group" "log-gr-RDS" {
  name              = "/RDS"
  retention_in_days = 150
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_RDS" {
  alarm_name          = "RDS-${var.project}-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "This metric monitors task CPU utilization"
  dimensions = {
    DBInstanceIdentifier = "db-primary"
  }

  alarm_actions = [aws_sns_topic.monitoreo.arn]
}