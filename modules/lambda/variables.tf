variable "lambda_function_name" {
  type        = string
  description = "Name of the Lambda function"
}

variable "lambda_handler" {
  type        = string
  description = "Handler for the Lambda function"
}

variable "lambda_runtime" {
  type        = string
  description = "Runtime for the Lambda function"
}

variable "lambda_timeout" {
  type        = number
  description = "Timeout for the Lambda function"
}

variable "lambda_memory_size" {
  type        = number
  description = "Memory size for the Lambda function"
}

variable "lambda_execution_role_name" {
  type        = string
  description = "Name for the Lambda execution role"
}

variable "lambda_zip_file" {
  type        = string
  description = "Path to the ZIP file containing the Lambda function code"
}

variable "sqs_queue_arn" {
  type        = string
  description = "ARN of the SQS queue to which Lambda subscribes"
}
