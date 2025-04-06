provider "aws" {
  region = var.aws_region
}

resource "aws_ecs_cluster" "portfolio_cluster" {
  name = "portfolio-cluster"
}

resource "aws_ecs_task_definition" "portfolio_task" {
  family                   = "portfolio-task"
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn      = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = var.image_name
      image     = "${var.gitlab_server}/${var.gitlab_user}/${var.image_name}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 50505
          hostPort      = 50505
        }
      ],
      environment = [
        {
          name  = "DB_CONNECTION_STRING"
          value = var.db_connection_string
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "portfolio_service" {
  name            = "portfolio-service"
  cluster         = aws_ecs_cluster.portfolio_cluster.id
  task_definition = aws_ecs_task_definition.portfolio_task.arn
  launch_type     = "FARGATE"

  desired_count = 1

  network_configuration {
    subnets         = ["subnet-xxxxxxxx"] # <-- aanpassen
    assign_public_ip = true
    security_groups = ["sg-xxxxxxxx"]     # <-- aanpassen
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
