resource "aws_sqs_queue" "my_queue" {
  name = var.queue_name
}

resource "aws_sqs_queue_policy" "sqs_policy" {
  queue_url = aws_sqs_queue.my_queue.id

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "MyPolicy",
    Statement = [
      {
        Effect      = "Allow",
        Principal   = "*",
        Action      = "sqs:SendMessage",
        Resource    = aws_sqs_queue.my_queue.arn,
        Condition   = {
          ArnEquals = {
            "aws:SourceArn" = var.sns_topic_arn
          }
        }
      }
    ]
  })
}


output "sqs_queue_arn" {
  value = aws_sqs_queue.my_queue.arn
}
