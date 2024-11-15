variable "repository_name" {
  description = "The name of your ECR repository"
  type        = string
  default     = "django-app-repository"
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}
