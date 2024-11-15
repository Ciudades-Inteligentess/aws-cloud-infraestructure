resource "aws_sns_topic" "my_sns_topic" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "sqs_subscription" {
  topic_arn = aws_sns_topic.my_sns_topic.arn
  protocol  = "sqs"
  endpoint  = var.sqs_queue_arn
}

resource "aws_sns_topic_policy" "sns_policy" {
  arn = aws_sns_topic.my_sns_topic.arn

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "MyPolicy",
    Statement = [
      {
        Effect      = "Allow",
        Principal   = { Service = "lambda.amazonaws.com" },
        Action      = "sns:Publish",
        Resource    = aws_sns_topic.my_sns_topic.arn,
        Condition   = {
          ArnEquals = {
            "aws:SourceArn" = var.sqs_queue_arn
          }
        }
      }
    ]
  })
}
