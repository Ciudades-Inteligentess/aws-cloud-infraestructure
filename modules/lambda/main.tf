resource "aws_lambda_function" "my_lambda_function" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  timeout          = var.lambda_timeout
  memory_size      = var.lambda_memory_size
  filename         = var.lambda_zip_file
  source_code_hash = filebase64(var.lambda_zip_file)
}

resource "aws_iam_role" "lambda_execution_role" {
  name = var.lambda_execution_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_execution_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole"
  role       = aws_iam_role.lambda_execution_role.name
}

resource "aws_iam_policy" "sqs_lambda_policy" {
  name        = "sqs_lambda_policy"
  description = "Policy to allow Lambda to receive messages from SQS"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
        ],
        Effect   = "Allow",
        Resource = var.sqs_queue_arn,
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "sqs_lambda_policy_attachment" {
  policy_arn = aws_iam_policy.sqs_lambda_policy.arn
  role       = aws_iam_role.lambda_execution_role.name
}

resource "aws_lambda_event_source_mapping" "sqs_event_mapping" {
  event_source_arn = var.sqs_queue_arn
  function_name    = aws_lambda_function.my_lambda_function.arn
}