provider "aws" {
  region = var.region
}

data "aws_iam_policy_document" "ecr_policy" {
  version = "2012-10-17"

  statement {
    actions   = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
      "ecr:ListImages",  
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
    ]
    resources = [aws_ecr_repository.django_app_repo.arn]
  }
}

resource "aws_iam_policy" "ecr_policy" {
  name        = "ECRPolicy"
  description = "Policy for ECR access"
  policy      = data.aws_iam_policy_document.ecr_policy.json
}

resource "aws_iam_role" "github_actions_role" {
  name = "GitHubActionsECRRole"
  
  assume_role_policy = <<JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
JSON
}

resource "aws_iam_role_policy_attachment" "ecr_attachment" {
  policy_arn = aws_iam_policy.ecr_policy.arn
  role       = aws_iam_role.github_actions_role.name
}

resource "aws_ecr_repository" "django_app_repo" {
  name = var.repository_name
}
