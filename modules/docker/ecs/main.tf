provider "aws" {
  region = var.region
}

module "ecr_module" {
  source = "./ecr"
  region = var.region
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_execution_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = var.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name  = var.container_name
    image = module.ecr_module.ecr_repository_url
    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.host_port
    }]
  }])
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = var.subnets

    security_groups = var.security_groups
  }

  depends_on = [aws_ecs_task_definition.ecs_task_definition]
}

