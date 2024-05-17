resource "aws_iam_role" "task_execution" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "role-task-exec-${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_iam_policy" "execution_policy" {
  name        = "ecs-task-execution-policy"
  description = "Policy for ECS task execution role"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = ["secretsmanager:GetSecretValue"],
        Resource  = "*"
      },
      {
        Effect    = "Allow",
        Action    = ["logs:CreateLogStream", "logs:PutLogEvents"],
        Resource  = "*"
      },
      {
        Effect    = "Allow",
        Action    = [
          "ecs:RegisterTaskDefinition",
          "ecs:DeregisterTaskDefinition",
          "ecs:DescribeTaskDefinition",
          "ecs:ListTaskDefinitions",
          "ecs:DescribeTasks",
          "ecs:ListTasks",
          "ecs:RunTask",
          "ecs:StopTask",
          "ecs:UpdateService",
          "ecs:CreateService",
          "ecs:DeleteService",
          "ecs:ListServices",
          "ecs:DescribeServices"
        ],
        Resource  = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_attachment" {
  role       = aws_iam_role.task_execution.name
  policy_arn = aws_iam_policy.execution_policy.arn
}