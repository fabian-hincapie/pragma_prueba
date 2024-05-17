resource "aws_ecs_service" "front" {
  name            = "web-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.front.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
    security_groups  = [aws_security_group.app.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg-front.arn
    container_name   = "nginx"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.frontend]

  tags = {
    Name        = "front-service-${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_ecs_service" "back" {
  name            = "back-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.back.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
    security_groups  = [aws_security_group.app.id]
    assign_public_ip = true
  }

  tags = {
    Name        = "back-service-${var.project}"
    Environment = "${var.environment}"
  }
}