resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-cluster-${var.project}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = "cluster-${var.project}"
    Environment = "${var.environment}"
  }
}