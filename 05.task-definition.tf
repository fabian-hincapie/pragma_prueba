resource "aws_ecs_task_definition" "front" {
  family                   = "front-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_cpu_front
  memory                   = var.ecs_ram_front

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:latest"
      cpu       = var.ecs_cpu_front
      memory    = var.ecs_ram_front
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/front"
          awslogs-region        = "us-west-1"
          awslogs-stream-prefix = "ecs"
        }
      }
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  execution_role_arn = aws_iam_role.task_execution.arn
  task_role_arn      = aws_iam_role.task_execution.arn

  tags = {
    Name        = "front-task-${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_ecs_task_definition" "back" {
  family                   = "back-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_cpu_back
  memory                   = var.ecs_ram_back

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:latest"
      cpu       = var.ecs_cpu_back
      memory    = var.ecs_ram_back
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/back"
          awslogs-region        = "us-west-1"
          awslogs-stream-prefix = "ecs"
        }
      }
      environment  = [
      { name = "redisport", value = var.redisport },
      #{ name = "RedisEndpoint", value = data.aws_elasticache_cluster.redis.endpoint },
      { name = "dbEndpoint", value = aws_db_instance.primary.endpoint }
      ]
      secrets = [{
        name      = "SECRET_DB"
        valueFrom = aws_secretsmanager_secret.secret_db.arn
      }]
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  execution_role_arn = aws_iam_role.task_execution.arn
  task_role_arn      = aws_iam_role.task_execution.arn

  tags = {
    Name        = "back-task-${var.project}"
    Environment = "${var.environment}"
  }
}
