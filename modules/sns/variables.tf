variable "sns_topic_name" {
  type        = string
  description = "Name for the SNS topic"
}

variable "sqs_queue_arn" {
  type        = string
  description = "ARN of the SQS queue to subscribe to"
}
