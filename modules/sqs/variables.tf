variable "queue_name" {
  type        = string
  description = "Name for the SQS queue"
}

variable "sns_topic_arn" {
  type        = string
  description = "ARN of the SNS topic to subscribe to"
}